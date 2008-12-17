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


local listHandler = { };

VanasKoSGUI.dropDownFrame = nil;

local optionsFrameInner = nil;

function VanasKoSGUI:AddConfigOption(name, option)
	if(not self.ConfigurationOptions) then
		self.ConfigurationOptions = {
			type = 'group',
			args = {
			}
		}
	end
	
	self.ConfigurationOptions.args[name] = option;
	
--[[	for k,v in pairs(self.ConfigurationOptions.args) do
		AceConfig:RegisterOptionsTable(k, self.ConfigurationOptions.args[k]);
		AceConfigDialog:AddToBlizOptions(k, self.ConfigurationOptions.args[k].name, "VanasKoS");
	end ]]
	AceConfig:RegisterOptionsTable(name, option);
	configFrameInner = AceConfigDialog:AddToBlizOptions(name, option.name, "VanasKoS")
end

function VanasKoSGUI:GetListName(listid)
	for k,v in pairs(VANASKOS.Lists) do
		if(v[1] == listid) then
			return v[2];
		end
	end
	return listid;
end

local sortOptions = {
};

local showOptions = { 
	{
		text = L["sort"],
		hasArrow = true,
		menuList = menuSortOptions,
	}
};


local defaultSortFunction = {
};

function VanasKoSGUI:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("GUI", 
					{
						profile = { 
								GUILocked = true,
								GUIMoved = false 
								}
					}
	);
	
	UIPanelWindows["VanasKoSFrame"] = { area = "left", pushable = 1, whileDead = 1 };

	AceConfig:RegisterOptionsTable("VanasKoS", {
		name = "VanasKoS",
		type = "group",
		args = {
			help = {
				type = "description",
				order = 1,
				name = GetAddOnMetadata("VanasKoS", "Notes"),
			},
			version = {
				type = "description",
				order = 2,
				name = L["Version: "] .. VANASKOS.VERSION,
			},
			performanceheader = {
				type = "header",
				order = 3,
				name = L["Performance"],
			},
			combatlog = {
				type = "toggle",
				order = 4,
				name = L["Use Combat Log"],
				desc = L["Toggles if the combatlog should be used to detect nearby player (Needs UI-Reload)"],
				get = function() return VanasKoSDataGatherer.db.profile.UseCombatLog; end,
				set = function(frame, v) VanasKoSDataGatherer.db.profile.UseCombatLog = v; end,
			},
			playerdatastore = {
				type = "toggle",
				order = 5,
				name = L["Permanent Player-Data-Storage"],
				desc = L["Toggles if the data about players (level, class, etc) should be saved permanently."],
				get = function() return VanasKoSDataGatherer.db.profile.StorePlayerDataPermanently; end,
				set = function(frame, v) VanasKoSDataGatherer.db.profile.StorePlayerDataPermanently = v; end,
			}
		},
	});

	self.configFrame = AceConfigDialog:AddToBlizOptions("VanasKoS", "VanasKoS");
	
	self:AddConfigOption(L["Profiles"], LibStub("AceDBOptions-3.0"):GetOptionsTable(VanasKoS.db));
	
	VanasKoSListFrameShowButton:SetScript("OnClick", function()
			local x, y = GetCursorPosition();
			local uiScale = UIParent:GetEffectiveScale();
			EasyMenu(showOptions, VanasKoSGUI.dropDownFrame, UIParent, x/uiScale, y/uiScale, "MENU");
		end);
	
	VanasKoSListFrameConfigurationButton:SetScript("OnClick", function()
			InterfaceOptionsFrame_OpenToCategory(configFrameInner); -- open any inner config frame first (causes list to expand)
			InterfaceOptionsFrame_OpenToCategory(VanasKoSGUI.configFrame);
		end);

	self:RegisterMessage("VanasKoS_List_Added", "InitializeDropDowns");
	
	self:AddConfigOption("GUI", {
		type = 'group',
		name = "GUI",
		desc = "Main GUI Options",
		args = {
			locked = { 
				type = 'toggle',
				name = L["Locked"],
				desc = L["Locks the Main Window"],
				order = 1,
				set = function() VanasKoSGUI.db.profile.GUILocked = not VanasKoSGUI.db.profile.GUILocked; end,
				get = function() return VanasKoSGUI.db.profile.GUILocked; end,
			},
			reset = {
				type = 'execute',
				name = L["Reset Position"],
				desc = L["Resets the Position of the Main Window"],
				order = 2,
				func = function() VanasKoSGUI.db.profile.GUIMoved = false; HideUIPanel(VanasKoSFrame); ShowUIPanel(VanasKoSFrame); end,
			}
		},
	});
	
	VanasKoSListFrameSearchBox:SetScript("OnTextChanged", function() VanasKoSGUI:SetFilterText(this:GetText()) end);
	
	VanasKoSFrame:RegisterForDrag("LeftButton");
	VanasKoSFrame:SetScript("OnDragStart",
								function()
									if(VanasKoSGUI.db.profile.GUILocked) then
										return;
									end
									VanasKoSFrame:StartMoving();
								end);
	VanasKoSFrame:SetScript("OnDragStop",
								function()
									VanasKoSFrame:StopMovingOrSizing();
									VanasKoSGUI.db.profile.GUIMoved = true;
								end);
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

function VanasKoSGUI:UpdateSortOptions()
	if(sortOptions[VANASKOS.showList]) then
		showOptions[1].menuList = sortOptions[VANASKOS.showList];
	else
		showOptions[1].menuList = { };
	end
	
end

function VanasKoSGUI:GetShowButtonOptions()
	return showOptions;
end

local shownList = nil;
local displayedList = nil;

function VanasKoSGUI:ShowList(list)
	VANASKOS.showList = list;
	shownList = VanasKoS:GetList(VANASKOS.showList);
	
	self:UpdateSortOptions();
	
	if(defaultSortFunction[list] ~= nil) then
		self:SetSortFunction(defaultSortFunction[list]);
	else
		self:SetSortFunction(nil);
	end
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
			self:GUIHideButtons(1, 10);
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
				self:GUIHideButtons(1, 10);
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
end

function VanasKoSGUI:ListButton_OnLeave(button, frame)
	if(listHandler[VANASKOS.showList] and listHandler[VANASKOS.showList].ListButtonOnLeave) then
		listHandler[VANASKOS.showList]:ListButtonOnLeave(button, frame);
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

function VanasKoSGUI:GUIShowButtons(minimum, maximum)
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
		function Reset()
			i = 0;
		end
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
function VanasKoSGUI:RegisterSortOption(listNames, sortOptionNameInternal, sortOptionName, sortOptionDesc, sortFunctionNew)
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
					if(VanasKoSGUI:GetCurrentSortFunction() == sortFunctionNew) then
						return true;
					end
					return false;
				end,
			func = function()
					VanasKoSGUI:SetSortFunction(sortFunctionNew);
				end,
		};
	end
end


function VanasKoSGUI:SetDefaultSortFunction(lists, sortFunc)
	if(type(lists) == "string") then
		lists = { lists };
	end
	for k,v in pairs(lists) do
		defaultSortFunction[v] = sortFunc;
	end
end

local sortFunction = nil;

function VanasKoSGUI:SetSortFunction(sortFunc)
	sortFunction = sortFunc;
	
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
		self:GUIHideButtons(1, 10);
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
	end
	
	for k,v in listVar do
 		if((listIndex-1) < listOffset) then
		else
			if(buttonIndex <= 10) then
				local buttonText1 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "ButtonTextName");
				local buttonText2 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "ButtonTextReason");
				local button = getglobal("VanasKoSListFrameListButton" .. buttonIndex);
				button:SetID(listIndex);
				if(listIndex == VANASKOS.selectedEntry) then
					button:LockHighlight();
				else
					button:UnlockHighlight();
				end
				
				if(listHandler[VANASKOS.showList] ~= nil) then
					listHandler[VANASKOS.showList]:RenderButton(VANASKOS.showList, buttonIndex, button, k, v, buttonText1, buttonText2);
				end
				
				buttonIndex = buttonIndex + 1;
			end
		end
		listIndex = listIndex + 1;
	end
	
	if(listIndex <= 10) then
		self:GUIHideButtons(listIndex, 10);
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
	FauxScrollFrame_Update(VanasKoSListScrollFrame, listIndex-1, 10, 34);
	
	oldlist = VANASKOS.showList;
end

function VanasKoSGUI:AddEntry()
	if(VANASKOS.showList == "GUILDKOS") then
		VANASKOS.LastNameEntered = GetGuildInfo("target");
	else
		VANASKOS.LastNameEntered = UnitName("target");
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
		VanasKoSFrameTopLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft");
		VanasKoSFrameTopRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight");
		VanasKoSFrameBottomLeft:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-BotLeft");
		VanasKoSFrameBottomRight:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-BotRight");
		
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
	if(firstchar:len() == 1 and firstchar:byte(1) > 127) then
		firstchar = firstchar .. rest:sub(1, 1);
		rest = rest:sub(2);
	end
	return firstchar:upper() .. rest;
end

-- /script VanasKoS:Print(string.Capitalize("üüüü"));
function string.Capitalize(str)
	if(str == nil) then
		return "error"; 
	end
    if(GetLocale() == "koKR") then 
		return str;
	end

	local result, _ = str:gsub("(.)(.*)", getConcatenatedString);
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

--[[---------------------------------------------------------------------------------------------------
				Popup Dialog
-----------------------------------------------------------------------------------------------------]]
StaticPopupDialogs["VANASKOS_ADD_REASON_ENTRY"] = {
	text = L["Reason"],
	button1 = L["Accept"],
	button2 = L["Cancel"],
	hasEditBox = 1,
	maxLetters = 40,
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
		if(ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
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
	maxLetters = 40,
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
		if(ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
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
	maxLetters = 100,
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
		if(ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
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
