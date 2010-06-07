--[[----------------------------------------------------------------------
      PvPStats Module - Part of VanasKoS
Displays Stats about PvP in a window
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PvPStats", false);

VanasKoSPvPStats = VanasKoS:NewModule("PvPStats", "AceEvent-3.0");
local VanasKoSPvPStats = VanasKoSPvPStats;
local VanasKoS = VanasKoS;

local pvpStatsList = nil;

local PLAYERS_LIST = 1;
local GUILDS_LIST = 2;
local GENERAL_LIST = 3;
local CLASS_LIST = 4;
local RACE_LIST = 5;
local MAP_LIST = 6;
local DATE_LIST = 7;
local MAX_LIST = 7;

local timeSpanStart = nil;
local timeSpanEnd = nil;
local selectedCharacter = nil;

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
	local list = pvpStatsList;
	if (list) then
		local cmp1 = list[val1] and (list[val1].score or ((list[val1].wins or 0) - (list[val1].losses or 0))) or 0;
		local cmp2 = list[val2] and (list[val2].score or ((list[val2].wins or 0) - (list[val2].losses or 0))) or 0;
		return (cmp1 > cmp2);
	end
	return false;
end
local function SortByScoreReverse(val1, val2)
	local list = pvpStatsList;
	if (list) then
		local cmp1 = list[val1] and (list[val1].score or ((list[val1].wins or 0) - (list[val1].losses or 0))) or 0;
		local cmp2 = list[val2] and (list[val2].score or ((list[val2].wins or 0) - (list[val2].losses or 0))) or 0;
		return (cmp1 < cmp2);
	end
	return false;
end

-- sorts by most pvp encounters
local function SortByEncounters(val1, val2)
	local list = pvpStatsList;
	if (list ~= nil) then
		local cmp1 = list[val1] and (list[val1].pvp or ((list[val1].wins or 0) + (list[val1].losses or 0))) or 0;
		local cmp2 = list[val2] and (list[val2].pvp or ((list[val2].wins or 0) + (list[val2].losses or 0))) or 0;
		return (cmp1 > cmp2);
	end
	return false;
end
local function SortByEncountersReverse(val1, val2)
	local list = pvpStatsList;
	if (list ~= nil) then
		local cmp1 = list[val1] and (list[val1].pvp or ((list[val1].wins or 0) + (list[val1].losses or 0))) or 0;
		local cmp2 = list[val2] and (list[val2].pvp or ((list[val2].wins or 0) + (list[val2].losses or 0))) or 0;
		return (cmp1 < cmp2);
	end
	return false;
end

-- sort by most wins
local function SortByWins(val1, val2)
	local list = pvpStatsList;
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].wins or 0;
		local cmp2 = list[val2] and list[val2].wins or 0;
		return (cmp1 > cmp2);
	end
	return false;
end
local function SortByWinsReverse(val1, val2)
	local list = pvpStatsList;
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].wins or 0;
		local cmp2 = list[val2] and list[val2].wins or 0;
		return (cmp1 < cmp2);
	end
	return false;
end

-- sort by most losses
local function SortByLosses(val1, val2)
	local list = pvpStatsList;
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].losses or 0;
		local cmp2 = list[val2] and list[val2].losses or 0;
		return (cmp1 > cmp2);
	end
	return false
end
local function SortByLossesReverse(val1, val2)
	local list = pvpStatsList;
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].losses or 0;
		local cmp2 = list[val2] and list[val2].losses or 0;
		return (cmp1 < cmp2);
	end
	return false
end

local frame = nil;

function VanasKoSPvPStats:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("PvPStats", 
		{
			profile = {
				Enabled = true,
			},
			realm = {
				pvpstats = {
					players = {
						},
				},
			}
		}
	);

	VanasKoS:RegisterList(5, "PVPSTATS", L["PvP Stats"], self);

	VanasKoSGUI:RegisterList("PVPSTATS", self);

	-- register sort options for the lists this module provides
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "byname", L["by name"], L["sort by name"], SortByIndex, SortByIndexReverse);
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "byscore", L["by score"], L["sort by most wins to losses"], SortByScore, SortByScoreReverse);
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "byencounters", L["by encounters"], L["sort by most PVP encounters"], SortByEncounters, SortByEncountersReverse);
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "bywins", L["by wins"], L["sort by most wins"], SortByWins, SortByWinsReverse);
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "bylosses", L["by losses"], L["sort by most losses"], SortByLosses, SortByLossesReverse);

	VanasKoSGUI:SetDefaultSortFunction({"PVPSTATS"}, SortByName);
	
end

function VanasKoSPvPStats:FilterFunction(key, value, searchBoxText)
	if(searchBoxText == "") then
		return true;
	end

	if(key:lower():find(searchBoxText:lower()) ~= nil) then
		return true;
	end

	return false;
end

function VanasKoSPvPStats:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
	local score = value.score or value.wins - value.losses;
	if(list == "PVPSTATS") then
		buttonText1:SetText(string.Capitalize(key));
		if (self.group ~= GENERAL_LIST or key == L["Total"] or key == L["Male"] or key == L["Female"]) then
			buttonText2:SetText(format("|cff00ff00%d|r", value.wins));
			buttonText3:SetText(format("|cffff0000%d|r", value.losses));
			buttonText4:SetText(format("|cffffffff%d|r", value.pvp or (value.wins + value.losses)));
			buttonText5:SetText(format("%d", score));
		else
			buttonText2:SetText(format("|cff00ff00%2.1f|r", value.wins));
			buttonText3:SetText(format("|cffff0000%2.1f|r", value.losses));
			buttonText4:SetText(format("|cffffffff%2.1f|r", value.pvp or (value.wins + value.losses)));
			buttonText5:SetText(format("%2.1f", score));
		end


		-- Could make the colors slightly change based on score
		local r, g, b = 0, 0, 0;
		if (score > 0) then
			g = 1;
			r = value.losses / (value.wins + value.losses);
		elseif (score < 0) then
			r = 1;
			g = value.wins / (value.wins + value.losses);
		else
			r = 1;
			g = 1;
		end
		buttonText5:SetTextColor(r, g, 0);
		button:Show();
	end
end

function VanasKoSPvPStats:ShowList(list)
	if(list == "PVPSTATS") then
		VanasKoSListFrameChangeButton:Disable();
		VanasKoSListFrameAddButton:Disable();
		if (self.group ~= PLAYERS_LIST) then
			VanasKoSListFrameRemoveButton:Disable();
		end
		VanasKoSPvPStatsCharacterDropDown:Show();
		VanasKoSPvPStatsTimeSpanDropDown:Show();
	end
end

function VanasKoSPvPStats:HideList(list)
	if(list == "PVPSTATS") then
		VanasKoSListFrameChangeButton:Enable();
		VanasKoSListFrameAddButton:Enable();
		if (self.group ~= PLAYERS_LIST) then
			VanasKoSListFrameRemoveButton:Enable();
		end
		VanasKoSPvPStatsCharacterDropDown:Hide();
		VanasKoSPvPStatsTimeSpanDropDown:Hide();
	end
end

function VanasKoSPvPStats:GetList(list, group)
	if(list == "PVPSTATS") then
		if(group == 1) then
			return self.db.realm.pvpstats.players;
		else
			if (not pvpStats) then
				self:BuildList();
			end
			return pvpStatsList;
		end
	else
		return nil;
	end
end

function VanasKoSPvPStats:BuildList()
	if (not pvpStatsList) then
		pvpStatsList = {};
	end
	wipe(pvpStatsList);

	local pvplog = VanasKoS:GetList("PVPLOG");
	local wins = 0;
	local losses = 0;
	local winELevelCnt = nil;
	local winELevelSum = 0;
	local lossELevelCnt = nil;
	local lossELevelSum = 0;
	local winMLevelCnt = nil;
	local winMLevelSum = 0;
	local lossMLevelCnt = nil;
	local lossMLevelSum = 0;
	local winDLevelCnt = nil;
	local winDLevelSum = 0;
	local lossDLevelCnt = nil;
	local lossDLevelSum = 0;

	if(not self.group) then
		self.group = PLAYERS_LIST;
	end

	local group = self.group;

	for idx,event in ipairs(pvplog.event) do
		if( (not timeSpanStart or event.time >= timeSpanStart) and
			(not timeSpanEnd or event.time <= timeSpanEnd)) then

			if(not selectedCharacter or event.myname == selectedCharacter) then
				if(event ~= nil) then
					if(group == PLAYERS_LIST) then
						if(event.enemyname) then
							if(not pvpStatsList[event.enemyname]) then
								pvpStatsList[event.enemyname] = {
									["wins"] = 0;
									["losses"] = 0;
								};
							end
							if(event.type == 'win') then
								pvpStatsList[event.enemyname].wins = pvpStatsList[event.enemyname].wins + 1;
							else
								pvpStatsList[event.enemyname].losses = pvpStatsList[event.enemyname].losses + 1;
							end
						end
					elseif(group == GUILDS_LIST) then
						local playerdata = VanasKoS:GetPlayerData(event.enemyname);
						if(playerdata and playerdata.guild) then
							if(not pvpStatsList[playerdata.guild]) then
								pvpStatsList[playerdata.guild] = {
									["wins"] = 0;
									["losses"] = 0;
								};
							end
							if (event.type == 'win') then
								pvpStatsList[playerdata.guild].wins = pvpStatsList[playerdata.guild].wins + 1;
							else
								pvpStatsList[playerdata.guild].losses = pvpStatsList[playerdata.guild].losses + 1;
							end
						end
					elseif(group == RACE_LIST) then
						local playerdata = VanasKoS:GetPlayerData(event.enemyname);
						if(playerdata and playerdata.race) then
							if(not pvpStatsList[playerdata.race]) then
								pvpStatsList[playerdata.race] = {
									["wins"] = 0;
									["losses"] = 0;
								};
							end
							if (event.type == 'win') then
								pvpStatsList[playerdata.race].wins = pvpStatsList[playerdata.race].wins + 1;
							else
								pvpStatsList[playerdata.race].losses = pvpStatsList[playerdata.race].losses + 1;
							end
						end
					elseif(group == CLASS_LIST) then
						local playerdata = VanasKoS:GetPlayerData(event.enemyname);
						if(playerdata and playerdata.class) then
							if(not pvpStatsList[playerdata.class]) then
								pvpStatsList[playerdata.class] = {
									["wins"] = 0;
									["losses"] = 0;
								};
							end
							if (event.type == 'win') then
								pvpStatsList[playerdata.class].wins = pvpStatsList[playerdata.class].wins + 1;
							else
								pvpStatsList[playerdata.class].losses = pvpStatsList[playerdata.class].losses + 1;
							end
						end
					elseif(group == MAP_LIST) then
						if(event.zone and event.zone ~= "UNKNOWN") then
							if(not pvpStatsList[event.zone]) then
								pvpStatsList[event.zone] = {
									["wins"] = 0;
									["losses"] = 0;
								};
							end
							if (event.type == 'win') then
								pvpStatsList[event.zone].wins = pvpStatsList[event.zone].wins + 1;
							else
								pvpStatsList[event.zone].losses = pvpStatsList[event.zone].losses + 1;
							end
						end
					elseif(group == DATE_LIST) then
						if(event.time) then
							local day = date("%Y-%m-%d", event.time);
							if(not pvpStatsList[day]) then
								pvpStatsList[day] = {
									["wins"] = 0;
									["losses"] = 0;
								};
							end
							if (event.type == 'win') then
								pvpStatsList[day].wins = pvpStatsList[day].wins + 1;
							else
								pvpStatsList[day].losses = pvpStatsList[day].losses + 1;
							end
						end
					elseif(group == GENERAL_LIST) then
						local elevel = string.gsub(event.enemylevel or 0, "[+]", "");
						elevel = tonumber(elevel);
						local mlevel = event.mylevel or 0;
						if(not pvpStatsList[L["Male"]]) then
							pvpStatsList[L["Male"]] = {
								["wins"] = 0;
								["losses"] = 0;
							};
						end
						if(not pvpStatsList[L["Female"]]) then
							pvpStatsList[L["Female"]] = {
								["wins"] = 0;
								["losses"] = 0;
							};
						end
						if(event.type == 'win') then
							wins = wins + 1;
							if(elevel and elevel > 0) then
								winELevelSum = winELevelSum + elevel;
								winELevelCnt = (winELevelCnt or 0) + 1;
							end
							if(mlevel and mlevel > 0) then
								winMLevelSum = winMLevelSum + mlevel;
								winMLevelCnt = (winMLevelCnt or 0) + 1;
							end
							if(elevel and elevel > 0 and mlevel and mlevel > 0) then
								winDLevelSum = winDLevelSum + mlevel - elevel;
								winDLevelCnt = (winDLevelCnt or 0) + 1;
							end
							local playerdata = VanasKoS:GetPlayerData(event.enemyname);
							if(playerdata and playerdata.gender == 2) then
								pvpStatsList[L["Male"]].wins = pvpStatsList[L["Male"]].wins + 1;
							end
							if(playerdata and playerdata.gender == 3) then
								pvpStatsList[L["Female"]].wins = pvpStatsList[L["Female"]].wins + 1;
							end
						else
							losses = losses + 1;
							if (elevel and elevel > 0) then
								lossELevelSum = lossELevelSum + mlevel;
								lossELevelCnt = (lossELevelCnt or 0) + 1;
							end
							if (mlevel and mlevel > 0) then
								lossMLevelSum = lossMLevelSum + mlevel;
								lossMLevelCnt = (lossMLevelCnt or 0) + 1;
							end
							if(elevel and elevel > 0 and mlevel and mlevel > 0) then
								lossDLevelSum = lossDLevelSum + mlevel - elevel;
								lossDLevelCnt = (lossDLevelCnt or 0) + 1;
							end
							local playerdata = VanasKoS:GetPlayerData(event.enemyname);
							if(playerdata and playerdata.gender == 2) then
								pvpStatsList[L["Male"]].losses = pvpStatsList[L["Male"]].losses + 1;
							end
							if(playerdata and playerdata.gender == 3) then
								pvpStatsList[L["Female"]].losses = pvpStatsList[L["Female"]].losses + 1;
							end
						end
					end
				end
			end
		end
	end

	if(group == GENERAL_LIST) then
		pvpStatsList[L["Total"]] = {
			["wins"] = wins,
			["losses"] = losses,
		};
		pvpStatsList[L["Enemy level"]] = {
			["wins"] = winELevelSum / (winELevelCnt or 1);
			["losses"] = lossELevelSum / (lossELevelCnt or 1);
			["pvp"] = (winELevelSum + lossELevelSum) / ((winELevelCnt or 0) + (lossELevelCnt or 1));
			["score"] = (lossELevelSum / (lossELevelCnt or 1)) - (winELevelSum / (winELevelCnt or 1));
		};
		pvpStatsList[L["My level"]] = {
			["wins"] = winMLevelSum / (winMLevelCnt or 1);
			["losses"] = lossMLevelSum / (lossMLevelCnt or 1);
			["pvp"] = (winMLevelSum + lossMLevelSum) / ((winMLevelCnt or 0) + (lossMLevelCnt or 1));
			["score"] = (lossMLevelSum / (lossMLevelCnt or 1)) - (winMLevelSum / (winMLevelCnt or 1));
		};
		pvpStatsList[L["Level difference"]] = {
			["wins"] = winDLevelSum / (winDLevelCnt or 1);
			["losses"] = lossDLevelSum / (lossDLevelCnt or 1);
			["pvp"] = (winDLevelSum + lossDLevelSum) / ((winDLevelCnt or 0) + (lossDLevelCnt or 1));
			["score"] = (lossDLevelSum / (lossDLevelCnt or 1)) - (winDLevelSum / (winDLevelCnt or 1));
		};
	end
end

function VanasKoSPvPStats:AddEntry(list, name, data)
	if(list == "PVPSTATS") then
		local listVar = VanasKoS:GetList("PVPSTATS", 1);
		if(listVar[name] == nil) then
			listVar[name] = {
				['wins'] = 0,
				['losses'] = 0,
				['bgwins'] = 0,
				['bglosses'] = 0,
			};
		end
		if(data.wins) then
			listVar[name].wins = listVar[name].wins + data.wins;
		end
		if(data.losses) then
			listVar[name].losses = listVar[name].losses + data.losses;
		end
		if(data.bgwins) then
			listVar[name].bgwins = listVar[name].bgwins + data.bgwins;
		end
		if(data.bglosses) then
			listVar[name].bglosses = listVar[name].bglosses + data.bglosses;
		end
	end
	return true;
end

function VanasKoSPvPStats:RemoveEntry(listname, name, guild)
	if(listname == "PVPSTATS") then
		local list = self:GetList(listname, 1);
		if(list and list[name]) then
			list[name] = nil;
			self:SendMessage("VanasKoS_List_Entry_Removed", listname, name);
		end
	end
end

function VanasKoSPvPStats:IsOnList(list, name)
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

function VanasKoSPvPStats:SetupColumns(list)
	if(list == "PVPSTATS") then
		VanasKoSGUI:SetNumColumns(5);
		VanasKoSGUI:SetColumnWidth(1, 140);
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
		VanasKoSGUI:ShowToggleButtons();
		if(not self.group or self.group == PLAYERS_LIST) then
			VanasKoSGUI:SetToggleButtonText(L["Players"]);
		elseif(self.group == GUILDS_LIST) then
			VanasKoSGUI:SetColumnName(1, L["Guild"]);
			VanasKoSGUI:SetToggleButtonText(L["Guilds"]);
		elseif(self.group == CLASS_LIST) then
			VanasKoSGUI:SetColumnName(1, L["Class"]);
			VanasKoSGUI:SetToggleButtonText(L["Class"]);
		elseif(self.group == RACE_LIST) then
			VanasKoSGUI:SetColumnName(1, L["Race"]);
			VanasKoSGUI:SetToggleButtonText(L["Race"]);
		elseif(self.group == MAP_LIST) then
			VanasKoSGUI:SetColumnName(1, L["Zone"]);
			VanasKoSGUI:SetToggleButtonText(L["Zone"]);
		elseif(self.group == DATE_LIST) then
			VanasKoSGUI:SetColumnName(1, L["Date"]);
			VanasKoSGUI:SetToggleButtonText(L["Date"]);
		elseif(self.group == GENERAL_LIST) then
			VanasKoSGUI:SetColumnName(1, L["Category"]);
			VanasKoSGUI:SetColumnName(4, L["Total"]);
			VanasKoSGUI:SetToggleButtonText(L["General"]);
		end
	end
end

function VanasKoSPvPStats:ToggleLeftButtonOnClick(button, frame)
	local list = VANASKOS.showList;
	if (not self.group or self.group < MAX_LIST) then
		self.group = (self.group or 1) + 1;
	else
		self.group = 1
	end
	if (self.group == PLAYERS_LIST) then
		VanasKoSListFrameRemoveButton:Enable();
	else
		VanasKoSListFrameRemoveButton:Disable();
	end
	self:BuildList();
	self:SetupColumns(list)
	VanasKoSGUI:UpdateShownList();
end

function VanasKoSPvPStats:ToggleRightButtonOnClick(button, frame)
	local list = VANASKOS.showList;
	if (not self.group or self.group > 1) then
		self.group = (self.group or (MAX_LIST + 1)) - 1;
	else
		self.group = MAX_LIST
	end
	if (self.group == PLAYERS_LIST) then
		VanasKoSListFrameRemoveButton:Enable();
	else
		VanasKoSListFrameRemoveButton:Disable();
	end
	self:BuildList();
	self:SetupColumns(list)
	VanasKoSGUI:UpdateShownList();
end

local statPie = nil;
local RED = { 1.0, 0.0, 0.0 };
local GREEN = { 0.0, 1.0, 0.0 };
local statrow = {};

function VanasKoSPvPStats:SetTimeSpan(timeSpanText)
	if(timeSpanText == "ALLTIME") then
		timeSpanStart = nil;
		timeSpanEnd = nil;
	end
	if(timeSpanText == "LAST24HOURS") then
		timeSpanStart = time() - 24*3600; -- 24hours a 3600 seconds
		timeSpanEnd = time();
	end
	if(timeSpanText == "LASTWEEK") then
		timeSpanStart = time() - 7*24*3600; -- 7 days a 24hours a 3600 seconds
		timeSpanEnd = time();
	end
	if(timeSpanText == "LASTMONTH") then
		timeSpanStart = time() - 31*24*3600; -- 31 days a 24hours a 3600 seconds
		timeSpanEnd = time();
	end

	self:BuildList();
	VanasKoSGUI:UpdateShownList();
end

function VanasKoSPvPStats:SetCategory(category)
	if (not category) then
		statsCategory = "GENERAL";
	else
		statsCategory = category;
	end

	self:BuildList();
	VanasKoSGUI:UpdateShownList();
end

function VanasKoSPvPStats:SetCharacter(charname)
	if(charname == "ALLCHARS") then
		selectedCharacter = nil;
	else
		selectedCharacter = charname;
	end

	self:BuildList();
	VanasKoSGUI:UpdateShownList();
end

function VanasKoSPvPStats:OnDisable()
	self:UnregisterAllMessages();
	local showOptions = VanasKoSGUI:GetShowButtonOptions();
	for k,v in pairs(showOptions) do
		if v.text == L["PvP Stats"] then
			showOptions[k] = nil;
		end
	end
	showOptions.args["pvpstats"] = nil;
end

function VanasKoSPvPStats:OnEnable()
	self:RegisterMessage("VanasKoS_PvPWin", "PvPWin");
	self:RegisterMessage("VanasKoS_PvPLoss", "PvPLoss");

	local characterDropdown = CreateFrame("Frame", "VanasKoSPvPStatsCharacterDropDown", VanasKoSListFrame, "UIDropDownMenuTemplate");
	characterDropdown:SetPoint("RIGHT", VanasKoSListFrameToggleLeftButton, "LEFT", 10, -2);
	UIDropDownMenu_SetWidth(characterDropdown, 60);

	local CharacterChoices = {
		[0] = { L["All Characters (Realm)"], "ALLCHARS" },
	}

	local pvplog = VanasKoS:GetList("PVPLOG") or {};

	local twinks = { };
	for idx, event in ipairs(pvplog.event or {}) do
		if(event.myname) then
			twinks[event.myname] = true;
		end
	end
	for k,v in pairs(twinks) do
		tinsert(CharacterChoices, { k, k });
	end

	UIDropDownMenu_Initialize(characterDropdown,
		function()
			for k,v in pairs(CharacterChoices) do
				local button = UIDropDownMenu_CreateInfo();
				button.text = v[1];
				button.value = v[2];
				button.func = function()
					VanasKoSPvPStats:SetCharacter(this.value);
					UIDropDownMenu_SetSelectedValue(VanasKoSPvPStatsCharacterDropDown, this.value);
				end
				UIDropDownMenu_AddButton(button);
			end

		end
	);
	UIDropDownMenu_SetSelectedValue(characterDropdown, "ALLCHARS");

	local timespanDropdown = CreateFrame("Frame", "VanasKoSPvPStatsTimeSpanDropDown", VanasKoSListFrame, "UIDropDownMenuTemplate");
	timespanDropdown:SetPoint("RIGHT", characterDropdown, "LEFT", 30, 0);
	UIDropDownMenu_SetWidth(timespanDropdown, 60);

	local TimeSpanChoices = {
		[0] = { L["All Time"], "ALLTIME" };
		[1] = { L["Last 24 hours"], "LAST24HOURS" };
		[2] = { L["Last Week"], "LASTWEEK" };
		[3] = { L["Last Month"], "LASTMONTH" };
	};

	UIDropDownMenu_Initialize(timespanDropdown,
		function()
			for k,v in VanasKoSGUI:pairsByKeys(TimeSpanChoices, nil) do
				local button = UIDropDownMenu_CreateInfo();
				button.text = v[1];
				button.value = v[2];
				button.func = function()
					VanasKoSPvPStats:SetTimeSpan(this.value);
					UIDropDownMenu_SetSelectedValue(VanasKoSPvPStatsTimeSpanDropDown, this.value);
				end
				UIDropDownMenu_AddButton(button);
			end

		end
	);
	UIDropDownMenu_SetSelectedValue(VanasKoSPvPStatsTimeSpanDropDown, "ALLTIME");

	characterDropdown:Hide();
	timespanDropdown:Hide();

	-- statPie = GraphLib:CreateGraphPieChart("VanasKoS_PvP_StatPie", VanasKoSPvPStatsCharacterDropDown, "TOPLEFT", "BOTTOMLEFT", 15, 0, 100, 100);
end


local tempStatData = { ['wins'] = 0, ['losses'] = 0 };

function VanasKoSPvPStats:PvPLoss(message, name)
	if(name == nil) then
		return;
	end

	local inBg = 0;
	if(VanasKoSDataGatherer:IsInBattleground()) then
		inBg = 1;
	end

	VanasKoS:Print(format(L["PvP Loss versus %s registered."], name));
	name = name:lower();

	tempStatData.wins = 0;
	tempStatData.losses = 1;
	tempStatData.bgwins = 0;
	tempStatData.bglosses = inBg;
	VanasKoS:AddEntry("PVPSTATS", name, tempStatData);
end

function VanasKoSPvPStats:PvPWin(message, name)
	if(name == nil) then
		return;
	end

	local inBg = 0;
	if(VanasKoSDataGatherer:IsInBattleground()) then
		inBg = 1;
	end

	VanasKoS:Print(format(L["PvP Win versus %s registered."], name));

	name = name:lower();

	tempStatData.wins = 1;
	tempStatData.losses = 0;
	tempStatData.bgwins = inBg;
	tempStatData.bglosses = 0;
	VanasKoS:AddEntry("PVPSTATS", name, tempStatData);
end

function VanasKoSPvPStats:ListButtonOnEnter(button, frame)
	if(self.group == PLAYERS_LIST) then
		local selectedPlayer, selectedPlayerData = VanasKoSGUI:GetListEntryForID(frame:GetID());
		VanasKoSDefaultLists:SetSelectedPlayerData(selectedPlayer, selectedPlayerData);
	end
	
	VanasKoSDefaultLists:ShowTooltip();
end

function VanasKoSPvPStats:ListButtonOnLeave(button, frame)
	VanasKoSDefaultLists:ListButtonOnLeave();
end

local function round(number, dp)
	local temp = 10^(dp or 0);
	return math.floor(number * temp + 0.5) / temp;
end

function VanasKoSPvPStats:SetWinLossStatsPie(wins, losses)
	if(statPie == nil) then
		statPie = GraphLib:CreateGraphPieChart("VanasKoS_PvP_StatPie", VanasKoSPvPStatsCharacterDropDown, "TOPLEFT", "BOTTOMLEFT", 15, 0, 100, 100);

		text1 = statPie:CreateFontString(nil, "ARTWORK");
		text1:SetFontObject("GameFontNormal");
		text1:SetPoint("TOPLEFT", statPie, "TOPRIGHT", 0, 0);
		text1:SetText("|cff00ff00Wins:" .. wins .. "|r");

		text2 = statPie: CreateFontString(nil, "ARTWORK");
		text2:SetFontObject("GameFontNormal");
		text2:SetPoint("TOPLEFT", text1, "BOTTOMLEFT", 0, 0);
		text2:SetText("|cffff0000Wins:" .. losses .. "|r");
	else
		statPie:ResetPie();
	end

	local losspercent = 0.0;
	local winpercent  = 0.0;

	if(wins+losses > 0) then
		local losspercent = losses / (wins + losses);
		if(losspercent == 1) then
			statPie:CompletePie(RED);
		elseif(losspercent == 0) then
			statPie:CompletePie(GREEN);
		else
			statPie:AddPie(losspercent * 100, RED);
			statPie:CompletePie(GREEN);
		end
		winpercent = (1.0-losspercent)
	end

	text1:SetText(format(L["Wins: |cff00ff00%d|r (%.1f%%)"], wins, winpercent*100));
	text2:SetText(format(L["Losses: |cffff0000%d|r (%.1f%%)"], losses, losspercent*100));

	if(losspercent ~= 0 and losspercent ~= 1) then
		statPie:CompletePie(GREEN);
	end
end
