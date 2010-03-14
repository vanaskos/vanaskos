local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/FriendsFrameDocker", false);

local VanasKoSFriendsFrameDocker = VanasKoS:NewModule("FriendsFrameDocker", "AceHook-3.0");

local TabID = 5;

local frame = nil;

function VanasKoSFriendsFrameDocker:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("FriendsFrameDocker", {
		profile = {
			Enabled = true,
		}
	});

	VanasKoSGUI:AddModuleToggle("FriendsFrameDocker", L["Dock into Friends Frame"]);

	self:SetEnabledState(self.db.profile.Enabled);
end

function VanasKoSFriendsFrameDocker:OnEnable()
	-- fix ctraid button so that the KoS button fits - why in hell they made it that big?
	if(FriendsFrameTab5 ~= nil and FriendsFrameTab5:GetText() == "CTRaid") then
		FriendsFrameTab5:SetText("CTRA");
		PanelTemplates_TabResize(0, FriendsFrameTab5, 62);
	end

	while(getglobal("FriendsFrameTab" .. TabID) ~= nil) do
		TabID = TabID + 1;
	end

	if(getglobal("FriendsFrameTab" .. (TabID-1)) and getglobal("FriendsFrameTab" .. (TabID-1)):GetText() == "KoS") then
		print("moep");
		TabID = TabID - 1;
		frame = getglobal("FriendsFrameTab" .. TabID);
		--frame:SetParent(FriendsFrame);
	else
		frame = CreateFrame("Button", "FriendsFrameTab" .. TabID, FriendsFrame, "FriendsFrameTabTemplate");
		frame:SetPoint("LEFT", "FriendsFrameTab" .. (TabID - 1), "RIGHT", -14, 0);
		frame:SetText("KoS");
		frame:SetID(TabID);
	end
	
	-- add ourself to the subframe list....
	tinsert(FRIENDSFRAME_SUBFRAMES, "VanasKoSListFrame");

	-- we need 5 instead of 4 tabs
	PanelTemplates_SetNumTabs(FriendsFrame, TabID);
	PanelTemplates_UpdateTabs(FriendsFrame);

	self:SecureHook("FriendsFrame_Update", "FriendsFrame_Update");
end

function VanasKoSFriendsFrameDocker:OnDisable()
	for k,v in pairs(FRIENDSFRAME_SUBFRAMES) do
		if(v == "VanasKoSListFrame") then
			tremove(FRIENDSFRAME_SUBFRAMES, k);
		end
	end 
	if(frame ~= nil) then
		getglobal("FriendsFrameTab" .. TabID):Hide();

		PanelTemplates_SetNumTabs(FriendsFrame, TabID - 1);
		PanelTemplates_UpdateTabs(FriendsFrame);

		VanasKoSListFrame:SetParent("UIParent");
		VanasKoSListFrame:Hide();
		
		FriendsFrame.selectedTab = 1;
		if(FriendsFrame:IsVisible()) then
			FriendsFrame_ShowSubFrame("FriendsListFrame");
		end
	end
	self:UnhookAll();
end

function VanasKoSFriendsFrameDocker:FriendsFrame_Update()
	if(FriendsFrame.selectedTab == TabID) then
		FriendsFrameTitleText:SetText(VANASKOS.NAME .. " - " .. VANASKOS.VERSION);
		if(VanasKoSFrame:IsVisible()) then
			return;
		end
		FriendsFrameTopLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopLeft");
		FriendsFrameTopRight:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopRight");
		--FriendsFrameBottomLeft:SetTexture("Interface\\FriendsFrame\\WhoFrame-BotLeft");
		FriendsFrameBottomLeft:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\KoSListFrame-BotLeft");
		FriendsFrameBottomRight:SetTexture("Interface\\FriendsFrame\\WhoFrame-BotRight");

		VanasKoSGUI:ScrollFrameUpdate();
		VanasKoSListFrame:SetParent("FriendsFrame");
		VanasKoSListFrame:SetAllPoints();

		FriendsFrame_ShowSubFrame("NonExistingFrame"); -- so all friendframe tabs get hidden
		VanasKoSListFrame:Show();
	else
		if(not VanasKoSFrame:IsVisible()) then
			VanasKoSListFrame:Hide();
		end
	end
end

