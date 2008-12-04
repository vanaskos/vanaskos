local function RegisterTranslations(locale, translationfunction)
	local defaultLocale = false;
	if(locale == "enUS") then
		defaultLocale = true;
	end
	
	local liblocale = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_FriendsFrameDocker", locale, defaultLocale);
	if liblocale then
		for k, v in pairs(translationfunction()) do
			liblocale[k] = v;
		end
	end
end

local VanasKoSFriendsFrameDocker = VanasKoS:NewModule("FriendsFrameDocker", "AceHook-3.0");

RegisterTranslations("enUS", function() return {
	["Dock into Friends Frame"] = true,
	["Enabled"] = true,
} end);

RegisterTranslations("deDE", function() return {
	["Dock into Friends Frame"] = "In das Freunde Fenster einbinden",
	["Enabled"] = "Aktiviert",
} end);

RegisterTranslations("frFR", function() return {
	["Dock into Friends Frame"] = "Onglet dans la liste d'amis",
	["Enabled"] = "Actif",
} end);

RegisterTranslations("koKR", function() return {
	["Dock into Friends Frame"] = "친구목록에 적용",
	["Enabled"] = "사용",
} end);

RegisterTranslations("esES", function() return {
	["Dock into Friends Frame"] = "Acoplar a la ventana de Amigos",
	["Enabled"] = "Activado",
} end);

RegisterTranslations("ruRU", function() return {
	["Dock into Friends Frame"] = "Прикрепить к окну Друзей",
	["Enabled"] = "Включено",
} end);

local TabID = 5;

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_FriendsFrameDocker", false);

function VanasKoSFriendsFrameDocker:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("FriendsFrameDocker", {
		profile = {
			Enabled = true,
		}
	});

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
					set = function(frame, v) VanasKoSFriendsFrameDocker.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("FriendsFrameDocker"); end,
					get = function() return VanasKoSFriendsFrameDocker.db.profile.Enabled end,
				}
			}
		});

end

function VanasKoSFriendsFrameDocker:OnEnable()
	if(not self.db.profile.Enabled) then
		self:SetEnabledState(false);
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

