--[[----------------------------------------------------------------------
	TargetPortraitContextMenu Module - Part of VanasKoS
modifies the TargetPortrait to add context menu options for adding targets to lists
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PortraitContextMenu", false)
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")
local VanasKoSGUI = VanasKoS:GetModule("GUI")
local VanasKoSPortraitContextMenu = VanasKoS:NewModule("PortraitContextMenu", "AceHook-3.0")

-- Declare some common global functions local
local ipairs = ipairs
local format = format
local strgsub = string.gsub
local assert = assert
local UnitName = UnitName

-- Local Variables
local VanasKoSTargetPopupButtons = {}
local VanasKoSTargetPopupMenu = {}
local defaultLists = {"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}

function VanasKoSPortraitContextMenu:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("PortraitContextMenu", {
		profile = {
			Enabled = true,
		}
	})

	VanasKoSGUI:AddModuleToggle("PortraitContextMenu", L["Context Menu"])
	self:SetEnabledState(self.db.profile.Enabled)
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
	self:SecureHook("UnitPopup_ShowMenu")
end

function VanasKoSPortraitContextMenu:OnDisable()
	self:Unhook("UnitPopup_ShowMenu")
end

function VanasKoSPortraitContextMenu:UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
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

	local guild
	if(unit) then
		name = UnitName(unit)
		guild = GetGuildInfo(unit)
	end
	name = strgsub(name, "-%w*", "")
	UIDropDownMenu_AddSeparator(1)
	info.text = L["Vanas|cffff0000KoS|r"]
	info.owner = which
	info.isTitle = true
	info.notCheckable = true
	UIDropDownMenu_AddButton(info)

	info.isTitle = nil
	info.disabled = nil
	for _, value in ipairs(VanasKoSTargetPopupMenu) do
		info.text = VanasKoSTargetPopupButtons[value].text
		info.value = value
		info.owner = which
		info.func = function(self, info)
			assert(info)
			assert(info.button)
			assert(info.name)

			if(info.button == "VANASKOS_ADD_PLAYERKOS") then
				VanasKoS:AddEntryByName("PLAYERKOS", info.name)
			elseif(info.button == "VANASKOS_ADD_GUILDKOS") then
				VanasKoS:AddEntryByName("GUILDKOS", info.guild)
			elseif(info.button == "VANASKOS_ADD_HATELIST") then
				VanasKoS:AddEntryByName("HATELIST", info.name)
			elseif(info.button == "VANASKOS_ADD_NICELIST") then
				VanasKoS:AddEntryByName("NICELIST", info.name)
			elseif(info.button == "VANASKOS_LOOKUP") then
				local data, list = VanasKoS:IsOnList(nil, info.name)
				if not data and info.guild then
					data, list = VanasKoS:IsOnList(nil, info.guild)
				end
				if list then
					VanasKoS:Print(format(L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"],
						info.name, VanasKoS:GetListNameByShortName(list), (data.reason or "")))
				else
					VanasKoS:Print(format(L["No entry for |cff00ff00%s|r"], info.name))
				end
			end
		end

		info.notCheckable = 1
		info.arg1 = {
			button = value,
			name = name,
			guild = guild
		}
		UIDropDownMenu_AddButton(info)
	end
end
