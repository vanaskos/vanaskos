--[[----------------------------------------------------------------------
      VanasKoSGUI - Part of VanasKoS
Handles the main gui frame
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS");

VanasKoSGUI = VanasKoS:NewModule("GUI", "AceEvent-3.0");
local VanasKoSGUI = VanasKoSGUI;
local VanasKoS = VanasKoS;
local AceConfigDialog = LibStub("AceConfigDialog-3.0");
local AceConfig = LibStub("AceConfig-3.0");


local tooltip = nil;
local listHandler = { };

VanasKoSGUI.dropDownFrame = nil;

local configFrameInner = nil;
VanasKoSGUI.numConfigOptions = 8;
VanasKoSConfigOptions = {
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
			name = function() return L["Version: "] .. VANASKOS.VERSION end,
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
					get = function(frame, k) return VanasKoS:GetModule(k).enabledState; end,
					set = function(frame, k, v) VanasKoS:ToggleModuleActive(k); end,
					values = {},
				},
			},
		},
	},
};

function VanasKoSGUI:AddConfigOption(name, option)
	if(not self.ConfigurationOptions) then
		self.ConfigurationOptions = {
			type = 'group',
			args = {
			}
		}
	end
	
	self.ConfigurationOptions.args[name] = option;
	AceConfig:RegisterOptionsTable("VanasKoS/" .. name, self.ConfigurationOptions.args[name]);
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
	VanasKoSConfigOptions.args.moduleGroup.args.modules.values[moduleName] = text;
end

function VanasKoSGUI:GetListName(listid)
	for k,v in pairs(VANASKOS.Lists) do
		if(v[1] == listid) then
			return v[2];
		end
	end
	return listid;
end

local sortButtonOptions = {
};

local sortOptions = { 
};


local defaultSortFunction = {
};

local defaultRevSortFunction = {
};

function VanasKoSGUI:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("GUI", {
						profile = { 
								GUILocked = true,
								GUIMoved = false,
							},
					}
				);
	
	UIPanelWindows["VanasKoSFrame"] = { area = "left", pushable = 1, whileDead = 1 };

	AceConfig:RegisterOptionsTable("VanasKoS", VanasKoSConfigOptions);

	self.configFrame = AceConfigDialog:AddToBlizOptions("VanasKoS", "VanasKoS");
	
	self:AddConfigOption("VanasKoS-Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(VanasKoS.db));
	
	VanasKoSListFrameConfigurationButton:SetScript("OnClick", function() VanasKoSGUI:OpenConfigWindow(); end);

	self:RegisterMessage("VanasKoS_List_Added", "InitializeDropDowns");
	
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
					set = function() VanasKoSGUI.db.profile.GUILocked = not VanasKoSGUI.db.profile.GUILocked; end,
					get = function() return VanasKoSGUI.db.profile.GUILocked; end,
				},
				gui_reset = {
					type = 'execute',
					name = L["Reset Position"],
					desc = L["Resets the Position of the Main Window"],
					order = 2,
					func = function() VanasKoSGUI.db.profile.GUIMoved = false; HideUIPanel(VanasKoSFrame); ShowUIPanel(VanasKoSFrame); end,
				},
			},
		},
	});
	
	VanasKoSListFrameSearchBox:SetScript("OnTextChanged", function() VanasKoSGUI:SetFilterText(this:GetText()) end);
	
	VanasKoSFrame:RegisterForDrag("LeftButton");
	VanasKoSFrame:SetScript("OnDragStart", function()
							if(VanasKoSGUI.db.profile.GUILocked) then
								return;
							end
							VanasKoSFrame:StartMoving();
						end);
	VanasKoSFrame:SetScript("OnDragStop", function()
							VanasKoSFrame:StopMovingOrSizing();
							VanasKoSGUI.db.profile.GUIMoved = true;
						end);
	self.tooltipFrame = CreateFrame("GameTooltip", "VanasKoSListTooltip", UIParent, "GameTooltipTemplate");
	tooltip = self.tooltipFrame;
	
	tooltip:Hide();
end

function VanasKoSGUI:OpenConfigWindow()
	-- open any inner config frame first (causes list to expand)
	InterfaceOptionsFrame_OpenToCategory(configFrameInner);
	InterfaceOptionsFrame_OpenToCategory(VanasKoSGUI.configFrame);
end

function VanasKoSGUI:InitializeDropDowns()
	UIDropDownMenu_Initialize(VanasKoSFrameChooseListDropDown, 
		function() 
			local lists = VANASKOS.Lists;
			for k,v in self:pairsByKeys(lists, nil) do
				local button = UIDropDownMenu_CreateInfo();
				button.text = v[2];
				button.value = v[1];
				button.func = function() 
						UIDropDownMenu_SetSelectedValue(VanasKoSFrameChooseListDropDown, this.value);
						VanasKoSGUI:ShowList(this.value);
				end
				UIDropDownMenu_AddButton(button); 
			end
		end, nil, nil);
	UIDropDownMenu_SetSelectedValue(VanasKoSFrameChooseListDropDown, "PLAYERKOS");
end

function VanasKoSGUI:OnEnable()
	VanasKoSGUI.dropDownFrame = CreateFrame("Frame", "VanasKoSGUIDropDownFrame", UIParent, "UIDropDownMenuTemplate");
	
	self:RegisterMessage("VanasKoS_List_Entry_Added", 
							function(listname, name, data)
								VanasKoSGUI:UpdateShownList(); 
							end);
	self:RegisterMessage("VanasKoS_List_Entry_Removed", 
							function(listname, name, data)
								VanasKoSGUI:UpdateShownList(); 
							end);
	
--[[	for k,v in pairs(self.ConfigurationOptions.args) do
		AceConfig:RegisterOptionsTable(k, self.ConfigurationOptions.args[k]);
		AceConfigDialog:AddToBlizOptions(k, self.ConfigurationOptions.args[k].name, "VanasKoS");
	end ]]
end

function VanasKoSGUI:OnDisable()
end

--[[----------------------------------------------------------------------
		GUI Functions
------------------------------------------------------------------------]]

VANASKOS.selectedEntry = nil;

local VANASKOSFRAME_SUBFRAMES = { "VanasKoSListFrame", "VanasKoSAboutFrame" };

local shownList = nil;
local displayedList = nil;

function VanasKoSGUI:ShowList(list)
	VANASKOS.showList = list;
	shownList = VanasKoS:GetList(VANASKOS.showList);
	
	self:SetSortFunction(defaultSortFunction[list], defaultRevSortFunction[list]);
end

-- if the list itself changed
function VanasKoSGUI:UpdateShownList()
	if(not VanasKoSListFrame:IsVisible()) then
		return;
	end
	displayedList = self:SortedList(shownList);
	
	self:ScrollFrameUpdate();
end

function VanasKoSGUI:GUIFrame_ShowSubFrame(frameName)
	for index, value in pairs(VANASKOSFRAME_SUBFRAMES) do
		if(value == frameName) then
			getglobal(value):Show();
		else
			getglobal(value):Hide();
		end
	end
end

function VanasKoSGUI:GUIShowChangeDialog()
	local dialog = nil;
	if(VANASKOS.selectedEntry) then
		dialog = StaticPopup_Show("VANASKOS_CHANGE_ENTRY");
		local name = self:GetSelectedEntryName();
		local reason = "";
		local list = self:GetCurrentList();
		if(VANASKOS.showList == "PLAYERKOS" or VANASKOS.showList == "GUILDKOS" or VANASKOS.showList == "HATELIST" or VANASKOS.showList == "NICELIST") then
			reason = list[string.lower(name)].reason;
			if (reason ~= nil and reason ~= "") then
				getglobal(dialog:GetName() .. "EditBox"):SetText(reason);
			end
		end
	end
end

function VanasKoSGUI:GetCurrentShownList()
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1;
		if(not displayedList or displayedList[i] == nil) then 
			return nil;
		else 
			return displayedList[i], shownList[displayedList[i]];
		end
	end

	return iter;
end

function VanasKoSGUI:GetCurrentList()
	return shownList;
end

function VanasKoSGUI:GUIChangeKoSReason(reason)
	local name = self:GetSelectedEntryName();
	local list = self:GetCurrentList();
	list[string.lower(name)].reason = reason;
	self:ScrollFrameUpdate();
end

function VanasKoSGUI:GetListEntryForID(id)
	local listVar = self:GetCurrentShownList();
	local listIndex = 1;
			
	if(listVar == nil) then
		return nil;
	end

	for k,v in listVar do
		if(listIndex == id) then
			return k, v;
		end
		listIndex = listIndex + 1;
	end
	
	return nil;
end

function VanasKoSGUI:GetSelectedEntryName()
	if(VANASKOS.selectedEntry) then
		local listVar = self:GetCurrentShownList();
		local listIndex = 1;
			
		if(listVar == nil) then
			self:GUIHideButtons(1, VANASKOS.MAX_LIST_BUTTONS);
			return nil;
		end

		for k,v in listVar do
			if(listIndex == VANASKOS.selectedEntry) then
				return k;
			end
			listIndex = listIndex + 1;
		end

	end
	return nil;
end

function VanasKoSGUI:GetSelectedButtonNumber()
	if(VANASKOS.selectedEntry) then
			local listVar = self:GetCurrentShownList();
			local listIndex = 1;
			
			if(listVar == nil) then
				self:GUIHideButtons(1, VANASKOS.MAX_LIST_BUTTONS);
				return nil;
			end

			for k,v in listVar do
				if(listIndex == VANASKOS.selectedEntry) then
					return listIndex;
				end
				listIndex = listIndex + 1;
			end

	end
	return nil;
end

function VanasKoSGUI:RemoveEntry()
	VanasKoS:RemoveEntry(VANASKOS.showList, VanasKoSGUI:GetSelectedEntryName());
end

function VanasKoSGUI:ColButton_OnClick(button, frame)
	PlaySound("igMainMenuOptionCheckBoxOn");
	self:SetSortFunction(frame.sortFunction, frame.revSortFunction);
	self:ScrollFrameUpdate();
end

function VanasKoSGUI:ColButton_OnEnter(button, frame)
end

function VanasKoSGUI:ColButton_OnLeave(button, frame)
end

function VanasKoSGUI:ListButton_OnClick(button, frame)
	if(button == "LeftButton") then
		VANASKOS.selectedEntry = frame:GetID();
		self:ScrollFrameUpdate();
	else
		VANASKOS.selectedEntry = frame:GetID();
		self:ScrollFrameUpdate();
	end
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ListButtonOnClick) then
		listHandler[VANASKOS.showList]:ListButtonOnClick(button, frame);
	end
end

function VanasKoSGUI:ListButton_OnEnter(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ListButtonOnEnter) then
		listHandler[VANASKOS.showList]:ListButtonOnEnter(button, frame);
	end
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].HoverType) then
		local hoveredKey, hoveredValue = self:GetListEntryForID(frame:GetID());
		local hoveredType = listHandler[VANASKOS.showList]:HoverType();
		self:ShowTooltip(hoveredKey, hoveredValue, hoveredType);
	end
end

function VanasKoSGUI:ListButton_OnLeave(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ListButtonOnLeave) then
		listHandler[VANASKOS.showList]:ListButtonOnLeave(button, frame);
	end

	self:HideTooltip();
end

function VanasKoSGUI:ToggleLeftButton_OnClick(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleLeftButtonOnClick) then
		listHandler[VANASKOS.showList]:ToggleLeftButtonOnClick(button, frame);
	end
	self:ScrollFrameUpdate();
end

function VanasKoSGUI:ToggleLeftButton_OnEnter(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleLeftButtonOnEnter) then
		listHandler[VANASKOS.showList]:ToggleLeftButtonOnEnter(button, frame);
	end
end

function VanasKoSGUI:ToggleLeftButton_OnLeave(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleLeftButtonOnLeave) then
		listHandler[VANASKOS.showList]:ToggleLeftButtonOnLeave(button, frame);
	end
end

function VanasKoSGUI:ToggleRightButton_OnClick(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleRightButtonOnClick) then
		listHandler[VANASKOS.showList]:ToggleRightButtonOnClick(button, frame);
	end
	self:ScrollFrameUpdate();
end

function VanasKoSGUI:ToggleRightButton_OnEnter(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleRightButtonOnEnter) then
		listHandler[VANASKOS.showList]:ToggleRightButtonOnEnter(button, frame);
	end
end

function VanasKoSGUI:ToggleRightButton_OnLeave(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ToggleRightButtonOnLeave) then
		listHandler[VANASKOS.showList]:ToggleRightButtonOnLeave(button, frame);
	end
end

function VanasKoSGUI:ShowTooltip(k, v, ty)
	if (ty == "player" or ty == "guild") then
		tooltip:ClearLines();
		tooltip:SetOwner(VanasKoSListFrame, "ANCHOR_CURSOR");
		tooltip:SetPoint("TOPLEFT", VanasKoSListFrame, "TOPRIGHT", -33, -30);
		tooltip:SetPoint("BOTTOMLEFT", VanasKoSListFrame, "TOPRIGHT", -33, -390);
		
		self:UpdateMouseOverFrame(k, v, ty);
		tooltip:Show();
	end
end

function VanasKoSGUI:HideTooltip()
	tooltip:Hide();
end

function VanasKoSGUI:UpdateMouseOverFrame(k, v, ty)
	if(not k) then
		tooltip:AddLine("----");
		return;
	end

	-- name
	local data = nil;
	if (ty == "player") then
		tooltip:AddLine(string.Capitalize(k));
		data = VanasKoS:GetList("PLAYERDATA")[k];

		-- guild, level, race, class, zone, lastseen
		if(data) then
			if(data.guild) then
				local text = "<|cffffffff" .. data.guild .. "|r>";
				if(data.guildrank) then
					text = text .. " (" .. data.guildrank .. ")";
				end
				tooltip:AddLine(text);
			end
			if(data.level and data.race and data.class) then
				tooltip:AddLine(format(L['Level %s %s %s'], data.level, data.race, data.class));
			elseif(data.race and data.class) then
				tooltip:AddLine(format('%s %s', data.race, data.class));
			end
			if(data.zone and data.lastseen) then
				tooltip:AddLine(format(L['Last seen at |cff00ff00%s|r in |cff00ff00%s|r'], date("%c", data.lastseen), data.zone));
			end
		end
	elseif(ty == "guild") then
		local data = VanasKoS:GetList("GUILDDATA")[k];
		if (data and data.displayName) then
			tooltip:AddLine("<"..data.displayName..">");
		else
			tooltip:AddLine("<"..string.Capitalize(k)..">");
		end
	end
		
	-- infos about creator, sender, owner, last updated
	if(v) then
		if(v.reason) then
			tooltip:AddLine(format('|cffffffff%s', v.reason));
		end
		if(v.owner) then
			tooltip:AddLine(format(L['Owner: |cffffffff%s|r'], v.owner));
		end

		if(v.creator) then
			tooltip:AddLine(format(L['Creator: |cffffffff%s|r'], v.creator));
		end

		if(v.created) then
			tooltip:AddLine(format(L['Created: |cffffffff%s|r'], date("%c", v.created)));
		end

		if(v.sender) then
			tooltip:AddLine(format(L['Received from: |cffffffff%s|r'], v.sender));
		end

		if(v.lastupdated) then
			tooltip:AddLine(format(L['Last updated: |cffffffff%s|r'], date("%c", v.lastupdated)));
		end
	end

	if (ty == "player") then
		local pvplog = VanasKoS:GetList("PVPLOG");
		if(pvplog) then
			local playerlog = pvplog.player[k];
			if(playerlog) then
				local i = #playerlog + 1;
				local iter = function()
					i = i - 1;
					if(not playerlog or playerlog[i] == nil) then 
						return nil;
					else 
						return i, playerlog[i];
					end
				end

				if (#playerlog > 0) then
					tooltip:AddLine("|cffffffff" .. L["PvP Encounter:"] .. "|r");
				end
				for key,eventIdx in iter do
					local event = pvplog.event[eventIdx];
					if(event.type and event.zone and event.myname) then
						if(event.type == 'win') then
							tooltip:AddLine(format(L["%s: |cff00ff00Win|r |cffffffffin %s (|r|cffff00ff%s|r|cffffffff)|r"], date("%c", event.time), event.zone, event.myname));
						else
							tooltip:AddLine(format(L["%s: |cffff0000Loss|r |cffffffffin %s(|r|cffff00ff%s|r|cffffffff)|r"], date("%c", event.time), event.zone, event.myname));
						end
					end
					if(key < #playerlog - 15) then
						return;
					end
				end
			end
		end
	end
end

function VanasKoSGUI:GUIHideButtons(minimum, maximum)
	for i=minimum,maximum,1 do
		local button = getglobal("VanasKoSListFrameListButton" .. i);
		if(button ~= nil) then
			button:Hide();
		end
	end
end

function VanasKoSGUI:GUISortButtons(minimum, maximum)
	for i=minimum,maximum,1 do
		local button = getglobal("VanasKoSListFrameListButton" .. i);
		button:Show();
	end
end

local searchBoxText = "";

function VanasKoSGUI:SetFilterText(text)
	searchBoxText = text:lower():gsub("%%", ""):gsub("([%^%(%)%.%[%]%*%+%-%?])","%%%1");
	
	self:UpdateShownList();
end

function VanasKoSGUI:sortList(t, fSort, fFilter)
	if(not t) then
		return nil;
	end
	
	local a = { };
	for k,v in pairs(t) do
		if(fFilter) then
			if(fFilter(self, k, v, searchBoxText)) then
				table.insert(a, k);
			end
		else
			table.insert(a, k);
		end
	end
	table.sort(a, fSort);
	
	return a;
end

function VanasKoSGUI:pairsByKeys(t, fSort, fFilter)
	local a = { };
	
	for k,v in pairs(t) do
		if(fFilter) then
			if(fFilter(self, k, v, searchBoxText)) then
				table.insert(a, k);
			end
		else
			table.insert(a, k);
		end
	end
	table.sort(a, fSort);
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1;
		if a[i] == nil then 
			return nil;
		else 
			return a[i], t[a[i]];
		end
	end
	
	return iter;
end

-- Registers a Sort Function with name to show up in the sorting options for a list
-- listNames can be either the internal name of the list (i.e. PLAYERKOS) or a list of internal list names
function VanasKoSGUI:RegisterSortOption(listNames, sortOptionNameInternal, sortOptionName, sortOptionDesc, sortFunctionNew, sortFunctionRev)
	if(type(listNames) == "string") then
		listNames = { listNames };
	end

	for k, listNameInternal in pairs(listNames) do
		if(not sortOptions[listNameInternal]) then
			sortOptions[listNameInternal] = { };
		end
		sortOptions[listNameInternal][#sortOptions[listNameInternal]+1] = {
			text = sortOptionName,
			checked = function()
					local currentSort = VanasKoSGUI:GetCurrentSortFunction();
					return (currentSort == sortFunctionNew or currentSort == sortFunctionRev);
				end,
			func = function()
					VanasKoSGUI:SetSortFunction(sortFunctionNew, sortFunctionRev);
				end,
		};
	end
end

function VanasKoSGUI:SetDefaultSortFunction(lists, sortFunc, revSortFunc)
	if(type(lists) == "string") then
		lists = { lists };
	end
	for k,v in pairs(lists) do
		defaultSortFunction[v] = sortFunc;
		defaultRevSortFunction[v] = revSortFunc;
	end
end


local sortFunction = nil;
local reverseSort = nil;

function VanasKoSGUI:SetSortFunction(sortFunc, revSortFunc)
	if(sortFunction == sortFunc) then
		sortFunction = revSortFunc;
	elseif(sortFunction == revSortFunc) then
		sortFunction = sortFunc;
	else
		sortFunction = sortFunc;
	end
	
	self:UpdateShownList();
end

function VanasKoSGUI:GetCurrentSortFunction()
	return sortFunction;
end

function VanasKoSGUI:SortedList(list)
	local sortFunction = self:GetCurrentSortFunction();
	
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].FilterFunction) then
		return self:sortList(list, sortFunction, listHandler[VANASKOS.showList].FilterFunction);
	else
		return self:sortList(list, sortFunction, nil);
	end
	
	return nil;
end

local oldlist = "";
function VanasKoSGUI:RegisterList(listName, handlerObject)
	if(not handlerObject) then
		VanasKoS:Print("Error: No handlerObject for " .. listName);
		return;
	end
	if(not handlerObject.RenderButton) then
		VanasKoS:Print("Error: No RenderButton method for " .. listName);
		return;
	end
	if(not handlerObject.SetupColumns) then
		VanasKoS:Print("Error: No SetupColumns method for " .. listName);
		return;
	end
	listHandler[listName] = handlerObject;
end

function VanasKoSGUI:UnregisterList(listName)
	listHandler[listName] = nil;
end

function VanasKoSGUI:ScrollUpdate()
	VanasKoSGUI:ScrollFrameUpdate();
end

-- call if only data from entries in the list changed
function VanasKoSGUI:ScrollFrameUpdate()
	if(not VanasKoSListFrame:IsVisible()) then
		return;
	end
	local listOffset = FauxScrollFrame_GetOffset(VanasKoSListScrollFrame);
	local listVar = self:GetCurrentShownList();
	local listIndex = 1;
	local buttonIndex = 1;

	if(listVar == nil) then
		VANASKOS.selectedEntry = nil;
		self:GUIHideButtons(1, VANASKOS.MAX_LIST_BUTTONS);
		return nil;
	end
	
	-- stupid fix that the dropdown selection is correct if showList is set external
	UIDropDownMenu_SetSelectedValue(VanasKoSFrameChooseListDropDown, VANASKOS.showList);

	if(oldlist ~= VANASKOS.showList) then
		if(listHandler[oldlist] and listHandler[oldlist].HideList) then
			listHandler[oldlist]:HideList(oldlist);
		end
		if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ShowList) then
			listHandler[VANASKOS.showList]:ShowList(VANASKOS.showList);
		end
		if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].SetupColumns) then
			listHandler[VANASKOS.showList]:SetupColumns(VANASKOS.showList);
		end
	end

	for k,v in listVar do
 		if((listIndex-1) < listOffset) then
		else
			if(buttonIndex <= VANASKOS.MAX_LIST_BUTTONS) then
				local buttonText1 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "Text1");
				local buttonText2 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "Text2");
				local buttonText3 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "Text3");
				local buttonText4 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "Text4");
				local buttonText5 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "Text5");
				local buttonText6 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "Text6");
				local buttonText6 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "Text7");
				local buttonText6 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "Text8");
				local buttonText6 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "Text9");
				local button = getglobal("VanasKoSListFrameListButton" .. buttonIndex);
				button:SetID(listIndex);
				if(listIndex == VANASKOS.selectedEntry) then
					button:LockHighlight();
				else
					button:UnlockHighlight();
				end
				
				if(listHandler[VANASKOS.showList] ~= nil) then
					listHandler[VANASKOS.showList]:RenderButton(VANASKOS.showList, buttonIndex, button, k, v, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6, buttonText7, buttonText8, buttonText9);
				end
				
				buttonIndex = buttonIndex + 1;
			end
		end
		listIndex = listIndex + 1;
	end
	
	if(listIndex <= VANASKOS.MAX_LIST_BUTTONS) then
		self:GUIHideButtons(listIndex, VANASKOS.MAX_LIST_BUTTONS);
	end
	
	if(listIndex == 1) then
		VANASKOS.selectedEntry = nil;
	else
		if(VANASKOS.selectedEntry == nil) then
			VANASKOS.selectedEntry = 1;
			self:ScrollFrameUpdate();
		end
		if(VANASKOS.selectedEntry >= listIndex) then
			VANASKOS.selectedEntry = 1;
			self:ScrollFrameUpdate();
		end
	end

	-- 34 = Hoehe VanasKoSListFrameListButtonTemplate
	-- scrollframe, maxnum, to_display, height
	FauxScrollFrame_Update(VanasKoSListScrollFrame, listIndex-1, VANASKOS.MAX_LIST_BUTTONS, 16);
	
	oldlist = VANASKOS.showList;
end

function VanasKoSGUI:AddEntry()
	local name, realm = UnitName("target");
	if(VANASKOS.showList == "GUILDKOS") then
		name = GetGuildInfo("target");
	end
	if (name and realm and realm ~= "") then
		VANASKOS.LastNameEntered = name .. "-" .. realm;
	else
		VANASKOS.LastNameEntered = name;
	end

	if(VANASKOS.LastNameEntered) then
		if(UnitIsPlayer("target")) then
			StaticPopup_Show("VANASKOS_ADD_REASON_ENTRY");
		else
			StaticPopup_Show("VANASKOS_ADD_ENTRY");
		end
	else
		StaticPopup_Show("VANASKOS_ADD_ENTRY");
	end
end

function VanasKoSGUI:Update()
	if(not VanasKoSFrame:IsVisible()) then
		return nil;
	end
	if(VanasKoSFrame.selectedTab == 1) then
		VanasKoSFrameTopLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopLeft");
		VanasKoSFrameTopRight:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopRight");
		VanasKoSFrameBottomLeft:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\KoSListFrame-BotLeft");
		VanasKoSFrameBottomRight:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\KoSListFrame-BotRight");
		
		VanasKoSFrameTitleText:SetText(VANASKOS.NAME .. " - " .. L["Lists"]);
		self:GUIFrame_ShowSubFrame("VanasKoSListFrame");
		self:ScrollFrameUpdate();
	end
	if(VanasKoSFrame.selectedTab == 2) then
		VanasKoSFrameTopLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft");
		VanasKoSFrameTopRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight");
		VanasKoSFrameBottomLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomLeft");
		VanasKoSFrameBottomRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomRight");

		self:GUIFrame_ShowSubFrame("VanasKoSAboutFrame");
		VanasKoSFrameTitleText:SetText(VANASKOS.NAME .. " - " .. L["About"]);
	end
end

local function getConcatenatedString(firstchar, rest)
	return firstchar:upper() .. rest;
end

-- /script VanasKoS:Print(string.Capitalize("üüüü"));
function string.Capitalize(str)
	if(str == nil) then
		return "error"; 
	end

	local result, _ = str:gsub("^([%z\1-\127\194-\244][\128-\191]*)(.*)", getConcatenatedString);
	return result;
end

function VanasKoSGUI:Toggle()
	-- show/hide the frame: if not visible, show it via blizzard uipanel function if it wasn't moved, if moved just do a Show()
	if(VanasKoSFrame:IsVisible()) then
		if(self.db.profile.GUIMoved) then
			VanasKoSFrame:Hide();
		else
			HideUIPanel(VanasKoSFrame);
		end
	else
		VanasKoSListFrame:SetParent("VanasKoSFrame");
		VanasKoSListFrame:SetAllPoints();
		
		if(VanasKoSGUI.db.profile.GUIMoved) then
			VanasKoSFrame:Show();
		else
			ShowUIPanel(VanasKoSFrame);
		end
	end
end

function VanasKoSGUI:SetNumColumns(num)
	for i=1,VANASKOS.MAX_LIST_COLS do
		local hdr = getglobal("VanasKoSListFrameColButton" .. i);
		if(i <= num) then
			hdr:Show();
		else
			hdr:Hide();
		end

		for j=1,VANASKOS.MAX_LIST_BUTTONS do
			local txt = getglobal("VanasKoSListFrameListButton" .. j .. "Text" .. i);
			if (i <= num) then
				txt:Show();
			else
				txt:Hide();
			end
		end
	end
end

function VanasKoSGUI:SetColumnWidth(col, width)
	getglobal("VanasKoSListFrameColButton" .. col):SetWidth(width);
	getglobal("VanasKoSListFrameColButton" .. col .. "Middle"):SetWidth(width - 9);
	for i=1,VANASKOS.MAX_LIST_BUTTONS do
		getglobal("VanasKoSListFrameListButton" .. i .. "Text" .. col):SetWidth(width - 5);
	end
end

function VanasKoSGUI:SetColumnName(col, Name)
	getglobal("VanasKoSListFrameColButton" .. col):SetText(Name);
end

function VanasKoSGUI:SetColumnType(col, colType)
	for i=1,VANASKOS.MAX_LIST_BUTTONS do
		local frame = getglobal("VanasKoSListFrameListButton" .. i .. "Text" .. col);
		if frame then
			if (colType == "normal") then
				frame:SetFontObject("GameFontNormalSmall");
				frame:SetJustifyH("LEFT");
				frame:SetJustifyV("MIDDLE");
			elseif (colType == "number") then
				frame:SetFontObject("GameFontHighlightSmall");
				frame:SetJustifyH("RIGHT");
				frame:SetJustifyV("MIDDLE");
			elseif (colType == "highlight") then
				frame:SetFontObject("GameFontHighlightSmall");
				frame:SetJustifyH("LEFT");
				frame:SetJustifyV("MIDDLE");
			else
				error("Invalid column type");
			end
		end
	end
end

function VanasKoSGUI:SetColumnSort(column, sortFunctionNew, sortFunctionRev)
	if(column) then
		local colButton = getglobal("VanasKoSListFrameColButton" .. column);
		if(colButton) then
			colButton.sortFunction = sortFunctionNew;
			colButton.revSortFunction = sortFunctionRev;
		end
	end
end

function VanasKoSGUI:SetToggleButtonText(text)
	VanasKoSListFrameToggleRightButton:SetText(text);
end

function VanasKoSGUI:HideToggleButtons()
	VanasKoSListFrameNoTogglePatch:Show();
	VanasKoSListFrameToggleLeftButton:Hide();
	VanasKoSListFrameToggleRightButton:Hide();
end

function VanasKoSGUI:ShowToggleButtons()
	VanasKoSListFrameNoTogglePatch:Hide();
	VanasKoSListFrameToggleLeftButton:Show();
	VanasKoSListFrameToggleRightButton:Show();
end

--[[---------------------------------------------------------------------------------------------------
				Popup Dialog
-----------------------------------------------------------------------------------------------------]]
StaticPopupDialogs["VANASKOS_ADD_REASON_ENTRY"] = {
	text = L["Reason"],
	button1 = L["Accept"],
	button2 = L["Cancel"],
	hasEditBox = 1,
	maxLetters = 255,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		local reason = editBox:GetText();
		if(reason == "") then
			reason = nil;
		end
		VanasKoS:AddEntry(VANASKOS.showList, VANASKOS.LastNameEntered, { ['reason'] = reason });
		VanasKoSGUI:Update();
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		local reason = editBox:GetText();
		if(reason == "") then
			reason = nil;
		end
		VanasKoS:AddEntry(VANASKOS.showList, VANASKOS.LastNameEntered, { ['reason'] = reason });
		VanasKoSGUI:Update();
		this:GetParent():Hide();
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
}

StaticPopupDialogs["VANASKOS_ADD_ENTRY"] = {
	text = L["Name"],
	button1 = L["Accept"],
	button2 = L["Cancel"],
	hasEditBox = 1,
	maxLetters = 255,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		VANASKOS.LastNameEntered = editBox:GetText();
		if(VANASKOS.LastNameEntered ~= "") then
			StaticPopup_Show("VANASKOS_ADD_REASON_ENTRY");
		end
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		VANASKOS.LastNameEntered = editBox:GetText();
		if(VANASKOS.LastNameEntered ~= "") then
			StaticPopup_Show("VANASKOS_ADD_REASON_ENTRY");
		end
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetText("");
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
}

StaticPopupDialogs["VANASKOS_CHANGE_ENTRY"] = {
	text = L["Reason"],
	button1 = L["Accept"],
	button2 = L["Cancel"],
	hasEditBox = 1,
	maxLetters = 255,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		VanasKoSGUI:GUIChangeKoSReason(editBox:GetText());
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		VanasKoSGUI:GUIChangeKoSReason(editBox:GetText());
		this:GetParent():Hide();
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
	end,
	OnHide = function()
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
}
