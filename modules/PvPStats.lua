--[[----------------------------------------------------------------------
      PvPStats Module - Part of VanasKoS
Displays Stats about PvP in a window
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PvPStats", false)
local Graph = LibStub("LibGraph-2.0", true)
VanasKoSPvPStats = VanasKoS:NewModule("PvPStats", "AceEvent-3.0")

-- Global wow strings
local MALE, FEMALE, NAME, WIN, PVP, GUILD, CLASS, RACE, ZONE, CATEGORY, GENERAL = MALE, FEMALE, NAME, WIN, PVP, GUILD, CLASS, RACE, ZONE, CATEGORY, GENERAL

-- Declare some common global functions local
local pairs = pairs
local ipairs = ipairs
local tonumber = tonumber
local strgsub = string.gsub
local wipe = wipe
local tinsert = tremove
local tremove = tinsert
local next = next
local date = date
local time = time
local format = format
local GetMapNameByID = GetMapNameByID
local GetCursorPosition = GetCursorPosition
local hashName = VanasKoS.hashName
local hashGuild = VanasKoS.hashGuild

-- Constants
local PLAYERS_LIST = 1
local GUILDS_LIST = 2
local GENERAL_LIST = 3
local CLASS_LIST = 4
local RACE_LIST = 5
local MAP_LIST = 6
local DATE_LIST = 7
local MAX_LIST = 7
local RED = {1.0, 0.0, 0.0}
local GREEN = {0.0, 1.0, 0.0}

-- Local Variables
local pvpStatsList = nil
local timeSpanStart = nil
local timeSpanEnd = nil
local selectedCharacter = nil
local tempStatData = {
	wins = 0,
	losses = 0 ,
	bgwins = 0,
	bglosses = 0,
	arenawins = 0,
	arenalosses = 0,
	combatwins = 0,
	combatlosses = 0,
	ffawins = 0,
	ffalosses = 0,
}

-- sort functions

-- sorts by name
local function SortByName(val1, val2)
	local list = pvpStatsList
	if (list) then
		local cmp1 = list[val1].name
		local cmp2 = list[val2].name
		return (cmp1 > cmp2)
	end
	return false
end
local function SortByNameReverse(val1, val2)
	local list = pvpStatsList
	if (list) then
		local cmp1 = list[val1].name
		local cmp2 = list[val2].name
		return (cmp1 < cmp2)
	end
	return false
end

-- sorts by most pvp encounters
local function SortByScore(val1, val2)
	local list = pvpStatsList
	if (list) then
		local cmp1 = list[val1] and (list[val1].score or ((list[val1].wins or 0) - (list[val1].losses or 0))) or 0
		local cmp2 = list[val2] and (list[val2].score or ((list[val2].wins or 0) - (list[val2].losses or 0))) or 0
		return (cmp1 > cmp2)
	end
	return false
end
local function SortByScoreReverse(val1, val2)
	local list = pvpStatsList
	if (list) then
		local cmp1 = list[val1] and (list[val1].score or ((list[val1].wins or 0) - (list[val1].losses or 0))) or 0
		local cmp2 = list[val2] and (list[val2].score or ((list[val2].wins or 0) - (list[val2].losses or 0))) or 0
		return (cmp1 < cmp2)
	end
	return false
end

-- sorts by most pvp encounters
local function SortByEncounters(val1, val2)
	local list = pvpStatsList
	if (list ~= nil) then
		local cmp1 = list[val1] and (list[val1].pvp or ((list[val1].wins or 0) + (list[val1].losses or 0))) or 0
		local cmp2 = list[val2] and (list[val2].pvp or ((list[val2].wins or 0) + (list[val2].losses or 0))) or 0
		return (cmp1 > cmp2)
	end
	return false
end
local function SortByEncountersReverse(val1, val2)
	local list = pvpStatsList
	if (list ~= nil) then
		local cmp1 = list[val1] and (list[val1].pvp or ((list[val1].wins or 0) + (list[val1].losses or 0))) or 0
		local cmp2 = list[val2] and (list[val2].pvp or ((list[val2].wins or 0) + (list[val2].losses or 0))) or 0
		return (cmp1 < cmp2)
	end
	return false
end

-- sort by most wins
local function SortByWins(val1, val2)
	local list = pvpStatsList
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].wins or 0
		local cmp2 = list[val2] and list[val2].wins or 0
		return (cmp1 > cmp2)
	end
	return false
end
local function SortByWinsReverse(val1, val2)
	local list = pvpStatsList
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].wins or 0
		local cmp2 = list[val2] and list[val2].wins or 0
		return (cmp1 < cmp2)
	end
	return false
end

-- sort by most losses
local function SortByLosses(val1, val2)
	local list = pvpStatsList
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].losses or 0
		local cmp2 = list[val2] and list[val2].losses or 0
		return (cmp1 > cmp2)
	end
	return false
end
local function SortByLossesReverse(val1, val2)
	local list = pvpStatsList
	if (list ~= nil) then
		local cmp1 = list[val1] and list[val1].losses or 0
		local cmp2 = list[val2] and list[val2].losses or 0
		return (cmp1 < cmp2)
	end
	return false
end

local frame = nil

function VanasKoSPvPStats:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("PvPStats", {
		profile = {
			Enabled = true,
		},
		global = {
			pvpstats = {
				players = {},
			},
		}
	})

	-- register sort options for the lists this module provides
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "byname", L["by name"], L["sort by name"], SortByIndex, SortByIndexReverse)
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "byscore", L["by score"], L["sort by most wins to losses"], SortByScore, SortByScoreReverse)
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "byencounters", L["by encounters"], L["sort by most PVP encounters"], SortByEncounters, SortByEncountersReverse)
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "bywins", L["by wins"], L["sort by most wins"], SortByWins, SortByWinsReverse)
	VanasKoSGUI:RegisterSortOption({"PVPSTATS"}, "bylosses", L["by losses"], L["sort by most losses"], SortByLosses, SortByLossesReverse)

	VanasKoSGUI:SetDefaultSortFunction({"PVPSTATS"}, SortByIndex)
end

function VanasKoSPvPStats:FilterFunction(key, value, searchBoxText)
	if(searchBoxText == "") then
		return true
	end

	if(key:lower():find(searchBoxText:lower()) ~= nil) then
		return true
	end

	return false
end

function VanasKoSPvPStats:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
	if(list == "PVPSTATS" and value) then
		local score = value.score or (value.wins - value.losses)
		buttonText1:SetText(value.name)
		if (self.group ~= GENERAL_LIST or key == L["Total"] or key == MALE or key == FEMALE) then
			buttonText2:SetText(format("|cff00ff00%d|r", value.wins))
			buttonText3:SetText(format("|cffff0000%d|r", value.losses))
			buttonText4:SetText(format("|cffffffff%d|r", value.pvp or (value.wins + value.losses)))
			buttonText5:SetText(format("%d",score))
		else
			buttonText2:SetText(format("|cff00ff00%2.1f|r", value.wins))
			buttonText3:SetText(format("|cffff0000%2.1f|r", value.losses))
			buttonText4:SetText(format("|cffffffff%2.1f|r", value.pvp or (value.wins + value.losses)))
			buttonText5:SetText(format("%2.1f", score))
		end


		local r, g, b
		if (score > 0) then
			g = 1
			r = value.losses / (value.wins + value.losses)
			b = 0
		elseif (score < 0) then
			r = 1
			g = value.wins / (value.wins + value.losses)
			b = 0
		else
			r = 1
			g = 1
			b = 1
		end
		buttonText5:SetTextColor(r, g, b)
		button:Show()
	end
end

function VanasKoSPvPStats:ShowList(list)
	if(list == "PVPSTATS") then
		VanasKoSListFrameChangeButton:Disable()
		VanasKoSListFrameAddButton:Disable()
		if (self.group == PLAYERS_LIST or self.group == DATE_LIST) then
			VanasKoSListFrameRemoveButton:Enable()
		else
			VanasKoSListFrameRemoveButton:Disable()
		end
		VanasKoSPvPStatsCharacterDropDown:Show()
		VanasKoSPvPStatsTimeSpanDropDown:Show()
		self.statPie:Show()
	end
end

function VanasKoSPvPStats:HideList(list)
	if(list == "PVPSTATS") then
		VanasKoSListFrameChangeButton:Enable()
		VanasKoSListFrameAddButton:Enable()
		VanasKoSListFrameRemoveButton:Enable()
		VanasKoSPvPStatsCharacterDropDown:Hide()
		VanasKoSPvPStatsTimeSpanDropDown:Hide()
		self.statPie:Hide()
	end
end

function VanasKoSPvPStats:GetList(list, group)
	if(list == "PVPSTATS") then
		if(group == 1) then
			return self.db.global.pvpstats.players
		else
			if (not pvpStatsList) then
				self:BuildList()
			end
			return pvpStatsList
		end
	else
		return nil
	end
end

function VanasKoSPvPStats:BuildList()
	if (not pvpStatsList) then
		pvpStatsList = {}
	end
	wipe(pvpStatsList)

	local pvplog = VanasKoS:GetList("PVPLOG")
	local wins = 0
	local losses = 0
	local winELevelCnt = nil
	local winELevelSum = 0
	local lossELevelCnt = nil
	local lossELevelSum = 0
	local winMLevelCnt = nil
	local winMLevelSum = 0
	local lossMLevelCnt = nil
	local lossMLevelSum = 0
	local winDLevelCnt = nil
	local winDLevelSum = 0
	local lossDLevelCnt = nil
	local lossDLevelSum = 0

	if(not self.group) then
		self.group = PLAYERS_LIST
	end

	local group = self.group

	local skipped = 0
	local count = 0
	for _, event in pairs(pvplog.event) do
		local myKey = event.myname and event.myrealm and hashName(event.myname, event.myrealm)
		if( (not timeSpanStart or event.time >= timeSpanStart) and
			(not timeSpanEnd or event.time <= timeSpanEnd) and
			(not selectedCharacter or myKey == selectedCharacter)) then
			assert(event.name)
			assert(event.realm)
			local enemykey = hashName(event.name, event.realm)
			if(group == PLAYERS_LIST) then
				if(not pvpStatsList[enemykey]) then
					pvpStatsList[enemykey] = {
						name = event.name,
						realm = event.realm,
						wins = 0,
						losses = 0
					}
				end
				if(event.type == 'win') then
					pvpStatsList[enemykey].wins = pvpStatsList[enemykey].wins + 1
					wins = wins + 1
				else
					pvpStatsList[enemykey].losses = pvpStatsList[enemykey].losses + 1
					losses = losses + 1
				end
			elseif(group == GUILDS_LIST) then
				local playerdata = VanasKoS:GetPlayerData(enemykey)
				if(playerdata and playerdata.guild) then
					local guildKey = hashGuild(playerdata.guild, event.realm)
					if(not pvpStatsList[guildKey]) then
						pvpStatsList[guildKey] = {
							name = playerdata.guild,
							wins = 0,
							losses = 0
						}
					end
					if (event.type == 'win') then
						pvpStatsList[guildKey].wins = pvpStatsList[guildKey].wins + 1
						wins = wins + 1
					else
						pvpStatsList[guildKey].losses = pvpStatsList[guildKey].losses + 1
						losses = losses + 1
					end
				end
			elseif(group == RACE_LIST) then
				local playerdata = VanasKoS:GetPlayerData(enemykey)
				if(playerdata and playerdata.race) then
					if(not pvpStatsList[playerdata.race]) then
						pvpStatsList[playerdata.race] = {
							name = playerdata.race,
							wins = 0,
							losses = 0
						}
					end
					if (event.type == 'win') then
						pvpStatsList[playerdata.race].wins = pvpStatsList[playerdata.race].wins + 1
						wins = wins + 1
					else
						pvpStatsList[playerdata.race].losses = pvpStatsList[playerdata.race].losses + 1
						losses = losses + 1
					end
				end
			elseif(group == CLASS_LIST) then
				local playerdata = VanasKoS:GetPlayerData(enemykey)
				if(playerdata and playerdata.class) then
					if(not pvpStatsList[playerdata.class]) then
						pvpStatsList[playerdata.class] = {
							name = playerdata.class,
							wins = 0,
							losses = 0
						}
					end
					if (event.type == 'win') then
						pvpStatsList[playerdata.class].wins = pvpStatsList[playerdata.class].wins + 1
						wins = wins + 1
					else
						pvpStatsList[playerdata.class].losses = pvpStatsList[playerdata.class].losses + 1
						losses = losses + 1
					end
				end
			elseif(group == MAP_LIST) then
				if(event.mapID and event.mapID ~= -1) then
					local mapName = C_Map.GetMapInfo(event.mapID).name
					if(not pvpStatsList[mapName]) then
						pvpStatsList[mapName] = {
							name = mapName,
							wins = 0,
							losses = 0
						}
					end
					if (event.type == 'win') then
						pvpStatsList[mapName].wins = pvpStatsList[mapName].wins + 1
						wins = wins + 1
					else
						pvpStatsList[mapName].losses = pvpStatsList[mapName].losses + 1
						losses = losses + 1
					end
				end
			elseif(group == DATE_LIST) then
				if(event.time) then
					local day = date("%Y-%m-%d", event.time)
					if(not pvpStatsList[day]) then
						pvpStatsList[day] = {
							name = day,
							wins = 0,
							losses = 0
						}
					end
					if (event.type == 'win') then
						pvpStatsList[day].wins = pvpStatsList[day].wins + 1
						wins = wins + 1
					else
						pvpStatsList[day].losses = pvpStatsList[day].losses + 1
						losses = losses + 1
					end
				end
			elseif(group == GENERAL_LIST) then
				local elevel = strgsub(event.enemylevel or 0, "[+]", "")
				elevel = tonumber(elevel)
				local mlevel = event.mylevel or 0
				if(not pvpStatsList[MALE]) then
					pvpStatsList[MALE] = {
						name = MALE,
						wins = 0,
						losses = 0
					}
				end
				if(not pvpStatsList[FEMALE]) then
					pvpStatsList[FEMALE] = {
						name = FEMALE,
						wins = 0,
						losses = 0
					}
				end
				if(event.type == 'win') then
					wins = wins + 1
					if(elevel and elevel > 0) then
						winELevelSum = winELevelSum + elevel
						winELevelCnt = (winELevelCnt or 0) + 1
					end
					if(mlevel and mlevel > 0) then
						winMLevelSum = winMLevelSum + mlevel
						winMLevelCnt = (winMLevelCnt or 0) + 1
					end
					if(elevel and elevel > 0 and mlevel and mlevel > 0) then
						winDLevelSum = winDLevelSum + mlevel - elevel
						winDLevelCnt = (winDLevelCnt or 0) + 1
					end
					local playerdata = VanasKoS:GetPlayerData(enemykey)
					if(playerdata and playerdata.gender == 2) then
						pvpStatsList[MALE].wins = pvpStatsList[MALE].wins + 1
					end
					if(playerdata and playerdata.gender == 3) then
						pvpStatsList[FEMALE].wins = pvpStatsList[FEMALE].wins + 1
					end
				else
					losses = losses + 1
					if (elevel and elevel > 0) then
						lossELevelSum = lossELevelSum + mlevel
						lossELevelCnt = (lossELevelCnt or 0) + 1
					end
					if (mlevel and mlevel > 0) then
						lossMLevelSum = lossMLevelSum + mlevel
						lossMLevelCnt = (lossMLevelCnt or 0) + 1
					end
					if(elevel and elevel > 0 and mlevel and mlevel > 0) then
						lossDLevelSum = lossDLevelSum + mlevel - elevel
						lossDLevelCnt = (lossDLevelCnt or 0) + 1
					end
					local playerdata = VanasKoS:GetPlayerData(enemykey)
					if(playerdata and playerdata.gender == 2) then
						pvpStatsList[MALE].losses = pvpStatsList[MALE].losses + 1
					end
					if(playerdata and playerdata.gender == 3) then
						pvpStatsList[FEMALE].losses = pvpStatsList[FEMALE].losses + 1
					end
				end
			end
			count = count + 1
		else
			skipped = skipped + 1
		end
	end

	if(group == GENERAL_LIST) then
		pvpStatsList[L["Total"]] = {
			name = L["Total"],
			wins = wins,
			losses = losses,
		}
		pvpStatsList[L["Enemy level"]] = {
			name = L["Enemy level"],
			wins = winELevelSum / (winELevelCnt or 1),
			losses = lossELevelSum / (lossELevelCnt or 1),
			pvp = (winELevelSum + lossELevelSum) / ((winELevelCnt or 0) + (lossELevelCnt or 1)),
			score = (lossELevelSum / (lossELevelCnt or 1)) - (winELevelSum / (winELevelCnt or 1))
		}
		pvpStatsList[L["My level"]] = {
			name = L["My level"],
			wins = winMLevelSum / (winMLevelCnt or 1),
			losses = lossMLevelSum / (lossMLevelCnt or 1),
			pvp = (winMLevelSum + lossMLevelSum) / ((winMLevelCnt or 0) + (lossMLevelCnt or 1)),
			score = (lossMLevelSum / (lossMLevelCnt or 1)) - (winMLevelSum / (winMLevelCnt or 1))
		}
		pvpStatsList[L["Level difference"]] = {
			name = L["Level difference"],
			wins = winDLevelSum / (winDLevelCnt or 1),
			losses = lossDLevelSum / (lossDLevelCnt or 1),
			pvp = (winDLevelSum + lossDLevelSum) / ((winDLevelCnt or 0) + (lossDLevelCnt or 1)),
			score = (lossDLevelSum / (lossDLevelCnt or 1)) - (winDLevelSum / (winDLevelCnt or 1))
		}
	end

	if Graph then
		self:SetWinLossStatsPie(wins, losses)
	end
end

function VanasKoSPvPStats:AddEntry(list, key, data)
	if(list == "PVPSTATS") then
		local listVar = VanasKoS:GetList("PVPSTATS", 1)
		if(not listVar[key]) then
			listVar[key] = {}
		end
		local pstat = listVar[key]

		listVar[key].wins = (pstat.wins or 0) + data.wins
		listVar[key].losses = (pstat.losses or 0) + data.losses
		listVar[key].bgwins = (pstat.bgwins or 0) + data.bgwins
		listVar[key].bglosses = (pstat.bglosses or 0) + data.bglosses
		listVar[key].arenawins = (pstat.arenawins or 0) + data.arenawins
		listVar[key].arenalosses = (pstat.arenalosses or 0) + data.arenalosses
		listVar[key].combatwins = (pstat.combatwins or 0) + data.combatwins
		listVar[key].combatlosses = (pstat.combatlosses or 0) + data.combatlosses
		listVar[key].ffawins = (pstat.ffawins or 0) + data.ffawins
		listVar[key].ffalosses = (pstat.ffalosses or 0) + data.ffalosses
	end
	return true
end

function VanasKoSPvPStats:RemoveEntry(listname, key, guild)
	local removed = nil
	local group = self.group
	local pvplog = VanasKoS:GetList("PVPLOG")

	if(listname == "PVPSTATS") then
		if (group == PLAYERS_LIST) then
			-- print("removing from players_list")
			local list = self:GetList(listname, 1)
			if(list and list[key]) then
				-- print("removing from pvp stats")
				list[key] = nil
				removed = true
			end

			if (pvplog.players[key]) then
				-- print("removing " .. list[key].name .. " from pvp player log")
				for _, eventKey in ipairs(pvplog.players[key]) do
					-- print("removing " .. eventKey .. " from pvp event log")
					local event = pvplog.event[eventKey]
					if (event and event.mapID) then
						for j, zhash in ipairs(pvplog.map[event.mapID]) do
							if (zhash == eventKey) then
								--print("removing " .. eventKey .. " from pvp zone log")
								tremove(pvplog.map[event.mapID], j)
								break
							end
						end
						if (next(pvplog.map[event.mapID]) == nil) then
							pvplog.map[event.mapID] = nil
						end
					end
					pvplog.event[eventKey] = nil
					removed = true
				end
				pvplog.players[key] = nil
			end
		elseif (group == DATE_LIST) then
			-- print("brute removing " .. list[key].name)
			-- brute force
			for eventKey, event in pairs(pvplog.event) do
				local remove = nil
				if (event.time and date("%Y-%m-%d", event.time) == key) then
					if (event and event.enemykey) then
						for j, zhash in ipairs(pvplog.players[event.enemykey] or {}) do
							if (zhash == eventKey) then
								--print("removing " .. eventKey .. " from player log")
								tremove(pvplog.players[event.enemykey], j)
								break
							end
						end
						if (pvplog.players[event.enemykey] and next(pvplog.players[event.enemykey]) == nil) then
							pvplog.players[event.enemykey] = nil
						end
					end
					if (event and event.mapID) then
						for j, zhash in ipairs(pvplog.map[event.mapID] or {}) do
							if (zhash == eventKey) then
								--print("removing " .. eventKey .. " from pvp zone log")
								tremove(pvplog.map[event.mapID], j)
								break
							end
						end
						if (pvplog.map[event.mapID] and next(pvplog.map[event.mapID]) == nil) then
							pvplog.map[event.mapID] = nil
						end
					end
					pvplog.event[eventKey] = nil
					removed = true
				end
			end
		end
	end

	if(removed) then
		pvpStatsList[key] = nil
		self:SendMessage("VanasKoS_List_Entry_Removed", listname, key)
	end
end

function VanasKoSPvPStats:IsOnList(list, key)
	local listVar = self:GetList(list)
	if(list == "PVPSTATS") then
		if(listVar[key]) then
			return listVar[key]
		else
			return nil
		end
	else
		return nil
	end
end

function VanasKoSPvPStats:SetupColumns(list)
	if(list == "PVPSTATS") then
		VanasKoSGUI:SetNumColumns(5)
		VanasKoSGUI:SetColumnWidth(1, 140)
		VanasKoSGUI:SetColumnWidth(2, 40)
		VanasKoSGUI:SetColumnWidth(3, 40)
		VanasKoSGUI:SetColumnWidth(4, 40)
		VanasKoSGUI:SetColumnWidth(5, 40)
		VanasKoSGUI:SetColumnName(1, NAME)
		VanasKoSGUI:SetColumnName(2, WIN)
		VanasKoSGUI:SetColumnName(3, L["Lost"])
		VanasKoSGUI:SetColumnName(4, PVP)
		VanasKoSGUI:SetColumnName(5, L["Score"])
		VanasKoSGUI:SetColumnSort(1, SortByName, SortByNameReverse)
		VanasKoSGUI:SetColumnSort(2, SortByWins, SortByWinsReverse)
		VanasKoSGUI:SetColumnSort(3, SortByLosses, SortByLossesReverse)
		VanasKoSGUI:SetColumnSort(4, SortByEncounters, SortByEncountersReverse)
		VanasKoSGUI:SetColumnSort(5, SortByScore, SortByScoreReverse)
		VanasKoSGUI:SetColumnType(1, "normal")
		VanasKoSGUI:SetColumnType(2, "number")
		VanasKoSGUI:SetColumnType(3, "number")
		VanasKoSGUI:SetColumnType(4, "number")
		VanasKoSGUI:SetColumnType(5, "number")
		VanasKoSGUI:ShowToggleButtons()
		if(not self.group or self.group == PLAYERS_LIST) then
			VanasKoSGUI:SetToggleButtonText(L["Players"])
		elseif(self.group == GUILDS_LIST) then
			VanasKoSGUI:SetColumnName(1, GUILD)
			VanasKoSGUI:SetToggleButtonText(GUILD)
		elseif(self.group == CLASS_LIST) then
			VanasKoSGUI:SetColumnName(1, CLASS)
			VanasKoSGUI:SetToggleButtonText(CLASS)
		elseif(self.group == RACE_LIST) then
			VanasKoSGUI:SetColumnName(1, RACE)
			VanasKoSGUI:SetToggleButtonText(RACE)
		elseif(self.group == MAP_LIST) then
			VanasKoSGUI:SetColumnName(1, ZONE)
			VanasKoSGUI:SetToggleButtonText(ZONE)
		elseif(self.group == DATE_LIST) then
			VanasKoSGUI:SetColumnName(1, L["Date"])
			VanasKoSGUI:SetToggleButtonText(L["Date"])
		elseif(self.group == GENERAL_LIST) then
			VanasKoSGUI:SetColumnName(1, CATEGORY)
			VanasKoSGUI:SetColumnName(4, L["Total"])
			VanasKoSGUI:SetToggleButtonText(GENERAL)
		end
	end
end

function VanasKoSPvPStats:ToggleLeftButtonOnClick(button, frame)
	local list = VANASKOS.showList
	if (not self.group or self.group < MAX_LIST) then
		self.group = (self.group or 1) + 1
	else
		self.group = 1
	end
	if (self.group == PLAYERS_LIST or self.group == DATE_LIST) then
		VanasKoSListFrameRemoveButton:Enable()
	else
		VanasKoSListFrameRemoveButton:Disable()
	end
	self:BuildList()
	self:SetupColumns(list)
	VanasKoSGUI:UpdateShownList()
end

function VanasKoSPvPStats:ToggleRightButtonOnClick(button, frame)
	local list = VANASKOS.showList
	if (not self.group or self.group > 1) then
		self.group = (self.group or (MAX_LIST + 1)) - 1
	else
		self.group = MAX_LIST
	end
	if (self.group == PLAYERS_LIST or self.group == DATE_LIST) then
		VanasKoSListFrameRemoveButton:Enable()
	else
		VanasKoSListFrameRemoveButton:Disable()
	end
	self:BuildList()
	self:SetupColumns(list)
	VanasKoSGUI:UpdateShownList()
end

function VanasKoSPvPStats:ListButtonOnClick(button, frame)
	local id = frame:GetID()
	local entryKey, entryValue = VanasKoSGUI:GetListKeyForIndex(id)
	if(id == nil or entryKey == nil) then
		return
	end
	if(button == "RightButton" and self.group == PLAYERS_LIST) then
		local x, y = GetCursorPosition()
		local uiScale = UIParent:GetEffectiveScale()
		local menuItems = {
			{
				text = entryValue.name and entryValue.name or "",
				isTitle = true,
			},
			{
				text = L["Add to Player KoS"],
				func = function()
					VanasKoS:AddEntryByName("PLAYERKOS", entryKey)
				end,
			},
			{
				text = L["Add to Hatelist"],
				func = function()
					VanasKoS:AddEntryByName("HATELIST", entryKey)
				end
			},
			{
				text = L["Add to Nicelist"],
				func = function()
					VanasKoS:AddEntryByName("NICELIST", entryKey)
				end
			},
			{
				text = L["Remove Entry"],
				func = function()
					VanasKoS:RemoveEntry(VANASKOS.showList, entryKey)
				end
			}
		}

		EasyMenu(menuItems, VanasKoSGUI.dropDownFrame, UIParent, x/uiScale, y/uiScale, "MENU")
	end
end

function VanasKoSPvPStats:SetTimeSpan(timeSpanText)
	if(timeSpanText == "ALLTIME") then
		timeSpanStart = nil
		timeSpanEnd = nil
	end
	if(timeSpanText == "LAST24HOURS") then
		timeSpanStart = time() - 24*3600 -- 24hours a 3600 seconds
		timeSpanEnd = time()
	end
	if(timeSpanText == "LASTWEEK") then
		timeSpanStart = time() - 7*24*3600 -- 7 days a 24hours a 3600 seconds
		timeSpanEnd = time()
	end
	if(timeSpanText == "LASTMONTH") then
		timeSpanStart = time() - 31*24*3600 -- 31 days a 24hours a 3600 seconds
		timeSpanEnd = time()
	end

	self:BuildList()
	VanasKoSGUI:UpdateShownList()
end

function VanasKoSPvPStats:SetCharacter(charname)
	if(charname == "ALLCHARS") then
		selectedCharacter = nil
	else
		selectedCharacter = charname
	end

	self:BuildList()
	VanasKoSGUI:UpdateShownList()
end

function VanasKoSPvPStats:OnDisable()
	self:UnregisterAllMessages()
	VanasKoS:UnregisterList("PVPSTATS")
	VanasKoSGUI:UnregisterList("PVPSTATS")
end

function VanasKoSPvPStats:OnEnable()
	self:RegisterMessage("VanasKoS_PvPWin", "PvPWin")
	self:RegisterMessage("VanasKoS_PvPLoss", "PvPLoss")

	VanasKoS:RegisterList(6, "PVPSTATS", L["PvP Stats"], self)
	VanasKoSGUI:RegisterList("PVPSTATS", self)

	local characterDropdown = CreateFrame("Frame", "VanasKoSPvPStatsCharacterDropDown", VanasKoSListFrame, "UIDropDownMenuTemplate")
	characterDropdown:SetPoint("RIGHT", VanasKoSListFrameToggleLeftButton, "LEFT", 10, -2)
	UIDropDownMenu_SetWidth(characterDropdown, 60)

	local CharacterChoices = {
		[0] = {
			L["All Characters"], "ALLCHARS"
		},
	}

	local pvplog = VanasKoS:GetList("PVPLOG") or {}

	local twinks = {}
	twinks[hashName(UnitName("player"), GetRealmName())] = {
		name = UnitName("player"),
		realm = GetRealmName()
	}
	for _, event in pairs(pvplog.event or {}) do
		if(event.myname and event.myrealm) then
			twinks[hashName(event.myname, event.myrealm)] = {
				name = event.myname,
				realm = event.myrealm
			}
		end
	end
	local i = 1
	for k, v in pairs(twinks) do
		CharacterChoices[i] = {v.name .. "-" .. v.realm, k}
		i = i + 1
	end

	UIDropDownMenu_Initialize(characterDropdown, function(self, level)
		for _, v in pairs(CharacterChoices) do
			local button = UIDropDownMenu_CreateInfo()
			button.text = v[1]
			button.value = v[2]
			button.func = function(self)
				VanasKoSPvPStats:SetCharacter(self.value)
				UIDropDownMenu_SetSelectedValue(VanasKoSPvPStatsCharacterDropDown, self.value)
			end
			UIDropDownMenu_AddButton(button)
		end
	end)
	UIDropDownMenu_SetSelectedValue(characterDropdown, "ALLCHARS")

	local timespanDropdown = CreateFrame("Frame", "VanasKoSPvPStatsTimeSpanDropDown", VanasKoSListFrame, "UIDropDownMenuTemplate")
	timespanDropdown:SetPoint("RIGHT", characterDropdown, "LEFT", 30, 0)
	UIDropDownMenu_SetWidth(timespanDropdown, 60)

	local TimeSpanChoices = {
		[0] = {L["All Time"], "ALLTIME"},
		[1] = {L["Last 24 hours"], "LAST24HOURS"},
		[2] = {L["Last Week"], "LASTWEEK"},
		[3] = {L["Last Month"], "LASTMONTH"}
	}

	UIDropDownMenu_Initialize(timespanDropdown, function(self, level)
		for _, v in VanasKoSGUI:pairsByKeys(TimeSpanChoices, nil) do
			local button = UIDropDownMenu_CreateInfo()
			button.text = v[1]
			button.value = v[2]
			button.func = function(self)
				VanasKoSPvPStats:SetTimeSpan(self.value)
				UIDropDownMenu_SetSelectedValue(VanasKoSPvPStatsTimeSpanDropDown, self.value)
			end
			UIDropDownMenu_AddButton(button)
		end
	end)
	UIDropDownMenu_SetSelectedValue(VanasKoSPvPStatsTimeSpanDropDown, "ALLTIME")

	characterDropdown:Hide()
	timespanDropdown:Hide()

	if Graph then
		self.statPie = Graph:CreateGraphPieChart("VanasKoS_PvP_StatPie", VanasKoSFrame, "LEFT", "RIGHT", 0, 0, 150, 150)

		text1 = self.statPie:CreateFontString(nil, "ARTWORK")
		text1:SetFontObject("GameFontNormal")
		text1:SetPoint("TOPLEFT", self.statPie, "TOPRIGHT", 0, 0)
		text1:SetText("|cff00ff00Wins:" .. 0 .. "|r")
		self.statPie.line1 = text1

		text2 = self.statPie:CreateFontString(nil, "ARTWORK")
		text2:SetFontObject("GameFontNormal")
		text2:SetPoint("TOPLEFT", text1, "BOTTOMLEFT", 0, 0)
		text2:SetText("|cffff0000Wins:" .. 0 .. "|r")
		self.statPie.line2 = text2

		self.statPie:Hide()
	end
end


function VanasKoSPvPStats:PvPLoss(message, name, realm)
	if(name == nil or realm == nil) then
		return
	end

	local key = hashName(name, realm)
	tempStatData.name = name
	tempStatData.realm = realm
	tempStatData.wins = 0
	tempStatData.losses = 1
	tempStatData.bgwins = 0
	tempStatData.bglosses = VanasKoS:IsInBattleground() and 1 or 0
	tempStatData.arenawins = 0
	tempStatData.arenalosses = VanasKoS:IsInArena() and 1 or 0
	tempStatData.combatwins = 0
	tempStatData.combatlosses = VanasKoS:IsInCombatZone() and 1 or 0
	tempStatData.ffawins = 0
	tempStatData.ffalosses = VanasKoS:IsInFfaZone() and 1 or 0

	VanasKoS:AddEntry("PVPSTATS", key, tempStatData)
end

function VanasKoSPvPStats:PvPWin(message, name, realm)
	if(name == nil or realm == nil) then
		return
	end

	local key = hashName(name, realm)
	tempStatData.name = name
	tempStatData.realm = realm
	tempStatData.wins = 1
	tempStatData.losses = 0
	tempStatData.bgwins = VanasKoS:IsInBattleground() and 1 or 0
	tempStatData.bglosses = 0
	tempStatData.arenawins = VanasKoS:IsInArena() and 1 or 0
	tempStatData.arenalosses = 0
	tempStatData.combatwins = VanasKoS:IsInCombatZone() and 1 or 0
	tempStatData.combatlosses = 0
	tempStatData.ffawins = VanasKoS:IsInFfaZone() and 1 or 0
	tempStatData.ffalosses = 0

	VanasKoS:AddEntry("PVPSTATS", key, tempStatData)
end

function VanasKoSPvPStats:HoverType()
	if (self.group == PLAYERS_LIST) then
		return "player"
	elseif (self.group == GUILDS_LIST) then
		return "guild"
	end
end

function VanasKoSPvPStats:SetWinLossStatsPie(wins, losses)
	if not self.statPie then
		return
	end

	self.statPie:ResetPie()

	local losspercent = 0.0
	local winpercent  = 0.0

	if(wins+losses > 0) then
		losspercent = losses / (wins + losses)
		if(losspercent > 0.99) then
			self.statPie:CompletePie(RED)
		elseif(losspercent < 0.01) then
			self.statPie:CompletePie(GREEN)
		else
			self.statPie:AddPie(losspercent * 100, RED)
			self.statPie:CompletePie(GREEN)
		end
		winpercent = (1.0-losspercent)
		self.statPie.line1:SetText(format(L["Wins: |cff00ff00%d|r (%.1f%%)"], wins, winpercent*100))
		self.statPie.line2:SetText(format(L["Losses: |cffff0000%d|r (%.1f%%)"], losses, losspercent*100))
	else
		text1:SetText("")
		text2:SetText("")
	end

	if(losspercent ~= 0 and losspercent ~= 1) then
		self.statPie:CompletePie(GREEN)
	end
end
