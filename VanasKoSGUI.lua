--[[----------------------------------------------------------------------
      VanasKoSGUI - Part of VanasKoS
Handles the main gui frame
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local Dialog = LibStub("LibDialog-1.0")
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")

local VanasKoSGUI = VanasKoS:NewModule("GUI", "AceEvent-3.0")

-- Global wow strings
local NAME, ACCEPT, CANCEL = NAME, ACCEPT, CANCEL

-- Declare some common global functions local
local pairs = pairs
local tinsert = tinsert
local tsort = table.sort
local format = format
local date = date

-- Local Variables
local tooltip = nil
local listHandler = {}
local sortOptions = {}
local defaultSortFunction = {}
local defaultRevSortFunction = {}
local configFrameInner = nil
local oldlist = ""
local buttonList = {}

VanasKoSGUI.numConfigOptions = 8
VanasKoSGUI.dropDownFrame = nil

local VanasKoSConfigOptions = {
	name = "VanasKoS",
	type = "group",
	childGroups = 'tab',
	args = {
		help = {
			type = "description",
			order = 1,
			name = GetAddOnMetadata("VanasKoS", "Notes"),
		},
		version = {
			type = "description",
			order = 2,
			name = function()
				return L["Version: "] .. VANASKOS.VERSION
			end,
		},
		moduleGroup = {
			type = "group",
			order = 3,
			name = "Modules",
			args = {
				modules = {
					type = "multiselect",
					order = 3,
					name = L["Enabled modules"],
					desc = L["Enable/Disable modules"],
					get = function(frame, k)
						return VanasKoS:GetModule(k).enabledState
					end,
					set = function(frame, k, v)
						VanasKoS:ToggleModuleActive(k)
					end,
					values = {},
				},
			},
		},
	},
}

function VanasKoSGUI:AddConfigOption(name, option)
	if(not self.ConfigurationOptions) then
		self.ConfigurationOptions = {
			type = 'group',
			args = {
			}
		}
	end

	self.ConfigurationOptions.args[name] = option
	AceConfig:RegisterOptionsTable("VanasKoS/" .. name, self.ConfigurationOptions.args[name])
	configFrameInner = AceConfigDialog:AddToBlizOptions("VanasKoS/" .. name, option.name, "VanasKoS")
end

function VanasKoSGUI:AddMainMenuConfigOptions(optionTable)
	local first = self.numConfigOptions
	for k, v in pairs(optionTable) do
		v.order = first + (v.order or 1)
		VanasKoSConfigOptions.args[k] = v
		self.numConfigOptions = self.numConfigOptions + 1
	end
end

function VanasKoSGUI:AddModuleToggle(moduleName, text)
	VanasKoSConfigOptions.args.moduleGroup.args.modules.values[moduleName] = text
end

function VanasKoSGUI:GetListName(listid)
	for _, v in pairs(VANASKOS.Lists) do
		if(v[1] == listid) then
			return v[2]
		end
	end
	return listid
end

local function verifyName(list, name)
	if not name or name == "" then
		return false
	end
	if list ~= "GUILDKOS" then
		if name:find(' ') or strmatch(name, '%d') or strmatch(name, '%-') then
			return false
		end
	end
	return true
end

function VanasKoSGUI:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("GUI", {
		profile = {
			GUILocked = true,
			GUIMoved = false,
		},
	})

	UIPanelWindows["VanasKoSFrame"] = {
		area = "left",
		pushable = 1,
		whileDead = 1
	}

	AceConfig:RegisterOptionsTable("VanasKoS", VanasKoSConfigOptions)

	self.configFrame = AceConfigDialog:AddToBlizOptions("VanasKoS", "VanasKoS")

	self:AddConfigOption("VanasKoS-Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(VanasKoS.db))

	VanasKoSGUI.listFrame.configurationButton:SetScript("OnClick", function()
		VanasKoSGUI:OpenConfigWindow()
	end)

	self:RegisterMessage("VanasKoS_List_Added", "InitializeDropDowns")

	self:AddMainMenuConfigOptions({
		gui_group = {
			name = L["GUI"],
			type = "group",
			args = {
				gui_locked = {
					type = 'toggle',
					name = L["Locked"],
					desc = L["Locks the Main Window"],
					order = 1,
					set = function()
						VanasKoSGUI.db.profile.GUILocked = not VanasKoSGUI.db.profile.GUILocked
					end,
					get = function()
						return VanasKoSGUI.db.profile.GUILocked
					end,
				},
				gui_reset = {
					type = 'execute',
					name = L["Reset Position"],
					desc = L["Resets the Position of the Main Window"],
					order = 2,
					func = function()
						VanasKoSGUI.db.profile.GUIMoved = false
						HideUIPanel(VanasKoSGUI.frame)
						ShowUIPanel(VanasKoSGUI.frame)
					end,
				},
			},
		},
	})

	VanasKoSGUI.listFrame.searchBox:SetScript("OnTextChanged", function(self, event, ...)
		VanasKoSGUI:SetFilterText(self:GetText())
	end)

	VanasKoSGUI.frame:RegisterForDrag("LeftButton")
	VanasKoSGUI.frame:SetScript("OnDragStart", function()
		if(VanasKoSGUI.db.profile.GUILocked) then
			return
		end
		VanasKoSGUI.frame:StartMoving()
	end)
	VanasKoSGUI.frame:SetScript("OnDragStop", function()
		VanasKoSGUI.frame:StopMovingOrSizing()
		VanasKoSGUI.db.profile.GUIMoved = true
	end)
	self.tooltipFrame = CreateFrame("GameTooltip", "VanasKoSListTooltip", UIParent, "GameTooltipTemplate")
	tooltip = self.tooltipFrame

	tooltip:Hide()

	Dialog:Register("VanasKoSAddEntry", {
		text = L["Add/Set List Entry"],
		icon = "Interface\\Icons\\Ability_Parry",
		show_while_dead = true,
		is_exclusive = true,
		nameText = "",
		reasonText = "",
		oldKey = nil,
		list = nil,

		editboxes = {
			{
				label = NAME,
				on_enter_pressed = function(self)
					self:GetParent().editboxes[2]:SetFocus()
				end,
				on_tab_pressed = function(self)
					self:GetParent().editboxes[2]:SetFocus()
				end,
				on_escape_pressed = function(self)
					Dialog:Dismiss("VanasKoSAddEntry")
					self.Key = nil
				end,
				on_text_changed = function(self)
					local name = self:GetParent().editboxes[1]:GetText()
					if verifyName(self:GetParent().list, name) then
						self:GetParent().buttons[1]:Enable()
					else
						self:GetParent().buttons[1]:Disable()
					end
				end,
				auto_focus = true,
				maxLetters = 100,
			},
			{
				label = L["Reason"],
				on_enter_pressed = function(self)
					local name = self:GetParent().editboxes[1]:GetText()
					local reason = self:GetText()
					local list = self:GetParent().list
					local oldKey = self:GetParent().oldKey
					local key = name
					if(reason == "") then
						reason = nil
					end

					if not verifyName(list, name) then
						return
					end

					if oldKey then
						VanasKoS:RemoveEntry(list, oldKey)
					end

					VanasKoS:AddEntry(list, key, {
						name = name,
						reason = reason,
					})
					Dialog:Dismiss("VanasKoSAddEntry")
					self.oldKey = nil
					VanasKoSGUI:Update()
				end,
				on_tab_pressed = function(self)
					self:GetParent().editboxes[1]:SetFocus()
				end,
				on_escape_pressed = function(self)
					Dialog:Dismiss("VanasKoSAddEntry")
					self.oldKey = nil
				end,
				auto_focus = true,
				maxLetters = 100,
			},
		},
		buttons = {
			{
				text = ACCEPT,
				on_click = function(self)
					local name = self.editboxes[1]:GetText()
					local reason = self.editboxes[2]:GetText()
					local list = self.list
					local oldKey = self.oldKey
					local key = name
					if(reason == "") then
						reason = nil
					end

					if not verifyName(list, name) then
						return
					end

					if oldKey then
						VanasKoS:RemoveEntry(list, oldKey)
					end

					VanasKoS:AddEntry(list, key, {
						name = name,
						reason = reason,
					})
					Dialog:Dismiss("VanasKoSAddEntry")
					self.oldKey = nil
					VanasKoSGUI:Update()
				end,
			},
			{
				text = CANCEL,
				on_click = function(self)
					Dialog:Dismiss("VanasKoSAddEntry")
					self.oldKey = nil
				end,
			},
		},
		on_show = function(self)
			local name = self.editboxes[1]:GetText()
			if verifyName(self.list, name) then
				self.buttons[1]:Enable()
			else
				self.buttons[1]:Disable()
			end
		end
	})
end

function VanasKoSGUI:OpenConfigWindow()
	-- open any inner config frame first (causes list to expand)
	InterfaceOptionsFrame_OpenToCategory(configFrameInner)
	InterfaceOptionsFrame_OpenToCategory(VanasKoSGUI.configFrame)
end

function VanasKoSGUI:InitializeDropDowns()
	local list = {}
	local order = {}
	local lists = VANASKOS.Lists
	for _,v in self:pairsByKeys(lists, nil) do
		list[v[1]] = v[2]
		order[v[3]] = v[1]
	end
	VanasKoSGUI.listFrame.chooseList:SetList(list, order)
	VanasKoSGUI.listFrame.chooseList:SetValue("PLAYERKOS")
end

function VanasKoSGUI:OnEnable()
	VanasKoSGUI.dropDownFrame = CreateFrame("Frame", "VanasKoSGUIDropDownFrame", UIParent, "UIDropDownMenuTemplate")

	self:RegisterMessage("VanasKoS_List_Entry_Added", "UpdateShownList")
	self:RegisterMessage("VanasKoS_List_Entry_Removed", "UpdateShownList")

	-- Save for faster lookup
	for i=1,VANASKOS.MAX_LIST_BUTTONS do
		buttonList[i] = {
			button = _G["VanasKoSListFrameListButton" .. i],
			text1 = _G["VanasKoSListFrameListButton" ..  i .. "Text1"],
			text2 = _G["VanasKoSListFrameListButton" ..  i .. "Text2"],
			text3 = _G["VanasKoSListFrameListButton" ..  i .. "Text3"],
			text4 = _G["VanasKoSListFrameListButton" ..  i .. "Text4"],
			text5 = _G["VanasKoSListFrameListButton" ..  i .. "Text5"],
			text6 = _G["VanasKoSListFrameListButton" ..  i .. "Text6"],
			text7 = _G["VanasKoSListFrameListButton" ..  i .. "Text7"],
			text8 = _G["VanasKoSListFrameListButton" ..  i .. "Text8"],
			text9 = _G["VanasKoSListFrameListButton" ..  i .. "Text9"]
		}
	end
end

function VanasKoSGUI:OnDisable()
end

--[[----------------------------------------------------------------------
		GUI Functions
------------------------------------------------------------------------]]

local VANASKOSFRAME_SUBFRAMES = { "VanasKoSListFrame", "VanasKoSAboutFrame" }

local shownList = nil
local displayedList = nil

function VanasKoSGUI:ShowList(list, group)
	VANASKOS.showList = list
	if group then
		VANASKOS.showGroup = group
	end
	shownList = VanasKoS:GetList(VANASKOS.showList, VANASKOS.showGroup)

	self:SetSortFunction(defaultSortFunction[list], defaultRevSortFunction[list])
end

-- if the list itself changed
function VanasKoSGUI:UpdateShownList()
	if(not VanasKoSGUI.listFrame:IsVisible()) then
		return
	end
	displayedList = self:SortedList(shownList)

	self:ScrollFrameUpdate()
end

function VanasKoSGUI:GUIFrame_ShowSubFrame(frameName)
	for _, value in pairs(VANASKOSFRAME_SUBFRAMES) do
		if(value == frameName) then
			_G[value]:Show()
		else
			_G[value]:Hide()
		end
	end
end

local defaultListNames = {
	["PLAYERKOS"] = true,
	["GUILDKOS"] = true,
	["HATELIST"] = true,
	["NICELIST"] = true
}

function VanasKoSGUI:GUIShowChangeDialog()
	if(VANASKOS.selectedEntry) then
		local reason = ""
		local list = self:GetCurrentList()
		local name
		local key
		if(defaultListNames[VANASKOS.showList]) then
			key = self:GetSelectedKey()
			name = list[key].name
			reason = list[key].reason
		end
		local dialog = Dialog:Spawn("VanasKoSAddEntry")
		dialog.list = VANASKOS.showList
		dialog.oldKey = key
		dialog.editboxes[1]:SetText(name or "")
		dialog.editboxes[2]:SetText(reason or "")
	end
end

function VanasKoSGUI:GetCurrentShownListIterator()
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if(not displayedList or displayedList[i] == nil) then
			return nil
		else
			return displayedList[i], shownList[displayedList[i]]
		end
	end

	return iter
end

function VanasKoSGUI:GetCurrentList()
	return shownList
end

function VanasKoSGUI:GetListKeyForIndex(idx)
	local listVar = self:GetCurrentShownListIterator()
	local listIndex = 1

	if(listVar == nil) then
		return nil
	end

	for key, value in listVar do
		if(listIndex == idx) then
			return key, value
		end
		listIndex = listIndex + 1
	end

	return nil
end

function VanasKoSGUI:GetSelectedKey()
	if(VANASKOS.selectedEntry) then
		local listVar = self:GetCurrentShownListIterator()
		local listIndex = 1

		if(listVar == nil) then
			self:GUIHideButtons(1, VANASKOS.MAX_LIST_BUTTONS)
			return nil
		end

		for key, value in listVar do
			if(listIndex == VANASKOS.selectedEntry) then
				return key, value
			end
			listIndex = listIndex + 1
		end

	end
	return nil
end

function VanasKoSGUI:GetSelectedButtonNumber()
	if(VANASKOS.selectedEntry) then
		local listVar = self:GetCurrentShownListIterator()
		local listIndex = 1

		if(listVar == nil) then
			self:GUIHideButtons(1, VANASKOS.MAX_LIST_BUTTONS)
			return nil
		end

		for _, value in listVar do
			if(listIndex == VANASKOS.selectedEntry) then
				return listIndex, value
			end
			listIndex = listIndex + 1
		end

	end
	return nil
end

function VanasKoSGUI:RemoveEntry()
	local key = VanasKoSGUI:GetSelectedKey()
	VanasKoS:RemoveEntry(VANASKOS.showList, key)
end

function VanasKoSGUI:ColButton_OnClick(button, frame)
	PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	self:SetSortFunction(frame.sortFunction, frame.revSortFunction)
	self:ScrollFrameUpdate()
end

function VanasKoSGUI:ColButton_OnEnter(button, frame)
end

function VanasKoSGUI:ColButton_OnLeave(button, frame)
end

function VanasKoSGUI:ListButton_OnClick(button, frame)
	if(button == "LeftButton") then
		VANASKOS.selectedEntry = frame:GetID()
		self:ScrollFrameUpdate()
	else
		VANASKOS.selectedEntry = frame:GetID()
		self:ScrollFrameUpdate()
	end
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ListButtonOnClick) then
		listHandler[VANASKOS.showList]:ListButtonOnClick(button, frame)
	end
end

function VanasKoSGUI:ListButton_OnEnter(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ListButtonOnEnter) then
		listHandler[VANASKOS.showList]:ListButtonOnEnter(button, frame)
	end
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].HoverType) then
		local hoveredKey = self:GetListKeyForIndex(frame:GetID())
		local hoveredType = listHandler[VANASKOS.showList]:HoverType()
		self:ShowTooltip(hoveredKey, hoveredType)
	end
end

function VanasKoSGUI:ListButton_OnLeave(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ListButtonOnLeave) then
		listHandler[VANASKOS.showList]:ListButtonOnLeave(button, frame)
	end

	self:HideTooltip()
end

function VanasKoSGUI:ToggleLeftButton_OnClick(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleLeftButtonOnClick) then
		listHandler[VANASKOS.showList]:ToggleLeftButtonOnClick(button, frame)
	end
	self:ScrollFrameUpdate()
end

function VanasKoSGUI:ToggleLeftButton_OnEnter(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleLeftButtonOnEnter) then
		listHandler[VANASKOS.showList]:ToggleLeftButtonOnEnter(button, frame)
	end
end

function VanasKoSGUI:ToggleLeftButton_OnLeave(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleLeftButtonOnLeave) then
		listHandler[VANASKOS.showList]:ToggleLeftButtonOnLeave(button, frame)
	end
end

function VanasKoSGUI:ToggleRightButton_OnClick(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleRightButtonOnClick) then
		listHandler[VANASKOS.showList]:ToggleRightButtonOnClick(button, frame)
	end
	self:ScrollFrameUpdate()
end

function VanasKoSGUI:ToggleRightButton_OnEnter(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleRightButtonOnEnter) then
		listHandler[VANASKOS.showList]:ToggleRightButtonOnEnter(button, frame)
	end
end

function VanasKoSGUI:ToggleRightButton_OnLeave(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleRightButtonOnLeave) then
		listHandler[VANASKOS.showList]:ToggleRightButtonOnLeave(button, frame)
	end
end

function VanasKoSGUI:ShowTooltip(key, hoveredType)
	if (hoveredType) then
		tooltip:ClearLines()
		tooltip:SetOwner(VanasKoSGUI.listFrame, "ANCHOR_CURSOR")
		tooltip:ClearAllPoints()
		tooltip:SetPoint("TOPLEFT", VanasKoSGUI.listFrame, "TOPRIGHT", -33, -30)
		tooltip:SetPoint("BOTTOMLEFT", VanasKoSGUI.listFrame, "TOPRIGHT", -33, -390)

		self:UpdateMouseOverFrame(key, hoveredType)
		tooltip:Show()
	end
end

function VanasKoSGUI:HideTooltip()
	tooltip:Hide()
end

function VanasKoSGUI:UpdateMouseOverFrame(key, hoveredType)
	if(not key) then
		tooltip:AddLine("----")
		return
	end

	-- name
	local data
	data = VanasKoS:GetList(VANASKOS.showList)[key]
	if not data then
		tooltip:AddLine("----")
		return
	end

	if (hoveredType == "player") then
		tooltip:AddLine(data.name)

		local playerdata = VanasKoS:GetPlayerData(key)

		-- guild, level, race, class, mapID, lastseen
		if(playerdata) then
			if(playerdata.guild) then
				local text = "<|cffffffff" .. playerdata.guild .. "|r>"
				if(playerdata.guildrank) then
					text = text .. " (" .. playerdata.guildrank .. ")"
				end
				tooltip:AddLine(text)
			end
			if(playerdata.level and playerdata.race and playerdata.class) then
				tooltip:AddLine(format(L['Level %s %s %s'], playerdata.level, playerdata.race, playerdata.class))
			elseif(playerdata.race and playerdata.class) then
				tooltip:AddLine(format('%s %s', playerdata.race, playerdata.class))
			end
			local mapInfo = playerdata.mapID and C_Map.GetMapInfo(playerdata.mapID) or nil
			if(playerdata.lastseen) then
				if mapInfo then
					tooltip:AddLine(format(L['Last seen at |cff00ff00%s|r in |cff00ff00%s|r'], date("%c", playerdata.lastseen), mapInfo.name))
				else
					tooltip:AddLine(format(L['Last seen at |cff00ff00%s|r'], date("%c", playerdata.lastseen)))
				end
			end
		end
	elseif(hoveredType == "guild") then
		tooltip:AddLine("<"..data.name..">")
	elseif(hoveredType == "eventlog") then
		if data.inBg then
			if data.type == "win" then
				tooltip:AddLine(L["Battleground win"])
			elseif data.type == "loss" then
				tooltip:AddLine(L["Battleground loss"])
			else
				tooltip:AddLine(L["Battleground encounter"])
			end
		elseif data.inArena then
			if data.type == "win" then
				tooltip:AddLine(L["Arena win"])
			elseif data.type == "loss" then
				tooltip:AddLine(L["Arena loss"])
			else
				tooltip:AddLine(L["Arena encounter"])
			end
		elseif data.inCombatZone then
			if data.type == "win" then
				tooltip:AddLine(L["Combat zone win"])
			elseif data.type == "loss" then
				tooltip:AddLine(L["Combat zone loss"])
			else
				tooltip:AddLine(L["Combat zone encounter"])
			end
		elseif data.inFfa then
			if data.type == "win" then
				tooltip:AddLine(L["Free-for-all win"])
			elseif data.type == "loss" then
				tooltip:AddLine(L["Free-for-all loss"])
			else
				tooltip:AddLine(L["Free-for-all encounter"])
			end
		else
			if data.type == "win" then
				tooltip:AddLine(L["World PvP win"])
			elseif data.type == "loss" then
				tooltip:AddLine(L["World PvP loss"])
			else
				tooltip:AddLine(L["World PvP encounter"])
			end
		end

		if data.time then
			tooltip:AddLine(date("%c", data.time))
		end
		tooltip:AddLine(format(L["Player: %s (%s)"], data.myname or L["_UNKNOWN_NAME_"], data.mylevel or "??"))
		tooltip:AddLine(format(L["Enemy: %s (%s)"], data.name or L["_UNKNOWN_NAME_"], data.enemylevel or "??"))
		if data.enemyguild then
			tooltip:AddLine("<|cffffffff" .. data.enemyguild .. "|r>")
		end

		local mapInfo = data.mapID and C_Map.GetMapInfo(data.mapID) or nil
		if mapInfo then
			local text = mapInfo.name
			if data.x and data.y then
				text = text .. format(" (%d, %d)", data.x * 100, data.y * 100)
			end
			tooltip:AddLine(text)
		end
	end

	-- infos about creator, sender, owner, last updated
	if(data) then
		if(data.reason) then
			tooltip:AddLine(format('|cffffffff%s', data.reason))
		end
		if(data.owner) then
			tooltip:AddLine(format(L['Owner: |cffffffff%s|r'], data.owner))
		end

		if(data.creator) then
			tooltip:AddLine(format(L['Creator: |cffffffff%s|r'], data.creator))
		end

		if(data.created) then
			tooltip:AddLine(format(L['Created: |cffffffff%s|r'], date("%c", data.created)))
		end

		if(data.sender) then
			tooltip:AddLine(format(L['Received from: |cffffffff%s|r'], data.sender))
		end

		if(data.lastupdated) then
			tooltip:AddLine(format(L['Last updated: |cffffffff%s|r'], date("%c", data.lastupdated)))
		end
	end

	if (hoveredType == "player") then
		local pvpEventLog = VanasKoS:GetList("PVPLOG", 1)
		local pvpPlayerLog = VanasKoS:GetList("PVPLOG", 2)
		if(pvpEventLog and pvpPlayerLog) then
			local playerlog = pvpPlayerLog[key]
			if(playerlog) then
				local i = #playerlog + 1
				local iter = function()
					i = i - 1
					if(not playerlog or playerlog[i] == nil) then
						return nil
					else
						return i, playerlog[i]
					end
				end

				if (#playerlog > 0) then
					tooltip:AddLine("|cffffffff" .. L["PvP Encounter:"] .. "|r")
				end
				for i,k in iter do
					local event = pvpEventLog[k]
					local mapInfo = event and event.mapID and C_Map.GetMapInfo(event.mapID) or nil
					local mapName = mapInfo and mapInfo.name or L["Unknown area"]
					if event and event.type == 'win' then
						tooltip:AddLine(format(L["%s: |cff00ff00Win|r |cffffffffin %s (|r|cffff00ff%s|r|cffffffff)|r"], date("%c", event.time), mapName, event.myname or L["Unknown player"]))
					elseif event and event.type == 'loss' then
						tooltip:AddLine(format(L["%s: |cffff0000Loss|r |cffffffffin %s (|r|cffff00ff%s|r|cffffffff)|r"], date("%c", event.time), mapName, event.myname or L["Unknown player"]))
					end
					if(i < #playerlog - 15) then
						return
					end
				end
			end
		end
	end
end

function VanasKoSGUI:GUIHideButtons(minimum, maximum)
	for i=minimum,maximum,1 do
		local button = _G["VanasKoSListFrameListButton" .. i]
		if(button ~= nil) then
			button:Hide()
		end
	end
end

function VanasKoSGUI:GUISortButtons(minimum, maximum)
	for i=minimum,maximum,1 do
		local button = _G["VanasKoSListFrameListButton" .. i]
		button:Show()
	end
end

local searchBoxText = ""

function VanasKoSGUI:SetFilterText(text)
	searchBoxText = text:lower():gsub("%%", ""):gsub("([%^%(%)%.%[%]%*%+%-%?])","%%%1")

	self:UpdateShownList()
end

function VanasKoSGUI:sortList(t, fSort, fFilter)
	if(not t) then
		return nil
	end

	local a = {}
	for k,v in pairs(t) do
		if(fFilter) then
			if(fFilter(self, k, v, searchBoxText)) then
				tinsert(a, k)
			end
		else
			tinsert(a, k)
		end
	end
	tsort(a, fSort)

	return a
end

function VanasKoSGUI:pairsByKeys(t, fSort, fFilter)
	local a = {}

	for k,v in pairs(t) do
		if(fFilter) then
			if(fFilter(self, k, v, searchBoxText)) then
				tinsert(a, k)
			end
		else
			tinsert(a, k)
		end
	end
	tsort(a, fSort)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	
	return iter
end

-- Registers a Sort Function with name to show up in the sorting options for a list
-- listNames can be either the internal name of the list (i.e. PLAYERKOS) or a list of internal list names
function VanasKoSGUI:RegisterSortOption(listNames, sortOptionNameInternal, sortOptionName, sortOptionDesc, sortFunctionNew, sortFunctionRev)
	if(type(listNames) == "string") then
		listNames = {listNames}
	end

	for _, listNameInternal in pairs(listNames) do
		if(not sortOptions[listNameInternal]) then
			sortOptions[listNameInternal] = {}
		end
		sortOptions[listNameInternal][#sortOptions[listNameInternal]+1] = {
			text = sortOptionName,
			checked = function()
				local currentSort = VanasKoSGUI:GetCurrentSortFunction()
				return (currentSort == sortFunctionNew or currentSort == sortFunctionRev)
			end,
			func = function()
				VanasKoSGUI:SetSortFunction(sortFunctionNew, sortFunctionRev)
			end,
		}
	end
end

function VanasKoSGUI:SetDefaultSortFunction(lists, sortFunc, revSortFunc)
	if(type(lists) == "string") then
		lists = {lists}
	end
	for _, v in pairs(lists) do
		defaultSortFunction[v] = sortFunc
		defaultRevSortFunction[v] = revSortFunc
	end
end


local sortFunction = nil

function VanasKoSGUI:SetSortFunction(sortFunc, revSortFunc)
	if(sortFunction == sortFunc) then
		sortFunction = revSortFunc
	elseif(sortFunction == revSortFunc) then
		sortFunction = sortFunc
	else
		sortFunction = sortFunc
	end

	self:UpdateShownList()
end

function VanasKoSGUI:GetCurrentSortFunction()
	return sortFunction
end

function VanasKoSGUI:SortedList(list)
	local sortFn = self:GetCurrentSortFunction()
	local filterFn = nil

	if(listHandler[VANASKOS.showList]) then
		filterFn = listHandler[VANASKOS.showList].FilterFunction
	end

	return self:sortList(list, sortFn, filterFn)
end

function VanasKoSGUI:RegisterList(listName, handlerObject)
	if(not handlerObject) then
		VanasKoS:Print("Error: No handlerObject for " .. listName)
		return
	end
	if(not handlerObject.RenderButton) then
		VanasKoS:Print("Error: No RenderButton method for " .. listName)
		return
	end
	if(not handlerObject.SetupColumns) then
		VanasKoS:Print("Error: No SetupColumns method for " .. listName)
		return
	end
	listHandler[listName] = handlerObject
	self:Update()
end

function VanasKoSGUI:UnregisterList(listName)
	listHandler[listName] = nil
	self:Update()
end

function VanasKoSGUI:ScrollUpdate()
	VanasKoSGUI:ScrollFrameUpdate()
end

-- call if only data from entries in the list changed
function VanasKoSGUI:ScrollFrameUpdate()
	if(not VanasKoSGUI.listFrame:IsVisible()) then
		return
	end
	local listOffset = FauxScrollFrame_GetOffset(VanasKoSGUI.listFrame.scrollFrame)
	local listVar = self:GetCurrentShownListIterator()
	local showList = VANASKOS.showList
	local showListHandler = listHandler[showList]
	local listIndex = 1
	local buttonIndex = 1
	local maxButtonIndex = VANASKOS.MAX_LIST_BUTTONS

	if(listVar == nil) then
		VANASKOS.selectedEntry = nil
		self:GUIHideButtons(1, VANASKOS.MAX_LIST_BUTTONS)
		return nil
	end

	if(oldlist ~= showList) then
		if(listHandler[oldlist] and listHandler[oldlist].HideList) then
			listHandler[oldlist]:HideList(oldlist)
		end
		if(showListHandler and showListHandler.ShowList) then
			showListHandler:ShowList(showList)
		end
		if(showListHandler and showListHandler.SetupColumns) then
			showListHandler:SetupColumns(showList)
		end
	end

	for k,v in listVar do
		if((listIndex-1) >= listOffset) then
			if(buttonIndex <= maxButtonIndex) then
				local button = buttonList[buttonIndex]
				button.button:SetID(listIndex)
				if(listIndex == VANASKOS.selectedEntry) then
					button.button:LockHighlight()
				else
					button.button:UnlockHighlight()
				end

				if(showListHandler) then
					showListHandler:RenderButton(showList, buttonIndex, button.button, k, v, button.text1, button.text2, button.text3, button.text4, button.text5, button.text6, button.text7, button.text8, button.text9)
				end
				buttonIndex = buttonIndex + 1
			end
		end
		listIndex = listIndex + 1
	end

	if(listIndex <= VANASKOS.MAX_LIST_BUTTONS) then
		self:GUIHideButtons(listIndex, VANASKOS.MAX_LIST_BUTTONS)
	end
	
	if(listIndex == 1) then
		VANASKOS.selectedEntry = nil
	else
		if(VANASKOS.selectedEntry == nil) then
			VANASKOS.selectedEntry = 1
			self:ScrollFrameUpdate()
		end
		if(VANASKOS.selectedEntry >= listIndex) then
			VANASKOS.selectedEntry = 1
			self:ScrollFrameUpdate()
		end
	end

	-- 34 = Hoehe VanasKoSListFrameListButtonTemplate
	-- scrollframe, maxnum, to_display, height
	FauxScrollFrame_Update(VanasKoSGUI.listFrame.scrollFrame, listIndex-1, VANASKOS.MAX_LIST_BUTTONS, 16)

	oldlist = showList
end

function VanasKoSGUI:AddEntry(list, name, reason)
	if(name == nil or name == "") then
		name = UnitName("target")
		if(list == "GUILDKOS") then
			name = GetGuildInfo("target")
		end
	end

	local dialog = Dialog:Spawn("VanasKoSAddEntry")
	dialog.list = list or VANASKOS.showList
	if (name) then
		dialog.editboxes[1]:SetText(name)
	end
	if (reason) then
		dialog.editboxes[2]:SetText(reason)
	end
	if (name ~= nil and name ~= "") then
		dialog.editboxes[2]:SetFocus()
	end
end

function VanasKoSGUI:Update()
	if(not VanasKoSGUI.frame:IsVisible()) then
		return nil
	end
	if(VanasKoSGUI.frame.selectedTab == 1) then
		VanasKoSGUI.frame.texTL:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopLeft")
		VanasKoSGUI.frame.texTR:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopRight")
		VanasKoSGUI.frame.texBL:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\KoSListFrame-BotLeft")
		VanasKoSGUI.frame.texBR:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\KoSListFrame-BotRight")

		VanasKoSGUI.frame.title:SetText(VANASKOS.NAME .. " - " .. L["Lists"])
		self:GUIFrame_ShowSubFrame("VanasKoSListFrame")
		self:ScrollFrameUpdate()
	end
	if(VanasKoSGUI.frame.selectedTab == 2) then
		VanasKoSGUI.frame.texTL:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft")
		VanasKoSGUI.frame.texTR:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight")
		VanasKoSGUI.frame.texBL:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomLeft")
		VanasKoSGUI.frame.texBR:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomRight")

		self:GUIFrame_ShowSubFrame("VanasKoSAboutFrame")
		VanasKoSGUI.frame.title:SetText(VANASKOS.NAME .. " - " .. L["About"])
	end
end

function VanasKoSGUI:Toggle()
	-- show/hide the frame:
	-- if not visible, show it via blizzard uipanel function if it wasn't moved,
	-- if moved just do a Show()
	if(VanasKoSGUI.frame:IsVisible()) then
		if(self.db.profile.GUIMoved) then
			VanasKoSGUI.frame:Hide()
		else
			HideUIPanel(VanasKoSGUI.frame)
		end
	else
		VanasKoSGUI.listFrame:SetParent("VanasKoSFrame")
		VanasKoSGUI.listFrame:SetAllPoints()

		if(VanasKoSGUI.db.profile.GUIMoved) then
			VanasKoSGUI.frame:Show()
		else
			ShowUIPanel(VanasKoSGUI.frame)
		end
	end
end

function VanasKoSGUI:SetNumColumns(num)
	for i=1,VANASKOS.MAX_LIST_COLS do
		local hdr = _G["VanasKoSListFrameColButton" .. i]
		if(i <= num) then
			hdr:Show()
		else
			hdr:Hide()
		end

		for j=1,VANASKOS.MAX_LIST_BUTTONS do
			local txt = _G["VanasKoSListFrameListButton" .. j .. "Text" .. i]
			if (i <= num) then
				txt:Show()
			else
				txt:Hide()
			end
		end
	end
end

function VanasKoSGUI:SetColumnWidth(col, width)
	_G["VanasKoSListFrameColButton" .. col]:SetWidth(width)
	_G["VanasKoSListFrameColButton" .. col .. "Middle"]:SetWidth(width - 9)
	for i=1,VANASKOS.MAX_LIST_BUTTONS do
		_G["VanasKoSListFrameListButton" .. i .. "Text" .. col]:SetWidth(width - 5)
	end
end

function VanasKoSGUI:SetColumnName(col, Name)
	_G["VanasKoSListFrameColButton" .. col]:SetText(Name)
end

function VanasKoSGUI:SetColumnType(col, colType)
	for i=1,VANASKOS.MAX_LIST_BUTTONS do
		local frame = _G["VanasKoSListFrameListButton" .. i .. "Text" .. col]
		if frame then
			if (colType == "normal") then
				frame:SetFontObject("GameFontNormalSmall")
				frame:SetJustifyH("LEFT")
				frame:SetJustifyV("MIDDLE")
			elseif (colType == "number") then
				frame:SetFontObject("GameFontHighlightSmall")
				frame:SetJustifyH("RIGHT")
				frame:SetJustifyV("MIDDLE")
			elseif (colType == "highlight") then
				frame:SetFontObject("GameFontHighlightSmall")
				frame:SetJustifyH("LEFT")
				frame:SetJustifyV("MIDDLE")
			else
				error("Invalid column type")
			end
		end
	end
end

function VanasKoSGUI:SetColumnSort(column, sortFunctionNew, sortFunctionRev)
	if(column) then
		local colButton = _G["VanasKoSListFrameColButton" .. column]
		if(colButton) then
			colButton.sortFunction = sortFunctionNew
			colButton.revSortFunction = sortFunctionRev
		end
	end
end

function VanasKoSGUI:SetToggleButtonText(text)
	VanasKoSGUI.listFrame.toggleRButton:SetText(text)
end

function VanasKoSGUI:HideToggleButtons()
	VanasKoSGUI.listFrame.noToggle:Show()
	VanasKoSGUI.listFrame.toggleLButton:Hide()
	VanasKoSGUI.listFrame.toggleRButton:Hide()
end

function VanasKoSGUI:ShowToggleButtons()
	VanasKoSGUI.listFrame.noToggle:Hide()
	VanasKoSGUI.listFrame.toggleLButton:Show()
	VanasKoSGUI.listFrame.toggleRButton:Show()
end
