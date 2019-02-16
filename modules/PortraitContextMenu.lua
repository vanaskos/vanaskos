--[[----------------------------------------------------------------------
	TargetPortraitContextMenu Module - Part of VanasKoS
modifies the TargetPortrait to add context menu options for adding targets to lists
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PortraitContextMenu", false)
VanasKoSPortraitContextMenu = VanasKoS:NewModule("PortraitContextMenu", "AceHook-3.0")

-- Declare some common global functions local
local ipairs = ipairs
local format = format
local strgsub = string.gsub
local assert = assert
local UnitName = UnitName
local GetRealmName = GetRealmName
local splitNameRealm = VanasKoS.splitNameRealm

-- Local Variables
local VanasKoSTargetPopupButtons = {}
local VanasKoSTargetPopupMenu = {}
local defaultLists = {"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}
local myRealm

function VanasKoSPortraitContextMenu:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("PortraitContextMenu", {
		profile = {
			Enabled = true,
		}
	})

	VanasKoSGUI:AddModuleToggle("PortraitContextMenu", L["Context Menu"])
	self:SetEnabledState(self.db.profile.Enabled)
	myRealm = GetRealmName()
end

function VanasKoSPortraitContextMenu:OnEnable()
	for i, v in ipairs(defaultLists) do
		local listname = VanasKoSGUI:GetListName(v)
		local shortname = "VANASKOS_ADD_" .. v
		VanasKoSTargetPopupButtons[shortname] = { text = format(L["Add to %s"], listname), dist = 0 }
		VanasKoSTargetPopupMenu[i] = shortname
	end
	self:SecureHook("UnitPopup_ShowMenu")
end

function VanasKoSPortraitContextMenu:OnDisable()
	self:Unhook("UnitPopup_ShowMenu")
end

function VanasKoSPortraitContextMenu:UnitPopup_ShowMenu(dropdownMenu, which, unit, fullName, userData)
	-- hack from fyrye to enable context menu for Pitbull4
	which = strgsub(which, "PB4_", "")

	if(which ~= "PLAYER" and which ~= "PARTY" and which ~= "RAID_PLAYER" and which ~= "RAID" and which ~= "FRIEND") then
		return
	end

	-- Only create menus for the top level
	if (UIDROPDOWNMENU_MENU_LEVEL > 1) then
		return
	end

	local info = UIDropDownMenu_CreateInfo()

	local name, realm = splitNameRealm(fullName)
	if(unit) then
		name, realm = UnitName(unit)
	end
	local guild = GetGuildInfo(unit)
	if(realm == nil or realm == "") then
		realm = myRealm
	end
	for _, value in ipairs(VanasKoSTargetPopupMenu) do
		info.text = VanasKoSTargetPopupButtons[value].text
		info.value = value
		info.owner = which
		info.func = VanasKoSPortraitContextMenu_UnitPopup_OnClick
		info.notCheckable = 1
		info.arg1 = {
			button = value,
			name = name,
			realm = realm,
			guild = guild
		}
		UIDropDownMenu_AddButton(info)
	end
end

function VanasKoSPortraitContextMenu_UnitPopup_OnClick(self, info)
	assert(info and info.button and info.name and info.realm)

	if(info.button == "VANASKOS_ADD_PLAYERKOS") then
		VanasKoS:AddEntryByName("PLAYERKOS", info.name, info.realm)
	elseif(info.button == "VANASKOS_ADD_GUILDKOS") then
		VanasKoS:AddEntryByName("GUILDKOS", info.guild, info.realm)
	elseif(info.button == "VANASKOS_ADD_HATELIST") then
		VanasKoS:AddEntryByName("HATELIST", info.name, info.realm)
	elseif(info.button == "VANASKOS_ADD_NICELIST") then
		VanasKoS:AddEntryByName("NICELIST", info.name, info.realm)
	end
end
