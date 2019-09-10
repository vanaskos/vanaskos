--[[----------------------------------------------------------------------
      MinimapButton Module - Part of VanasKoS
Creates a MinimapButton with a menu for VanasKoS
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/MinimapButton", false)
local icon = LibStub("LibDBIcon-1.0")
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")
local VanasKoSGUI = VanasKoS:GetModule("GUI")
local VanasKoSMinimapButton = VanasKoS:NewModule("MinimapButton", "AceEvent-3.0", "AceTimer-3.0")

-- Initialized later
local PvPDataGatherer = nil
local warnFrame = nil

-- Declare some common global functions local
local pairs = pairs
local format = format
local time = time
local date = date
local wipe = wipe
local SecondsToTime = SecondsToTime
local IsShiftKeyDown = IsShiftKeyDown
local GetCursorPosition = GetCursorPosition

-- Local Variables
local attackerMenu = {}
local nearbyKoS = {}
local nearbyEnemies = {}
local nearbyFriendly = {}
local nearbyKoSCount = 0
local nearbyEnemyCount = 0
local nearbyFriendlyCount = 0
local timer = nil
local showWarnFrameInfoText = false

-- Create our Lib Data Broker Object
local Broker = ldb:NewDataObject("VanasKoS", {
	type = "launcher",
	icon = "Interface\\Icons\\Ability_Parry",
	OnClick = function(self, button)
		VanasKoSMinimapButton:OnClick(button)
	end,
	OnTooltipShow = function(tt)
		VanasKoSMinimapButton:OnTooltipShow(tt)
	end
})

local minimapOptions = {
	{
		text = VANASKOS.NAME .. " " .. VANASKOS.VERSION,
		isTitle = true,
		isNotRadio = true,
		notCheckable = true,
	},
	{
		text = L["Main Window"],
		func = function()
			VanasKoS:ToggleMenu()
		end,
		checked = function()
			return VanasKoSGUI.frame:IsVisible()
		end,
		isNotRadio = true,
	},
	{
		text = L["Warning Window"],
		func = function()
			if warnFrame then
				VanasKoS:ToggleModuleActive("WarnFrame")
				warnFrame:Update()
			end
		end,
		checked = function()
			return warnFrame.enabledState
		end,
		isNotRadio = true,
	},
	{
		text = L["Configuration"],
		func = function()
			VanasKoSGUI:OpenConfigWindow()
		end,
		isNotRadio = true,
		notCheckable = true,
	},
	{
		text = L["Add Player to KoS"],
		func = function()
			VanasKoS:AddEntryFromTarget("PLAYERKOS")
		end,
		isNotRadio = true,
		notCheckable = true,
	},
	{
		text = L["Add Guild to KoS"],
		func = function()
			VanasKoS:AddEntryFromTarget("GUILDKOS")
		end,
		isNotRadio = true,
		notCheckable = true,
	},
	{
		text = L["Add Player to Hatelist"],
		func = function()
			VanasKoS:AddEntryFromTarget("HATELIST")
		end,
		isNotRadio = true,
		notCheckable = true,
	},
	{
		text = L["Add Player to Nicelist"],
		func = function()
			VanasKoS:AddEntryFromTarget("NICELIST")
		end,
		isNotRadio = true,
		notCheckable = true,
	},
	{
		text = L["Add Attacker to KoS"],
		hasArrow = true,
		menuList = attackerMenu,
		isNotRadio = true,
		notCheckable = true,
	},
}


function VanasKoSMinimapButton:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("MinimapButton", {
		profile = {
			Enabled = true,
			Moved = false,
			ShowWarnFrameInfoText = true,
			button = {},
			ReverseButtons = false,
		}
	})

	self.name = "VanasKoSMinimapButton"

	self.configOptions = {
		type = 'group',
		name = L["Minimap Button"],
		desc = L["Minimap Button"],
		args = {
			showInfo = {
				type = 'toggle',
				name = L["Show information"],
				desc = L["Show Warning Frame Infos as Text and Tooltip"],
				order = 1,
				set = function(frame, v)
					VanasKoSMinimapButton.db.profile.ShowWarnFrameInfoText = v
					if (v) then
						VanasKoSMinimapButton:EnableWarnFrameText()
					else
						VanasKoSMinimapButton:EnableWarnFrameText()
					end
				end,
				get = function()
					return VanasKoSMinimapButton.db.profile.ShowWarnFrameInfoText
				end,
			},
			reverseButtons = {
				type = 'toggle',
				name = L["Reverse Buttons"],
				desc = L["Reverse action of left/right mouse buttons"],
				order = 2,
				set = function(frame, v)
					VanasKoSMinimapButton.db.profile.ReverseButtons = v
				end,
				get = function()
					return VanasKoSMinimapButton.db.profile.ReverseButtons
				end,
			},
		},
	}

	PvPDataGatherer = VanasKoS:GetModule("PvPDataGatherer", false)
	warnFrame = VanasKoS:GetModule("WarnFrame", false)
	VanasKoSGUI:AddModuleToggle("MinimapButton", L["Minimap Button"])
	VanasKoSGUI:AddConfigOption("MinimapButton", self.configOptions)
	minimapOptions[1].text = VANASKOS.NAME .. " " .. VANASKOS.VERSION
	self:SetEnabledState(self.db.profile.Enabled)
end

function VanasKoSMinimapButton:Toggle()
	if(icon:IsVisible()) then
		icon:Hide(self.name)
	else
		icon:Show(self.name)
	end
end

function VanasKoSMinimapButton:UpdateOptions()
	if PvPDataGatherer then
		local list = PvPDataGatherer:GetDamageFromArray()

		wipe(attackerMenu)
		if(not list) then
			return
		end

		for _, v in pairs(list) do
			attackerMenu[#attackerMenu+1] = {
				text = format("%s %s", v.name, date("%c", v.time)),
				order = #attackerMenu,
				func = function()
					VanasKoSGUI:AddEntry("PLAYERKOS", v.name, format(L["Attacked %s on %s"], UnitName("player"), date("%c", v.time)))
				end,
			}
		end
	end
end

function VanasKoSMinimapButton:OnClick(button)
	local action = nil

	if(button == "LeftButton" and not IsShiftKeyDown()) then
		if(self.db.profile.ReverseButtons) then
			action = "addkos"
		else
			action = "menu"
		end
	elseif(button == "RightButton") then
		if(self.db.profile.ReverseButtons) then
			action = "menu"
		else
			action = "addkos"
		end
	end

	if (action == "menu") then
		VanasKoSMinimapButton:UpdateOptions()
		local x, y = GetCursorPosition()
		local uiScale = UIParent:GetEffectiveScale()
		EasyMenu(minimapOptions, VanasKoSGUI.dropDownFrame, UIParent, x/uiScale, y/uiScale, "MENU")
	elseif(action == "addkos") then
		VanasKoS:AddEntryFromTarget("PLAYERKOS")
	end
end

function VanasKoSMinimapButton:OnEnable()
	if(not icon:IsRegistered(self.name)) then
		icon:Register(self.name, Broker, self.db.profile.button)
	end
	self.db.profile.button.hide = false
	icon:Refresh(self.name, self.db.profile.button)

	if(self.db.profile.ShowWarnFrameInfoText) then
		self:EnableWarnFrameText()
		if(timer == nil) then
			timer = self:ScheduleRepeatingTimer("UpdateList", 1)
		end
	end
end

function VanasKoSMinimapButton:OnDisable()
	self.db.profile.button.hide = true
	icon:Refresh(self.name, self.db.profile.button)
	self:CancelAllTimers()
	if(self.db.profile.ShowWarnFrameInfoText) then
		self:DisableWarnFrameText()
	end
end

function VanasKoSMinimapButton:EnableWarnFrameText()
	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected")
	showWarnFrameInfoText = true
	self:UpdateMyText()
end

function VanasKoSMinimapButton:DisableWarnFrameText()
	self:UnregisterMessage("VanasKoS_Player_Detected")
	showWarnFrameInfoText = false
	Broker.text = nil
end

function VanasKoSMinimapButton:Player_Detected(message, data)
	if(data.name == nil or showWarnFrameInfoText == false) then
		return
	end

	if data.list == "PLAYERKOS" or data.list == "GUILDKOS" then
		data.faction = "kos"
	end

	local unitData = {
		name = data.name,
		faction = data.faction,
		time = time()
	}

	local key = data.name

	if(data.faction == "kos") then
		if(not nearbyKoS[key]) then
			nearbyKoSCount = nearbyKoSCount + 1
		end
		nearbyKoS[key] = unitData
	elseif(data.faction == "enemy") then
		if(not nearbyEnemies[key]) then
			nearbyEnemyCount = nearbyEnemyCount + 1
		end
		nearbyEnemies[key] = unitData
	elseif(data.faction == "friendly") then
		if(not nearbyFriendly[key]) then
			nearbyFriendlyCount = nearbyFriendlyCount + 1
		end
		nearbyFriendly[key] = unitData
	else
		return
	end
	self:UpdateMyText()
end


function VanasKoSMinimapButton:RemovePlayer(key)
	if (nearbyKoS[key]) then
		nearbyKoS[key] = nil
		nearbyKoSCount = nearbyKoSCount - 1
	end
	if (nearbyEnemies[key]) then
		nearbyEnemies[key] = nil
		nearbyEnemyCount = nearbyEnemyCount - 1
	end
	if (nearbyFriendly[key]) then
		nearbyFriendly[key] = nil
		nearbyFriendlyCount = nearbyFriendlyCount - 1
	end
	self:UpdateMyText()
end

function VanasKoSMinimapButton:UpdateMyText()
	Broker.text = "|cffffff00" .. nearbyKoSCount .. "|r |cffff0000" .. nearbyEnemyCount .. "|r |cff00ff00" .. nearbyFriendlyCount .. "|r"
end

function VanasKoSMinimapButton:OnTooltipShow(tt)
	tt:AddLine(VANASKOS.NAME)

	if PvPDataGatherer then
		local list = PvPDataGatherer:GetDamageFromArray()
		if (#list > 0) then
			tt:AddLine(L["Last Attackers"] .. ":", 1.0, 1.0, 1.0)

			for _, v in pairs(list) do
				tt:AddDoubleLine(v.name, format(L["%s ago"], SecondsToTime(time() - v.time)), 1.0, 0.0, 0.0, 1.0, 1.0, 1.0)
			end
		end
	end

	if(showWarnFrameInfoText and (nearbyKoSCount + nearbyEnemyCount + nearbyFriendlyCount) > 0) then
		tt:AddLine(L["Nearby People"] .. ":", 1.0, 1.0, 1.0)
		for _, v in pairs(nearbyKoS) do
			tt:AddLine(v.name, 1.0, 0.0, 1.0)
		end
		for _, v in pairs(nearbyEnemies) do
			tt:AddLine(v.name, 1.0, 0.0, 0.0)
		end
		for _, v in pairs(nearbyFriendly) do
			tt:AddLine(v.name, 0.0, 1.0, 0.0)
		end
	end
end

function VanasKoSMinimapButton:UpdateList()
	local t = time()
	for k, v in pairs(nearbyKoS) do
		if(t - v.time > 60) then
			self:RemovePlayer(k)
		end
	end
	for k, v in pairs(nearbyEnemies) do
		if(t - v.time > 10) then
			self:RemovePlayer(k)
		end
	end
	for k, v in pairs(nearbyFriendly) do
		if(t - v.time > 10) then
			self:RemovePlayer(k)
		end
	end
end
