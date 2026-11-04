--[[----------------------------------------------------------------------
	TargetPortraitContextMenu Module - Part of VanasKoS
modifies the TargetPortrait to add context menu options for adding targets to lists
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PortraitContextMenu", false)
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")
local VanasKoSGUI = VanasKoS:GetModule("GUI")
local VanasKoSPortraitContextMenu = VanasKoS:NewModule("PortraitContextMenu", "AceHook-3.0")
local Compat = VANASKOS.Compat

-- Declare some common global functions local
local ipairs = ipairs
local format = format
local strgsub = string.gsub
local assert = assert
local UnitIsPlayer = UnitIsPlayer
local GetGuildInfo = GetGuildInfo
local GetRealmName = GetRealmName
local splitNameRealm = VanasKoS.splitNameRealm
local hashName = VanasKoS.hashName
local hashGuild = VanasKoS.hashGuild

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

-- unit popup menus we extend (Menu tags are "MENU_UNIT_" .. which)
local menuTypes = {"PLAYER", "ENEMY_PLAYER", "PARTY", "RAID_PLAYER", "RAID", "FRIEND", "TARGET", "FOCUS"}
local menusRegistered = false

local function OnMenuAction(button, name, realm, guild)
	if(button == "VANASKOS_ADD_PLAYERKOS") then
		VanasKoS:AddEntryByName("PLAYERKOS", name, realm)
	elseif(button == "VANASKOS_ADD_GUILDKOS") then
		VanasKoS:AddEntryByName("GUILDKOS", guild, realm)
	elseif(button == "VANASKOS_ADD_HATELIST") then
		VanasKoS:AddEntryByName("HATELIST", name, realm)
	elseif(button == "VANASKOS_ADD_NICELIST") then
		VanasKoS:AddEntryByName("NICELIST", name, realm)
	elseif(button == "VANASKOS_LOOKUP") then
		local data, list = VanasKoS:IsOnList(nil, hashName(name, realm))
		if not data and guild then
			data, list = VanasKoS:IsOnList(nil, hashGuild(guild, realm))
		end
		if list then
			VanasKoS:Print(format(L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"],
				name, VanasKoS:GetListNameByShortName(list), (data.reason or "")))
		else
			VanasKoS:Print(format(L["No entry for |cff00ff00%s|r"], name))
		end
	end
end

local function ModifyUnitMenu(owner, rootDescription, contextData)
	if not VanasKoSPortraitContextMenu:IsEnabled() or not contextData then
		return
	end

	local unit = Compat.Clean(contextData.unit)
	-- only players; NPC targets also use the TARGET/FOCUS menus
	if unit and not Compat.Clean(UnitIsPlayer(unit)) then
		return
	end

	local name, realm, guild
	if unit then
		name, realm = Compat.UnitName(unit)
		guild = Compat.Clean(GetGuildInfo(unit))
	else
		name = Compat.Clean(contextData.name)
		realm = Compat.Clean(contextData.server)
		if name and not realm then
			name, realm = splitNameRealm(name)
		end
	end
	if not name or name == "" then
		return
	end
	if(realm == nil or realm == "") then
		realm = myRealm
	end

	rootDescription:CreateDivider()
	rootDescription:CreateTitle(L["Vanas|cffff0000KoS|r"])
	for _, value in ipairs(VanasKoSTargetPopupMenu) do
		if value ~= "VANASKOS_ADD_GUILDKOS" or guild then
			rootDescription:CreateButton(VanasKoSTargetPopupButtons[value].text, function()
				OnMenuAction(value, name, realm, guild)
			end)
		end
	end
end

function VanasKoSPortraitContextMenu:OnEnable()
	for i, v in ipairs(defaultLists) do
		local listname = VanasKoSGUI:GetListName(v)
		local shortname = "VANASKOS_ADD_" .. v
		VanasKoSTargetPopupButtons[shortname] = {
			text = format(L["Add to %s"], listname)
		}
		VanasKoSTargetPopupMenu[i] = shortname
	end
	VanasKoSTargetPopupButtons["VANASKOS_LOOKUP"] = {
		text = L["Lookup in VanasKoS"]
	}
	VanasKoSTargetPopupMenu[#defaultLists + 1] = "VANASKOS_LOOKUP"

	-- Menu.ModifyMenu callbacks cannot be removed again, so register once and
	-- check IsEnabled() inside the callback instead.
	if not menusRegistered and Menu and Menu.ModifyMenu then
		for _, which in ipairs(menuTypes) do
			Menu.ModifyMenu("MENU_UNIT_" .. which, ModifyUnitMenu)
		end
		menusRegistered = true
	end
end

function VanasKoSPortraitContextMenu:OnDisable()
end
