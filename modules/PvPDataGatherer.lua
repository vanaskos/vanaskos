--[[---------------------------------------------------------------------------------------------
      PvPDataGatherer Module - Part of VanasKoS
Gathers PvP Wins and Losses
---------------------------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "enUS", true)
if L then
	L["Name"] = true
	L["Win"] = true
	L["Lost"] = true
	L["PvP"] = true
	L["Score"] = true
	L["PvP Data Gathering"] = true
	L["PvP Loss versus %s registered."] = true
	L["PvP Stats"] = true
	L["PvP Win versus %s registered."] = true
	L["by losses"] = true
	L["sort by most losses"] = true
	L["by encounters"] = true
	L["sort by most PVP encounters"] = true
	L["by wins"] = true
	L["sort by most wins"] = true
	L["by score"] = true
	L["sort by most wins to losses"] = true
	L["by name"] = true
	L["sort by name"] = true
	L["wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PvPDataGatherer", false);

VanasKoSPvPDataGatherer = VanasKoS:NewModule("PvPDataGatherer", "AceEvent-3.0");
local VanasKoSPvPDataGatherer = VanasKoSPvPDataGatherer;
local VanasKoS = VanasKoS;

-- sort functions

-- sorts by index
local function SortByIndex(val1, val2)
	return val1 < val2;
end
local function SortByIndexReverse(val1, val2)
	return val1 > val2
end

-- sorts by most pvp encounters
local function SortByScore(val1, val2)
	local list = VanasKoS:GetList("PVPSTATS");
	if (list) then
		local cmp1 = list[val1] and ((list[val1].wins or 0) - (list[val1].losses or 0)) or 0;
		local cmp2 = list[val2] and ((list[val2].wins or 0) - (list[val2].losses or 0)) or 0;
		return (cmp1 > cmp2);
	end
	return false;
end
local function SortByScoreReverse(val1, val2)
	local list = VanasKoS:GetList("PVPSTATS");
	if (list) then
		local cmp1 = list[val1] and ((list[val1].wins or 0) - (list[val1].losses or 0)) or 0;
		local cmp2 = list[val2] and ((list[val2].wins or 0) - (list[val2].losses or 0)) or 0;
		return (cmp1 < cmp2);
	end
	return false;
end

-- sorts by most pvp encounters
local function SortByEncounters(val1, val2)
	local list = VanasKoS:GetList("PVPSTATS");
	if (list ~= nil) then
		local cmp1 = list[val1] and ((list[val1].wins or 0) + (list[val1].losses or 0)) or 0;
		local cmp2 = list[val2] and ((list[val2].wins or 0) + (list[val2].losses or 0)) or 0;
		return (cmp1 > cmp2);
	end
	return false;
end
local function SortByEncountersReverse(val1, val2)
	local list = VanasKoS:GetList("PVPSTATS");
	if (list ~= nil) then
		local cmp1 = list[val1] and ((list[val1].wins or 0) + (list[val1].losses or 0)) or 0;
		local cmp2 = list[val2] and ((list[val2].wins or 0) + (list[val2].losses or 0)) or 0;
		return (cmp1 < cmp2);
	end
	return false;
end

-- sort by most wins
local function SortByWins(val1, val2)
	local list = VanasKoS:GetList("PVPSTATS");
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].wins or 0;
		local cmp2 = list[val2] and list[val2].wins or 0;
		return (cmp1 > cmp2);
	end
	return false;
end
local function SortByWinsReverse(val1, val2)
	local list = VanasKoS:GetList("PVPSTATS");
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].wins or 0;
		local cmp2 = list[val2] and list[val2].wins or 0;
		return (cmp1 < cmp2);
	end
	return false;
end

-- sort by most losses
local function SortByLosses(val1, val2)
	local list = VanasKoS:GetList("PVPSTATS");
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].losses or 0;
		local cmp2 = list[val2] and list[val2].losses or 0;
		return (cmp1 > cmp2);
	end
	return false
end
local function SortByLossesReverse(val1, val2)
	local list = VanasKoS:GetList("PVPSTATS");
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].losses or 0;
		local cmp2 = list[val2] and list[val2].losses or 0;
		return (cmp1 < cmp2);
	end
	return false
end

function VanasKoSPvPDataGatherer:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("PvPDataGatherer", 
		{
			profile = {
				Enabled = true,
			},
			realm = {
				pvpstats = {
					players = {
						},
					pvplog = {
						},
				},
			}
		}
	);

	if(VanasKoSDB.namespaces.PvPDataGatherer.realms) then
		for k,v in pairs(VanasKoSDB.namespaces.PvPDataGatherer.realms) do
			if(string.find(k, GetRealmName()) ~= nil) then
				if(v.pvpstats) then
					self.db.realm.pvpstats = v.pvpstats;
					v.pvpstats = nil;
				end
			end
		end
	end
	
	-- import of old data, will be removed in some version in the future
	--[[if(VanasKoS.db.realm.pvpstats) then
		self.db.realm.pvpstats = VanasKoS.db.realm.pvpstats;
		VanasKoS.db.realm.pvpstats = nil;
	end]]--

	VanasKoSGUI:AddModuleToggle("PvPDataGatherer", L["PvP Data Gathering"]);

	VanasKoS:RegisterList(5, "PVPSTATS", L["PvP Stats"], self);
	VanasKoS:RegisterList(nil, "PVPLOG", nil, self);

	VanasKoSGUI:RegisterList("PVPSTATS", self);

	-- register sort options for the lists this module provides
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "byname", L["by name"], L["sort by name"], SortByIndex, SortByIndexReverse);
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "byscore", L["by score"], L["sort by most wins to losses"], SortByScore, SortByScoreReverse);
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "byencounters", L["by encounters"], L["sort by most PVP encounters"], SortByEncounters, SortByEncountersReverse);
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "bywins", L["by wins"], L["sort by most wins"], SortByWins, SortByWinsReverse);
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "bylosses", L["by losses"], L["sort by most losses"], SortByLosses, SortByLossesReverse);

	VanasKoSGUI:SetDefaultSortFunction({"PVPSTATS"}, SortByName);
	
	self:SetEnabledState(self.db.profile.Enabled);
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

function VanasKoSPvPDataGatherer:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
	if(list == "PVPSTATS") then
		local data = VanasKoS:IsOnList("PVPSTATS", key);
		buttonText1:SetText(string.Capitalize(key));
		buttonText2:SetText(format("|cff00ff00%d|r", data.wins));
		buttonText3:SetText(format("|cffff0000%d|r", data.losses));
		buttonText4:SetText(format("|cffffffff%d|r", data.wins + data.losses));
		buttonText5:SetText(format("%d", data.wins - data.losses));

		-- Could make the colors slightly change based on score
		if (data.wins > data.losses) then
			buttonText5:SetTextColor(0, 1, 0);
		elseif (data.losses > data.wins) then
			buttonText5:SetTextColor(1, 0, 0);
		else
			buttonText5:SetTextColor(1, 1, 0);
		end
		button:Show();
	end
end

function VanasKoSPvPDataGatherer:ShowList(list)
	VanasKoSListFrameChangeButton:Disable();
	VanasKoSListFrameAddButton:Disable();
end

function VanasKoSPvPDataGatherer:HideList(list)
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
		self:SendMessage("VanasKoS_List_Entry_Removed", listname, name);
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

function VanasKoSPvPDataGatherer:SetupColumns(list)
	if(list == "PVPSTATS") then
		if(not self.group or self.group == 1) then
			VanasKoSGUI:SetNumColumns(5);
			VanasKoSGUI:SetColumnWidth(1, 103);
			VanasKoSGUI:SetColumnWidth(2, 40);
			VanasKoSGUI:SetColumnWidth(3, 40);
			VanasKoSGUI:SetColumnWidth(4, 40);
			VanasKoSGUI:SetColumnWidth(5, 40);
			VanasKoSGUI:SetColumnName(1, L["Name"]);
			VanasKoSGUI:SetColumnName(2, L["Win"]);
			VanasKoSGUI:SetColumnName(3, L["Lost"]);
			VanasKoSGUI:SetColumnName(4, L["PvP"]);
			VanasKoSGUI:SetColumnName(5, L["Score"]);
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse);
			VanasKoSGUI:SetColumnSort(2, SortByWins, SortByWinsReverse);
			VanasKoSGUI:SetColumnSort(3, SortByLosses, SortByLossesReverse);
			VanasKoSGUI:SetColumnSort(4, SortByEncounters, SortByEncountersReverse);
			VanasKoSGUI:SetColumnSort(5, SortByScore, SortByScoreReverse);
			VanasKoSGUI:SetColumnType(1, "normal");
			VanasKoSGUI:SetColumnType(2, "number");
			VanasKoSGUI:SetColumnType(3, "number");
			VanasKoSGUI:SetColumnType(4, "number");
			VanasKoSGUI:SetColumnType(5, "number");
			VanasKoSGUI:HideToggleButton();
		end
	end
end

function VanasKoSPvPDataGatherer:ToggleButtonOnClick(button, frame)
	local list = VANASKOS.showList;
	if(list == "PVPSTATS") then
		self.group = 1
	end
	self:SetupColumns(list)
	VanasKoSGUI:Update();
end

function VanasKoSPvPDataGatherer:OnDisable()
	self:UnregisterAllMessages();
end

function VanasKoSPvPDataGatherer:OnEnable()
	self:RegisterMessage("VanasKoS_PvPDamage", "PvPDamage");
	self:RegisterMessage("VanasKoS_PvPDeath", "PvPDeath");
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
					self:LogPvPWin(name);
					tremove(lastDamageTo, i);
				end
			end
		end
	else
		if (lastDamageFromTime ~= nil) then
			if((time() - lastDamageFromTime) < 5) then
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
