--[[---------------------------------------------------------------------------------------------
      PvPDataGatherer Module - Part of VanasKoS
Gathers PvP Wins and Losses

Credits: DeuceLog for code on how to use Parser-3.0
---------------------------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.2"):new("VanasKoSPvPDataGatherer");

VanasKoSPvPDataGatherer = VanasKoS:NewModule("PvPDataGatherer");
local VanasKoSPvPDataGatherer = VanasKoSPvPDataGatherer;
local VanasKoS = VanasKoS;

local tablet = AceLibrary("Tablet-2.0");

L:RegisterTranslations("enUS", function() return {
	["PvP Data Gathering"] = true,
	["Enabled"] = true,
	["PvP Stats"] = true,
	["wins: %d - losses: %d"] = "wins: |cff00ff00%d|r losses: |cffff0000%d|r",
	["PvP Win versus %s registered."] = true,
	["PvP Loss versus %s registered."] = true,
	["Show Messages when a PvP Win/Loss is registered"] = true,
} end);

L:RegisterTranslations("deDE", function() return {
	["PvP Data Gathering"] = "PvP Daten sammeln",
	["Enabled"] = "Aktiviert",
	["PvP Stats"] = "PvP Statistik",
	["wins: %d - losses: %d"] = "gewonnen: |cff00ff00%d|r verloren: |cffff0000%d|r",
	["PvP Win versus %s registered."] = "PvP Sieg gegen %s registriert.",
	["PvP Loss versus %s registered."] = "PvP Verlust gegen %s registriert.",
} end);

L:RegisterTranslations("frFR", function() return {
	["PvP Data Gathering"] = "Rassemblement de donn\195\169es PvP",
	["Enabled"] = "actif",
	["PvP Stats"] = "PvP Stats",
	["wins: %d - losses: %d"] = "victoires: |cff00ff00%d|r d\195\169faites: |cffff0000%d|r",
} end);

L:RegisterTranslations("koKR", function() return {
	["PvP Data Gathering"] = "PvP 데이터 수집",
	["Enabled"] = "사용",
	["PvP Stats"] = "PvP 현황",
	["wins: %d - losses: %d"] = "승: |cff00ff00%d|r 패: |cffff0000%d|r",
	["PvP Win versus %s registered."] = "%s에 대한 PvP 승리가 기록되었습니다.",
	["PvP Loss versus %s registered."] = "%s에 대한 PvP 패배가 기록되었습니다.",
	["Show Messages when a PvP Win/Loss is registered"] = "PvP 승/패 기록 시 메세지를 표시합니다.",
} end);

L:RegisterTranslations("esES", function() return {
	["PvP Data Gathering"] = "Recolección de Datos JcJ",
	["Enabled"] = "Activado",
	["PvP Stats"] = "Estadísticas JcJ",
	["wins: %d - losses: %d"] = "ganados: |cff00ff00%d|r perdidos: |cffff0000%d|r",
} end);

L:RegisterTranslations("ruRU", function() return {
	["PvP Data Gathering"] = "Сбор PvP-статистики",
	["Enabled"] = "Включено",
	["PvP Stats"] = "Статистика PvP ",
	["wins: %d - losses: %d"] = "побед: |cff00ff00%d|r поражений: |cffff0000%d|r",
	["PvP Win versus %s registered."] = "PvP побед над %s.",
	["PvP Loss versus %s registered."] = "PvP поражений от %s.",
	["Show Messages when a PvP Win/Loss is registered"] = "Сообщать о зарегистрированной PvP победе/поражении",
} end);


function VanasKoSPvPDataGatherer:OnInitialize()
	VanasKoS:RegisterDefaults("PvPDataGatherer", "profile", {
		Enabled = true,
		ShowWinLossMessages = true,
	});
	VanasKoS:RegisterDefaults("PvPDataGatherer", "realm", {
		pvpstats = {
			players = {
			},
			pvplog = {
			},
		},
	});


	self.db = VanasKoS:AcquireDBNamespace("PvPDataGatherer");

	-- import of old data, will be removed in some version in the future
	if(VanasKoS.db.realm.pvpstats) then
		self.db.realm.pvpstats = VanasKoS.db.realm.pvpstats;
		VanasKoS.db.realm.pvpstats = nil;
	end

	VanasKoSGUI:AddConfigOption("PvP Data Gathering", {
			type = 'group',
			name = L["PvP Data Gathering"],
			desc = L["PvP Data Gathering"],
			args = {
				enabled = {
					type = 'toggle',
					name = L["Enabled"],
					desc = L["Enabled"],
					order = 1,
					set = function(v) VanasKoSPvPDataGatherer.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("PvPDataGatherer", v); end,
					get = function() return VanasKoSPvPDataGatherer.db.profile.Enabled end,
				},
				showstatusmessages = {
					type = 'toggle',
					name = L["Show Messages when a PvP Win/Loss is registered"],
					desc = L["Show Messages when a PvP Win/Loss is registered"],
					order = 2,
					set = function(v) VanasKoSPvPDataGatherer.db.profile.ShowWinLossMessages = v; end,
					get = function() return VanasKoSPvPDataGatherer.db.profile.ShowWinLossMessages end,
				},
			}
		});

	VanasKoS:RegisterList(5, "PVPSTATS", L["PvP Stats"], self);
	VanasKoS:RegisterList(nil, "PVPLOG", nil, self);

	VanasKoSGUI:RegisterList("PVPSTATS", self);
end

function VanasKoSPvPDataGatherer:FilterFunction(key, value, searchBoxText)
	if(searchBoxText == "") then
		return true;
	end

	if(key:find(searchBoxText) ~= nil) then
		return true;
	end

	return false;
end

function VanasKoSPvPDataGatherer:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2)
	if(list == "PVPSTATS") then
		buttonText1:SetText(string.Capitalize(key));
		local data = VanasKoS:IsOnList("PVPSTATS", key);

		buttonText2:SetText(format(L["wins: %d - losses: %d"], data.wins or 0, data.losses or 0));

		button:Show();
	end
end

function VanasKoSPvPDataGatherer:ShowList(list)
--	VanasKoSListFrameSyncButton:Disable();
	VanasKoSListFrameChangeButton:Disable();
	VanasKoSListFrameAddButton:Disable();
end

function VanasKoSPvPDataGatherer:HideList(list)
--	VanasKoSListFrameSyncButton:Enable();
	VanasKoSListFrameChangeButton:Enable();
	VanasKoSListFrameAddButton:Enable();
end

function VanasKoSPvPDataGatherer:GetList(list)
	if(list == "PVPSTATS") then
		return self.db.realm.pvpstats.players;
	elseif(list == "PVPLOG") then
		return self.db.realm.pvpstats.pvplog;
	else
		return nil;
	end
end

function VanasKoSPvPDataGatherer:AddEntry(list, name, data)
	if(list == "PVPSTATS") then
		local listVar = VanasKoS:GetList("PVPSTATS");
		if(listVar[name] == nil) then
			listVar[name] = { ['wins'] = 0, ['losses'] = 0};
		end
		if(data.wins) then
			listVar[name].wins = listVar[name].wins + data.wins;
		end
		if(data.losses) then
			listVar[name].losses = listVar[name].losses + data.losses;
		end
	elseif(list == "PVPLOG") then
		local listVar = VanasKoS:GetList("PVPLOG");
		if(listVar[name] == nil) then
			listVar[name] = { };
		end
		listVar[name][data['time']] = { ['myname'] = data['myname'],
										['mylevel'] = data['mylevel'],
										['enemylevel'] = data['enemylevel'],
										['type'] = data['type'],
										['continent'] = data['continent'],
										['zoneid'] = data['zoneid'],
										['zone']  = data['zone'],
										['posX'] = data['posX'],
										['posY'] = data['posY']
									};
		return true;
	end
	return true;
end

function VanasKoSPvPDataGatherer:RemoveEntry(listname, name, guild)
	if(listname == "PVPLOG") then
		return;
	end
	local list = self:GetList(listname);
	if(list and list[name]) then
		list[name] = nil;
		self:TriggerEvent("VanasKoS_List_Entry_Removed", listname, name);
	end
end

function VanasKoSPvPDataGatherer:IsOnList(list, name)
	local listVar = self:GetList(list);
	if(list == "PVPSTATS") then
		if(listVar[name]) then
			return listVar[name];
		else
			return nil;
		end
	else
		return nil;
	end
end

function VanasKoSPvPDataGatherer:OnDisable()
--FIXME(xilcoy): Cannot unregister for some reason
--	VanasKoSPvPDataGatherer:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	self:UnregisterAllEvents();
end

function VanasKoSPvPDataGatherer:OnEnable()
	if(not self.db.profile.Enabled) then
		return;
	end

	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "CombatEvent");
end

local lastDamageFrom = nil;
local lastDamageFromTime = nil;

local zone = nil;

function VanasKoSPvPDataGatherer:CombatEvent(...)
	local timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags = select(1, ...);

	-- Ignore if there was no destination
	if (dstFlags == nil) then
		return;
	end
	-- Ignore if the destination is not a player
	if (bit.band(dstFlags, COMBATLOG_OBJECT_TYPE_PLAYER) == 0) then
		return;
	end
	-- Ignore if there was no source and the event is not UNIT_DIED
	if (srcFlags == nil) then
		if (eventType ~= "UNIT_DIED") then
			return;
		end
	elseif (eventType ~= "UNIT_DIED") then
		-- Ignore unless both the source and destination are player controlled
		if (bit.band(srcFlags, dstFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) == 0) then
			return;
		end
		-- Ignore if neither the source nor the target is self
		if (bit.band(bit.bor(srcFlags, dstFlags), COMBATLOG_OBJECT_AFFILIATION_MINE) == 0) then
			return;
		end
		-- Ignore if neither the source nor the target is hostile
		if (bit.band(bit.bor(srcFlags, dstFlags), COMBATLOG_OBJECT_REACTION_HOSTILE) == 0) then
			return;
		end
		-- Ignore non-damage spells
		if (eventType ~= "PARTY_KILL" and not (string.match(eventType, ".*_DAMAGE") or (string.match(eventType, ".*_DRAIN")))) then

			return;
		end
	end

	if (bit.band(dstFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0) then
		if (eventType == "PARTY_KILL") then
			-- Record all PARTY_KILLs as "wins"? or should we match
			-- up the source to the player?
			self:Death(dstName, "win");
 		--Without this we may not catch killing blows by pet 
--[[		elseif (eventType == "UNIT_DIED") then
			self:Death(lastDamageTo, "win");
		else
			self:DamageDoneTo(dstName);
]]
		end
	end
	if (bit.band(dstFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0) then
		if (eventType == "UNIT_DIED") then
			self:Death(lastDamageFrom, "loss");
		else
			self:DamageDoneFrom(srcName);
		end
	end
end


function VanasKoSPvPDataGatherer:Death(name, winOrLoss)
	if(winOrLoss == "win") then
		self:LogPvPWin(name);
	end
	if(winOrLoss == "loss") then
		if(lastDamageFromTime ~= nil) then
			if((time() - lastDamageFromTime) < 5) then
				self:LogPvPLoss(name);
			end
		end
		lastDamageFrom = nil;
	end
end

function VanasKoSPvPDataGatherer:DamageDoneFrom(name)
	if(name) then
		lastDamageFrom = name;
		lastDamageFromTime = time();

		self:AddLastDamageFrom(name);
	end
end

--[[
function VanasKoSPvPDataGatherer:DamageDoneTo(t)
	if(t.recipientName) then
		tinsert(lastDamageTo, 1,  { t.recipientName, time() });

		if(#lastDamageTo > 5) then
			tremove(lastDamageTo, 5);
		end
	end
end]]

local tempStatData = { ['wins'] = 0, ['losses'] = 0 };


function VanasKoSPvPDataGatherer:LogPvPLoss(name)
	if(name == nil) then
		return;
	end
	if(VanasKoSDataGatherer:IsInBattleground()) then
		return;
	end

	VanasKoS:Print(format(L["PvP Loss versus %s registered."], name));
	name = name:lower();

	tempStatData.wins = 0;
	tempStatData.losses = 1;
	VanasKoS:AddEntry("PVPSTATS", name, tempStatData);

	local posX, posY = GetPlayerMapPosition("player");
	local lastseen, faction, guild, data = VanasKoS:IsOnList("LASTSEEN", name);
	local enemylevel = nil;
	if(lastseen and data and data['level']) then
		enemylevel = data['level'];
	end
	VanasKoS:AddEntry("PVPLOG", name, { ['time'] = time(),
										['myname'] = UnitName("player"),
										['mylevel'] = UnitLevel("player"),
										['enemylevel'] = enemylevel,
										['type'] = "loss",
										['continent'] = GetCurrentMapContinent(),
										['zoneid'] = GetCurrentMapZone(),
										['zone']  = zone,
										['posX'] = posX,
										['posY'] = posY });
end

function VanasKoSPvPDataGatherer:LogPvPWin(name)
	if(name == nil) then
		return;
	end
	if(VanasKoSDataGatherer:IsInBattleground()) then
		return;
	end

	VanasKoS:Print(format(L["PvP Win versus %s registered."], name));

	name = name:lower();

	local list = VanasKoS:GetList("PVPSTATS");

	tempStatData.wins = 1;
	tempStatData.losses = 0;
	VanasKoS:AddEntry("PVPSTATS", name, tempStatData);

	local posX, posY = GetPlayerMapPosition("player");
	local lastseen, faction, guild, data = VanasKoS:IsOnList("LASTSEEN", name);
	local enemylevel = nil;
	if(lastseen and data and data['level']) then
		enemylevel = data['level'];
	end

	VanasKoS:AddEntry("PVPLOG", name, { ['time'] = time(),
										['myname'] = UnitName("player"),
										['mylevel'] = UnitLevel("player"),
										['enemylevel'] = enemylevel,
										['type'] = "win",
										['continent'] = GetCurrentMapContinent(),
										['zoneid'] = GetCurrentMapZone(),
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

function VanasKoSPvPDataGatherer:ListButtonOnEnter(button, frame)
	local selectedPlayer, selectedPlayerData = VanasKoSGUI:GetListEntryForID(frame:GetID());
	VanasKoSDefaultLists:SetSelectedPlayerData(selectedPlayer, selectedPlayerData)
	tablet:Open("VanasKoS_DefaultLists_MouseOverFrame");
	--tablet:Refresh("VanasKoS_DefaultLists_MouseOverFrame");
end

function VanasKoSPvPDataGatherer:ListButtonOnLeave(button, frame)
	tablet:Close("VanasKoS_DefaultLists_MouseOverFrame")
end
