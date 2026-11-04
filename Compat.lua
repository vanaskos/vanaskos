--[[----------------------------------------------------------------------
      Compat - Part of VanasKoS
Small shims so the same code runs on every client the TOC lists:
Retail (Midnight), WoW Forever, Mists Classic, Burning Crusade Anniversary
and Classic Era. Everything here is feature-detected; nothing assumes a
particular client beyond what the API itself reports.
------------------------------------------------------------------------]]

local _G = _G
local type = type
local select = select
local ipairs = ipairs

local Compat = {}
VANASKOS.Compat = Compat

--[[----------------------------------------------------------------------
	Client detection
------------------------------------------------------------------------]]
local tocVersion = select(4, GetBuildInfo()) or 0
Compat.tocVersion = tocVersion

Compat.isForever = (WOW_PROJECT_CAMELOT ~= nil and WOW_PROJECT_ID == WOW_PROJECT_CAMELOT)
	or (tocVersion >= 16000 and tocVersion < 20000)
Compat.isMainline = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) and not Compat.isForever
Compat.isClassic = not Compat.isMainline and not Compat.isForever

-- Retail 12.0+ ("Midnight") and Forever no longer deliver the combat log to
-- addons (COMBAT_LOG_EVENT_UNFILTERED and its info getter are secure-only).
-- The Classic clients still provide it.
local combatLogInfo = _G.CombatLogGetCurrentEventInfo or (C_CombatLog and C_CombatLog.GetCurrentEventInfo)
Compat.hasCombatLog = (combatLogInfo ~= nil) and not (tocVersion >= 120000 or Compat.isForever)
Compat.CombatLogGetCurrentEventInfo = combatLogInfo

-- Combat log object flags. The globals moved into a deprecation shim on newer
-- clients, so fall back to the Enum and finally to the long-standing values.
local CLO = Enum and Enum.CombatLogObject or {}
Compat.COMBATLOG_OBJECT_REACTION_FRIENDLY = _G.COMBATLOG_OBJECT_REACTION_FRIENDLY or CLO.ReactionFriendly or 0x00000010
Compat.COMBATLOG_OBJECT_REACTION_NEUTRAL = _G.COMBATLOG_OBJECT_REACTION_NEUTRAL or CLO.ReactionNeutral or 0x00000020
Compat.COMBATLOG_OBJECT_REACTION_HOSTILE = _G.COMBATLOG_OBJECT_REACTION_HOSTILE or CLO.ReactionHostile or 0x00000040
Compat.COMBATLOG_OBJECT_CONTROL_PLAYER = _G.COMBATLOG_OBJECT_CONTROL_PLAYER or CLO.ControlPlayer or 0x00000100
Compat.COMBATLOG_OBJECT_TYPE_PLAYER = _G.COMBATLOG_OBJECT_TYPE_PLAYER or CLO.TypePlayer or 0x00000400

--[[----------------------------------------------------------------------
	Secret values (Midnight / Forever)
	Some unit and chat APIs can hand back opaque "secret" values that may
	not be compared, concatenated or stored. Treat them as unknown.
------------------------------------------------------------------------]]
local issecretvalue = _G.issecretvalue
function Compat.IsSecret(value)
	return issecretvalue ~= nil and value ~= nil and issecretvalue(value) or false
end

-- returns value, or nil if it is a secret value
function Compat.Clean(value)
	if issecretvalue and value ~= nil and issecretvalue(value) then
		return nil
	end
	return value
end

-- UnitName that never returns secret values
function Compat.UnitName(unit)
	local name, realm = UnitName(unit)
	if issecretvalue then
		if name ~= nil and issecretvalue(name) then
			return nil, nil
		end
		if realm ~= nil and issecretvalue(realm) then
			realm = nil
		end
	end
	return name, realm
end

--[[----------------------------------------------------------------------
	Small API moves
------------------------------------------------------------------------]]
Compat.GetAddOnMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or _G.GetAddOnMetadata

-- returns pvpType, isFFA/isSubZonePvP, faction
function Compat.GetZonePVPInfo()
	if C_PvP and C_PvP.GetZonePVPInfo then
		return C_PvP.GetZonePVPInfo()
	elseif _G.GetZonePVPInfo then
		return _G.GetZonePVPInfo()
	end
	return nil
end

-- War Mode only exists on clients that know its event
Compat.hasWarMode = (C_PvP ~= nil and C_PvP.IsWarModeDesired ~= nil)
	and (not C_EventUtils or not C_EventUtils.IsEventValid or C_EventUtils.IsEventValid("WAR_MODE_STATUS_UPDATE"))

function Compat.IsWarModeDesired()
	if C_PvP and C_PvP.IsWarModeDesired then
		return C_PvP.IsWarModeDesired() and true or false
	end
	return false
end

function Compat.GetMaxPlayerLevel()
	local lvl = (_G.GetMaxLevelForPlayerExpansion and _G.GetMaxLevelForPlayerExpansion())
		or (_G.GetMaxPlayerLevel and _G.GetMaxPlayerLevel())
	if type(lvl) == "number" and lvl > 0 then
		return lvl
	end
	return 60
end

-- Registering an event the client does not know about throws an error on
-- modern clients, so check first.
function Compat.IsEventValid(event)
	if C_EventUtils and C_EventUtils.IsEventValid then
		return C_EventUtils.IsEventValid(event)
	end
	return true
end

--[[----------------------------------------------------------------------
	Settings panel
------------------------------------------------------------------------]]
function Compat.OpenSettings(categoryID)
	if not categoryID then
		return
	end
	if Settings and Settings.OpenToCategory then
		Settings.OpenToCategory(categoryID)
	elseif _G.InterfaceOptionsFrame_OpenToCategory then
		_G.InterfaceOptionsFrame_OpenToCategory(categoryID)
		_G.InterfaceOptionsFrame_OpenToCategory(categoryID)
	end
end

--[[----------------------------------------------------------------------
	Context menus
	EasyMenu/UIDropDownMenu were replaced by the Menu system on every client.
	ShowMenu accepts the old EasyMenu table format so the module code can
	keep describing menus the way it always has.
------------------------------------------------------------------------]]
local function evaluate(value)
	if type(value) == "function" then
		return value()
	end
	return value
end

local function addMenuItems(parentDescription, items)
	for _, item in ipairs(items) do
		local text = item.text or ""
		local description
		if item.isTitle then
			description = parentDescription:CreateTitle(text)
		elseif item.hasArrow and type(item.menuList) == "table" then
			description = parentDescription:CreateButton(text)
			if #item.menuList > 0 then
				addMenuItems(description, item.menuList)
			else
				description:SetEnabled(false)
			end
		elseif item.checked ~= nil and not item.notCheckable then
			description = parentDescription:CreateCheckbox(text,
				function()
					return evaluate(item.checked) and true or false
				end,
				function()
					if item.func then
						item.func(nil, item.arg1, item.arg2, evaluate(item.checked))
					end
					if item.keepShownOnClick and MenuResponse then
						return MenuResponse.Refresh
					end
				end)
		else
			description = parentDescription:CreateButton(text, function()
				if item.func then
					item.func(nil, item.arg1, item.arg2)
				end
				if item.keepShownOnClick and MenuResponse then
					return MenuResponse.Refresh
				end
			end)
		end
		if description and item.disabled and description.SetEnabled then
			description:SetEnabled(false)
		end
	end
end
Compat.AddMenuItems = addMenuItems

function Compat.ShowMenu(menuList, owner)
	if MenuUtil and MenuUtil.CreateContextMenu then
		MenuUtil.CreateContextMenu(owner or UIParent, function(_, rootDescription)
			rootDescription:SetTag("MENU_VANASKOS")
			addMenuItems(rootDescription, menuList)
		end)
	elseif _G.EasyMenu then
		-- very old fallback, kept in case a client still ships EasyMenu
		local VanasKoSGUI = LibStub("AceAddon-3.0"):GetAddon("VanasKoS"):GetModule("GUI")
		_G.EasyMenu(menuList, VanasKoSGUI.dropDownFrame, "cursor", 0, 0, "MENU")
	end
end

--[[----------------------------------------------------------------------
	Unit tooltips
	Calls callback(tooltip, unit) whenever GameTooltip shows a unit.
------------------------------------------------------------------------]]
function Compat.HookUnitTooltip(callback)
	local function handler(tooltip)
		if tooltip ~= GameTooltip then
			return
		end
		local unit
		if tooltip.GetUnit then
			unit = select(2, tooltip:GetUnit())
		end
		if unit == nil or Compat.IsSecret(unit) then
			unit = "mouseover"
		end
		callback(tooltip, unit)
	end

	if GameTooltip:HasScript("OnTooltipSetUnit") then
		GameTooltip:HookScript("OnTooltipSetUnit", handler)
	elseif TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall and Enum.TooltipDataType then
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, handler)
	end
end

--[[----------------------------------------------------------------------
	Target and party frame highlighting
	kind: "kos", "guildkos", "hate", "nice" or nil
------------------------------------------------------------------------]]
local classicTargetTextures = {
	kos = { "Interface\\TargetingFrame\\UI-TargetingFrame-Elite", 1.0, 1.0, 1.0 },
	guildkos = { "Interface\\TargetingFrame\\UI-TargetingFrame-Rare", 1.0, 1.0, 1.0 },
	hate = { "Interface\\TargetingFrame\\UI-TargetingFrame-Rare", 1.0, 0.0, 0.0 },
	nice = { "Interface\\TargetingFrame\\UI-TargetingFrame-Rare", 0.0, 1.0, 0.0 },
}

local modernTargetAtlases = {
	kos = { "UI-HUD-UnitFrame-Target-PortraitOn-Boss-Gold", 1.0, 1.0, 1.0 },
	guildkos = { "ui-hud-unitframe-target-portraiton-boss-rare-silver", 1.0, 1.0, 1.0 },
	hate = { "ui-hud-unitframe-target-portraiton-boss-rare-silver", 1.0, 0.0, 0.0 },
	nice = { "ui-hud-unitframe-target-portraiton-boss-rare-silver", 0.0, 1.0, 0.0 },
}

local function GetClassicTargetTexture()
	if _G.TargetFrameTextureFrameTexture then
		return _G.TargetFrameTextureFrameTexture
	end
	local tf = _G.TargetFrame
	return tf and tf.textureFrame and tf.textureFrame.texture or nil
end

local function GetModernTargetTexture()
	local tf = _G.TargetFrame
	return tf and tf.TargetFrameContainer and tf.TargetFrameContainer.BossPortraitFrameTexture or nil
end

local targetHighlight = { guid = nil, kind = nil }
local modernHookInstalled = false

local function ApplyModernHighlight()
	local tex = GetModernTargetTexture()
	if not tex then
		return
	end
	local guid = Compat.Clean(UnitGUID("target"))
	local style = targetHighlight.kind and guid and guid == targetHighlight.guid and modernTargetAtlases[targetHighlight.kind]
	if style then
		tex:SetAtlas(style[1], true)
		tex:ClearAllPoints()
		tex:SetPoint("TOPRIGHT", -11, -8)
		tex:SetVertexColor(style[2], style[3], style[4])
		tex:Show()
	else
		-- Blizzard positions/shows the texture itself; only undo our tint
		tex:SetVertexColor(1.0, 1.0, 1.0)
	end
end

function Compat.SetTargetFrameHighlight(kind)
	local classicTex = GetClassicTargetTexture()
	if classicTex then
		local alpha = classicTex:GetAlpha()
		local style = kind and classicTargetTextures[kind]
		if style then
			classicTex:SetTexture(style[1])
			classicTex:SetVertexColor(style[2], style[3], style[4], alpha)
		else
			classicTex:SetVertexColor(1.0, 1.0, 1.0, alpha)
		end
		return
	end

	local modernTex = GetModernTargetTexture()
	if not modernTex then
		return
	end
	if not modernHookInstalled and _G.TargetFrame and _G.TargetFrame.CheckClassification then
		-- Blizzard re-evaluates the elite/rare art on every target change; re-apply ours afterwards
		hooksecurefunc(_G.TargetFrame, "CheckClassification", ApplyModernHighlight)
		modernHookInstalled = true
	end
	targetHighlight.guid = kind and Compat.Clean(UnitGUID("target")) or nil
	targetHighlight.kind = kind
	if kind then
		ApplyModernHighlight()
	else
		modernTex:SetVertexColor(1.0, 1.0, 1.0)
	end
end

-- Texture of the i-th party member frame on clients whose party frames use
-- the classic art. Returns nil where that does not apply.
function Compat.GetPartyMemberFrameTexture(i)
	local tex = _G["PartyMemberFrame" .. i .. "Texture"]
	if tex then
		return tex
	end
	if Compat.isClassic and _G.PartyFrame then
		local member = _G.PartyFrame["MemberFrame" .. i]
		if member and member.PartyMemberOverlay and member.PartyMemberOverlay.Texture then
			return member.PartyMemberOverlay.Texture
		end
	end
	return nil
end
