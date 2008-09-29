--[[----------------------------------------------------------------------
	TargetPortraitContextMenu Module - Part of VanasKoS
modifies the TargetPortrait to add context menu options for adding targets to lists
------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.2"):new("VanasKoSPortraitContextMenu");

L:RegisterTranslations("enUS", function() return {
	["Add to %s"] = true,
	["Add Context Menu to Player Portrait"] = true,
	["Enabled"] = true,
} end);

L:RegisterTranslations("deDE", function() return {
	["Add to %s"] = "Zu %s hinzufügen",
	["Add Context Menu to Player Portrait"] = "Kontext Menu zum Spieler Portrait hinzufügen",
	["Enabled"] = "Aktiviert",
} end);

L:RegisterTranslations("frFR", function() return {
	["Add to %s"] = "Ajouter - %s",
	["Add Context Menu to Player Portrait"] = "Ajouter un menu de contexte au portrait du joueur",
	["Enabled"] = "Actif",
} end);

L:RegisterTranslations("koKR", function() return {
	["Add to %s"] = "%s에 추가",
	["Add Context Menu to Player Portrait"] = "플레이어 초상화에 메뉴 추가",
	["Enabled"] = "사용",
} end);

L:RegisterTranslations("esES", function() return {
	["Add to %s"] = "Añadir a %s",
	["Add Context Menu to Player Portrait"] = "Añadir menú contextual a retrato del jugador",
	["Enabled"] = "Activado",
} end);

L:RegisterTranslations("ruRU", function() return {
	["Add to %s"] = "Добавить в %s",
	["Add Context Menu to Player Portrait"] = "Контекстное меню на портрете игрока",
	["Enabled"] = "Добавлять",
} end);

VanasKoSPortraitContextMenu = VanasKoS:NewModule("PortraitContextMenu");
local VanasKoSPortraitContextMenu = VanasKoSPortraitContextMenu;
local VanasKoS = VanasKoS;

function VanasKoSPortraitContextMenu:OnInitialize()
	VanasKoS:RegisterDefaults("PortraitContextMenu", "profile", {
		Enabled = true,
	});
	self.db = VanasKoS:AcquireDBNamespace("PortraitContextMenu");

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
					set = function(v) VanasKoSPortraitContextMenu.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("PortraitContextMenu", v); end,
					get = function() return VanasKoSPortraitContextMenu.db.profile.Enabled; end,
				}
			}
		});
end

local listsToAdd = { "PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST" };

function VanasKoSPortraitContextMenu:OnEnable()
	if(not self.db.profile.Enabled) then
		return;
	end
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
