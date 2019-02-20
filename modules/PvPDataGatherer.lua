--[[---------------------------------------------------------------------------------------------
      PvPDataGatherer Module - Part of VanasKoS
Gathers PvP Wins and Losses
---------------------------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PvPDataGatherer", false)
VanasKoSPvPDataGatherer = VanasKoS:NewModule("PvPDataGatherer", "AceEvent-3.0")

-- Declare some common global functions local
local time = time
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local UnitName = UnitName
local UnitLevel = UnitLevel
local SetMapToCurrentZone = SetMapToCurrentZone
local GetRealmName = GetRealmName
local GetPlayerMapPosition = GetPlayerMapPosition
local GetCurrentMapAreaID = GetCurrentMapAreaID
local hashName = VanasKoS.hashName

-- Constants
local EVENT_LIST = 1
local PLAYERS_LIST = 2
local MAP_LIST = 3
local MAX_LIST = 3

-- Local Variables
local myName = nil
local myRealm = nil
local shownList = nil
local lastDamageFrom = {}
local lastDamageTo = {}
local DamageFromArray = {}

-- sort functions

-- sorts by index
local function SortByKey(val1, val2)
	return (val1 > val2)
end
local function SortByKeyReverse(val1, val2)
	return (val1 < val2)
end

-- sorts by name
local function SortByName(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].name
		local cmp2 = list[val2].name
		return (cmp1 > cmp2)
	end
	return false
end
local function SortByNameReverse(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].name
		local cmp2 = list[val2].name
		return (cmp1 < cmp2)
	end
	return false
end

-- sorts by myname
local function SortByMyName(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].myname
		local cmp2 = list[val2].myname
		return (cmp1 > cmp2)
	end
	return false
end
local function SortByMyNameReverse(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].myname
		local cmp2 = list[val2].myname
		return (cmp1 < cmp2)
	end
	return false
end

-- sorts by time
local function SortByTime(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].time
		local cmp2 = list[val2].time
		return (cmp1 > cmp2)
	end
	return false
end
local function SortByTimeReverse(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].time
		local cmp2 = list[val2].time
		return (cmp1 < cmp2)
	end
	return false
end

-- sorts by type (win/loss)
local function SortByType(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].type
		local cmp2 = list[val2].type
		return (cmp1 > cmp2)
	end
	return false
end
local function SortByTypeReverse(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = list[val1].type
		local cmp2 = list[val2].type
		return (cmp1 < cmp2)
	end
	return false
end

-- sorts by type map
local function SortByMap(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = val1
		local cmp2 = val2
		return (cmp1 > cmp2)
	end
	return false
end
local function SortByMapCount(val1, val2)
	if (list) then
		local cmp1 = val1
		local cmp2 = val2
		return (cmp1 < cmp2)
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
		return (cmp1 > cmp2)
	end
	return false
end
local function SortByCountReverse(val1, val2)
	local list = shownList
	if (list) then
		local cmp1 = countEntries(list[val1])
		local cmp2 = countEntries(list[val2])
		return (cmp1 < cmp2)
	end
	return false
end

function VanasKoSPvPDataGatherer:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("PvPDataGatherer", {
		profile = {
			Enabled = true,
		},
		global = {
			pvplog = {
				event = {},
				player = {},
				map = {},
			},
		}
	})

	VanasKoSGUI:AddModuleToggle("PvPDataGatherer", L["PvP Data Gathering"])

	VanasKoS:RegisterList(7, "PVPLOG", L["PvP Log"], self)
	VanasKoSGUI:RegisterList("PVPLOG", self)

	-- register sort options for the lists this module provides
--	VanasKoSGUI:RegisterSortOption({"PVPLOG"}, "byname", L["by name"], L["sort by name"], SortByIndex, SortByIndexReverse)

--	VanasKoSGUI:SetDefaultSortFunction({"PVPLOG"}, SortByKey)

	self:SetEnabledState(self.db.profile.Enabled)
	self.group = EVENT_LIST
	myName = UnitName("player")
	myRealm = GetRealmName()
end

function VanasKoSPvPDataGatherer:FilterFunction(key, value, searchBoxText)
	return (searchBoxText == "") or (key:find(searchBoxText) ~= nil)
end

function VanasKoSPvPDataGatherer:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
	local group = self.group
	if(list == "PVPLOG" and value) then
		local playerKey = nil
		if group == EVENT_LIST then
			playerKey = value.name and hashName(value.name, value.realm)
			playerName = value.name
		elseif group == PLAYERS_LIST then
			playerKey = key
			playerName = key
		end

		if group == EVENT_LIST or group == PLAYERS_LIST then
			local listname = select(2, VanasKoS:IsOnList(nil, playerKey))
			if(listname == "PLAYERKOS") then
				buttonText1:SetText(format("%s%s|r", PURPLE, playerName))
			elseif(listname == "HATELIST") then
				buttonText1:SetText(format("%s%s|r", RED, playerName))
			elseif(listname == "NICELIST") then
				buttonText1:SetText(format("%s%s|r", GREEN, playerName))
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
		VanasKoSListFrameChangeButton:Disable()
		VanasKoSListFrameAddButton:Disable()
		VanasKoSListFrameRemoveButton:Enable()
	end
end

function VanasKoSPvPDataGatherer:HideList(list)
	if(list == "PVPLOG") then
		VanasKoSListFrameChangeButton:Enable()
		VanasKoSListFrameAddButton:Enable()
		VanasKoSListFrameRemoveButton:Enable()
	end
end

function VanasKoSPvPDataGatherer:GetList(list, group)
	if group == nil then
		group = self.group
	end
	if(list == "PVPLOG") then
		if group == EVENT_LIST then
			return self.db.global.pvplog.event
		elseif group == PLAYERS_LIST then
			return self.db.global.pvplog.players
		elseif group == MAP_LIST then
			return self.db.global.pvplog.map
		end
	end
	return nil
end


function VanasKoSPvPDataGatherer:AddEntry(list, key, data)
	if(list == "PVPLOG") then
		local pvpEventLog = VanasKoS:GetList("PVPLOG", EVENT_LIST)
		local pvpPlayerLog = VanasKoS:GetList("PVPLOG", PLAYERS_LIST)
		local pvpMapLog = VanasKoS:GetList("PVPLOG", MAP_LIST)
		eventkey = key .. (data.time or time())
		pvpEventLog[eventkey] = {
			name = data.name,
			realm = data.realm,
			time = data.time,
			myname = data.myname,
			myrealm = data.myrealm,
			mylevel = data.mylevel,
			enemylevel = data.enemylevel,
			type = data.type,
			mapID  = data.mapID,
			x = data.x,
			y = data.y
		}

		if (data.mapID) then
			if (not pvpMapLog[data.mapID]) then
				pvpMapLog[data.mapID] = {}
			end
			tinsert(pvpMapLog[data.mapID], eventkey)
		end

		if (not pvpPlayerslog[key]) then
			pvpPlayerslog[key] = {}
		end
		tinsert(pvpPlayerslog[key], eventkey)
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
				local playerKey = hashName(pvpEventLog[key].name, pvpEventLog[key].realm)
				local mapKey = pvpEventLog[key].mapID

				--VanasKoS:Print("removing " .. key .. " from pvp event log")
				pvpEventLog[key] = nil
				removed = true

				if pvpPlayersLog[playerKey] then
					for j, zhash in ipairs(pvpPlayersLog[key]) do
						if (zhash == key) then
							--VanasKoS:Print("removing " .. playerKey .. "-" .. j .. " from pvp player log")
							tremove(pvpPlayersLog[playerKey], j)
							break
						end
					end
					if (next(pvpPlayerLog[playerKey]) == nil) then
						pvpPlayerLog[playerKey] = nil
					end
				end
				if pvpMapLog[mapKey] then
					for j, zhash in ipairs(pvpMapLog[key]) do
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
				pvpPlayerLog[key] = nil
				removed = true
			end
		elseif (group == MAP_LIST) then
			if (pvpMapLog[key]) then
				for _, eventKey in ipairs(pvpMapLog[key]) do
					local event = pvpEventLog[eventKey]
					if (event and event.name and event.realm) then
						local playerKey = hashName(event.name, event.realm)
						for j, zhash in ipairs(pvpPlayerLog[playerKey]) do
							if (zhash == eventKey) then
								--VanasKoS:Print("removing " .. playerKey .. "-" .. j .. " from pvp player log")
								tremove(pvpMapLog[playerKey], j)
								break
							end
						end
						if (next(pvpPlayerLog[playerKey]) == nil) then
							pvpPlayerLog[playerKey] = nil
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
			VanasKoSGUI:SetColumnSort(3, SortByTime, SortByTimeReverse)
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
			VanasKoSGUI:SetColumnSort(1, SortByKey, SortByMyKeyReverse)
			VanasKoSGUI:SetColumnSort(2, SortByCount, SortByCountReverse)
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
			VanasKoSGUI:SetColumnSort(2, SortByCount, SortByCountReverse)
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
end

function VanasKoSPvPDataGatherer:OnEnable()
	self:RegisterMessage("VanasKoS_PvPDamage", "PvPDamage")
	self:RegisterMessage("VanasKoS_PvPDeath", "PvPDeath")
end

function VanasKoSPvPDataGatherer:PvPDamage(message, srcName, srcRealm, dstName, dstRealm, amount)
	if (srcName == myName) then
		self:DamageDoneTo(dstName, dstRealm, amount)
	elseif (dstName == myName) then
		self:DamageDoneFrom(srcName, srcRealm, amount)
	end
end

function VanasKoSPvPDataGatherer:PvPDeath(message, name, realm)
	if (name ~= myName and lastDamageTo) then
		for i=1,#lastDamageTo do
			if(lastDamageTo[i] and lastDamageTo[i].name == name and lastDamageTo[i].realm == realm) then
				self:SendMessage("VanasKoS_PvPWin", name, realm)
				self:LogPvPWin(name, realm)
				tremove(lastDamageTo, i)
			end
		end
	else
		-- TODO: Blame kill on player who caused the most damage?
		if (lastDamageFrom.time ~= nil) then
			if((time() - lastDamageFrom.time) < 5) then
				self:SendMessage("VanasKoS_PvPLoss", lastDamageFrom.name, lastDamageFrom.realm)
				self:LogPvPLoss(lastDamageFrom.name, lastDamageFrom.realm)
			end
		end
		wipe(lastDamageFrom)
		wipe(lastDamageTo)
	end
end

function VanasKoSPvPDataGatherer:DamageDoneFrom(name, realm)
	if(name and realm) then
		lastDamageFrom = {
			name = name,
			realm = realm,
			time = time()
		}

		self:AddLastDamageFrom(name, realm)
	end
end

function VanasKoSPvPDataGatherer:DamageDoneTo(name, realm)
	tinsert(lastDamageTo, 1,  {
		name = name,
		realm = realm,
		time = time()
	})

	if(#lastDamageTo < 2) then
		return
	end

	for i=2,#lastDamageTo do
		if(lastDamageTo[i] and lastDamageTo[i].name == name and lastDamageTo[i].realm == realm) then
			tremove(lastDamageTo, i)
		end
	end

	if(#lastDamageTo > 10) then
		tremove(lastDamageTo, 11)
	end
end

function VanasKoSPvPDataGatherer:LogPvPLoss(name, realm)
	assert(name)
	assert(realm)

	VanasKoS:Print(format(L["PvP Loss versus %s registered."], name))

	-- /script local t = C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player") for k,v in pairs(t) do print("k" .. k) end
	local mapID = C_Map.GetBestMapForUnit("player")
	local x, y = C_Map.GetPlayerMapPosition(mapID, "player"):GetXY()
	local data = VanasKoS:GetPlayerData(name)
	local key = hashName(name, realm)

	VanasKoS:AddEntry("PVPLOG", key, {
		time = time(),
		myname = myName,
		myrealm = myRealm,
		mylevel = UnitLevel("player"),
		name = name,
		enemyguild = data and data.guild or nil,
		realm = realm,
		enemylevel = data and data.level or 0,
		type = "loss",
		mapID = mapID,
		x = x,
		y = y,
		inBg = VanasKoS:IsInBattleground(),
		inArena = VanasKoS:IsInArena(),
		inCombatZone = VanasKoS:IsInCombatZone(),
		inFfa = VanasKoS:IsInFfaZone()
	})
end

function VanasKoSPvPDataGatherer:LogPvPWin(name, realm)
	assert(name)
	assert(realm)

	VanasKoS:Print(format(L["PvP Win versus %s registered."], name))

	-- Same as losses, but it should be even more rare that you can win in
	-- pvp while staring at the map, so shouldn't be a problem
	local mapID = C_Map.GetBestMapForUnit("player")
	local x, y = GetPlayerMapPosition(mapID, "player")
	local data = VanasKoS:GetPlayerData(name)
	local key = hashName(name, realm)

	VanasKoS:AddEntry("PVPLOG", key, {
		time = time(),
		myname = myName,
		myrealm = myRealm,
		mylevel = UnitLevel("player"),
		name = name,
		realm = realm,
		enemylevel = data and data.level or 0,
		type = "win",
		mapID  = mapID,
		x = x,
		y = y,
		inBg = VanasKoS:IsInBattleground(),
		inArena = VanasKoS:IsInArena(),
		inCombatZone = VanasKoS:IsInCombatZone(),
		inFfa = VanasKoS:IsInFfaZone()
	})
end

function VanasKoSPvPDataGatherer:AddLastDamageFrom(name, realm)
	local key = hashName(name, realm)
	tinsert(DamageFromArray, 1, {
		key = key,
		name = name,
		realm = realm,
		time = time()
	})
	if(#DamageFromArray < 2) then
		return
	end

	for i=#DamageFromArray,2,-1 do
		if(DamageFromArray[i] and DamageFromArray[i].key == key) then
			tremove(DamageFromArray, i)
		end
	end

	for i=#DamageFromArray,11,-1 do
		tremove(DamageFromArray, i)
	end
end

function VanasKoSPvPDataGatherer:GetDamageFromArray()
	return DamageFromArray
end

function VanasKoSPvPDataGatherer:GetDamageToArray()
	return lastDamageTo
end

function VanasKoSPvPDataGatherer:HoverType()
	if (self.group == PLAYERS_LIST) then
		return "playerlog"
	elseif (self.group == EVENT_LIST) then
		return "eventlog"
	elseif (self.group == MAP_LIST) then
		return "maplog"
	end
end

-- /script VanasKoSPvPDataGatherer:AddTestData(100)
function VanasKoSPvPDataGatherer:AddTestData(cnt)
	for i=1,cnt do
		local name = "test" .. i
		local realm = "some random realm"
		local key = hashName(name, realm)
		VanasKoS:SendMessage("VanasKoS_Player_Detected", {
			name=name,
			realm=realm,
			guild="Evil is us",
			guildRank="Recruit",
			faction = "Alliance",
			mapID = C_Map.GetBestMapForUnit("player"),
			class = "Tank",
			classEnglish = "Warrior",
			race = "Gerbil",
			raceEnglish = "Gnome",
			gender = FEMALE,
			guid = "Player-XXXXXXXX",
		})
		local special = math.random()
		VanasKoS:AddEntry("PVPLOG", key, {
			name=name,
			realm=realm,
			time=time(),
			myname="bob",
			myrealm="the good one",
			mylevel=15,
			enemylevel=16,
			mapID=C_Map.GetBestMapForUnit("player"),
			type=math.random() > 0.5 and "win" or "loss",
			x=math.random(),
			y=math.random(),
			inBg = special < 0.2,
			inArena = special >= 0.2 and special < 0.4,
			inCombatZone = special >=0.4 and special < 0.6,
			inFfa = special >= 0.6 and special < 0.8
		})
	end
end
