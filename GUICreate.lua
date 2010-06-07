local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS");

VanasKoSGUICreate = VanasKoS:NewModule("GUICreate");

function VanasKoSGUICreate:OnInitialize()
	self:CreateFrames();
end

function VanasKoSGUICreate:OnEnable()
end

function VanasKoSGUICreate:OnDisable()
end

function VanasKoSGUICreate:CreateFrames()
	self:CreateMainFrame();
	self:CreateTabButtons();
	self:CreateListFrame();
	self:CreateAboutFrame();

	VanasKoSFrame:Hide();
end


function VanasKoSGUICreate:CreateTabButtons()
	local tabButton1 = CreateFrame("Button", "VanasKoSFrameTab1", VanasKoSFrame, "CharacterFrameTabButtonTemplate");
	tabButton1:SetID(1);
	tabButton1:SetPoint("BOTTOMLEFT", VanasKoSFrame, "BOTTOMLEFT", 11, 45);
	tabButton1:SetText(L["Lists"]);
	tabButton1:SetScript("OnClick",
			function(frame)
				PanelTemplates_Tab_OnClick(frame, VanasKoSFrame);
				VanasKoSGUI:Update();
			end);


	local tabButton2 = CreateFrame("Button", "VanasKoSFrameTab2", VanasKoSFrame, "CharacterFrameTabButtonTemplate");
	tabButton2:SetID(2);
	tabButton2:SetPoint("LEFT", tabButton1, "RIGHT", -14, 0);
	tabButton2:SetText(L["About"]);
	tabButton2:SetScript("OnClick",
			function(frame)
				PanelTemplates_Tab_OnClick(frame, VanasKoSFrame);
				VanasKoSGUI:Update();
			end);

	PanelTemplates_SetNumTabs(VanasKoSFrame, 2);
	VanasKoSFrame.selectedTab = 1;
	PanelTemplates_UpdateTabs(VanasKoSFrame);
end

function VanasKoSGUICreate:CreateAboutFrame()
	local aboutFrame = CreateFrame("Frame", "VanasKoSAboutFrame", VanasKoSFrame);
	aboutFrame:SetAllPoints(VanasKoSFrame);

	local htmlFrame = CreateFrame("SimpleHTML", "VanasKoSAboutFrameText", aboutFrame);
	htmlFrame:SetPoint("TOPLEFT", aboutFrame, 26, -77);
	htmlFrame:SetWidth(312);
	htmlFrame:SetHeight(512);
	htmlFrame:SetFontObject("h1", "GameFontNormalLarge");
	htmlFrame:SetFontObject("h2", "GameFontNormal");
	htmlFrame:SetFontObject("h3", "GameFontNormalSmall");


	htmlFrame:SetScript("OnShow", function() VanasKoSGUICreate:UpdateAboutText(); end);

	--[[
	local donateButton = CreateFrame("Button", nil, aboutFrame, "UIPanelButtonTemplate");
	donateButton:SetPoint("BOTTOM", aboutFrame, "BOTTOM", -10, 90);
	donateButton:SetHeight(21);
	donateButton:SetWidth(120);
	donateButton:SetText(L["Donate"]);
	donateButton:SetScript("OnClick", function() VanasKoS:Print("Donate via PayPal to boredvana@gmail.com") end); ]]
	self:UpdateAboutText()
end

function VanasKoSGUICreate:UpdateAboutText()
	local modules = "";

	local i = 1;
	for name, module in VanasKoS:IterateModules() do
		local status = "";

		if(VanasKoS:GetModule(name):IsEnabled()) then
			status = "|cFF00FF00active|r";
		else
			status = "|cFFFF0000inactive|r";
		end

		modules = modules .. name .. ": " .. status
		if(i % 2 == 0) then
			modules = modules .. "<br />";
		else
			modules = modules .. ", ";
		end
		i = i + 1;
	end

	getglobal("VanasKoSAboutFrameText"):SetText("<html><body>"
		.. "<h1 align=\"center\">|cFFFFFFFF" .. VANASKOS.NAME .. "|r - " .. VANASKOS.VERSION .. "</h1><br />"
		.. "<h2 align=\"center\">Created by: |cFFFFFFFFVane (|cFF0000FFEU-Aegwynn|r)|r</h2><br />"
		.. "<h2><br />|cFF00FF00Authors:|r</h2><br />"
		.. "<h2>|cFFFFFFFFFRRjak |r</h2><br />"
		.. "<h2>|cFFFFFFFFVane (|cFF0000FFEU-Aegwynn|r)|r</h2><br />"
		.. "<h2>|cFFFFFFFFXilcoy (|cFF0000FFUS-Lightning's Blade|r)|r</h2><br />"
		.. "<h2><br />|cFF00FF00Localization:|r</h2><br />"
		.. "<h2>French: |cFFFFFFFFScrapy (|cFF0000FFEU-Archimonde|r)|r</h2><br />"
		.. "<h2>Korean: |cFFFFFFFFFenlis|r</h2><br />"
		.. "<h2>Spanish: |cFFFFFFFFshiftos|r</h2><br />"
		.. "<h2>English/German: |cFFFFFFFFVane (|cFF0000FFEU-Aegwynn|r)|r / |cFFFFFFFFFRRjak|r</h2><br />"
		.. "<h2><br /></h2><h3>|cFF00FF00Modules:|r<br />"
		.. modules
		.. "</h3>"
		.. "</body></html>");
end

function VanasKoSGUICreate:CreateListFrame()
	local listFrame = CreateFrame("Frame", "VanasKoSListFrame", VanasKoSFrame);
	listFrame:SetAllPoints(VanasKoSFrame);

	local chooseListDropDown = CreateFrame("Frame", "VanasKoSFrameChooseListDropDown", VanasKoSListFrame, "UIDropDownMenuTemplate");
	chooseListDropDown:SetPoint("TOPLEFT", VanasKoSListFrame, "TOPLEFT", 65, -43);
	VanasKoSFrameChooseListDropDownButton:SetScript("OnClick", function() ToggleDropDownMenu(1, nil, VanasKoSFrameChooseListDropDown, VanasKoSFrameChooseListDropDown, 15, 10); end);
	UIDropDownMenu_SetWidth(chooseListDropDown, 100, 15)

	local checkButton = CreateFrame("CheckButton", "VanasKoSListFrameCheckBox", VanasKoSListFrame, "UICheckButtonTemplate");
	local checkButtonText = checkButton:CreateFontString(checkButton:GetName() .. "Text", "BORDER");
	checkButtonText:SetPoint("LEFT", checkButton, "RIGHT", 0, 0);
	checkButton:SetFontString(checkButtonText);
	checkButton:SetWidth(20);
	checkButton:SetHeight(20);
	checkButton:SetNormalFontObject("GameFontHighlightSmall");
	checkButton:SetPoint("TOPLEFT", listFrame, "TOPLEFT", 200, -44);

	local addEntryButton = CreateFrame("Button", "VanasKoSListFrameAddButton", VanasKoSListFrame, "UIPanelButtonTemplate");
	addEntryButton:SetWidth(110);
	addEntryButton:SetHeight(22);
	addEntryButton:SetText(L["Add Entry"]);
	addEntryButton:SetPoint("BOTTOMRIGHT", VanasKoSListFrame, "BOTTOMRIGHT", -40, 82);
	addEntryButton:SetScript("OnClick", function() VanasKoSGUI:AddEntry(); end);

	local removeEntryButton = CreateFrame("Button", "VanasKoSListFrameRemoveButton", VanasKoSListFrame, "UIPanelButtonTemplate");
	removeEntryButton:SetWidth(110);
	removeEntryButton:SetHeight(22);
	removeEntryButton:SetText(L["Remove Entry"]);
	removeEntryButton:SetPoint("RIGHT", addEntryButton, "LEFT", 0, 0);
	removeEntryButton:SetScript("OnClick", function() VanasKoSGUI:RemoveEntry(); end);

	local changeEntryButton = CreateFrame("Button", "VanasKoSListFrameChangeButton", VanasKoSListFrame, "UIPanelButtonTemplate");
	changeEntryButton:SetWidth(105);
	changeEntryButton:SetHeight(22);
	changeEntryButton:SetPoint("RIGHT", removeEntryButton, "LEFT", 0, 0);
	changeEntryButton:SetText(L["Change Entry"]);
	changeEntryButton:SetScript("OnClick", function() VanasKoSGUI:GUIShowChangeDialog(); end);

	local configurationButton = CreateFrame("Button", "VanasKoSListFrameConfigurationButton", VanasKoSListFrame, "UIPanelButtonTemplate");
	configurationButton:SetWidth(110);
	configurationButton:SetHeight(22);
	configurationButton:SetPoint("BOTTOM", addEntryButton, "TOP", 0, 0);
	configurationButton:SetText(L["Configuration"]);

	local colButton = { };
	local colButtonName = "VanasKoSListFrameColButton";
	for i=1,VANASKOS.MAX_LIST_COLS do
		colButton[i] = CreateFrame("Button", colButtonName .. i, VanasKoSListFrame);
		colButton[i]:SetWidth(10);
		colButton[i]:SetHeight(24);
		colButton[i]:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		colButton[i]:SetScript("OnClick", function() VanasKoSGUI:ColButton_OnClick(arg1, this); end);
		colButton[i]:SetScript("OnEnter", function() VanasKoSGUI:ColButton_OnEnter(arg1, this); end);
		colButton[i]:SetScript("OnLeave", function() VanasKoSGUI:ColButton_OnLeave(arg1, this); end);
		colButton[i]:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
		colButton[i]:GetHighlightTexture():SetBlendMode("ADD");
		colButton[i]:SetID(i);

		local colButtonLeft = colButton[i]:CreateTexture(colButton[i]:GetName() .. "Left", "BACKGROUND");
		colButtonLeft:SetWidth(5);
		colButtonLeft:SetHeight(24);
		colButtonLeft:SetPoint("TOPLEFT");
		colButtonLeft:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
		colButtonLeft:SetTexCoord(0, 0.078125, 0, 0.75);

		local colButtonMiddle = colButton[i]:CreateTexture(colButton[i]:GetName() .. "Middle", "BACKGROUND");
		colButtonMiddle:SetWidth(53);
		colButtonMiddle:SetHeight(24);
		colButtonMiddle:SetPoint("LEFT", colButtonLeft, "RIGHT");
		colButtonMiddle:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
		colButtonMiddle:SetTexCoord(0.078125, 0.90625, 0, 0.75);

		local colButtonRight = colButton[i]:CreateTexture(colButton[i]:GetName() .. "Right", "BACKGROUND");
		colButtonRight:SetWidth(4);
		colButtonRight:SetHeight(24);
		colButtonRight:SetPoint("LEFT", colButtonMiddle, "RIGHT");
		colButtonRight:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
		colButtonRight:SetTexCoord(0.90625, 0.96875, 0, 0.75);

		colButton[i]:SetNormalFontObject("GameFontHighlightSmall");
		colButton[i].sortFunction = {};
		colButton[i].revSortFunction = {};

		if(i == 1) then
			colButton[i]:SetPoint("TOPLEFT", VanasKoSListFrame, "TOPLEFT", 20, -70);
		else
			colButton[i]:SetPoint("LEFT", colButton[i-1], "RIGHT", -2, 0);
		end
	end

	local listButton = { };
	local listButtonName = "VanasKoSListFrameListButton";
	for i=1,VANASKOS.MAX_LIST_BUTTONS do
		listButton[i] = CreateFrame("Button", listButtonName .. i, VanasKoSListFrame);
		listButton[i]:SetWidth(298);
		listButton[i]:SetHeight(16);
		listButton[i]:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		listButton[i]:SetScript("OnClick", function() VanasKoSGUI:ListButton_OnClick(arg1, this); end);
		listButton[i]:SetScript("OnEnter", function() VanasKoSGUI:ListButton_OnEnter(arg1, this); end);
		listButton[i]:SetScript("OnLeave", function() VanasKoSGUI:ListButton_OnLeave(arg1, this); end);
		listButton[i]:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
		listButton[i]:GetHighlightTexture():SetBlendMode("ADD");
		listButton[i]:SetID(i);

		local listButtonTextName = listButton[i]:GetName() .. "Text"
		local listButtonText = CreateFrame("Frame", listButtonTextName, listButton[i]);
		listButtonText:SetAllPoints(listButton[i]);
		if(i == 1) then
			listButton[i]:SetPoint("TOPLEFT", VanasKoSListFrame, "TOPLEFT", 15, -95);
		else
			listButton[i]:SetPoint("TOPLEFT", listButton[i-1], "BOTTOMLEFT");
		end

		local listButtonSubText = { };
		for j=1,VANASKOS.MAX_LIST_COLS do
			listButtonSubText[j] = listButtonText:CreateFontString(listButtonTextName .. j, "BORDER");
			listButtonSubText[j]:SetWidth(10);
			listButtonSubText[j]:SetHeight(14);
			listButtonSubText[j]:SetJustifyH("LEFT");
			listButtonSubText[j]:SetJustifyV("MIDDLE");
			listButtonSubText[j]:SetFontObject("GameFontNormalSmall");

			if(j == 1) then
				listButtonSubText[j]:SetPoint("TOPLEFT", listButtonText, "TOPLEFT", 10, 0);
			else
				listButtonSubText[j]:SetPoint("LEFT", listButtonSubText[j-1], "RIGHT", 2, 0);
			end
		end
	end

--[[	VanasKoSListFrameSyncButton = CreateFrame("Button", "VanasKoSListFrameSyncButton", VanasKoSListFrame, "UIPanelButtonTemplate");
	VanasKoSListFrameSyncButton:SetWidth(40);
	VanasKoSListFrameSyncButton:SetHeight(17);
	VanasKoSListFrameSyncButton:SetPoint("TOPRIGHT", listFrame, "TOPRIGHT", -44, -36);
	VanasKoSListFrameSyncButton:SetText(L["sync"]); ]]

	local toggleRButton = CreateFrame("Button", "VanasKoSListFrameToggleRightButton", VanasKoSListFrame);
	toggleRButton:SetWidth(20);
	toggleRButton:SetHeight(20);
	toggleRButton:SetPoint("BOTTOMRIGHT", VanasKoSListFrame, "BOTTOMRIGHT", -65, 126);
	toggleRButton:SetScript("OnClick", function() VanasKoSGUI:ToggleRightButton_OnClick(arg1, this); end);
	toggleRButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
	toggleRButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
	toggleRButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
	toggleRButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD");
	toggleRButton:SetNormalFontObject("GameFontNormalSmall");
	toggleRButton:SetPushedTextOffset(0, 0);
	local toggleRButtonText = toggleRButton:CreateFontString(toggleRButton:GetName() .. "Text", "BORDER");
	toggleRButtonText:SetWidth(100);
	toggleRButtonText:SetJustifyH("MIDDLE");
	toggleRButtonText:SetPoint("RIGHT", toggleRButton, "LEFT", 0, 0);
	toggleRButton:SetFontString(toggleRButtonText);

	local toggleLButton = CreateFrame("Button", "VanasKoSListFrameToggleLeftButton", VanasKoSListFrame);
	toggleLButton:SetWidth(20);
	toggleLButton:SetHeight(20);
	toggleLButton:SetPoint("RIGHT", toggleRButtonText, "LEFT", 0, 0);
	toggleLButton:SetScript("OnClick", function() VanasKoSGUI:ToggleLeftButton_OnClick(arg1, this); end);
	toggleLButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
	toggleLButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down");
	toggleLButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
	toggleLButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD");

	local noToggleFrame = CreateFrame("Frame", "VanasKoSListFrameNoTogglePatch", VanasKoSListFrame);
	noToggleFrame:SetWidth(256);
	noToggleFrame:SetHeight(32);
	noToggleFrame:SetPoint("BOTTOMLEFT", listFrame, "BOTTOMLEFT", 150, 117);
	local noToggleTexture = noToggleFrame:CreateTexture(nil, "OVERLAY");
	noToggleTexture:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\NoTogglePatch");
	noToggleTexture:SetWidth(256);
	noToggleTexture:SetHeight(32);
	noToggleTexture:SetPoint("TOPLEFT", noToggleFrame);
	noToggleFrame:Hide();

	local scrollFrame = CreateFrame("ScrollFrame", "VanasKoSListScrollFrame", VanasKoSListFrame, "FauxScrollFrameTemplate");
	scrollFrame:SetWidth(296);
	scrollFrame:SetHeight(287)
	scrollFrame:SetPoint("TOPRIGHT", listFrame, "TOPRIGHT", -67, -96);

	local searchBox = CreateFrame("EditBox", "VanasKoSListFrameSearchBox", VanasKoSListFrame, "InputBoxTemplate");
	searchBox:SetWidth(191);
	searchBox:SetHeight(32);
	searchBox:SetAutoFocus(false);
	searchBox:SetPoint("BOTTOMLEFT", listFrame, "BOTTOMLEFT", 42, 100);

	local scrollBarTexture1 = scrollFrame:CreateTexture(nil, "ARTWORK");
	scrollBarTexture1:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar");
	scrollBarTexture1:SetWidth(31);
	scrollBarTexture1:SetHeight(256);
	scrollBarTexture1:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", -2, 5);
	scrollBarTexture1:SetTexCoord(0, 0.484375, 0, 1.0);

	local scrollBarTexture2 = scrollFrame:CreateTexture(nil, "ARTWORK");
	scrollBarTexture2:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar");
	scrollBarTexture2:SetWidth(31);
	scrollBarTexture2:SetHeight(106);
	scrollBarTexture2:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", -2, -2);
	scrollBarTexture2:SetTexCoord(0.515625, 1.0, 0, 0.4140625);

	scrollFrame:SetScript("OnVerticalScroll", 
							function(frame, offset)
								FauxScrollFrame_OnVerticalScroll(frame, offset, 16, VanasKoSGUI.ScrollUpdate);
							end);
	scrollFrame:SetScript("OnShow", 
							function() 
								UIDropDownMenu_SetSelectedValue(VanasKoSFrameChooseListDropDown, VANASKOS.showList);
							end);
end

function VanasKoSGUICreate:CreateMainFrameButtons()
	local closeButton = CreateFrame("Button", "VanasKosFrameCloseButton", VanasKoSFrame, "UIPanelCloseButton");
	closeButton:SetPoint("TOPRIGHT", VanasKoSFrame, -30, -8);
end

function VanasKoSGUICreate:CreateMainFrame()
	local kosFrame = CreateFrame("Frame", "VanasKoSFrame", UIParent);
	kosFrame:SetWidth(384);
	kosFrame:SetHeight(512);
	kosFrame:SetToplevel(1);
	kosFrame:SetMovable(1);
	kosFrame:EnableMouse(1);
	kosFrame:SetPoint("TOPLEFT", "UIParent", 0, -104);
	kosFrame:SetHitRectInsets(0, 30, 0, 45);
	kosFrame:SetScript("OnShow", function() VanasKoSGUI:Update(); end);

	local backgroundIconTexture = kosFrame:CreateTexture("VanasKoSFrame_BackgroundIcon", "BACKGROUND");
	backgroundIconTexture:SetTexture("Interface\\FriendsFrame\\FriendsFrameScrollIcon");
	backgroundIconTexture:SetWidth(60);
	backgroundIconTexture:SetHeight(60);
	backgroundIconTexture:SetPoint("TOPLEFT", kosFrame, 7, -6);

	local kosFrameTextureTopLeft = kosFrame:CreateTexture("VanasKoSFrameTopLeft", "ARTWORK");
	kosFrameTextureTopLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopLeft");
	kosFrameTextureTopLeft:SetWidth(256);
	kosFrameTextureTopLeft:SetHeight(256);
	kosFrameTextureTopLeft:SetPoint("TOPLEFT");

	local kosFrameTextureTopRight = kosFrame:CreateTexture("VanasKoSFrameTopRight", "ARTWORK");
	kosFrameTextureTopLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopRight");
	kosFrameTextureTopRight:SetWidth(128);
	kosFrameTextureTopRight:SetHeight(256);
	kosFrameTextureTopRight:SetPoint("TOPRIGHT");

	local kosFrameTextureBottomLeft = kosFrame:CreateTexture("VanasKoSFrameBottomLeft", "ARTWORK");
	kosFrameTextureBottomLeft:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\KoSListFrame-BotLeft");
	kosFrameTextureBottomLeft:SetWidth(256);
	kosFrameTextureBottomLeft:SetHeight(256);
	kosFrameTextureBottomLeft:SetPoint("BOTTOMLEFT");

	local kosFrameTextureBottomRight = kosFrame:CreateTexture("VanasKoSFrameBottomRight", "ARTWORK");
	kosFrameTextureBottomRight:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\KoSListFrame-BotRight");
	kosFrameTextureBottomRight:SetWidth(128);
	kosFrameTextureBottomRight:SetHeight(256);
	kosFrameTextureBottomRight:SetPoint("BOTTOMRIGHT");

	local kosFrameTitleText = kosFrame:CreateFontString("VanasKoSFrameTitleText", "OVERLAY");
	kosFrameTitleText:SetPoint("TOP", kosFrame, 0, -18);
	kosFrameTitleText:SetFontObject("GameFontNormal");
	kosFrameTitleText:SetText(VANASKOS.NAME .. " " .. VANASKOS.VERSION);

	self:CreateMainFrameButtons();
end
