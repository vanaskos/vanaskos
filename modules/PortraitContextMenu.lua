--[[----------------------------------------------------------------------
	TargetPortraitContextMenu Module - Part of VanasKoS
modifies the TargetPortrait to add context menu options for adding targets to lists
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PortraitContextMenu", false);

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

	VanasKoSGUI:AddModuleToggle("PortraitContextMenu", L["Context Menu"]);
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
	-- hack from fyrye to enable context menu for Pitbull4
	which = string.gsub(which, "PB4_", "")

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
