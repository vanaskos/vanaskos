local L = AceLibrary("AceLocale-2.2"):new("VanasKoS");

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

	local donateButton = CreateFrame("Button", nil, aboutFrame, "UIPanelButtonTemplate");
	donateButton:SetPoint("BOTTOM", aboutFrame, "BOTTOM", -10, 90);
	donateButton:SetHeight(21);
	donateButton:SetWidth(120);
	donateButton:SetText(L["Donate"]);
	donateButton:SetScript("OnClick", function() VanasKoS:OpenDonationFrame(); end);
	self:UpdateAboutText()
end

function VanasKoSGUICreate:UpdateAboutText()
	local modules = "";
	
	local i = 1;
	for name, module in VanasKoS:IterateModules() do
		local status = "";
		if(VanasKoS:IsModuleActive(name, true)) then
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
	chooseListDropDown:SetPoint("TOPLEFT", VanasKoSListFrame, "TOPLEFT", 65, -44);
	
	local addEntryButton = CreateFrame("Button", "VanasKoSListFrameAddButton", VanasKoSListFrame, "UIPanelButtonTemplate");
	addEntryButton:SetWidth(131);
	addEntryButton:SetHeight(21);
	addEntryButton:SetText(L["Add Entry"]);
	addEntryButton:SetPoint("BOTTOMLEFT", VanasKoSListFrame, "BOTTOMLEFT", 17, 107);
	addEntryButton:SetScript("OnClick", function() VanasKoSGUI:AddEntry(); end);
	
	local removeEntryButton = CreateFrame("Button", "VanasKoSListFrameRemoveButton", VanasKoSListFrame, "UIPanelButtonTemplate");
	removeEntryButton:SetWidth(131);
	removeEntryButton:SetHeight(21);
	removeEntryButton:SetText(L["Remove Entry"]);
	removeEntryButton:SetPoint("TOP", addEntryButton, "BOTTOM", 0, -5);
	removeEntryButton:SetScript("OnClick", function() VanasKoSGUI:RemoveEntry(); end);
	
	local changeEntryButton = CreateFrame("Button", "VanasKoSListFrameChangeButton", VanasKoSListFrame, "UIPanelButtonTemplate");
	changeEntryButton:SetWidth(131);
	changeEntryButton:SetHeight(21);
	changeEntryButton:SetPoint("LEFT", removeEntryButton, "RIGHT", 66, 0);
	changeEntryButton:SetText(L["Change Entry"]);
	changeEntryButton:SetScript("OnClick", function() VanasKoSGUI:GUIShowChangeDialog(); end);

	local configurationButton = CreateFrame("Button", "VanasKoSListFrameConfigurationButton", VanasKoSListFrame, "UIPanelButtonTemplate");
	configurationButton:SetWidth(131);
	configurationButton:SetHeight(21);
	configurationButton:SetPoint("LEFT", addEntryButton, "RIGHT", 66, 0);
	configurationButton:SetText(L["Configuration"]);
	
	local listButton = { };
	local listButtonName = "VanasKoSListFrameListButton";
	for i=1,10 do
		listButton[i] = CreateFrame("Button", listButtonName .. i, VanasKoSListFrame);
		listButton[i]:SetWidth(298);
		listButton[i]:SetHeight(31);
		listButton[i]:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		listButton[i]:SetScript("OnClick", function() VanasKoSGUI:ListButton_OnClick(arg1, this); end);
		listButton[i]:SetScript("OnEnter", function() VanasKoSGUI:ListButton_OnEnter(arg1, this); end);
		listButton[i]:SetScript("OnLeave", function() VanasKoSGUI:ListButton_OnLeave(arg1, this); end);
		listButton[i]:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
		listButton[i]:GetHighlightTexture():SetBlendMode("ADD");
		listButton[i]:SetID(i);
		
		local listButtonText = CreateFrame("Frame", listButton[i]:GetName() .. "ButtonText", listButton[i]);
		listButtonText:SetAllPoints(listButton[i]);

		local listButtonTextName = listButtonText:CreateFontString(listButtonText:GetName() .. "Name", "BORDER"); -- , "GameFontNormal"
		listButtonTextName:SetWidth(298);
		listButtonTextName:SetJustifyH("LEFT");
		listButtonTextName:SetPoint("TOPLEFT", listButtonText, "TOPLEFT", 10, -3);
		listButtonTextName:SetFontObject("GameFontNormal");
		
		local listButtonTextReason = listButtonText:CreateFontString(listButtonText:GetName() .. "Reason", "BORDER"); -- , "GameFontHighlight"
		listButtonTextReason:SetWidth(298);
		listButtonTextReason:SetJustifyH("LEFT");
		listButtonTextReason:SetPoint("TOPLEFT", listButtonTextName, "BOTTOMLEFT");
		listButtonTextReason:SetFontObject("GameFontHighlightSmall");
	
		if(i == 1) then
			listButton[i]:SetPoint("TOPLEFT", VanasKoSListFrame, "TOPLEFT", 23, -76);
		else
			listButton[i]:SetPoint("TOP", listButton[i-1], "BOTTOM");
		end
	end
	
	--[[
	local syncButton = CreateFrame("Button", "VanasKoSListFrameSyncButton", VanasKoSListFrame, "UIPanelButtonTemplate");
	syncButton:SetWidth(40);
	syncButton:SetHeight(17);
	syncButton:SetPoint("TOPRIGHT", listFrame, "TOPRIGHT", -44, -36);
	syncButton:SetText(L["sync"]);
	]]
	
	local showButton = CreateFrame("Button", "VanasKoSListFrameShowButton", VanasKoSListFrame, "UIPanelButtonTemplate");
	showButton:SetWidth(40);
	showButton:SetHeight(17);
	showButton:SetPoint("TOPRIGHT", listFrame, "TOPRIGHT", -124, -36);
	showButton:SetText(L["show"]);
	
	local scrollFrame = CreateFrame("ScrollFrame", "VanasKoSListScrollFrame", VanasKoSListFrame, "FauxScrollFrameTemplate");
	scrollFrame:SetWidth(296);
	scrollFrame:SetHeight(304)
	scrollFrame:SetPoint("TOPRIGHT", listFrame, "TOPRIGHT", -67, -75);

	local searchBox = CreateFrame("EditBox", "VanasKoSListFrameSearchBox", VanasKoSListFrame, "InputBoxTemplate");
	searchBox:SetWidth(120);
	searchBox:SetHeight(12);
	searchBox:SetAutoFocus(false);
	searchBox:SetPoint("BOTTOMRIGHT", scrollFrame, "TOPRIGHT", 28, 5);
	
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
								FauxScrollFrame_OnVerticalScroll(frame, offset, 34, VanasKoSGUI.ScrollUpdate);
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
	kosFrameTextureTopLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft");
	kosFrameTextureTopLeft:SetWidth(256);
	kosFrameTextureTopLeft:SetHeight(256);
	kosFrameTextureTopLeft:SetPoint("TOPLEFT");

	local kosFrameTextureTopRight = kosFrame:CreateTexture("VanasKoSFrameTopRight", "ARTWORK");
	kosFrameTextureTopRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight");
	kosFrameTextureTopRight:SetWidth(128);
	kosFrameTextureTopRight:SetHeight(256);
	kosFrameTextureTopRight:SetPoint("TOPRIGHT");
	
	local kosFrameTextureBottomLeft = kosFrame:CreateTexture("VanasKoSFrameBottomLeft", "ARTWORK");
	kosFrameTextureBottomLeft:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-BotLeft");
	kosFrameTextureBottomLeft:SetWidth(256);
	kosFrameTextureBottomLeft:SetHeight(256);
	kosFrameTextureBottomLeft:SetPoint("BOTTOMLEFT");

	local kosFrameTextureBottomRight = kosFrame:CreateTexture("VanasKoSFrameBottomRight", "ARTWORK");
	kosFrameTextureBottomRight:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-BotRight");
	kosFrameTextureBottomRight:SetWidth(128);
	kosFrameTextureBottomRight:SetHeight(256);
	kosFrameTextureBottomRight:SetPoint("BOTTOMRIGHT");
	
	local kosFrameTitleText = kosFrame:CreateFontString("VanasKoSFrameTitleText", "OVERLAY");
	kosFrameTitleText:SetPoint("TOP", kosFrame, 0, -18);
	kosFrameTitleText:SetFontObject("GameFontNormal");
	kosFrameTitleText:SetText(VANASKOS.NAME .. " " .. VANASKOS.VERSION);
	
	self:CreateMainFrameButtons();
end
