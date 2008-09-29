local L = AceLibrary("AceLocale-2.2"):new("VanasKoSFriendsFrameDocker");

local VanasKoSFriendsFrameDocker = VanasKoS:NewModule("FriendsFrameDocker");

L:RegisterTranslations("enUS", function() return {
	["Dock into Friends Frame"] = true,
	["Enabled"] = true,
} end);

L:RegisterTranslations("deDE", function() return {
	["Dock into Friends Frame"] = "In das Freunde Fenster einbinden",
	["Enabled"] = "Aktiviert",
} end);

L:RegisterTranslations("frFR", function() return {
	["Dock into Friends Frame"] = "Onglet dans la liste d'amis",
	["Enabled"] = "Actif",
} end);

L:RegisterTranslations("koKR", function() return {
	["Dock into Friends Frame"] = "친구목록에 적용",
	["Enabled"] = "사용",
} end);

L:RegisterTranslations("esES", function() return {
	["Dock into Friends Frame"] = "Acoplar a la ventana de Amigos",
	["Enabled"] = "Activado",
} end);

L:RegisterTranslations("ruRU", function() return {
	["Dock into Friends Frame"] = "Прикрепить к окну Друзей",
	["Enabled"] = "Включено",
} end);

local TabID = 5;

function VanasKoSFriendsFrameDocker:OnInitialize()
	VanasKoS:RegisterDefaults("FriendsFrameDocker", "profile", {
		Enabled = true,
	});

	self.db = VanasKoS:AcquireDBNamespace("FriendsFrameDocker");

	VanasKoSGUI:AddConfigOption("FriendsFrameDocker",
		{
			type = 'group',
			name = L["Dock into Friends Frame"],
			desc = L["Dock into Friends Frame"],
			args = {
				enabled = {
					type = 'toggle',
					name = L["Enabled"],
					desc = L["Enabled"],
					set = function() VanasKoSFriendsFrameDocker.db.profile.Enabled = not VanasKoSFriendsFrameDocker.db.profile.Enabled; VanasKoS:ToggleModuleActive("FriendsFrameDocker", VanasKoSFriendsFrameDocker.db.profile.Enabled); end,
					get = function() return VanasKoSFriendsFrameDocker.db.profile.Enabled end,
				}
			}
		});

end

function VanasKoSFriendsFrameDocker:OnEnable()
	if(not self.db.profile.Enabled) then
		return;
	end

	-- fix ctraid button so that the KoS button fits - why in hell they made it that big?
	if(FriendsFrameTab5 ~= nil and FriendsFrameTab5:GetText() == "CTRaid") then
		FriendsFrameTab5:SetText("CTRA");
		PanelTemplates_TabResize(0, FriendsFrameTab5, 62);
	end

	while(getglobal("FriendsFrameTab" .. TabID) ~= nil) do
		TabID = TabID + 1;
	end

	local frame = CreateFrame("Button", "FriendsFrameTab" .. TabID, FriendsFrame, "FriendsFrameTabTemplate");
	frame:SetPoint("LEFT", "FriendsFrameTab" .. (TabID - 1), "RIGHT", -14, 0);
	frame:SetText("KoS");
	frame:SetID(TabID);

	-- add ourself to the subframe list....
	tinsert(FRIENDSFRAME_SUBFRAMES, "VanasKoSListFrame");

	-- we need 5 instead of 4 tabs
	PanelTemplates_SetNumTabs(FriendsFrame, TabID);
	PanelTemplates_UpdateTabs(FriendsFrame);

	self:SecureHook("FriendsFrame_Update", "FriendsFrame_Update");

end

function VanasKoSFriendsFrameDocker:OnDisable()
--[[	for k,v in pairs(FRIENDSFRAME_SUBFRAMES) do
		if(v == "VanasKoSListFrame") then
			k = nil;
		end
	end ]]--

	self:UnhookAll();
	getglobal("FriendsFrameTab" .. TabID):SetParent("UIParent");
	getglobal("FriendsFrameTab" .. TabID):Hide();
	PanelTemplates_SetNumTabs(FriendsFrame, TabID - 1);
	PanelTemplates_UpdateTabs(FriendsFrame);

	FriendsFrame.selectedTab = 1;
	if(FriendsFrame:IsVisible()) then
		FriendsFrame_ShowSubFrame("FriendsListFrame");
	end
end

function VanasKoSFriendsFrameDocker:FriendsFrame_Update()
	if(FriendsFrame.selectedTab == TabID) then
		FriendsFrameTitleText:SetText(VANASKOS.NAME .. " - " .. VANASKOS.VERSION);
		if(VanasKoSFrame:IsVisible()) then
			return;
		end
		FriendsFrameTopLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft");
		FriendsFrameTopRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight");
		FriendsFrameBottomLeft:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-BotLeft");
		FriendsFrameBottomRight:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-BotRight");

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

