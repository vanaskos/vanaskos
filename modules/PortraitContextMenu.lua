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
	["Context Menu"] = true,
	["Add Context Menu to Player Portrait"] = true,
	["Enabled"] = true,
} end);

RegisterTranslations("deDE", function() return {
	["Add to %s"] = "Zu %s hinzufügen",
	["Context Menu"] = "Kontext Menu",
	["Add Context Menu to Player Portrait"] = "Kontext Menu zum Spieler Portrait hinzufügen",
	["Enabled"] = "Aktiviert",
} end);

RegisterTranslations("frFR", function() return {
	["Add to %s"] = "Ajouter - %s",
--	["Context Menu"] = "menu de contexte",
	["Add Context Menu to Player Portrait"] = "Ajouter un menu de contexte au portrait du joueur",
	["Enabled"] = "Actif",
} end);

RegisterTranslations("koKR", function() return {
	["Add to %s"] = "%s에 추가",
--	["Context Menu"] = true,
	["Add Context Menu to Player Portrait"] = "플레이어 초상화에 메뉴 추가",
	["Enabled"] = "사용",
} end);

RegisterTranslations("esES", function() return {
	["Add to %s"] = "Añadir a %s",
--	["Context Menu"] = "mennú contextual",
	["Add Context Menu to Player Portrait"] = "Añadir menú contextual a retrato del jugador",
	["Enabled"] = "Activado",
} end);

RegisterTranslations("ruRU", function() return {
	["Add to %s"] = "Добавить в %s",
--	["Context Menu"] = "Контекстное меню",
	["Add Context Menu to Player Portrait"] = "Контекстное меню на портрете игрока",
	["Enabled"] = "Добавлять",
} end);

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_PortraitContextMenu", false);

VanasKoSPortraitContextMenu = VanasKoS:NewModule("PortraitContextMenu", "AceHook-3.0");
local VanasKoSPortraitContextMenu = VanasKoSPortraitContextMenu;
local VanasKoS = VanasKoS;
local VanasKoSTargetPopupButtons = { };
local VanasKoSTargetPopupMenu = { };

function VanasKoSPortraitContextMenu:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("PortraitContextMenu", {
		profile = {
			Enabled = true,
		}
	});

	VanasKoSGUI:AddConfigOption("VanasKoS-PortraitContextMenu",
		{
			type = 'group',
			name = L["Context Menu"],
			desc = L["Add Context Menu to Player Portrait"],
			args = {
				enabled = {
					type = 'toggle',
					name = L["Enabled"],
					desc = L["Enabled"],
					set = function(frame, v) VanasKoSPortraitContextMenu.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("PortraitContextMenu", v); end,
					get = function() return VanasKoSPortraitContextMenu.db.profile.Enabled; end,
				}
			}
		});
	self:SetEnabledState(self.db.profile.Enabled);
end

local listsToAdd = { "PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST" };

function VanasKoSPortraitContextMenu:OnEnable()
	for i,v in ipairs(listsToAdd) do
		local listname = VanasKoSGUI:GetListName(v);
		local shortname = "VANASKOS_ADD_" .. v;
		VanasKoSTargetPopupButtons[shortname] = { text = format(L["Add to %s"], listname), dist = 0 };
		VanasKoSTargetPopupMenu[i] = shortname;
	end
	self:SecureHook("UnitPopup_ShowMenu");
end

function VanasKoSPortraitContextMenu:OnDisable()
	self:Unhook("UnitPopup_ShowMenu");
end

function VanasKoSPortraitContextMenu:UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
	if(which ~= "PLAYER" and which ~= "PARTY" and which ~= "RAID_PLAYER" and which ~= "RAID" and which ~= "FRIEND") then
		return;
	end

	-- Only create menus for the top level
	if (UIDROPDOWNMENU_MENU_LEVEL > 1) then
		return;
	end

	local info = UIDropDownMenu_CreateInfo();
	for index, value in ipairs(VanasKoSTargetPopupMenu) do
		info.text = VanasKoSTargetPopupButtons[value].text;
		info.value = value;
		info.owner = which;
		info.func = VanasKoSPortraitContextMenu_UnitPopup_OnClick;
		info.notCheckable = 1;
		info.arg1 = {["button"] = value, ["unit"] = unit, ["name"] = name};
		UIDropDownMenu_AddButton(info);
	end
end

function VanasKoSPortraitContextMenu_UnitPopup_OnClick(self, info)
	assert(info);
	assert(info.button);
	name = info.name or UnitName(info.unit);
	assert(name);

	if(info.button == "VANASKOS_ADD_PLAYERKOS") then
		VanasKoS:AddEntryByName("PLAYERKOS", name);
	elseif(info.button == "VANASKOS_ADD_GUILDKOS") then
		VanasKoS:AddEntryByName("GUILDKOS", name);
	elseif(info.button == "VANASKOS_ADD_HATELIST") then
		VanasKoS:AddEntryByName("HATELIST", name);
	elseif(info.button == "VANASKOS_ADD_NICELIST") then
		VanasKoS:AddEntryByName("NICELIST", name);
	end
end
