--[[----------------------------------------------------------------------
	TargetPortraitContextMenu Module - Part of VanasKoS
modifies the TargetPortrait to add context menu options for adding targets to lists
------------------------------------------------------------------------]]

local function RegisterTranslations(locale, translationfunction)
	local defaultLocale = false;
	if(locale == "enUS") then
		defaultLocale = true;
	end
	
	local liblocale = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_PortraitContextMenu", locale, defaultLocale);
	if liblocale then
		for k, v in pairs(translationfunction()) do
			liblocale[k] = v;
		end
	end
end

RegisterTranslations("enUS", function() return {
	["Add to %s"] = true,
	["Add Context Menu to Player Portrait"] = true,
	["Enabled"] = true,
	["Warning! Enabling this will cause errors setting the focus from target menue. Continue?"] = true,
	["Accept"] = true,
	["Cancel"] = true,
} end);

RegisterTranslations("deDE", function() return {
	["Add to %s"] = "Zu %s hinzufügen",
	["Add Context Menu to Player Portrait"] = "Kontext Menu zum Spieler Portrait hinzufügen",
	["Enabled"] = "Aktiviert",
	["Accept"] = "Ok",
	["Cancel"] = "Abbrechen",
} end);

RegisterTranslations("frFR", function() return {
	["Add to %s"] = "Ajouter - %s",
	["Add Context Menu to Player Portrait"] = "Ajouter un menu de contexte au portrait du joueur",
	["Enabled"] = "Actif",
--	["Accept"] = true,
--	["Cancel"] = true,
} end);

RegisterTranslations("koKR", function() return {
	["Add to %s"] = "%s에 추가",
	["Add Context Menu to Player Portrait"] = "플레이어 초상화에 메뉴 추가",
	["Enabled"] = "사용",
--	["Accept"] = true,
--	["Cancel"] = true,
} end);

RegisterTranslations("esES", function() return {
	["Add to %s"] = "Añadir a %s",
	["Add Context Menu to Player Portrait"] = "Añadir menú contextual a retrato del jugador",
	["Enabled"] = "Activado",
--	["Accept"] = true,
--	["Cancel"] = true,
} end);

RegisterTranslations("ruRU", function() return {
	["Add to %s"] = "Добавить в %s",
	["Add Context Menu to Player Portrait"] = "Контекстное меню на портрете игрока",
	["Enabled"] = "Добавлять",
--	["Accept"] = true,
--	["Cancel"] = true,
} end);

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_PortraitContextMenu", false);

VanasKoSPortraitContextMenu = VanasKoS:NewModule("PortraitContextMenu");
local VanasKoSPortraitContextMenu = VanasKoSPortraitContextMenu;
local VanasKoS = VanasKoS;
local VanasKoSTaintOK = false;

function VanasKoSPortraitContextMenu:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("PortraitContextMenu", {
		profile = {
			Enabled = true,
			EnabledWithTaint = false,
		}
	});

	-- FIXME(xilcoy): Modifying the UnitPopupButtons taints the player
	-- context menu, this is a "known issue" according to the blizzard
	-- forums. Which may mean this will work without causing taint again
	-- someday...
	VanasKoSGUI:AddConfigOption("PortraitContextMenu",
		{
			type = 'group',
			name = L["Add Context Menu to Player Portrait"],
			desc = L["Add Context Menu to Player Portrait"],
			args = {
				enabled = {
					type = 'toggle',
					name = L["Enabled"],
					desc = L["Enabled"],
--					set = function(frame, v) VanasKoSPortraitContextMenu.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("PortraitContextMenu", v); end,
--					get = function() return VanasKoSPortraitContextMenu.db.profile.Enabled; end,
					set = function(frame, v)
						if (VanasKoSTaintOK == false and v == true) then
							local dialog = StaticPopup_Show("VANASKOS_TAINT_WARNING");
							if(dialog) then
								dialog.sender = sender;
								getglobal(dialog:GetName() .. "Text"):SetText(format(L["Warning! Enabling this will cause errors setting the focus from target menue. Continue?"], count, VanasKoSGUI:GetListName(nameOfList), sender));
							end
						else
							VanasKoSPortraitContextMenu.db.profile.EnabledWithTaint = v; VanasKoS:ToggleModuleActive("PortraitContextMenu");
						end
					end,
					get = function() return VanasKoSPortraitContextMenu.db.profile.EnabledWithTaint; end,
				}
			}
		});
end

local listsToAdd = { "PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST" };

function VanasKoSPortraitContextMenu:OnEnable()
	if(not self.db.profile.EnabledWithTaint) then
		return;
	end
--[[	if(not self.db.profile.Enabled) then
		self:SetEnabledState(false);
		return;
	end ]]
	for k,v in pairs(listsToAdd) do
		local listname = VanasKoSGUI:GetListName(v);
		local shortname = "VANASKOS_ADD_" .. v;
		UnitPopupButtons[shortname] = { text = format(L["Add to %s"], listname), dist = 0 };
		tinsert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["PLAYER"]-1, shortname);
	end
	self:SecureHook("UnitPopup_OnClick");
end

function VanasKoSPortraitContextMenu:RemoveFromList(list, entryname)
	local moveEntries = nil;
	local list2 = UnitPopupMenus["PLAYER"];
	for k,v in pairs(list2) do
		if(v == entryname) then
			tremove(list2, k);
		end
	end
	if(list[entryname]) then
		list[entryname] = nil;
	end
end

function VanasKoSPortraitContextMenu:OnDisable()
	self:Unhook("UnitPopup_OnClick");
	for k,v in pairs(listsToAdd) do
		local shortname = "VANASKOS_ADD_" .. v;
		self:RemoveFromList(UnitPopupButtons, shortname);
	end
end

function VanasKoSPortraitContextMenu:UnitPopup_OnClick()
	local frame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local button = this.value;

	local target = UnitName("target");
	if(target == nil) then
		return;
	end

	if(button == "VANASKOS_ADD_PLAYERKOS") then
		VanasKoS:AddEntryFromTarget("PLAYERKOS");
	elseif(button == "VANASKOS_ADD_GUILDKOS") then
		VanasKoS:AddEntryFromTarget("GUILDKOS");
	elseif(button == "VANASKOS_ADD_HATELIST") then
		VanasKoS:AddEntryFromTarget("HATELIST");
	elseif(button == "VANASKOS_ADD_NICELIST") then
		VanasKoS:AddEntryFromTarget("NICELIST");
	end
end


StaticPopupDialogs["VANASKOS_TAINT_WARNING"] = {
	text = "TEMPLATE",
	button1 = L["Accept"],
	button2 = L["Cancel"],
	OnAccept = function()
		local dialog = this:GetParent();
		VanasKoSPortraitContextMenu.db.profile.EnabledWithTaint = true;
		VanasKoSTaintOK = true;
		VanasKoS:ToggleModuleActive("PortraitContextMenu", true);
	end,
	OnHide = function()
		if(ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
	end,
	timeout = 10,
	exclusive = 0,
	whileDead = 1,
	hideOnEscape = 1
}
