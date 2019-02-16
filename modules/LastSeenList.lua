--[[----------------------------------------------------------------------
      LastSeenList Module - Part of VanasKoS
Keeps track of recently seen players
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/LastSeenList", false)
VanasKoSLastSeenList = VanasKoS:NewModule("LastSeenList", "AceEvent-3.0")

-- Global wow strings
local NAME = NAME

-- Declare some common global functions local
local assert = assert
local select = select
local pairs = pairs
local format = format
local time = time
local wipe = wipe
local SecondsToTime = SecondsToTime
local GetCursorPosition = GetCursorPosition
local hashName = VanasKoS.hashName

-- Constants
local PURPLE = "|cffff00ff"
local RED = "|cffff0000"
local GREEN = "|cff00ff00"
local WHITE = "|cffffffff"
local ORANGE = "|cffff7f00"

-- Local Variables
local lastseenlist = {}
local lastseenOptions = {}
local entryKey, entryValue


-- sorts by index
local function SortByIndex(val1, val2)
	return val1 < val2
end
local function SortByIndexReverse(val1, val2)
	return val1 > val2
end

-- sort current lastseen
local function SortByLastSeen(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	if(list ~= nil) then
		local cmp1 = 2^30
		local cmp2 = 2^30
		if(list[val1] ~= nil and list[val1].lastseen ~= nil) then
			cmp1 = time() - list[val1].lastseen
		end
		if(list[val2] ~= nil and list[val2].lastseen ~= nil) then
			cmp2 = time() - list[val2].lastseen
		end
		return (cmp1 < cmp2)
	end
	return false
end
local function SortByLastSeenReverse(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	if(list ~= nil) then
		local cmp1 = 2^30
		local cmp2 = 2^30
		if(list[val1] ~= nil and list[val1].lastseen ~= nil) then
			cmp1 = time() - list[val1].lastseen
		end
		if(list[val2] ~= nil and list[val2].lastseen ~= nil) then
			cmp2 = time() - list[val2].lastseen
		end
		return (cmp1 > cmp2)
	end
	return false
end

function VanasKoSLastSeenList:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("LastSeenList", {
		profile = {
			Enabled = true,
		}
	})

	VanasKoSGUI:RegisterSortOption({"LASTSEEN"}, "byname", L["by name"], L["sort by name"], SortByIndex, SortByIndexReverse)
	VanasKoSGUI:RegisterSortOption({"LASTSEEN"}, "bylastseen", L["by last seen"], L["sort by last seen"], SortByLastSeen, SortByLastSeenReverse)
	VanasKoSGUI:SetDefaultSortFunction({"LASTSEEN"}, SortByLastSeen)

	VanasKoSGUI:AddModuleToggle("LastSeenList", L["Last Seen List"])
end

function VanasKoSLastSeenList:OnEnable()
	if(not self.db.profile.Enabled) then
		self:SetEnabledState(false)
		return
	end
	if(VanasKoSDataGatherer) then
		if(VanasKoSDataGatherer.db.profile.StorePlayerDataPermanently == true) then
			lastseenlist = VanasKoSDataGatherer.db.realm.data.players or {}
		else
			-- Copy player data into the volatile lastseenlist
			for key, data in pairs(VanasKoSDataGatherer.db.global.data.players) do
				lastseenlist[key] = {}
				for k, v in pairs(data) do
					lastseenlist[key][k] = v
				end
				assert(lastseenlist[key].name)
				assert(lastseenlist[key].realm)
			end
		end
	end

	VanasKoS:RegisterList(5, "LASTSEEN", L["Last seen"], self)
	VanasKoSGUI:RegisterList("LASTSEEN", self)

	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected")
end

function VanasKoSLastSeenList:OnDisable()
	VanasKoSGUI:UnregisterList("LASTSEEN")
	VanasKoS:UnregisterList("LASTSEEN")
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
end

-- FilterFunction as called by VanasKoSGUI - key is the index from the table
-- entry that gets displayed, value the data associated with the index.
-- searchBoxText the text entered in the searchBox
-- returns true if the entry should be shown, false otherwise
function VanasKoSLastSeenList:FilterFunction(key, value, searchBoxText)
	if(searchBoxText == "") then
		return true
	end

	if(key:find(searchBoxText) ~= nil) then
		return true
	end

	return false
end

function VanasKoSLastSeenList:AddEntry(list, name, data)
end

function VanasKoSLastSeenList:RemoveEntry(listname, name)
	if(listname == "LASTSEEN") then
		for k, _ in pairs(lastseenlist) do
			lastseenlist[k] = nil
		end
	end
end

function VanasKoSLastSeenList:GetList(listname)
	return lastseenlist
end

function VanasKoSLastSeenList:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
	if(list == "LASTSEEN") then
		local listname = select(2, VanasKoS:IsOnList(nil, key))
		if(listname == "PLAYERKOS") then
			buttonText1:SetText(format("%s%s|r", PURPLE, value.name))
		elseif(listname == "HATELIST") then
			buttonText1:SetText(format("%s%s|r", RED, value.name))
		elseif(listname == "NICELIST") then
			buttonText1:SetText(format("%s%s|r", GREEN, value.name))
		elseif(value.faction == "friendly") then
			buttonText1:SetText(format("%s%s|r", WHITE, value.name))
		elseif(value.faction == "enemy") then
			buttonText1:SetText(format("%s%s|r", ORANGE, value.name))
		elseif(value and value.name) then
			buttonText1:SetText(format("%s%s|r", "", value.name))
		else
			buttonText1:SetText("unknown")
		end

		if(not value.lastseen) then
			buttonText2:SetText(L["never seen"])
		else
			local timespan = SecondsToTime(time() - value.lastseen)
			if(timespan == "") then
				buttonText2:SetText(L["0 Secs ago"])
			else
				buttonText2:SetText(format(L["%s ago"], timespan))
			end
		end
		button:Show()
	end
end

function VanasKoSLastSeenList:SetupColumns(list)
	if(list == "LASTSEEN") then
		if(not self.group or self.group == 1) then
			VanasKoSGUI:SetNumColumns(2)
			VanasKoSGUI:SetColumnWidth(1, 103)
			VanasKoSGUI:SetColumnWidth(2, 200)
			VanasKoSGUI:SetColumnName(1, NAME)
			VanasKoSGUI:SetColumnName(2, L["Last seen"])
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse)
			VanasKoSGUI:SetColumnSort(2, SortByLastSeen, SortByLastSeenReverse)
			VanasKoSGUI:SetColumnType(1, "normal")
			VanasKoSGUI:SetColumnType(2, "highlight")
			VanasKoSGUI:HideToggleButtons()
		end
	end
end

function VanasKoSLastSeenList:ToggleLeftButtonOnClick(button, frame)
	local list = VANASKOS.showList
	if(list == "LASTSEEN") then
		self.group = 1
	end
	self:SetupColumns(list)
	VanasKoSGUI:Update()
end

function VanasKoSLastSeenList:ToggleRightButtonOnClick(button, frame)
	local list = VANASKOS.showList
	if(list == "LASTSEEN") then
		self.group = 1
	end
	self:SetupColumns(list)
	VanasKoSGUI:Update()
end

-- /script for k,v in pairs(VanasKoS:GetList("LASTSEEN")) do for f,j in pairs(v) do print("key: " .. f .. ", val: " .. j) end end
function VanasKoSLastSeenList:IsOnList(listname, key)
	if(listname == "LASTSEEN") then
		if(lastseenlist[key]) then
			return lastseenlist[key]
		end
	end
	return nil
end

function VanasKoSLastSeenList:Player_Detected(message, data)
	assert(data.name)
	assert(data.realm)
	local key = hashName(data.name, data.realm)

	if(not (VanasKoSDataGatherer and VanasKoSDataGatherer.db.profile.StorePlayerDataPermanently)) then
		if(not lastseenlist[key]) then
			lastseenlist[key] = {}
		end

		for k, v in pairs(data) do
			lastseenlist[key][k] = v
		end
		lastseenlist[key].lastseen = time()
	end

	-- update the frame
	self:SendMessage("VanasKoS_List_Entry_Added", "LASTSEEN", nil, nil)
end

function VanasKoSLastSeenList:ShowList(list)
	if(list == "LASTSEEN") then
		--VanasKoSListFrameSyncButton:Disable()
		VanasKoSListFrameChangeButton:Disable()
		VanasKoSListFrameAddButton:Disable()
		VanasKoSListFrameRemoveButton:Disable()
	end
end

function VanasKoSLastSeenList:HideList(list)
	if(list == "LASTSEEN") then
		--VanasKoSListFrameSyncButton:Enable()
		VanasKoSListFrameChangeButton:Enable()
		VanasKoSListFrameAddButton:Enable()
		VanasKoSListFrameRemoveButton:Enable()
	end
end

local function ListButtonOnRightClickMenu()
	local x, y = GetCursorPosition()
	local uiScale = UIParent:GetEffectiveScale()
	wipe(lastseenOptions)
	lastseenOptions = {
		{
			text = entryValue.name,
			isTitle = true,
			order = 1,
		},
		{
			text = L["Add to Player KoS"],
			func = function()
				VanasKoS:AddEntryByName("PLAYERKOS", entryKey)
			end,
			order = 2,
		},
		{
			text = L["Add to Hatelist"],
			func = function()
				VanasKoS:AddEntryByName("HATELIST", entryKey)
			end,
			order = 3,
		},
		{
			text = L["Add to Nicelist"],
			func = function()
				VanasKoS:AddEntryByName("NICELIST", entryKey)
			end,
			order = 4,
		},
	}
	EasyMenu(lastseenOptions, VanasKoSGUI.dropDownFrame, UIParent, x/uiScale, y/uiScale, "MENU")
end

function VanasKoSLastSeenList:ListButtonOnClick(button, frame)
	local id = frame:GetID()
	entryKey, entryValue = VanasKoSGUI:GetListKeyForIndex(id)

	if(id == nil or entryKey == nil) then
		return
	end

	if(button == "RightButton") then
		ListButtonOnRightClickMenu()
	end
end

function VanasKoSLastSeenList:HoverType()
	return "player"
end
