--[[---------------------------------------------------------------------------------------------
      PvPDataGatherer Module - Part of VanasKoS
Gathers PvP Wins and Losses
---------------------------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PvPDataGatherer", false);

VanasKoSPvPDataGatherer = VanasKoS:NewModule("PvPDataGatherer", "AceEvent-3.0");
local VanasKoSPvPDataGatherer = VanasKoSPvPDataGatherer;
local VanasKoS = VanasKoS;

function VanasKoSPvPDataGatherer:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("PvPDataGatherer", 
		{
			profile = {
				Enabled = true,
			},
			realm = {
				-- Bug in ace3 prevents moving pvplog from
				-- realm/pvpstast/pvplog to realm/pvplog
				pvpstats = {
					pvplog = {
					},
				}
			}
		}
	);

	VanasKoSGUI:AddModuleToggle("PvPDataGatherer", L["PvP Data Gathering"]);

	VanasKoS:RegisterList(nil, "PVPLOG", nil, self);

	self:SetEnabledState(self.db.profile.Enabled);
end

function VanasKoSPvPDataGatherer:FilterFunction(key, value, searchBoxText)
	return (searchBoxText == "") or (key:find(searchBoxText) ~= nil)
end

function VanasKoSPvPDataGatherer:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
end

function VanasKoSPvPDataGatherer:ShowList(list)
end

function VanasKoSPvPDataGatherer:HideList(list)
end

function VanasKoSPvPDataGatherer:GetList(list)
	if(list == "PVPLOG") then
		return self.db.realm.pvpstats.pvplog;
	else
		return nil;
	end
end

function VanasKoSPvPDataGatherer:AddEntry(list, name, data)
	if(list == "PVPLOG") then
		local pvplog = VanasKoS:GetList("PVPLOG");
		tinsert(pvplog.event, {['enemyname'] = name,
					['time'] = data['time'],
					['myname'] = data['myname'],
					['mylevel'] = data['mylevel'],
					['enemylevel'] = data['enemylevel'],
					['type'] = data['type'],
					['zone']  = data['zone'],
					['posX'] = data['posX'],
					['posY'] = data['posY']
				});

		if (data['zone']) then
			if (not pvplog.zone[data['zone']]) then
				pvplog.zone[data['zone']] = {}
			end
			tinsert(pvplog.zone[data['zone']], #pvplog.event);
		end

		if (not pvplog.player[name]) then
			pvplog.player[name] = {}
		end
		tinsert(pvplog.player[name], #pvplog.event);
	end
	return true;
end

function VanasKoSPvPDataGatherer:RemoveEntry(listname, name, guild)
end

function VanasKoSPvPDataGatherer:IsOnList(list, name)
	return nil;
end

function VanasKoSPvPDataGatherer:SetupColumns(list)
end

function VanasKoSPvPDataGatherer:ToggleLeftButtonOnClick(button, frame)
	self:SetupColumns(list)
	VanasKoSGUI:Update();
end

function VanasKoSPvPDataGatherer:ToggleRightButtonOnClick(button, frame)
	self:SetupColumns(list)
	VanasKoSGUI:Update();
end

function VanasKoSPvPDataGatherer:OnDisable()
	self:UnregisterAllMessages();
end

function VanasKoSPvPDataGatherer:OnEnable()
	self:RegisterMessage("VanasKoS_PvPDamage", "PvPDamage");
	self:RegisterMessage("VanasKoS_PvPDeath", "PvPDeath");
	if(self.db.realm.pvpstats.players) then
		VanasKoS:Print(L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"]);
	end
end

local lastDamageFrom = nil;
local lastDamageFromTime = nil;
local lastDamageTo = { };


function VanasKoSPvPDataGatherer:PvPDamage(message, srcName, dstName, amount)
	if (srcName == UnitName("player")) then
		self:DamageDoneTo(dstName, amount);
	elseif (dstName == UnitName("player")) then
		self:DamageDoneFrom(srcName, amount);
	end
end

function VanasKoSPvPDataGatherer:PvPDeath(message, name)
	if (name ~= UnitName("player")) then
		if (lastDamageTo) then
			for i=1,#lastDamageTo do
				if(lastDamageTo[i] and lastDamageTo[i][1] == name) then
					self:SendMessage("VanasKoS_PvPWin", name);
					self:LogPvPWin(name);
					tremove(lastDamageTo, i);
				end
			end
		end
	else
		if (lastDamageFromTime ~= nil) then
			if((time() - lastDamageFromTime) < 5) then
				self:SendMessage("VanasKoS_PvPLoss", lastDamageFrom);
				self:LogPvPLoss(lastDamageFrom);
			end
		end
		lastDamageFrom = nil;
		wipe (lastDamageTo);
	end
end

function VanasKoSPvPDataGatherer:DamageDoneFrom(name)
	if(name) then
		lastDamageFrom = name;
		lastDamageFromTime = time();

		self:AddLastDamageFrom(name);
	end
end

function VanasKoSPvPDataGatherer:DamageDoneTo(name)
	tinsert(lastDamageTo, 1,  {name, time()});

	if(#lastDamageTo < 2) then
		return;
	end

	for i=2,#lastDamageTo do
		if(lastDamageTo[i] and lastDamageTo[i][1] == name) then
			tremove(lastDamageTo, i);
		end
	end

	if(#lastDamageTo > 5) then
		tremove(lastDamageTo, 6);
	end
end

function VanasKoSPvPDataGatherer:LogPvPLoss(name)
	if(name == nil) then
		return;
	end

	VanasKoS:Print(format(L["PvP Loss versus %s registered."], name));

	name = name:lower();

	-- Should be ok to call set current zone here, pvp losses don't
	-- happen *that* often, and when they do you probably shouldn't have
	-- been staring at your map anyway...
	SetMapToCurrentZone();
	local posX, posY = GetPlayerMapPosition("player");
	local data = VanasKoS:GetPlayerData(name);
	local zone = GetRealZoneText();

	VanasKoS:AddEntry("PVPLOG", name, {	['time'] = time(),
						['myname'] = UnitName("player"),
						['mylevel'] = UnitLevel("player"),
						['enemylevel'] = data and data['level'] or 0,
						['type'] = "loss",
						['zone']  = zone,
						['posX'] = posX,
						['posY'] = posY });
end

function VanasKoSPvPDataGatherer:LogPvPWin(name)
	if(name == nil) then
		return;
	end

	VanasKoS:Print(format(L["PvP Win versus %s registered."], name));

	name = name:lower();

	-- Same as losses, but it should be even more rare that you can win in
	-- pvp while staring at the map, so shouldn't be a problem
	SetMapToCurrentZone();
	local posX, posY = GetPlayerMapPosition("player");
	local data = VanasKoS:GetPlayerData(name);
	local zone = GetRealZoneText();

	VanasKoS:AddEntry("PVPLOG", name, {
						['time'] = time(),
						['myname'] = UnitName("player"),
						['mylevel'] = UnitLevel("player"),
						['enemylevel'] = data['level'],
						['type'] = "win",
						['zone']  = zone,
						['posX'] = posX,
						['posY'] = posY });
end

local DamageFromArray = { };

function VanasKoSPvPDataGatherer:AddLastDamageFrom(name)
	name = name:lower();
	tinsert(DamageFromArray, 1, { name, time() });
	if(#DamageFromArray < 2) then
		return;
	end

	for i=2,#DamageFromArray do
		if(DamageFromArray[i] and DamageFromArray[i][1] == name) then
			tremove(DamageFromArray, i);
		end
	end

	if(#DamageFromArray > 10) then
		tremove(DamageFromArray, 11);
	end
end

function VanasKoSPvPDataGatherer:GetDamageFromArray()
	return DamageFromArray;
end

function VanasKoSPvPDataGatherer:GetDamageToArray()
	return lastDamageTo;
end

function VanasKoSPvPDataGatherer:ListButtonOnEnter(button, frame)
	local selectedPlayer, selectedPlayerData = VanasKoSGUI:GetListEntryForID(frame:GetID());
	VanasKoSDefaultLists:SetSelectedPlayerData(selectedPlayer, selectedPlayerData)
	
	VanasKoSDefaultLists:ShowTooltip();
end

function VanasKoSPvPDataGatherer:ListButtonOnLeave(button, frame)
	VanasKoSDefaultLists:ListButtonOnLeave();
end
