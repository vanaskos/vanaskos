--[[----------------------------------------------------------------------
      EventMap Module - Part of VanasKoS
Displays PvP Events on World Map
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/EventMap", false)
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")
local VanasKoSGUI = VanasKoS:GetModule("GUI")
local VanasKoSEventMap = VanasKoS:NewModule("EventMap", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
Mixin(VanasKoSEventMap, MapCanvasDataProviderMixin)

-- Global wow strings
local WIN, LOSS = WIN, LOSS

-- Declare some common global functions local
local ipairs = ipairs
local pairs = pairs

-- Constants
local pinTemplate = "VanasKoSEventMapPinsTemplate"

-- Local Variables
local zoneContinentZoneID = {}
local ICONSIZE = 16
local PINGRIDALIGN = 16
local trackedPlayers = {}

VanasKoSEventMap.lastzoom = 20
VanasKoSEventMap.lastMapID = -1

-- Storage for worldmap pins
VanasKoSEventMap.PinsPool = VanasKoSEventMap.PinsPool or CreateFramePool("BUTTON")
VanasKoSEventMap.ProviderPin = VanasKoSEventMap.ProviderPin or CreateFromMixins(MapCanvasPinMixin)

-- upvalue data tables
local mapPinsPool = VanasKoSEventMap.PinsPool
local mapProviderPin = VanasKoSEventMap.ProviderPin

-- Setup pin pool
mapPinsPool.parent = WorldMapFrame:GetCanvas()
mapPinsPool.creationFunc = function(framePool)
	local frame = CreateFrame(framePool.frameType, nil, framePool.parent)
	frame:SetSize(ICONSIZE, ICONSIZE)
	return Mixin(frame, mapProviderPin)
end
mapPinsPool.resetterFunc = function(pinPool, pin)
	FramePool_HideAndClearAnchors(pinPool, pin)
	pin:OnReleased()

	pin.pinTemplate = nil
	pin.owningMap = nil
end

-- register pin pool with the world map
WorldMapFrame.pinPools[pinTemplate] = mapPinsPool

function VanasKoSEventMap:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate(pinTemplate)
	wipe(self.PinGrid)
	self.PinUsed = 0
	self:CancelAllTimers()
	self.lastMapID = -1
end

function VanasKoSEventMap:RefreshAllData(fromOnShow)
	if self:IsEnabled() and self.showEncounters then
		local mapID = self:GetMap():GetMapID()
		-- Only draw if the zone has changed
		if (self.lastMapID == mapID) then
			return
		end

		self.lastMapID = mapID

		self:RemoveAllData()
		self:CreatePoints(1)
	end
end

function VanasKoSEventMap:GetPin(x, y)
	local mapWidth = self:GetMap():GetWidth()
	local mapHeight = self:GetMap():GetHeight()
	local ax = x * mapWidth
	local ay = -y * mapHeight
	ax = floor(ax/PINGRIDALIGN) * PINGRIDALIGN
	ay = floor(ay/PINGRIDALIGN) * PINGRIDALIGN

	if (self.PinGrid[ax] and self.PinGrid[ax][ay]) then
		return self.PinGrid[ax][ay]
	end

	if not self.PinGrid[ax] then
		self.PinGrid[ax] = {}
	end

	local Pin = self:GetMap():AcquirePin(pinTemplate, x, y)
	self.PinGrid[ax][ay] = Pin
	return Pin
end

function mapProviderPin:OnLoad()
	self:UseFrameLevelType("PIN_FRAME_LEVEL_AREA_POI")
	self:SetScalingLimits(1, 1.0, 1.2)
end

function mapProviderPin:OnAcquired(x, y)
	self:UseFrameLevelType("PIN_FRAME_LEVEL_AREA_POI")
	self:SetPosition(x, y)
	self.score = 0
	self.event = {}
end

function mapProviderPin:OnReleased()
	self:Hide()
	self:SetParent(UIParent)
	self:ClearAllPoints()
end

function mapProviderPin:OnMouseEnter()
	VanasKoSEventMap:Pin_OnEnter(self)
end

function mapProviderPin:OnMouseLeave()
	VanasKoSEventMap:Pin_OnLeave(self)
end

function mapProviderPin:OnClick(button)
	VanasKoSEventMap:Pin_OnClick(self, button)
end

-- register with the world map
WorldMapFrame:AddDataProvider(VanasKoSEventMap)

function VanasKoSEventMap:Pin_Resize(frame)
	frame:SetWidth(ICONSIZE)
	frame:SetHeight(ICONSIZE)
end

function VanasKoSEventMap:Pin_OnClick(frame, button, down)
	if(button == "RightButton") then
		local x, y = GetCursorPosition()
		local uiScale = UIParent:GetEffectiveScale()
		local menuItems = {
			{
				text = L["Remove events"],
				func = function()
					VanasKoSEventMap:RemoveEventsInPin(frame)
				end
			}
		}

		EasyMenu(menuItems, VanasKoSGUI.dropDownFrame, UIParent, x/uiScale, y/uiScale, "MENU")
	end
end

function VanasKoSEventMap:OnShow()
	self:RefreshAllData(true)
end

function VanasKoSEventMap:RemoveEventsInPin(Pin)
	local pvpEventLog = VanasKoS:GetList("PVPLOG", 1)
	local pvpPlayerLog = VanasKoS:GetList("PVPLOG", 2)
	local pvpMapLog = VanasKoS:GetList("PVPLOG", 3)
	for i, hash in ipairs(Pin.event) do
		local event = pvpEventLog[hash]
		if (event) then
			if (event.enemyname) then
				for j, zhash in ipairs(pvpPlayerLog[event.enemyname] or {}) do
					if (zhash == hash) then
						--print("removing " .. hash .. " from player log")
						tremove(pvpPlayerLog[event.enemyname], j)
						break
					end
					if (pvpPlayerLog[event.enemyname] and next(pvpPlayerLog[event.enemyname]) == nil) then
						pvpPlayerLog[event.enemyname] = nil
					end
				end
			end
		end
		if (event.mapID) then
			for j, zhash in ipairs(pvpMapLog[event.mapID] or {}) do
				if (zhash == hash) then
					--print("removing " .. hash .. " from pvp zone log")
					tremove(pvpMapLog[event.mapID], j)
					break
				end
			end
			if (pvpMapLog[event.mapID] and next(pvpMapLog[event.mapID]) == nil) then
				pvpMapLog[event.mapID] = nil
			end
		end
		pvpEventLog[hash] = nil
	end
	wipe(Pin.event)
	Pin:Hide()
end

function VanasKoSEventMap:Pin_OnEnter(frame, motion)
	if (not self.db.profile.showTooltip) then
		return
	end

	local anchor = "ANCHOR_RIGHT"
	--if (self:GetMap():GetCanvas():GetCenter() < frame.x) then
	--	anchor = "ANCHOR_LEFT"
	--end

	local tooltip = WorldMapTooltip
	tooltip:ClearLines()
	tooltip:SetOwner(frame, anchor)
	if(frame.trackedPlayer) then
		local name = frame.playerName
		tooltip:AddLine(format("Tracking: %s (%s)", name,
					SecondsToTime(time() - trackedPlayers[name:lower()].lastseen)))
	else
		tooltip:AddLine(format(L["PvP Encounter"]))

		local pvpEventLog = VanasKoS:GetList("PVPLOG", 1)
		for i, eventIdx in ipairs(frame.event) do
			local event = pvpEventLog[eventIdx]
			local player = ""
			if (event.myname) then
				player = player .. event.myname
			end
			if (event.mylevel) then
				player = player .. " (" .. event.mylevel .. ")"
			end

			local key = event.name
			local playerdata = VanasKoS:GetPlayerData(key)
			local enemy = event.name
			local enemyNote = event.enemylevel or ""

			if (playerdata) then
				if (playerdata.guild) then
					enemy = enemy .. " <" .. playerdata.guild .. ">"
				end
				if (playerdata.race) then
					enemyNote = enemyNote .. " " .. playerdata.race
				end
				if (playerdata.class) then
					enemyNote = enemyNote .. " " .. playerdata.class
				end
			end

			if (enemyNote ~= "") then
				enemy = enemy .. " (" .. enemyNote .. ")"
			end

			if (event.type == "loss") then
				tooltip:AddLine(format(L["|cffff0000%s - %s killed by %s|r"], date("%c", event.time), player, enemy))
			elseif (event.type == "win") then
				tooltip:AddLine(format(L["|cff00ff00%s - %s killed %s|r"], date("%c", event.time), player, enemy))
			end
		end
	end
	--WorldMapPinFrame.allowBlobTooltip = false
	tooltip:Show()
end

function VanasKoSEventMap:Pin_OnLeave(frame)
	WorldMapTooltip:Hide()
	--WorldMapPinFrame.allowBlobTooltip = true
end

function VanasKoSEventMap:drawPin(Pin)
	local alpha = 1

	-- sanity check
	if (Pin == nil) then
		return
	end

	Pin:Hide()

	if(Pin.trackedPlayer) then
		Pin:SetNormalTexture("Interface\\Addons\\VanasKoS\\Artwork\\loss")
		Pin:Show()
		return
	end

	Pin:SetNormalTexture(nil)

	if (Pin.score < 0) then
		Pin:SetNormalTexture("Interface\\Addons\\VanasKoS\\Artwork\\loss")
	elseif (Pin.score > 0) then
		Pin:SetNormalTexture("Interface\\Addons\\VanasKoS\\Artwork\\win")
	else
		Pin:SetNormalTexture("Interface\\Addons\\VanasKoS\\Artwork\\tie")
	end
	Pin:Show()
end

function VanasKoSEventMap:TrackPlayer(name, mapID, x, y)
	--VanasKoS:Print(format("%s %d %d %f %f", playername, mapID, x, y))
	local key = name
	local playerData = trackedPlayers[key]
	if not trackedPlayers[key] then
		trackedPlayers[key] = {
			name = name,
		}
	end
	trackedPlayers[key].name = name
	trackedPlayers[key].mapID = mapID
	trackedPlayers[key].x = x
	trackedPlayers[key].y = y
	trackedPlayers[key].lastseen = time()

	self:RefreshAllData()
end

function VanasKoSEventMap:CreateTrackingPoints()
	local mapID = self:GetMap():GetMapID()
	for k, v in pairs(trackedPlayers) do
		if(v.mapID ~= mapID) then
			--VanasKoS:Print(format("break %d %d", v.mapID, mapProvider:GetMapID()))
		else
			local Pin = self:GetPin(v.x, v.y)

			Pin.trackedPlayer = true
			Pin.show = true
			Pin.playerName = k

			self:drawPin(Pin)
		end
	end
end

function VanasKoSEventMap:CreatePoints(enemyIdx)
	self:CreateTrackingPoints()

	local mapID = self:GetMap():GetMapID()
	local drawAlts = self.db.profile.drawAlts
	local mapWidth = self:GetMap():GetWidth()
	local mapHeight = self:GetMap():GetHeight()
	local pvpEventLog = VanasKoS:GetList("PVPLOG", 1)
	local pvpMapLog = VanasKoS:GetList("PVPLOG", 3)

	if (pvpMapLog and pvpMapLog[mapID]) then
		local i = 0
		local myname = UnitName("player")
		local zonelog = pvpMapLog[mapID] or {}
		for idx = enemyIdx, #zonelog do
			local event = pvpEventLog[zonelog[idx]]
			if event and event.x and event.y then
				if (drawAlts or event.myname == myname) then
					local Pin = self:GetPin(event.x, event.y)
					if (event.type == "loss") then
						Pin.score = Pin.score - 1
					elseif (event.type == "win") then
						Pin.score = Pin.score + 1
					end
					Pin.show = true

					tinsert(Pin.event, zonelog[idx])
					self:drawPin(Pin)
				end
				i = i + 1
				if (i >= 100) then
					self:ScheduleTimer("CreatePoints", 0, idx + 1)
					return
				end
			end
		end
	end
end

function VanasKoSEventMap:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("EventMap", {
		profile = {
			Enabled = true,
			drawAlts = true,
			showTooltip = true,
		},
	})

	VanasKoSGUI:AddModuleToggle("EventMap", L["PvP Event Map"])
	VanasKoSGUI:AddMainMenuConfigOptions({
		pvp_event_map_group = {
			name = L["Event Map"],
			desc = L["PvP Event Map"],
			type = 'group',
			args = {
				drawAlts = {
					type = 'toggle',
					name = L["Draw Alts"],
					desc = L["Draws PvP events on map for all characters"],
					order = 1,
					set = function(frame, v)
						VanasKoSEventMap.db.profile.drawAlts = v VanasKoSEventMap:RefreshAllData()
					end,
					get = function()
						return VanasKoSEventMap.db.profile.drawAlts
					end,
				},
				showTooltip = {
					type = 'toggle',
					name = L["Tooltips"],
					desc = L["Show tooltips when hovering over PvP events"],
					order = 2,
					set = function(frame, v)
						VanasKoSEventMap.db.profile.showTooltip = v
					end,
					get = function()
						return VanasKoSEventMap.db.profile.showTooltip
					end,
				}
			}
		}
	})
	self.PinCnt = 0
	self.PinUsed = 0
	self.Pins = {}
	self.PinGrid = {}
	self.showEncounters = true

	self:SetEnabledState(self.db.profile.Enabled)

	PINGRIDALIGN = ICONSIZE

	for _, overlayFrame in next, WorldMapFrame.overlayFrames do
		if(overlayFrame.Border and overlayFrame.Border:GetTexture() == 'Interface\\Minimap\\MiniMap-TrackingBorder') then
			hooksecurefunc(overlayFrame, 'InitializeDropDown', VanasKoSEventMap.InitializeTrackingDropDown)
			break
		end
	end
end

function VanasKoSEventMap:OnEnable()
	self:RegisterMessage("VanasKoS_PvPDeath", "PvPDeath")
	PINGRIDALIGN = ICONSIZE
	self:RefreshAllData()
end

function VanasKoSEventMap:OnDisable()
	self:UnregisterAllMessages()
	self:RemoveAllData()
end

function VanasKoSEventMap.InitializeTrackingDropDown()
	if VanasKoSEventMap:IsEnabled() then
		local info = UIDropDownMenu_CreateInfo()
		info.text = L["Show PvP Encounters"]
		info.value = "PVPencounter"
		info.notCheckable = nil
		info.isNotRadio = true
		info.checked = VanasKoSEventMap.showEncounters
		info.keepShownOnClick = true
		info.func = function(button)
			if not VanasKoSEventMap.showEncounters then
				VanasKoSEventMap.showEncounters = true
				VanasKoSEventMap:RefreshAllData()
			else
				VanasKoSEventMap.showEncounters = nil
				VanasKoSEventMap:RemoveAllData()
			end
		end
		UIDropDownMenu_AddButton(info)
	end
end

function VanasKoSEventMap:PvPDeath(message, name)
	self:RefreshAllData()
end
