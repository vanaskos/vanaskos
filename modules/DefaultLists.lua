--[[----------------------------------------------------------------------
      DefaultLists Module - Part of VanasKoS
Handles the Default lists (KOS, GUILDKOS, HATE, NICE)
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/DefaultLists", false)
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")
local VanasKoSGUI = VanasKoS:GetModule("GUI")
local VanasKoSDefaultLists = VanasKoS:NewModule("DefaultLists", "AceEvent-3.0")

-- Global wow strings and variables
local NAME, GUILD, LEVEL_ABBR, CLASS, ZONE = NAME, GUILD, LEVEL_ABBR, CLASS, ZONE
local RAID_CLASS_COLORS, NORMAL_FONT_COLOR = RAID_CLASS_COLORS, NORMAL_FONT_COLOR

-- Declare some common global functions local
local tonumber = tonumber
local tinsert = tinsert
local strfind = string.find
local strgsub = string.gsub
local time = time
local SecondsToTime = SecondsToTime
local format = format
local GetMapNameByID = GetMapNameByID
local GetCursorPosition = GetCursorPosition
local IsShiftKeyDown = IsShiftKeyDown
local UnitName = UnitName

-- Local variables
local entryKey, entryData

-- sort functions

-- sorts by index
local function SortByIndex(val1, val2)
	return val1 < val2
end
local function SortByIndexReverse(val1, val2)
	return val1 > val2
end

-- sorts from a-z
local function SortByReason(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	local str1 = list[val1].reason or L["_Reason Unknown_"]
	local str2 = list[val2].reason or L["_Reason Unknown_"]
	return (str1:lower() < str2:lower())
end
local function SortByReasonReverse(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	local str1 = list[val1].reason or L["_Reason Unknown_"]
	local str2 = list[val2].reason or L["_Reason Unknown_"]
	return (str1:lower() > str2:lower())
end

local function SortByCreateDate(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	local cmp1 = list[val1].created or 2^30
	local cmp2 = list[val2].created or 2^30
	return (cmp1 > cmp2)
end
local function SortByCreateDateReverse(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	local cmp1 = list[val1].created or 2^30
	local cmp2 = list[val2].created or 2^30
	return (cmp1 < cmp2)
end

-- sorts from a-z
local function SortByCreator(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	local str1 = list[val1].creator or ""
	local str2 = list[val2].creator or ""
	return (str1:lower() < str2:lower())
end
local function SortByCreatorReverse(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	local str1 = list[val1].creator or ""
	local str2 = list[val2].creator or ""
	return (str1:lower() > str2:lower())
end

-- sorts from a-z
local function SortByOwner(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	local str1 = list[val1].owner or ""
	local str2 = list[val2].owner or ""
	return (str1:lower() < str2:lower())
end
local function SortByOwnerReverse(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	local str1 = list[val1].owner or ""
	local str2 = list[val2].owner or ""
	return (str1:lower() > str2:lower())
end

-- sorts from lowest to highest level
local function SortByLevel(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA")
	if(list) then
		local lvl1 = list[val1] and (strgsub(list[val1].level, "+", ".5"))
		local lvl2 = list[val2] and (strgsub(list[val2].level, "+", ".5"))
		return ((tonumber(lvl1) or 0) < (tonumber(lvl2) or 0))
	end
	return false
end
local function SortByLevelReverse(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA")
	if(list) then
		local lvl1 = list[val1] and (strgsub(list[val1].level, "+", ".5"))
		local lvl2 = list[val2] and (strgsub(list[val2].level, "+", ".5"))
		return ((tonumber(lvl1) or 0) > (tonumber(lvl2) or 0))
	end
	return false
end

-- sorts from early to later
local function SortByLastSeen(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA")
	if(list) then
		local now = time()
		local cmp1 = list[val1] and list[val1].lastseen and (now - list[val1].lastseen) or 2^30
		local cmp2 = list[val2] and list[val2].lastseen and (now - list[val2].lastseen) or 2^30
		return (cmp1 < cmp2)
	end
	return false
end
local function SortByLastSeenReverse(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA")
	if(list) then
		local now = time()
		local cmp1 = list[val1] and list[val1].lastseen and (now - list[val1].lastseen) or 2^30
		local cmp2 = list[val2] and list[val2].lastseen and (now - list[val2].lastseen) or 2^30
		return (cmp1 > cmp2)
	end
	return false
end

-- sorts from a-z
local function SortByClass(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA")
	if(list) then
		local str1 = list[val1] and list[val1].class or ""
		local str2 = list[val2] and list[val2].class or ""
		return (str1:lower() < str2:lower())
	end
	return false
end
local function SortByClassReverse(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA")
	if(list) then
		local str1 = list[val1] and list[val1].class or ""
		local str2 = list[val2] and list[val2].class or ""
		return (str1:lower() > str2:lower())
	end
	return false
end

-- sorts from a-z
local function SortByGuild(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA")
	if(list) then
		local str1 = list[val1] and list[val1].guild or ""
		local str2 = list[val2] and list[val2].guild or ""
		return (str1:lower() < str2:lower())
	end
	return false
end
local function SortByGuildReverse(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA")
	if(list) then
		local str1 = list[val1] and list[val1].guild or ""
		local str2 = list[val2] and list[val2].guild or ""
		return (str1:lower() > str2:lower())
	end
	return false
end

-- sorts from a-z
local function SortByZone(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA")
	if(list) then
		local str1 = list[val1] and list[val1].areaID and GetMapNameByID(list[val1].areaID) or ""
		local str2 = list[val2] and list[val2].areaID and GetMapNameByID(list[val2].areaID) or ""
		return (str1:lower() < str2:lower())
	end
	return false
end
local function SortByZoneReverse(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA")
	if(list) then
		local str1 = list[val1] and list[val1].areaID and GetMapNameByID(list[val1].areaID) or ""
		local str2 = list[val2] and list[val2].areaID and GetMapNameByID(list[val2].areaID) or ""
		return (str1:lower() > str2:lower())
	end
	return false
end

function VanasKoSDefaultLists:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("DefaultLists", {
		factionrealm = {
			koslist = {
				players = {},
				guilds = {}
			},
			hatelist = {
				players = {},
			},
			nicelist = {
				players = {},
			},
		},
		profile = {
			ShowOnlyMyEntries = false
		}
	})

	-- register lists this modules provides at the core
	VanasKoS:RegisterList(1, "PLAYERKOS", L["Player KoS"], self)
	VanasKoS:RegisterList(2, "GUILDKOS", L["Guild KoS"], self)
	VanasKoS:RegisterList(3, "HATELIST", L["Hatelist"], self)
	VanasKoS:RegisterList(4, "NICELIST", L["Nicelist"], self)

	-- register lists this modules provides in the GUI
	VanasKoSGUI:RegisterList("PLAYERKOS", self)
	VanasKoSGUI:RegisterList("GUILDKOS", self)
	VanasKoSGUI:RegisterList("HATELIST", self)
	VanasKoSGUI:RegisterList("NICELIST", self)

	-- register sort options for the lists this module provides
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "byname", L["by name"], L["sort by name"], SortByIndex, SortByIndexReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "bycreatedate", L["by create date"], L["sort by date created"], SortByCreateDate, SortByCreateDateReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "bycreator", L["by creator"], L["sort by creator"], SortByCreator, SortByCreatorReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "byreason", L["by reason"], L["sort by reason"], SortByReason, SortByReasonReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "byowner", L["by owner"], L["sort by owner"], SortByOwner, SortByOwnerReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST"}, "byguild", L["by guild"], L["sort by guild"], SortByGuild, SortByGuildReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST"}, "bylevel", L["by level"], L["sort by level"], SortByLevel, SortByLevelReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST"}, "byclass", L["by class"], L["sort by class"], SortByClass, SortByClassReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST"}, "bylastseen", L["by last seen"], L["sort by last seen"], SortByLastSeen, SortByLastSeenReverse)

	VanasKoSGUI:SetDefaultSortFunction({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, SortByIndex)

	-- first sort function is sorting by name
	VanasKoSGUI:SetSortFunction(SortByIndex)

	-- show the PLAYERKOS list after startup
	VanasKoSGUI:ShowList("PLAYERKOS")

	VanasKoSGUI.listFrame.checkBox:SetText(L["Only my entries"])
	VanasKoSGUI.listFrame.checkBox:SetChecked(VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries)
	VanasKoSGUI.listFrame.checkBox:SetScript("OnClick", function(frame)
		VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries = not VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries
		VanasKoSGUI:UpdateShownList()
	end)
end

function VanasKoSDefaultLists:OnEnable()
end

function VanasKoSDefaultLists:OnDisable()
end

function VanasKoSDefaultLists:ShowList()
	VanasKoSGUI.listFrame.checkBox:Show()
end

function VanasKoSDefaultLists:HideList()
	VanasKoSGUI.listFrame.checkBox:Hide()
end

function VanasKoSDefaultLists:HoverType()
	local list = VANASKOS.showList
	if (list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST") then
		return "player"
	elseif (list == "GUILDKOS") then
		return "guild"
	end
end

-- FilterFunction as called by VanasKoSGUI - key is the index from the table
-- entry that gets displayed, value the data associated with the index.
-- searchBoxText the text entered in the searchBox
-- returns true if the entry should be shown, false otherwise
function VanasKoSDefaultLists:FilterFunction(key, value, searchBoxText)
	if(VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries and value.owner ~= nil) then
		return false
	end
	if(searchBoxText == "") then
		return true
	end

	if(key:find(searchBoxText) ~= nil) then
		return true
	end

	if(value.reason and (value.reason:lower():find(searchBoxText) ~= nil)) then
		return true
	end

	if(value.owner and (value.owner:lower():find(searchBoxText) ~= nil)) then
		return true
	end

	return false
end


function VanasKoSDefaultLists:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
	if(key and value and (list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST")) then
		local data = VanasKoS:GetPlayerData(key)
		-- name, guildrank, guild, level, race, class, gender, zone, lastseen
		local owner = ""
		local creator = ""
		local displayname = value.name
		if(value.owner ~= nil and value.owner ~= "") then
			owner = value.owner
			displayname = "|cffff7700" .. displayname .. "|r"
		end
		if(value.creator ~= nil and value.creator ~= "") then
			creator = value.creator
		end
		if(value.wanted == true) then
			displayname = "|cffff0000" .. displayname .. "|r"
		end
		buttonText1:SetText(displayname)
		if(not self.group or self.group == 1) then
			buttonText2:SetText(value and value.reason or L["_Reason Unknown_"])
		elseif(self.group == 2) then
			buttonText2:SetText(data and data.guild or "")
			buttonText3:SetText(data and data.level or "")
			buttonText4:SetText(data and data.class or "")
			if (data and data.classEnglish) then
				local classColor = RAID_CLASS_COLORS[data.classEnglish] or NORMAL_FONT_COLOR
				buttonText4:SetTextColor(classColor.r, classColor.g, classColor.b)
			end
		elseif(self.group == 3) then
			if(data and data.lastseen) then
				local timespan = SecondsToTime(time() - data.lastseen)
				if(timespan == "") then
					timespan = L["0 Secs"]
				end
				buttonText2:SetText(timespan)
			else
				buttonText2:SetText(format(L["never seen"]))
			end
			local mapInfo = data and data.mapID and C_Map.GetMapInfo(data.mapID) or nil
			if (mapInfo) then
				buttonText3:SetText(mapInfo.name)
			else
				buttonText3:SetText("")
			end
		else
			buttonText2:SetText(owner)
			buttonText3:SetText(creator)
		end
	elseif(list == "GUILDKOS") then
		local displayname = "<" .. value.name .. ">"
		if(value.owner ~= nil and value.owner ~= "") then
			displayname = "|cffff7700" .. displayname .. "|r"
		end
		buttonText1:SetText(displayname)
		if(not self.group or self.group == 1) then
			buttonText2:SetText(value and value.reason or L["_Reason Unknown_"])
			buttonText3:SetText("")
			buttonText4:SetText(value.owner and value.owner or "")
		else
			if (value and value.owner) then
				buttonText2:SetText(value.owner)
			else
				buttonText2:SetText("")
			end
			if (value and value.creator) then
				buttonText3:SetText(value.creator)
			else
				buttonText3:SetText("")
			end
		end
	end

	button:Show()
end

function VanasKoSDefaultLists:SetupColumns(list)
	if(list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST") then
		if(not self.group or self.group == 1) then
			VanasKoSGUI:SetNumColumns(2)
			VanasKoSGUI:SetColumnWidth(1, 83)
			VanasKoSGUI:SetColumnWidth(2, 220)
			VanasKoSGUI:SetColumnName(1, NAME)
			VanasKoSGUI:SetColumnName(2, L["Reason"])
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse)
			VanasKoSGUI:SetColumnSort(2, SortByReason, SortByReasonReverse)
			VanasKoSGUI:SetColumnType(1, "normal")
			VanasKoSGUI:SetColumnType(2, "highlight")
			VanasKoSGUI:SetToggleButtonText(L["Reason"])
		elseif(self.group == 2) then
			VanasKoSGUI:SetNumColumns(4)
			VanasKoSGUI:SetColumnWidth(1, 83)
			VanasKoSGUI:SetColumnWidth(2, 100)
			VanasKoSGUI:SetColumnWidth(3, 32)
			VanasKoSGUI:SetColumnWidth(4, 92)
			VanasKoSGUI:SetColumnName(1, NAME)
			VanasKoSGUI:SetColumnName(2, GUILD)
			VanasKoSGUI:SetColumnName(3, LEVEL_ABBR)
			VanasKoSGUI:SetColumnName(4, CLASS)
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse)
			VanasKoSGUI:SetColumnSort(2, SortByGuild, SortByGuildReverse)
			VanasKoSGUI:SetColumnSort(3, SortByLevel, SortByLevelReverse)
			VanasKoSGUI:SetColumnSort(4, SortByClass, SortByClassReverse)
			VanasKoSGUI:SetColumnType(1, "normal")
			VanasKoSGUI:SetColumnType(2, "highlight")
			VanasKoSGUI:SetColumnType(3, "number")
			VanasKoSGUI:SetColumnType(4, "highlight")
			VanasKoSGUI:SetToggleButtonText(L["Player Info"])
		elseif(self.group == 3) then
			VanasKoSGUI:SetNumColumns(3)
			VanasKoSGUI:SetColumnWidth(1, 83)
			VanasKoSGUI:SetColumnWidth(2, 110)
			VanasKoSGUI:SetColumnWidth(3, 110)
			VanasKoSGUI:SetColumnName(1, NAME)
			VanasKoSGUI:SetColumnName(2, L["Last Seen"])
			VanasKoSGUI:SetColumnName(3, ZONE)
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse)
			VanasKoSGUI:SetColumnSort(2, SortByLastSeen, SortByLastSeenReverse)
			VanasKoSGUI:SetColumnSort(3, SortByZone, SortByZoneReverse)
			VanasKoSGUI:SetColumnType(1, "normal")
			VanasKoSGUI:SetColumnType(2, "highlight")
			VanasKoSGUI:SetColumnType(3, "highlight")
			VanasKoSGUI:SetToggleButtonText(L["Last Seen"])
		else
			VanasKoSGUI:SetNumColumns(3)
			VanasKoSGUI:SetColumnWidth(1, 83)
			VanasKoSGUI:SetColumnWidth(2, 110)
			VanasKoSGUI:SetColumnWidth(3, 110)
			VanasKoSGUI:SetColumnName(1, NAME)
			VanasKoSGUI:SetColumnName(2, L["Owner"])
			VanasKoSGUI:SetColumnName(3, L["Creator"])
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse)
			VanasKoSGUI:SetColumnSort(2, SortByOwner, SortByOwnerReverse)
			VanasKoSGUI:SetColumnSort(3, SortByCreator, SortByCreatorReverse)
			VanasKoSGUI:SetColumnType(1, "normal")
			VanasKoSGUI:SetColumnType(2, "highlight")
			VanasKoSGUI:SetColumnType(3, "highlight")
			VanasKoSGUI:SetToggleButtonText(L["Owner"])
		end
		VanasKoSGUI:ShowToggleButtons()
	elseif(list == "GUILDKOS") then
		if(not self.group or self.group == 1) then
			VanasKoSGUI:SetNumColumns(2)
			VanasKoSGUI:SetColumnWidth(1, 105)
			VanasKoSGUI:SetColumnWidth(2, 208)
			VanasKoSGUI:SetColumnName(1, GUILD)
			VanasKoSGUI:SetColumnName(2, L["Reason"])
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse)
			VanasKoSGUI:SetColumnSort(2, SortByReason, SortByReasonReverse)
			VanasKoSGUI:SetColumnType(1, "normal")
			VanasKoSGUI:SetColumnType(2, "highlight")
			VanasKoSGUI:SetToggleButtonText(L["Reason"])
			VanasKoSGUI:ShowToggleButtons()
		else
			VanasKoSGUI:SetNumColumns(3)
			VanasKoSGUI:SetColumnWidth(1, 83)
			VanasKoSGUI:SetColumnWidth(2, 110)
			VanasKoSGUI:SetColumnWidth(3, 110)
			VanasKoSGUI:SetColumnName(1, NAME)
			VanasKoSGUI:SetColumnName(2, L["Owner"])
			VanasKoSGUI:SetColumnName(3, L["Creator"])
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse)
			VanasKoSGUI:SetColumnSort(2, SortByOwner, SortByOwnerReverse)
			VanasKoSGUI:SetColumnSort(3, SortByCreator, SortByCreatorReverse)
			VanasKoSGUI:SetColumnType(1, "normal")
			VanasKoSGUI:SetColumnType(2, "highlight")
			VanasKoSGUI:SetColumnType(3, "highlight")
			VanasKoSGUI:SetToggleButtonText(L["Owner"])
		end
	end
end

function VanasKoSDefaultLists:ToggleLeftButtonOnClick(button, frame)
	local list = VANASKOS.showList
	if(list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST") then
		if (not self.group or self.group < 4) then
			self.group = (self.group or 1) + 1
		else
			self.group = 1
		end
	elseif(list == "GUILDKOS") then
		if (not self.group or self.group < 2) then
			self.group = (self.group or 1) + 1
		else
			self.group = 1
		end
	end
	self:SetupColumns(list)
	VanasKoSGUI:ScrollFrameUpdate()
end

function VanasKoSDefaultLists:ToggleRightButtonOnClick(button, frame)
	local list = VANASKOS.showList
	if(list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST") then
		if (not self.group or self.group > 1) then
			self.group = (self.group or 5) - 1
		else
			self.group = 4
		end
	elseif(list == "GUILDKOS") then
		if (not self.group or self.group > 1) then
			self.group = (self.group or 3) - 1
		else
			self.group = 2
		end
	end
	self:SetupColumns(list)
	VanasKoSGUI:ScrollFrameUpdate()
end

function VanasKoSDefaultLists:IsOnList(list, key)
	local listVar = VanasKoS:GetList(list)
	if(listVar and listVar[key]) then
		return listVar[key]
	else
		return nil
	end
end

-- don't call this directly, call it via VanasKoS:AddEntry - it expects name to be lower case!
function VanasKoSDefaultLists:AddEntry(list, key, data)
	if (not key) then
		return
	end

	if(list == "PLAYERKOS") then
		self.db.factionrealm.koslist.players[key] = {
			name = data.name,
			reason = data.reason,
			created = time(),
			creator = UnitName("player"),
		}
	elseif(list == "GUILDKOS") then
		self.db.factionrealm.koslist.guilds[key] = {
			name = data.name,
			reason = data.reason,
			created = time(),
			creator = UnitName("player"),

		}
	elseif(list == "HATELIST") then
		if(VanasKoS:IsOnList("NICELIST", key)) then
			VanasKoS:Print(format(L["Entry %s is already on Nicelist"], key))
			return
		end
		self.db.factionrealm.hatelist.players[key] = {
			name = data.name,
			reason = data.reason,
			created = time(),
			creator = UnitName("player"),

		}
	elseif(list == "NICELIST") then
		if(VanasKoS:IsOnList("HATELIST", key)) then
			VanasKoS:Print(format(L["Entry %s is already on Hatelist"], key))
			return
		end
		self.db.factionrealm.nicelist.players[key] = {
			name = data.name,
			reason = data.reason,
			created = time(),
			creator = UnitName("player"),

		}
	end

	self:SendMessage("VanasKoS_List_Entry_Added", list, key, data)
end

function VanasKoSDefaultLists:RemoveEntry(listname, key)
	local list = VanasKoS:GetList(listname)
	local data
	if(list and list[key]) then
		data = list[key]
		list[key] = nil
		self:SendMessage("VanasKoS_List_Entry_Removed", listname, key, data)
	end
end

function VanasKoSDefaultLists:GetList(list)
	if(list == "PLAYERKOS") then
		return self.db.factionrealm.koslist.players
	elseif(list == "GUILDKOS") then
		return self.db.factionrealm.koslist.guilds
	elseif(list == "HATELIST") then
		return self.db.factionrealm.hatelist.players
	elseif(list == "NICELIST") then
		return self.db.factionrealm.nicelist.players
	else
		return nil
	end
end

local function ListButtonOnRightClickMenu()
	local x, y = GetCursorPosition()
	local uiScale = UIParent:GetEffectiveScale()
	local menuItems = {
		{
			text = entryData.name,
			isTitle = true,
		},
		{
			text = L["Move to Player KoS"],
			func = function()
				VanasKoS:RemoveEntry(VANASKOS.showList, entryKey)
				VanasKoS:AddEntry("PLAYERKOS", entryKey, entryData)
			end,
		},
		{
			text = L["Move to Hatelist"],
			func = function()
				VanasKoS:RemoveEntry(VANASKOS.showList, entryKey)
				VanasKoS:AddEntry("HATELIST", entryKey, entryData)
			end
		},
		{
			text = L["Move to Nicelist"],
			func = function()
				VanasKoS:RemoveEntry(VANASKOS.showList, entryKey)
				VanasKoS:AddEntry("NICELIST", entryKey, entryData)
			end
		},
		{
			text = L["Remove Entry"],
			func = function()
				VanasKoS:RemoveEntry(VANASKOS.showList, entryKey)
			end
		}
	}

	if(VANASKOS.showList == "PLAYERKOS"and VanasKoS:ModuleEnabled("DistributedTracker")) then
		tinsert(menuItems, {
			text = L["Wanted"],
			func = function()
				local list = VanasKoS:GetList("PLAYERKOS")
				if (not list[entryKey].wanted) then
					list[entryKey].wanted = true
				else
					list[entryKey].wanted = nil
				end
				VanasKoSGUI:Update()
			end,
			checked = function()
				local list = VanasKoS:GetList("PLAYERKOS")
				return list[entryKey].wanted
			end,
		})
	end

	EasyMenu(menuItems, VanasKoSGUI.dropDownFrame, UIParent, x/uiScale, y/uiScale, "MENU")
end

function VanasKoSDefaultLists:ListButtonOnClick(button, frame)
	local id = frame:GetID()
	entryKey, entryData = VanasKoSGUI:GetListKeyForIndex(id)
	if(id == nil or entryKey == nil) then
		return
	end

	if(button == "LeftButton") then
		if(IsShiftKeyDown()) then
			if(not entryData) then
				return
			end

			local str
			if(entryData.owner) then
				str = format(L["[%s] %s (%s) - Reason: %s"], entryData.owner, entryKey, VanasKoSGUI:GetListName(VANASKOS.showList), entryData.reason)
			else
				str = format(L["%s (%s) - Reason: %s"], entryData.name, VanasKoSGUI:GetListName(VANASKOS.showList), entryData.reason)
			end
			if(DEFAULT_CHAT_FRAME.editBox and str) then
				if(DEFAULT_CHAT_FRAME.editBox:IsVisible()) then
					DEFAULT_CHAT_FRAME.editBox:SetText(DEFAULT_CHAT_FRAME.editBox:GetText() .. str .. " ")
				end
			end
		end
		return
	end

	ListButtonOnRightClickMenu()
end
