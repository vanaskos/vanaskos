--[[---------------------------------------------------------------------------------------------
      PvPDataGatherer Module - Part of VanasKoS
Gathers PvP Wins and Losses
---------------------------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PvPDataGatherer", false)
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")
local VanasKoSGUI = VanasKoS:GetModule("GUI")
local VanasKoSPvPDataGatherer = VanasKoS:NewModule("PvPDataGatherer", "AceEvent-3.0")

-- Declare some common global functions local
local time = time
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local UnitName = UnitName
local UnitLevel = UnitLevel
local SetMapToCurrentZone = SetMapToCurrentZone
local GetPlayerMapPosition = GetPlayerMapPosition
local GetCurrentMapAreaID = GetCurrentMapAreaID

-- Constants
local EVENT_LIST = 1
local PLAYERS_LIST = 2
local MAP_LIST = 3
local MAX_LIST = 3
local TXT_RED = "|cffff0000"
local TXT_GREEN = "|cff00ff00"
local TXT_YELLOW = "|cffffff00"
local KILLING_BLOW = 1
local MOST_DAMAGE = 2
local ALL_ATTACKERS = 3
local KILLING_BLOW_TIMEOUT = 5
local MOST_DAMAGE_TIMEOUT = 30
local ALL_ATTACKERS_TIMEOUT = 5

-- Local Variables
local myName = nil
local pvpLoggingEnabled = nil
local shownList = nil
local lastDamageFrom = {}
local lastDamageTo = {}

-- sort functions

-- sorts by index
local function SortByKey(val1, val2)
	if val1 and val2 then
		return (val1 < val2)
	elseif val1 then
		return true
	end
	return false
end
local function SortByKeyReverse(val1, val2)
	if val1 and val2 then
		return (val1 > val2)
	elseif val2 then
		return true
	end
	return false
end

-- sorts by name
local function SortByName(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].name
		local cmp2 = list[val2].name
		if cmp1 and cmp2 then
			return (cmp1 < cmp2)
		elseif cmp1 then
			return true
		end
	end
	return false
end
local function SortByNameReverse(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].name
		local cmp2 = list[val2].name
		if cmp1 and cmp2 then
			return (cmp1 > cmp2)
		elseif cmp2 then
			return true
		end
	end
	return false
end

-- sorts by myname
local function SortByMyName(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].myname
		local cmp2 = list[val2].myname
		if cmp1 and cmp2 then
			return (cmp1 < cmp2)
		elseif cmp1 then
			return true
		end
	end
	return false
end
local function SortByMyNameReverse(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].myname
		local cmp2 = list[val2].myname
		if cmp1 and cmp2 then
			return (cmp1 > cmp2)
		elseif cmp2 then
			return true
		end
	end
	return false
end

-- sorts by time
local function SortByTime(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].time
		local cmp2 = list[val2].time
		if cmp1 and cmp2 then
			return (cmp1 < cmp2)
		elseif cmp1 then
			return true
		end
	end
	return false
end
local function SortByTimeReverse(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].time
		local cmp2 = list[val2].time
		if cmp1 and cmp2 then
			return (cmp1 > cmp2)
		elseif cmp2 then
			return true
		end
	end
	return false
end

-- sorts by type (win/loss)
local function SortByType(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].type
		local cmp2 = list[val2].type
		if cmp1 and cmp2 then
			return (cmp1 < cmp2)
		elseif cmp1 then
			return true
		end
	end
	return false
end
local function SortByTypeReverse(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].type
		local cmp2 = list[val2].type
		if cmp1 and cmp2 then
			return (cmp1 > cmp2)
		elseif cmp2 then
			return true
		end
	end
	return false
end

-- sorts by map
local function SortByMap(val1, val2)
	local cmp1 = C_Map.GetMapInfo(val1).name
	local cmp2 = C_Map.GetMapInfo(val2).name
	if cmp1 and cmp2 then
		return (cmp1 < cmp2)
	elseif cmp1 then
		return true
	end
	return false
end
local function SortByMapReverse(val1, val2)
	local cmp1 = C_Map.GetMapInfo(val1).name
	local cmp2 = C_Map.GetMapInfo(val2).name
	if cmp1 and cmp2 then
		return (cmp1 > cmp2)
	elseif cmp2 then
		return true
	end
	return false
end

-- helper function to get # of entries in list
local function countEntries(val)
	local count = 0
	for _ in pairs(val) do
		count = count + 1
	end
	return count
end

-- sorts by Number of entries in table
local function SortByCount(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = countEntries(list[val1])
		local cmp2 = countEntries(list[val2])
		return (cmp1 < cmp2)
	end
	return false
end
local function SortByCountReverse(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = countEntries(list[val1])
		local cmp2 = countEntries(list[val2])
		return (cmp1 > cmp2)
	end
	return false
end

function VanasKoSPvPDataGatherer:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("PvPDataGatherer", {
		profile = {
			Enabled = true,
			EnableInBattleground = true,
			EnableInCombatZone = true,
			EnableInArena = true,
			deathOption = KILLING_BLOW,
		},
		realm = {
			pvplog = {
				event = {},
				players = {},
				map = {},
			},
		}
	})

	VanasKoSGUI:AddMainMenuConfigOptions({
		pvp_log_group = {
			name = L["PvP Log"],
			desc = L["PvP Log"],
			type = "group",
			args = {
				enableinbg = {
					type = "toggle",
					order = 1,
					name = L["Enable in Battleground"],
					desc = L["Toggles logging of PvP events in battlegrounds"],
					get = function()
						return VanasKoSPvPDataGatherer.db.profile.EnableInBattleground
					end,
					set = function(frame, v)
						VanasKoSPvPDataGatherer.db.profile.EnableInBattleground = v
						VanasKoSPvPDataGatherer:Update()
					end,
				},
				enableincombatzone = {
					type = "toggle",
					order = 2,
					name = L["Enable in combat zone"],
					desc = L["Toggles logging of PvP events in combat zones (Wintergrasp, Tol Barad)"],
					get = function()
						return VanasKoSPvPDataGatherer.db.profile.EnableInCombatZone
					end,
					set = function(frame, v)
						VanasKoSPvPDataGatherer.db.profile.EnableInCombatZone = v
						VanasKoSPvPDataGatherer:Update()
					end,
				},
				enableinarena = {
					type = "toggle",
					order = 3,
					name = L["Enable in arena"],
					desc = L["Toggles logging of PvP events in arenas"],
					get = function()
						return VanasKoSPvPDataGatherer.db.profile.EnableInArena
					end,
					set = function(frame, v)
						VanasKoSPvPDataGatherer.db.profile.EnableInArena = v
						VanasKoSPvPDataGatherer:Update()
					end,
				},
				deathOptions = {
					type = "select",
					order = 4,
					name = L["Defeat Logging Method"],
					desc = L["Method used to record defeats"],
					style = "radio",
					values = {
						[KILLING_BLOW] = L["Killing Blow"],
						[MOST_DAMAGE] = L["Most Damage"],
						[ALL_ATTACKERS] = L["All Attackers"],
					},
					get = function()
						return VanasKoSPvPDataGatherer.db.profile.deathOption
					end,
					set = function(frame, v)
						VanasKoSPvPDataGatherer.db.profile.deathOption = v
					end,
				},
			},
		},
	})

	VanasKoSGUI:AddModuleToggle("PvPDataGatherer", L["PvP Data Gathering"])

	VanasKoS:RegisterList(7, "PVPLOG", L["PvP Log"], self)
	VanasKoSGUI:RegisterList("PVPLOG", self)

	-- register sort options for the lists this module provides
--	VanasKoSGUI:RegisterSortOption({"PVPLOG"}, "byname", L["by name"], L["sort by name"], SortByIndex, SortByIndexReverse)

	VanasKoSGUI:SetDefaultSortFunction({"PVPLOG"}, SortByKey)

	self:SetEnabledState(self.db.profile.Enabled)
	self.group = EVENT_LIST
	myName = UnitName("player")
end

function VanasKoSPvPDataGatherer:EnablePvPLog(enable)
	if enable and not pvpLoggingEnabled then
		self:RegisterMessage("VanasKoS_PvPDamage", "PvPDamage")
		self:RegisterMessage("VanasKoS_PvPDeath", "PvPDeath")
		pvpLoggingEnabled = true
	elseif not enable then
		self:UnregisterMessage("VanasKoS_PvPDamage")
		self:UnregisterMessage("VanasKoS_PvPDeath")
		pvpLoggingEnabled = nil
	end
end

function VanasKoSPvPDataGatherer:Update()
	if (VanasKoS:IsInBattleground()) then
		self:EnablePvPLog(self.db.profile.EnableInBattleground)
	elseif (VanasKoS:IsInCombatZone()) then
		self:EnablePvPLog(self.db.profile.EnableInCombatZone)
	elseif (VanasKoS:IsInArena()) then
		self:EnablePvPLog(self.db.profile.EnableInArena)
	elseif (VanasKoS:IsInDungeon()) then
		self:EnablePvPLog(false)
	else
		self:EnablePvPLog(true)
	end
end

function VanasKoSPvPDataGatherer:FilterFunction(key, value, searchBoxText)
	return (searchBoxText == "") or (key:find(searchBoxText) ~= nil)
end

function VanasKoSPvPDataGatherer:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
	local group = self.group
	if(list == "PVPLOG" and value) then
		local playerKey = nil
		local playerName = nil
		if group == EVENT_LIST then
			playerKey = value.name
			playerName = value.name
		elseif group == PLAYERS_LIST then
			playerKey = key
			playerName = key
		end

		if group == EVENT_LIST or group == PLAYERS_LIST then
			local listname = select(2, VanasKoS:IsOnList(nil, playerKey))
			if(listname == "PLAYERKOS") then
				buttonText1:SetText(format("%s%s|r", TXT_YELLOW, playerName))
			elseif(listname == "HATELIST") then
				buttonText1:SetText(format("%s%s|r", TXT_RED, playerName))
			elseif(listname == "NICELIST") then
				buttonText1:SetText(format("%s%s|r", TXT_GREEN, playerName))
			else
				buttonText1:SetText(playerName or L["unknown"])
			end
		else
			local mapInfo = C_Map.GetMapInfo(key)
			buttonText1:SetText(mapInfo and mapInfo.name or L["unknown"])
		end

		if group == MAP_LIST or group == PLAYERS_LIST then
			buttonText2:SetText(countEntries(value))
		else
			buttonText2:SetText(value and value.myname or L["unknown"])
			buttonText3:SetText(date("%x", value.time))
			buttonText4:SetText(value.type)
		end
		button:Show()
	end
end

function VanasKoSPvPDataGatherer:ShowList(list, group)
	if(list == "PVPLOG") then
		VanasKoSGUI.listFrame.changeButton:Disable()
		VanasKoSGUI.listFrame.addButton:Disable()
		VanasKoSGUI.listFrame.removeButton:Enable()
	end
end

function VanasKoSPvPDataGatherer:HideList(list)
	if(list == "PVPLOG") then
		VanasKoSGUI.listFrame.changeButton:Enable()
		VanasKoSGUI.listFrame.addButton:Enable()
		VanasKoSGUI.listFrame.removeButton:Enable()
	end
end

function VanasKoSPvPDataGatherer:GetList(list, group)
	if group == nil then
		group = self.group
	end
	if(list == "PVPLOG") then
		if group == EVENT_LIST then
			return self.db.realm.pvplog.event
		elseif group == PLAYERS_LIST then
			return self.db.realm.pvplog.players
		elseif group == MAP_LIST then
			return self.db.realm.pvplog.map
		end
	end
	return nil
end


function VanasKoSPvPDataGatherer:AddEntry(list, key, data)
	if(list == "PVPLOG") then
		local pvpEventLog = VanasKoS:GetList("PVPLOG", EVENT_LIST)
		local pvpPlayersLog = VanasKoS:GetList("PVPLOG", PLAYERS_LIST)
		local pvpMapLog = VanasKoS:GetList("PVPLOG", MAP_LIST)
		local eventkey = key .. (data.time or time())
		local playerkey = data.name
		pvpEventLog[eventkey] = data
		if (data.mapID) then
			if (not pvpMapLog[data.mapID]) then
				pvpMapLog[data.mapID] = {}
			end
			tinsert(pvpMapLog[data.mapID], eventkey)
		end

		if (not pvpPlayersLog[playerkey]) then
			pvpPlayersLog[playerkey] = {}
		end
		tinsert(pvpPlayersLog[playerkey], eventkey)
		self:SendMessage("VanasKoS_List_Entry_Added", list, key, data)
	end
	return true
end

function VanasKoSPvPDataGatherer:RemoveEntry(listname, key)
	local removed = nil
	local group = self.group
	local pvpEventLog = VanasKoS:GetList("PVPLOG", 1)
	local pvpPlayersLog = VanasKoS:GetList("PVPLOG", 2)
	local pvpMapLog = VanasKoS:GetList("PVPLOG", 3)

	if(listname == "PVPLOG") then
		if (group == EVENT_LIST) then
			if (pvpEventLog[key]) then
				local playerKey = pvpEventLog[key].name
				local mapKey = pvpEventLog[key].mapID

				--VanasKoS:Print("removing " .. key .. " from pvp event log")
				pvpEventLog[key] = nil
				removed = true

				if pvpPlayersLog[playerKey] then
					for j, zhash in ipairs(pvpPlayersLog[playerKey]) do
						if (zhash == key) then
							--VanasKoS:Print("removing " .. playerKey .. "-" .. j .. " from pvp player log")
							tremove(pvpPlayersLog[playerKey], j)
							break
						end
					end
					if (next(pvpPlayersLog[playerKey]) == nil) then
						pvpPlayersLog[playerKey] = nil
					end
				end
				if pvpMapLog[mapKey] then
					for j, zhash in ipairs(pvpMapLog[mapKey]) do
						if (zhash == key) then
							--VanasKoS:Print("removing " .. mapKey .. "-" .. j .. " from pvp map log")
							tremove(pvpMapLog[mapKey], j)
							break
						end
					end
					if (next(pvpMapLog[mapKey]) == nil) then
						pvpMapLog[mapKey] = nil
					end
				end
			end
		elseif (group == PLAYERS_LIST) then
			if (pvpPlayersLog[key]) then
				for _, eventKey in ipairs(pvpPlayersLog[key]) do
					local event = pvpEventLog[eventKey]
					if (event and event.mapID) then
						for j, zhash in ipairs(pvpMapLog[event.mapID]) do
							if (zhash == eventKey) then
								--VanasKoS:Print("removing " .. event.mapID .. "-" .. j .. " from pvp map log")
								tremove(pvpMapLog[event.mapID], j)
								break
							end
						end
						if (next(pvpMapLog[event.mapID]) == nil) then
							pvpMapLog[event.mapID] = nil
						end
					end
					--VanasKoS:Print("removing " .. eventKey .. " from pvp event log")
					pvpEventLog[eventKey] = nil
					removed = true
				end
				--VanasKoS:Print("removing " .. key .. " from pvp player log")
				pvpPlayersLog[key] = nil
				removed = true
			end
		elseif (group == MAP_LIST) then
			if (pvpMapLog[key]) then
				for _, eventKey in ipairs(pvpMapLog[key]) do
					local event = pvpEventLog[eventKey]
					if (event and event.name) then
						local playerKey = event.name
						for j, zhash in ipairs(pvpPlayersLog[playerKey]) do
							if (zhash == eventKey) then
								--VanasKoS:Print("removing " .. playerKey .. "-" .. j .. " from pvp player log")
								tremove(pvpPlayersLog[playerKey], j)
								break
							end
						end
						if (next(pvpPlayersLog[playerKey]) == nil) then
							pvpPlayersLog[playerKey] = nil
						end
					end
					--VanasKoS:Print("removing " .. eventKey .. " from pvp event log")
					pvpEventLog[eventKey] = nil
					removed = true
				end
				--VanasKoS:Print("removing " .. key .. " from pvp map log")
				pvpMapLog[key] = nil
				removed = true
			end
		end
	end

	if(removed) then
		self:SendMessage("VanasKoS_List_Entry_Removed", "PVPLOG", key)
	end
end

function VanasKoSPvPDataGatherer:IsOnList(list, key, group)
	local listVar = self:GetList(list)
	if(list == "PVPLOG") then
		if(listVar[key]) then
			return listVar[key]
		else
			return nil
		end
	else
		return nil
	end
end

function VanasKoSPvPDataGatherer:SetupColumns(list)
	if(list == "PVPLOG") then
		VanasKoSGUI:ShowToggleButtons()
		if(not self.group or self.group == EVENT_LIST) then
			VanasKoSGUI:SetNumColumns(4)
			VanasKoSGUI:SetColumnWidth(1, 83)
			VanasKoSGUI:SetColumnWidth(2, 83)
			VanasKoSGUI:SetColumnWidth(3, 100)
			VanasKoSGUI:SetColumnWidth(4, 35)
			VanasKoSGUI:SetColumnType(1, "normal")
			VanasKoSGUI:SetColumnType(2, "normal")
			VanasKoSGUI:SetColumnType(3, "normal")
			VanasKoSGUI:SetColumnType(4, "normal")
			VanasKoSGUI:SetColumnName(1, L["Enemy"])
			VanasKoSGUI:SetColumnName(2, L["Player"])
			VanasKoSGUI:SetColumnName(3, L["Date"])
			VanasKoSGUI:SetColumnName(4, L["Type"])
			VanasKoSGUI:SetColumnSort(1, SortByName, SortByNameReverse)
			VanasKoSGUI:SetColumnSort(2, SortByMyName, SortByMyNameReverse)
			VanasKoSGUI:SetColumnSort(3, SortByTimeReverse, SortByTime)
			VanasKoSGUI:SetColumnSort(4, SortByType, SortByTypeReverse)
			shownList = self:GetList("PVPLOG", EVENT_LIST)
			VanasKoSGUI:SetToggleButtonText(L["Events"])
		elseif(self.group == PLAYERS_LIST) then
			VanasKoSGUI:SetNumColumns(2)
			VanasKoSGUI:SetColumnWidth(1, 240)
			VanasKoSGUI:SetColumnWidth(2, 60)
			VanasKoSGUI:SetColumnType(1, "normal")
			VanasKoSGUI:SetColumnType(2, "number")
			VanasKoSGUI:SetColumnName(1, NAME)
			VanasKoSGUI:SetColumnName(2, L["Events"])
			VanasKoSGUI:SetColumnSort(1, SortByKey, SortByKeyReverse)
			VanasKoSGUI:SetColumnSort(2, SortByCountReverse, SortByCount)
			shownList = self:GetList("PVPLOG", PLAYERS_LIST)
			VanasKoSGUI:SetToggleButtonText(L["Players"])
		elseif(self.group == MAP_LIST) then
			VanasKoSGUI:SetNumColumns(2)
			VanasKoSGUI:SetColumnWidth(1, 240)
			VanasKoSGUI:SetColumnWidth(2, 60)
			VanasKoSGUI:SetColumnType(1, "normal")
			VanasKoSGUI:SetColumnType(2, "number")
			VanasKoSGUI:SetColumnName(1, L["Zone"])
			VanasKoSGUI:SetColumnName(2, L["Events"])
			VanasKoSGUI:SetColumnSort(1, SortByMap, SortByMapReverse)
			VanasKoSGUI:SetColumnSort(2, SortByCountReverse, SortByCount)
			shownList = self:GetList("PVPLOG", MAP_LIST)
			VanasKoSGUI:SetToggleButtonText(L["Zone"])
		end
	end
end

function VanasKoSPvPDataGatherer:ToggleLeftButtonOnClick(button, frame)
	local list = VANASKOS.showList
	if list == "PVPLOG" then
		if (not self.group or self.group < MAX_LIST) then
			self.group = (self.group or 1) + 1
		else
			self.group = 1
		end
		self:SetupColumns(list)
		VanasKoSGUI:ShowList("PVPLOG", self.group)
	end
end

function VanasKoSPvPDataGatherer:ToggleRightButtonOnClick(button, frame)
	local list = VANASKOS.showList
	if list == "PVPLOG" then
		if (not self.group or self.group > 1) then
			self.group = (self.group or (MAX_LIST + 1)) - 1
		else
			self.group = MAX_LIST
		end
		self:SetupColumns(list)
		VanasKoSGUI:ShowList("PVPLOG", self.group)
	end
end

function VanasKoSPvPDataGatherer:OnDisable()
	self:UnregisterAllMessages()
	pvpLoggingEnabled = nil
end

function VanasKoSPvPDataGatherer:OnEnable()
	self:Update()
	self:RegisterMessage("VanasKoS_Zone_Changed", "Update")
end

function VanasKoSPvPDataGatherer:PvPDamage(message, srcName, dstName, amount)
	if (srcName == myName) then
		self:DamageDoneTo(dstName, amount)
	elseif (dstName == myName) then
		self:DamageDoneFrom(srcName, amount)
	end
end

-- /script LibStub("AceAddon-3.0"):GetAddon("VanasKoS"):PvPDeath("DEATH", UnitName("player"))
function VanasKoSPvPDataGatherer:PvPDeath(message, name)
	if (lastDamageTo and not (name == myName)) then
		for i=1,#lastDamageTo do
			if(lastDamageTo[i] and lastDamageTo[i].name == name) then
				self:SendMessage("VanasKoS_PvPWin", name)
				self:LogPvPEvent(name, true)
				tremove(lastDamageTo, i)
			end
		end
	elseif lastDamageFrom then
		if self.db.profile.deathOption == KILLING_BLOW then
			if (lastDamageFrom[1] and (lastDamageFrom[1].deaths or 0) == 0 and (time() - lastDamageFrom[1].time) < KILLING_BLOW_TIMEOUT) then
				self:SendMessage("VanasKoS_PvPLoss", lastDamageFrom[1].name)
				self:LogPvPEvent(lastDamageFrom[1].name, false)
			end
		elseif self.db.profile.deathOption == MOST_DAMAGE then
			local mostDamageIdx = nil
			local mostDamage = 0
			for i=1,#lastDamageFrom do
				if (lastDamageFrom[i] and (lastDamageFrom[i].deaths or 0) == 0 and lastDamageFrom[i].amount > mostDamage
				    and (time() - lastDamageFrom[i].time) < MOST_DAMAGE_TIMEOUT) then
					mostDamageIdx = i
					mostDamage = lastDamageFrom[i].amount
				end
			end
			if mostDamageIdx then
				self:SendMessage("VanasKoS_PvPLoss", lastDamageFrom[mostDamageIdx].name)
				self:LogPvPEvent(lastDamageFrom[mostDamageIdx].name, false)
			end
		elseif self.db.profile.deathOption == ALL_ATTACKERS then
			for i=1,#lastDamageFrom do
				if (lastDamageFrom[i] and (lastDamageFrom[i].deaths or 0) == 0 and (time() - lastDamageFrom[i].time) < ALL_ATTACKERS_TIMEOUT) then
					self:SendMessage("VanasKoS_PvPLoss", lastDamageFrom[i].name)
					self:LogPvPEvent(lastDamageFrom[i].name, false)
				end
			end
		end
		wipe(lastDamageTo)
		for i=1,#lastDamageFrom do
			if lastDamageFrom[i] then
				lastDamageFrom[i].deaths = (lastDamageFrom[i].deaths or 0) + 1
			end
		end
	end
end

function VanasKoSPvPDataGatherer:DamageDoneFrom(name, amount)
	if(name) then
		tinsert(lastDamageFrom, 1, {
			name = name,
			time = time(),
			amount = amount or 0,
			deaths = 0
		})
		if(#lastDamageFrom < 2) then
			return
		end

		for i=#lastDamageFrom,2,-1 do
			if(lastDamageFrom[i] and lastDamageFrom[i].name == name) then
				lastDamageFrom[1].amount = (amount or 0) + lastDamageFrom[i].amount
				tremove(lastDamageFrom, i)
			end
			if (lastDamageFrom[i] and (time() - lastDamageFrom[i].time) < MOST_DAMAGE_TIMEOUT) then
				lastDamageFrom[i].amount = 0
			end
		end

		if(#lastDamageFrom > 10) then
			tremove(lastDamageFrom, 11)
		end
	end
end

function VanasKoSPvPDataGatherer:DamageDoneTo(name, amount)
	tinsert(lastDamageTo, 1,  {
		name = name,
		time = time(),
		amount = amount or 0
	})

	if(#lastDamageTo < 2) then
		return
	end

	for i=2,#lastDamageTo do
		if(lastDamageTo[i] and lastDamageTo[i].name == name) then
			lastDamageTo[1].amount = (amount or 0) + lastDamageTo[i].amount
			tremove(lastDamageTo, i)
		end
	end

	if(#lastDamageTo > 10) then
		tremove(lastDamageTo, 11)
	end
end

-- /script LibStub("AceAddon-3.0"):GetAddon("VanasKoS"):GetModule("PvPDataGatherer"):LogPvPEvent("test", true)
function VanasKoSPvPDataGatherer:LogPvPEvent(name, isWin)
	assert(name)

	if isWin then
		VanasKoS:Print(format(L["PvP Win versus %s registered."], name))
	else
		VanasKoS:Print(format(L["PvP Loss versus %s registered."], name))
	end

	-- /script local m = C_Map.GetBestMapForUnit("player"); local p = m and C_Map.GetPlayerMapPosition(m, "player"); x, y = p:GetXY(); print(x, y)
	local mapID = C_Map.GetBestMapForUnit("player")
	local mapPos = mapID and C_Map.GetPlayerMapPosition(mapID, "player")
	local x, y, cID, wPos, wx, wy
	if mapPos then
		x, y = mapPos:GetXY()
		cID, wPos = C_Map.GetWorldPosFromMapPos(mapID, mapPos)
		if wPos then
			wx, wy = wPos:GetXY()
		end
	end
	local key = name
	local data = VanasKoS:GetPlayerData(key)

	VanasKoS:AddEntry("PVPLOG", key, {
		name = name,
		enemylevel = data and data.level or nil,
		enemyguild = data and data.guild or nil,
		myname = myName,
		mylevel = UnitLevel("player"),
		time = time(),
		type = isWin and "win" or "loss",
		mapID = mapID,
		x = x,
		y = y,
		cID = cID,
		wx = wx,
		wy = wy,
		inBg = VanasKoS:IsInBattleground() or nil,
		inArena = VanasKoS:IsInArena() or nil,
		inCombatZone = VanasKoS:IsInCombatZone() or nil,
		inFfa = VanasKoS:IsInFfaZone() or nil
	})
end

function VanasKoSPvPDataGatherer:GetDamageFromArray()
	return lastDamageFrom
end

function VanasKoSPvPDataGatherer:GetDamageToArray()
	return lastDamageTo
end

function VanasKoSPvPDataGatherer:HoverType()
	if (self.group == PLAYERS_LIST) then
		return nil
	elseif (self.group == EVENT_LIST) then
		return "eventlog"
	elseif (self.group == MAP_LIST) then
		return nil
	end
end
