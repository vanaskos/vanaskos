local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/FriendsFrameDocker", "enUS", true, VANASKOS.DEBUG)
if L then
-- auto generated from wowace translation app
--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, namespace="VanasKoS/FriendsFrameDocker")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/FriendsFrameDocker", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS/FriendsFrameDocker")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/FriendsFrameDocker", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS/FriendsFrameDocker")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/FriendsFrameDocker", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS/FriendsFrameDocker")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/FriendsFrameDocker", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS/FriendsFrameDocker")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/FriendsFrameDocker", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS/FriendsFrameDocker")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/FriendsFrameDocker", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS/FriendsFrameDocker")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/FriendsFrameDocker", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS/FriendsFrameDocker")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/FriendsFrameDocker", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS/FriendsFrameDocker")@
end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/FriendsFrameDocker", false);

local VanasKoSFriendsFrameDocker = VanasKoS:NewModule("FriendsFrameDocker", "AceHook-3.0");

local TabID = 5;

local frame = nil;

function VanasKoSFriendsFrameDocker:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("FriendsFrameDocker", {
		profile = {
			Enabled = true,
		}
	});

	VanasKoSGUI:AddConfigOption("VanasKoS-FriendsFrameDocker",
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
					get = function() return VanasKoSFriendsFrameDocker.db.profile.Enabled; end,
				}
			}
		});

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

