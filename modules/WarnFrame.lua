--[[----------------------------------------------------------------------
      WarnFrame Module - Part of VanasKoS
Creates the WarnFrame to alert of nearby KoS, Hostile and Friendly
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/WarnFrame", false)
local SML = LibStub("LibSharedMedia-3.0")
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")
local VanasKoSGUI = VanasKoS:GetModule("GUI")
local VanasKoSWarnFrame = VanasKoS:NewModule("WarnFrame", "AceEvent-3.0", "AceTimer-3.0")

-- Global wow strings
local LEVEL = LEVEL

-- Declare some common global functions local
local floor = math.floor
local pairs = pairs
local format = format
local wipe = wipe
local assert = assert
local time = time
local tonumber = tonumber
local tostring = tostring
local GetZoneText = GetZoneText

-- Constants
local WARN_BUTTONS_MAX = 40

-- Local variables
local warnFrame = nil
local normalFont = nil
local kosFont = nil
local enemyFont = nil
local friendlyFont = nil
local warnButtonsOOC = nil
local warnButtonsCombat = nil
local classIcons = nil
local testFontFrame = nil

local nearbyKoS = nil
local nearbyEnemy = nil
local nearbyFriendly = nil
local nearbyKoSCount = 0
local nearbyEnemyCount = 0
local nearbyFriendlyCount = 0

local dataCache = nil
local buttonData = nil

local timer = nil
local currentButtonCount = 0
local InCombatLockdown = InCombatLockdown
local playerDetectEventEnabled = false

local function GetColor(which)
	return VanasKoSWarnFrame.db.profile[which .. "R"], VanasKoSWarnFrame.db.profile[which .. "G"], VanasKoSWarnFrame.db.profile[which .. "B"], VanasKoSWarnFrame.db.profile[which .. "A"]
end

local function SetBgColor(which, r, g, b, a)
	warnFrame:SetBackdropColor(r, g, b, a)

	VanasKoSWarnFrame.db.profile[which .. "R"] = r
	VanasKoSWarnFrame.db.profile[which .. "G"] = g
	VanasKoSWarnFrame.db.profile[which .. "B"] = b
	VanasKoSWarnFrame.db.profile[which .. "A"] = a
end

local function CreateWarnFrameFonts(size)
	if (testFontFrame == nil) then
		testFontFrame = CreateFrame("Button", nil, UIParent)
		testFontFrame:SetText("XXXXXXXXXXXX [00+]")
		testFontFrame:Hide()
	end

	if (kosFont == nil) then
		kosFont = CreateFont("VanasKoS_FontKos")
		kosFont:SetFont(SML:Fetch("font"), size)
	end
	kosFont:SetTextColor(VanasKoSWarnFrame.db.profile.KoSTextColorR,
				VanasKoSWarnFrame.db.profile.KoSTextColorG,
				VanasKoSWarnFrame.db.profile.KoSTextColorB)

	if (enemyFont == nil) then
		enemyFont = CreateFont("VanasKoS_FontEnemy")
		enemyFont:SetFont(SML:Fetch("font"), size)
	end
	enemyFont:SetTextColor(VanasKoSWarnFrame.db.profile.EnemyTextColorR,
				VanasKoSWarnFrame.db.profile.EnemyTextColorG,
				VanasKoSWarnFrame.db.profile.EnemyTextColorB)

	if (friendlyFont == nil) then
		friendlyFont = CreateFont("VanasKoS_FontFriendly")
		friendlyFont:SetFont(SML:Fetch("font"), size)
	end
	friendlyFont:SetTextColor(VanasKoSWarnFrame.db.profile.FriendlyTextColorR,
				VanasKoSWarnFrame.db.profile.FriendlyTextColorG,
				VanasKoSWarnFrame.db.profile.FriendlyTextColorB)

	if (normalFont == nil) then
		normalFont = CreateFont("VanasKoS_FontNormal")
		normalFont:SetFont(SML:Fetch("font"), size)
	end
	normalFont:SetTextColor(VanasKoSWarnFrame.db.profile.NormalTextColorR,
				VanasKoSWarnFrame.db.profile.NormalTextColorG,
				VanasKoSWarnFrame.db.profile.NormalTextColorB)

	testFontFrame:SetNormalFontObject("VanasKoS_FontNormal")
	local h = floor(testFontFrame:GetTextHeight() + 5)
	local w = floor(testFontFrame:GetTextWidth() + 5) + h
	VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT = h
	VanasKoSWarnFrame.db.profile.WARN_FRAME_WIDTH = w
end

local function SetTextColor(which, r, g, b)
	VanasKoSWarnFrame.db.profile[which .. "R"] = r
	VanasKoSWarnFrame.db.profile[which .. "G"] = g
	VanasKoSWarnFrame.db.profile[which .. "B"] = b

	CreateWarnFrameFonts(VanasKoSWarnFrame.db.profile.FontSize)
end

local listsToCheck = {
		['PLAYERKOS'] = { L["KoS: %s"], L["%sKoS: %s"] },
		['GUILDKOS'] = { L["KoS (Guild): %s"], L["%sKoS (Guild): %s"] },
		['NICELIST'] = { L["Nicelist: %s"], L["%sNicelist: %s"] },
		['HATELIST'] = { L["Hatelist: %s"], L["%sHatelist: %s"] },
		['WANTED'] = {  L["Wanted: %s"], L["%sWanted: %s"] },
	}

local function HideTooltip()
	GameTooltip:Hide()
end

local function ShowTooltip(self, buttonNr)
	local buttonName = buttonData[buttonNr]
	local data = dataCache[buttonName]

	if(not VanasKoSWarnFrame.db.profile.ShowMouseOverInfos or not data) then
		return
	end

	GameTooltip:Hide()
	GameTooltip:SetOwner(self)
	if data.guid then
		GameTooltip:SetHyperlink("unit:" .. data.guid)
	end

	-- add the KoS: <text> and KoS (Guild): <text> messages
	for k,v in pairs(listsToCheck) do
		local key
		if(k == "GUILDKOS") then
			key = data.guild or nil
		else
			key = data.name
		end
		local listData = key and VanasKoS:IsOnList(k, key) or nil
		if(listData) then
			if(listData.owner == nil) then
				GameTooltip:AddLine(format(v[1], listData.reason or ""))
			else
				GameTooltip:AddLine(format(v[2], listData.creator or listData.owner, listData.reason or ""))
			end
		end
	end

	-- add pvp stats line if turned on and data is available
	local listData = VanasKoS:IsOnList("PVPSTATS", data.key, 1)
	local playerdata = VanasKoS:IsOnList("PLAYERDATA", data.key)

	if(listData or playerdata) then
		GameTooltip:AddLine(format(L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"],
			(playerdata and playerdata.seen) or 0,
			(listData and listData.wins) or 0,
			(listData and listData.losses) or 0))
	end
	GameTooltip:Show()
end

local function UpdateButtonAlignment(nr, justify)
	local offset = 0
	if (justify == "LEFT") then
		if (VanasKoSWarnFrame.db.profile.ShowClassIcons) then
			offset = VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT + 5
		else
			offset = 5
		end
	elseif (justify == "RIGHT") then
		offset = -5
	else
		if (VanasKoSWarnFrame.db.profile.ShowClassIcons) then
			offset = VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT / 2
		else
			offset = 0
		end
	end

	local fs = warnButtonsOOC[nr]:GetFontString()
	if (fs) then
		fs:ClearAllPoints()
		fs:SetPoint(justify, warnButtonsOOC[nr], justify, offset, 0)
	end
	fs = warnButtonsCombat[nr]:GetFontString()
	if (fs) then
		fs:ClearAllPoints()
		fs:SetPoint(justify, warnButtonsCombat[nr], justify, offset, 0)
	end
end

local function SetFontAlignment(justify)
	for i=1,WARN_BUTTONS_MAX do
		UpdateButtonAlignment(i, justify)
	end
end

local function SetProperties(self, profile)
	if(self == nil) then
		return
	end

	self:SetWidth(profile.WARN_FRAME_WIDTH)
	self:SetHeight(profile.WARN_BUTTONS * profile.WARN_BUTTON_HEIGHT +
			    profile.WARN_FRAME_HEIGHT_PADDING * 2 + 1)
	if(profile.WARN_FRAME_POINT) then
		warnFrame:ClearAllPoints()
		self:SetPoint(profile.WARN_FRAME_POINT,
					"UIParent",
					profile.WARN_FRAME_ANCHOR,
					profile.WARN_FRAME_XOFF,
					profile.WARN_FRAME_YOFF)
	else
		self:SetPoint("CENTER")
	end

	if(profile.WarnFrameBorder) then
		warnFrame:SetBackdrop( {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
					insets = { left = 5, right = 4, top = 5, bottom = 5 },
		})
		self:EnableMouse(true)
	else
		warnFrame:SetBackdrop({bgfile = nil, edgeFile = nil})
		self:EnableMouse(false)
	end

	-- set the default backdrop color
	local r, g, b, a = GetColor("DefaultBGColor")
	self:SetBackdropColor(r, g, b, a)
	SetFontAlignment(VanasKoSWarnFrame.db.profile.FontAlign)
	self:Hide()
end

local function CreateWarnFrame()
	if(warnFrame ~= nil) then
		return
	end
	-- Create the Main Window
	warnFrame = CreateFrame("Button", "VanasKoS_WarnFrame", UIParent)
	warnFrame:SetToplevel(true)
	warnFrame:SetMovable(true)
	warnFrame:SetFrameStrata("LOW")

	-- allow dragging the window
	warnFrame:RegisterForDrag("LeftButton")
	warnFrame:SetScript("OnDragStart", function()
		if(VanasKoSWarnFrame.db.profile.Locked) then
			return
		end
		warnFrame:StartMoving()
	end)
	warnFrame:SetScript("OnDragStop", function()
		warnFrame:StopMovingOrSizing()
		local point, _, anchor, xOff, yOff = warnFrame:GetPoint()
		VanasKoSWarnFrame.db.profile.WARN_FRAME_POINT = point
		VanasKoSWarnFrame.db.profile.WARN_FRAME_ANCHOR = anchor
		VanasKoSWarnFrame.db.profile.WARN_FRAME_XOFF = xOff
		VanasKoSWarnFrame.db.profile.WARN_FRAME_YOFF = yOff
	end)
	VanasKoSWarnFrame.frame = warnFrame
end

local classIconNameToCoords = CLASS_ICON_TCOORDS

local function CreateClassIcons()
	if(classIcons) then
		return
	end

	classIcons = { }
	for i=1,WARN_BUTTONS_MAX do
		local classIcon = CreateFrame("Button", nil, warnFrame)
		classIcon:SetPoint("LEFT", warnButtonsCombat[i], "LEFT", 5, 0)
		classIcon:SetWidth(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT)
		classIcon:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT)

		local texture = classIcon:CreateTexture(nil, "ARTWORK")
		texture:SetAllPoints(classIcon)
		texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")

		classIcon:Hide()

		classIcons[i] = { classIcon, texture }
	end
end

local function setButtonClassIcon(iconNr, class)
	if(class == nil) then
		classIcons[iconNr][1]:Hide()
		return
	end

	local coords = classIconNameToCoords[class]
	if(not coords) then
		return
	end
	classIcons[iconNr][2]:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
	classIcons[iconNr][1]:Show()
end

local function CreateOOCButtons()
	if(warnButtonsOOC) then
		return
	end
	warnButtonsOOC = { }

	for i=1,WARN_BUTTONS_MAX do
		local warnButton = CreateFrame("Button", nil, warnFrame, "SecureActionButtonTemplate")
		if(i == 1) then
			warnButton:SetPoint("TOP", warnFrame, 0, -5)
		else
			warnButton:SetPoint("TOP", warnButtonsOOC[i-1], "BOTTOM", 0, 0)
		end

		warnButton:SetWidth(VanasKoSWarnFrame.db.profile.WARN_FRAME_WIDTH)
		warnButton:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT)
		warnButton:EnableMouse(true)
		warnButton:SetNormalFontObject("GameFontWhiteSmall")
		warnButton:SetFrameStrata("MEDIUM")
		warnButton:SetText("")
		warnButton:RegisterForClicks("AnyUp")
		warnButton:SetAttribute("type", "macro")
		warnButton:SetAttribute("macrotext", "/wave")

		warnButton:SetScript("OnEnter", function()
			ShowTooltip(warnButton, i)
		end)
		warnButton:SetScript("OnLeave", function()
			HideTooltip()
		end)
		if (i <= currentButtonCount) then
			warnButton:Show()
		else
			warnButton:Hide()
		end

		warnButtonsOOC[i] = warnButton
	end
end

local function CreateCombatButtons()
	if(warnButtonsCombat) then
		return
	end
	warnButtonsCombat = { }

	for i=1,WARN_BUTTONS_MAX do
		local warnButton = CreateFrame("Button", nil, warnFrame)
		-- same size as OOC buttons
		warnButton:SetAllPoints(warnButtonsOOC[i])
		warnButton:EnableMouse(true)
		warnButton:SetNormalFontObject("GameFontWhiteSmall")
		warnButton:RegisterForClicks("LeftButtonUp")
		warnButton:RegisterForClicks("RightButtonUp")
		warnButton:SetFrameStrata("HIGH")
		warnButton:SetText("")

		warnButton:SetScript("OnEnter", function()
			ShowTooltip(warnButton, i)
		end)
		warnButton:SetScript("OnLeave", function()
			HideTooltip()
		end)

		warnButton:Hide()

		warnButtonsCombat[i] = warnButton
	end
end

local function HideButton(buttonNr)
	if(not warnButtonsOOC or not warnButtonsOOC[buttonNr]) then
		return
	end
	if(InCombatLockdown()) then
		warnButtonsOOC[buttonNr]:SetText("")
		warnButtonsOOC[buttonNr]:SetAlpha(0)
		warnButtonsCombat[buttonNr]:SetText("")
		warnButtonsCombat[buttonNr]:EnableMouse(false)
		warnButtonsCombat[buttonNr]:Hide()
	else
		warnButtonsOOC[buttonNr]:SetText("")
		warnButtonsOOC[buttonNr]:EnableMouse(false)
		warnButtonsOOC[buttonNr]:SetAlpha(0)
		warnButtonsOOC[buttonNr]:Hide()
		warnButtonsCombat[buttonNr]:SetText("")
		warnButtonsCombat[buttonNr]:EnableMouse(false)
		warnButtonsCombat[buttonNr]:Hide()
	end

	if (VanasKoSWarnFrame.db.profile.ShowClassIcons) then
		setButtonClassIcon(buttonNr, nil)
	end
	buttonData[buttonNr] = nil
end

local function HideWarnFrame()
	if(not InCombatLockdown() and warnFrame:IsVisible()) then
		UIFrameFadeOut(warnFrame, 0.1, 1.0, 0.0)
		warnFrame.fadeInfo.finishedFunc = function()
			if(not InCombatLockdown()) then
				warnFrame:Hide()
			end
		end
	end
end

local function ShowWarnFrame()
	if(not InCombatLockdown() and not warnFrame:IsVisible()) then
		warnFrame:Show()
		UIFrameFadeIn(warnFrame, 0.1, 0.0, 1.0)
	end
end

local function UpdateWarnSize()
	local point, _, anchor, xOff, yOff = warnFrame:GetPoint()
	local oldH = warnFrame:GetHeight()
	warnFrame:SetWidth(VanasKoSWarnFrame.db.profile.WARN_FRAME_WIDTH)
	local h = currentButtonCount * VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT +
				VanasKoSWarnFrame.db.profile.WARN_FRAME_HEIGHT_PADDING * 2 + 1
	warnFrame:SetHeight(h)
	if(VanasKoSWarnFrame.db.profile.GrowUp) then
		if (point == "TOPRIGHT" or point == "TOP" or point == "TOPLEFT") then
			warnFrame:ClearAllPoints()
			warnFrame:SetPoint(point, "UIParent", anchor, xOff, yOff + h - oldH)

		elseif (point == "RIGHT" or point == "CENTER" or point == "LEFT") then
			warnFrame:ClearAllPoints()
			warnFrame:SetPoint(point, "UIParent", anchor, xOff, yOff + (h - oldH) / 2)
		end
	else
		if (point == "BOTTOMRIGHT" or point == "BOTTOM" or point == "BOTTOMLEFT") then
			warnFrame:ClearAllPoints()
			warnFrame:SetPoint(point, "UIParent", anchor, xOff, yOff - h + oldH)
		elseif (point == "RIGHT" or point == "CENTER" or point == "LEFT") then
			warnFrame:ClearAllPoints()
			warnFrame:SetPoint(point, "UIParent", anchor, xOff, yOff - (h - oldH) / 2)
		end
	end

	for i=currentButtonCount+1, WARN_BUTTONS_MAX do
		HideButton(i)
	end

	for i=1,WARN_BUTTONS_MAX do
		warnButtonsCombat[i]:SetWidth(VanasKoSWarnFrame.db.profile.WARN_FRAME_WIDTH)
		warnButtonsCombat[i]:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT)
		warnButtonsOOC[i]:SetWidth(VanasKoSWarnFrame.db.profile.WARN_FRAME_WIDTH)
		warnButtonsOOC[i]:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT)
		classIcons[i][1]:SetWidth(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT)
		classIcons[i][1]:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT)
	end
end

function VanasKoSWarnFrame:RegisterConfiguration()
	self.configOptions = {
		type = 'group',
		name = L["Warning Window"],
		desc = L["KoS/Enemy/Friendly Warning Window"],
		childGroups = 'tab',
		args = {
			locked = {
				type = 'toggle',
				name = L["Locked"],
				desc = L["Locked"],
				order = 1,
				set = function(frame, v)
					VanasKoSWarnFrame.db.profile.Locked = v
				end,
				get = function()
					return VanasKoSWarnFrame.db.profile.Locked
				end,
			},
			hideifinactive = {
				type = 'toggle',
				name = L["Hide if inactive"],
				desc = L["Hide if inactive"],
				order = 2,
				set = function(frame, v)
					VanasKoSWarnFrame.db.profile.HideIfInactive = v
					VanasKoSWarnFrame:Update()
				end,
				get = function()
					return VanasKoSWarnFrame.db.profile.HideIfInactive
				end,
			},
			hideifpvpflagoff = {
				type = 'toggle',
				name = L["Hide if PvP flag off"],
				desc = L["Hide if PvP flag off"],
				order = 3,
				set = function(frame, v)
					VanasKoSWarnFrame.db.profile.HideIfPvPOff = v
					VanasKoSWarnFrame:Update()
				end,
				get = function()
					return VanasKoSWarnFrame.db.profile.HideIfPvPOff
				end,
			},
			showBorder = {
				type = 'toggle',
				name = L["Show border"],
				desc = L["Show border"],
				order = 5,
				set = function(frame, v)
					VanasKoSWarnFrame.db.profile.WarnFrameBorder = v
					if (v == true) then
						warnFrame:SetBackdrop( {
							bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
							edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
							insets = { left = 5, right = 4, top = 5, bottom = 5 },
						})
						warnFrame:EnableMouse(true)
					else
						warnFrame:SetBackdrop({bgfile = nil, edgeFile = nil})
						warnFrame:EnableMouse(false)
					end
					VanasKoSWarnFrame:Update()
				end,
				get = function()
					return VanasKoSWarnFrame.db.profile.WarnFrameBorder
				end,
			},
			growUp = {
				type = 'toggle',
				name = L["Grow list upwards"],
				desc = L["Grow list from the bottom of the WarnFrame"],
				order = 6,
				get = function()
					return VanasKoSWarnFrame.db.profile.GrowUp
				end,
				set = function(frame, v)
					VanasKoSWarnFrame.db.profile.GrowUp = v
					VanasKoSWarnFrame:Update()
				end,
			},
			reset = {
				type = 'execute',
				name = L["Reset Position"],
				desc= L["Reset Position"],
				order = 7,
				func = function()
					warnFrame:ClearAllPoints()
					warnFrame:SetPoint("CENTER")
					VanasKoSWarnFrame.db.profile.WARN_FRAME_POINT = nil
					VanasKoSWarnFrame.db.profile.WARN_FRAME_ANCHOR = nil
					VanasKoSWarnFrame.db.profile.WARN_FRAME_XOFF = nil
					VanasKoSWarnFrame.db.profile.WARN_FRAME_YOFF = nil
				end,
			},
			contentGroup = {
				type = 'group',
				name = L["Content"],
				desc = L["What to show in the warning window"],
				order = 8,
				args = {
					setLines = {
						type = 'range',
						name = L["Number of lines"],
						desc = L["Sets the number of entries to display in the Warnframe"],
						order = 1,
						get = function()
							return VanasKoSWarnFrame.db.profile.WARN_BUTTONS
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.WARN_BUTTONS = v
							UpdateWarnSize()
							VanasKoSWarnFrame:Update()
						end,
						min = 1,
						max = WARN_BUTTONS_MAX,
						step = 1,
						isPercent = false,
					},
					dynamicResize = {
						type = 'toggle',
						name = L["Dynamic resize"],
						desc = L["Sets number of entries to display in the WarnFrame based on nearby player count"],
						order = 2,
						get = function()
							return VanasKoSWarnFrame.db.profile.DynamicResize
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.DynamicResize = v
						end
					},
					contentShowLevel = {
						type = 'toggle',
						name = L["Show Target Level When Possible"],
						desc = L["Show Target Level When Possible"],
						order = 3,
						get = function()
							return VanasKoSWarnFrame.db.profile.ShowTargetLevel
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.ShowTargetLevel = v
							VanasKoSWarnFrame:Update()
						end
					},
					contentShowKoS = {
						type = 'toggle',
						name = L["Show KoS Targets"],
						desc = L["Show KoS Targets"],
						order = 4,
						get = function()
							return VanasKoSWarnFrame.db.profile.ShowKoS
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.ShowKoS = v
							VanasKoSWarnFrame:Update()
						end
					},
					contentShowHostile = {
						type = 'toggle',
						name = L["Show Hostile Targets"],
						desc = L["Show Hostile Targets"],
						order = 5,
						get = function()
							return VanasKoSWarnFrame.db.profile.ShowHostile
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.ShowHostile = v
							VanasKoSWarnFrame:Update()
						end
					},
					contentShowFriendly = {
						type = 'toggle',
						name = L["Show Friendly Targets"],
						desc = L["Show Friendly Targets"],
						order = 6,
						get = function()
							return VanasKoSWarnFrame.db.profile.ShowFriendly
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.ShowFriendly = v
							VanasKoSWarnFrame:Update()
						end
					},
					contentShowMouseOverInfos = {
						type = 'toggle',
						name = L["Show additional Information on Mouse Over"],
						desc = L["Toggles the display of additional Information on Mouse Over"],
						order = 7,
						get = function()
							return VanasKoSWarnFrame.db.profile.ShowMouseOverInfos
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.ShowMouseOverInfos = v
							VanasKoSWarnFrame:Update()
						end
					},
					contentShowClassIcons = {
						type = 'toggle',
						name = L["Show class icons"],
						desc = L["Toggles the display of Class icons in the Warnframe"],
						order = 8,
						get = function()
							return VanasKoSWarnFrame.db.profile.ShowClassIcons
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.ShowClassIcons = v
							VanasKoSWarnFrame:Update()
							for i=1,currentButtonCount do
								setButtonClassIcon(i, nil)
								SetFontAlignment(VanasKoSWarnFrame.db.profile.FontAlign)
							end
						end
					},
				},
			},
			designGroup = {
				type = 'group',
				name = L["Design"],
				desc = L["Controls the design of the warning window"],
				order = 9,
				args = {
					fontSize = {
						type = 'range',
						name = L["Font Size"],
						desc = L["Sets the size of the font in the Warnframe"],
						order = 1,
						get = function()
							return VanasKoSWarnFrame.db.profile.FontSize
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.FontSize = v
							CreateWarnFrameFonts(VanasKoSWarnFrame.db.profile.FontSize)
							UpdateWarnSize()
							VanasKoSWarnFrame:Update()
						end,
						min = 6,
						max = 20,
						step = 1,
						isPercent = false,
					},
					fontAlign = {
						type = 'select',
						name = L["Alignment"],
						desc = L["Sets warnframe font alignment"],
						order = 2,
						values = {L["LEFT"], L["CENTER"], L["RIGHT"]},
						set = function(frame, v)
								local align
								if (v == 1) then
									align = "LEFT"
								elseif (v == 3) then
									align = "RIGHT"
								else
									align = "CENTER"
								end
								VanasKoSWarnFrame.db.profile.FontAlign = align
								SetFontAlignment(align)
							end,
						get = function()
								local align = VanasKoSWarnFrame.db.profile.FontAlign
								if align == "LEFT" then
									return 1
								elseif align == "RIGHT" then
									return 3
								else
									return 2
								end
							end
					},
					kos = {
						type = 'group',
						name = L["KoS"],
						desc = L["How kos content is shown"],
						order = 3,
						args = {
							designMoreKoSBackgroundColor = {
								type = 'color',
								name = L["Background Color"],
								desc = L["Sets the KoS majority Color and Opacity"],
								order = 1,
								get = function()
									return GetColor("MoreKoSBGColor")
								end,
								set = function(frame, r, g, b, a)
									SetBgColor("MoreKoSBGColor", r, g, b, a)
								end,
								hasAlpha = true
							},
							kosTextColor = {
								type = 'color',
								name = L["Text"],
								desc = L["Sets the normal text color"],
								order = 2,
								get = function()
									return GetColor("KoSTextColor")
								end,
								set = function(frame, r, g, b)
									SetTextColor("KoSTextColor", r, g, b, 1.0)
								end,
								hasAlpha = false,
							},
							kosRemoveDelay = {
								type = 'range',
								name = L["Remove delay"],
								desc = L["Sets the number of seconds before entry is removed"],
								order = 3,
								get = function()
									return VanasKoSWarnFrame.db.profile.KoSRemoveDelay
								end,
								set = function(frame, v)
									VanasKoSWarnFrame.db.profile.KoSRemoveDelay = v
									VanasKoSWarnFrame:Update()
								end,
								min = 5,
								max = 300,
								step = 5,
								isPercent = false,
							},
							designKoSReset = {
								type = 'execute',
								name = L["Reset"],
								desc = L["Reset Settings"],
								order = 4,
								func = function()
									SetBgColor("MoreKoSBGColor", 1.0, 0.0, 0.0, 0.5)
									SetTextColor("KoSTextColor", 1.0, 0.82, 0.0)
									VanasKoSWarnFrame.db.profile.KoSRemoveDelay = 60
									VanasKoSWarnFrame:Update()
								end,
							},
						},
					},
					hostile = {
						type = 'group',
						name = L["Hostile"],
						desc = L["How hostile content is shown"],
						order = 4,
						args = {
							designMoreHostilesBackdropBackgroundColor = {
								type = 'color',
								name = L["Background"],
								desc = L["Sets the more Hostiles than Allied Background Color and Opacity"],
								order = 1,
								get = function()
									return GetColor("MoreHostileBGColor")
								end,
								set = function(frame, r, g, b, a)
									SetBgColor("MoreHostileBGColor", r, g, b, a)
								end,
								hasAlpha = true
							},
							enemyTextColor = {
								type = 'color',
								name = L["Text"],
								desc = L["Sets the normal text color"],
								order = 2,
								get = function()
									return GetColor("EnemyTextColor")
								end,
								set = function(frame, r, g, b)
									SetTextColor("EnemyTextColor", r, g, b, 1.0)
								end,
								hasAlpha = false,
							},
							enemyRemoveDelay = {
								type = 'range',
								name = L["Remove delay"],
								desc = L["Sets the number of seconds before entry is removed"],
								order = 3,
								get = function()
									return VanasKoSWarnFrame.db.profile.EnemyRemoveDelay
								end,
								set = function(frame, v)
									VanasKoSWarnFrame.db.profile.EnemyRemoveDelay = v
									VanasKoSWarnFrame:Update()
								end,
								min = 5,
								max = 300,
								step = 5,
								isPercent = false,
							},
							designEnemyReset = {
								type = 'execute',
								name = L["Reset"],
								desc = L["Reset Settings"],
								order = 4,
								func = function()
									SetBgColor("MoreHostileBGColor", 1.0, 0.0, 0.0, 0.5)
									SetTextColor("EnemyTextColor", 0.9, 0.0, 0.0)
									VanasKoSWarnFrame.db.profile.EnemyRemoveDelay = 10
									VanasKoSWarnFrame:Update()
								end,
							},
						},
					},
					friendly = {
						type = 'group',
						name = L["Friendly"],
						desc = L["How friendly content is shown"],
						order = 5,
						args = {
							designMoreAlliedBackdropBackgroundColor = {
								type = 'color',
								name = L["Background Color"],
								desc = L["Sets the more Allied than Hostiles Background Color and Opacity"],
								order = 1,
								get = function()
									return GetColor("MoreAlliedBGColor")
								end,
								set = function(frame, r, g, b, a)
									SetBgColor("MoreAlliedBGColor", r, g, b, a)
								end,
								hasAlpha = true
							},
							frendlyTextColor = {
								type = 'color',
								name = L["Text"],
								desc = L["Sets the normal text color"],
								order = 2,
								get = function()
									return GetColor("FriendlyTextColor")
								end,
								set = function(frame, r, g, b)
									SetTextColor("FriendlyTextColor", r, g, b, 1.0)
								end,
								hasAlpha = false,
							},
							friendlyRemoveDelay = {
								type = 'range',
								name = L["Remove delay"],
								desc = L["Sets the number of seconds before entry is removed"],
								order = 3,
								get = function()
									return VanasKoSWarnFrame.db.profile.FriendlyRemoveDelay
								end,
								set = function(frame, v)
									VanasKoSWarnFrame.db.profile.FriendlyRemoveDelay = v
									VanasKoSWarnFrame:Update()
								end,
								min = 5,
								max = 300,
								step = 5,
								isPercent = false,
							},
							designFriendlyReset = {
								type = 'execute',
								name = L["Reset"],
								desc = L["Reset Settings"],
								order = 4,
								func = function()
									SetBgColor("MoreAlliedBGColor", 0.0, 1.0, 0.0, 0.5)
									SetTextColor("FriendlyTextColor", 0.0, 1.0, 0.0)
									VanasKoSWarnFrame.db.profile.FriendlyRemoveDelay = 10
									VanasKoSWarnFrame:Update()
								end,
							},
						},
					},
					neutral = {
						type = 'group',
						name = L["Neutral"],
						desc = L["How neutral content is shown"],
						order = 6,
						args = {
							designDefaultBackdropBackgroundColor = {
								type = 'color',
								name = L["Background"],
								desc = L["Sets the default Background Color and Opacity"],
								order = 1,
								get = function()
									return GetColor("DefaultBGColor")
								end,
								set = function(frame, r, g, b, a)
									SetBgColor("DefaultBGColor", r, g, b, a)
								end,
								hasAlpha = true,
							},
							normalTextColor = {
								type = 'color',
								name = L["Text"],
								desc = L["Sets the normal text color"],
								order = 2,
								get = function()
									return GetColor("NormalTextColor")
								end,
								set = function(frame, r, g, b)
									SetTextColor("NormalTextColor", r, g, b, 1.0)
								end,
								hasAlpha = false,
							},
							designNormalReset = {
								type = 'execute',
								name = L["Reset"],
								desc = L["Reset Settings"],
								order = 4,
								func = function()
									SetBgColor("DefaultBGColor", 0.5, 0.5, 1.0, 0.5)
									SetTextColor("NormalTextColor", 1.0, 1.0, 1.0)
								end,
							},
						},
					},
				},
			},
			macroGroup = {
				type = 'group',
				name = L["Macro"],
				desc = L["Macro to execute on click"],
				order = 10,
				args = {
					macroInfo = {
						type = 'description',
						name = L["Sets the text of the macro to be executed when a name is clicked. An example can be found in the macros.txt file"],
						order = 1,
					},
					macroText = {
						type ='input',
						name = L["Macro Text"],
						multiline = 8,
						order = 2,
						width = "full",
						get = function()
							return VanasKoSWarnFrame.db.profile.MacroText
						end,
						set = function(frame, text)
							VanasKoSWarnFrame.db.profile.MacroText = text
							VanasKoSWarnFrame:Update()
						end,
					},
					macroReset = {
						type = 'execute',
						name = L["Reset"],
						desc = L["Reset macro to default"],
						order = 3,
						func = function()
							self.db.profile.MacroText = "/targetexact ${name}"
						end,
					},
				},
			},
			zoneGroup = {
				type = 'group',
				name = L["Zones"],
				desc = L["Zones to show the warning window in"],
				order = 11,
				args = {
					showInBattleground = {
						type = 'toggle',
						name = L["Battlegrounds"],
						desc = L["Show in battlegrounds and pvp zones"],
						order = 1,
						get = function()
							return not VanasKoSWarnFrame.db.profile.hideInBg
						end,
						set = function(frame, v)
							local hide = not v
							VanasKoSWarnFrame.db.profile.hideInBg = hide
							VanasKoSWarnFrame:ZoneChanged()
						end
					},
					showInInstance = {
						type = 'toggle',
						name = L["Dungeon"],
						desc = L["Show in dungeon instances"],
						order = 2,
						get = function()
							return not VanasKoSWarnFrame.db.profile.hideInInstance
						end,
						set = function(frame, v)
							local hide = not v
							VanasKoSWarnFrame.db.profile.hideInInstance = hide
							VanasKoSWarnFrame:ZoneChanged()
						end
					},
					showInArenas = {
						type = 'toggle',
						name = L["Arena"],
						desc = L["Show in arenas"],
						order = 3,
						get = function()
							return VanasKoSWarnFrame.db.profile.showInArena
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.showInArena = v
							VanasKoSWarnFrame:ZoneChanged()
						end
					},
					showInCities = {
						type = 'toggle',
						name = L["Cities"],
						desc = L["Show in cities"],
						order = 3,
						get = function()
							return VanasKoSWarnFrame.db.profile.showInCity
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.showInCity = v
							VanasKoSWarnFrame:ZoneChanged()
						end
					},
					showInSanctuaries = {
						type = 'toggle',
						name = L["Sanctuaries"],
						desc = L["Show in sanctuaries"],
						order = 3,
						get = function()
							return VanasKoSWarnFrame.db.profile.showInSanctuary
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.showInSanctuary = v
							VanasKoSWarnFrame:ZoneChanged()
						end
					},
					showInCombatZone = {
						type = 'toggle',
						name = L["Combat Zones"],
						desc = L["Show in combat zones"],
						order = 3,
						get = function()
							return VanasKoSWarnFrame.db.profile.showInCombatZone
						end,
						set = function(frame, v)
							VanasKoSWarnFrame.db.profile.showInCombatZone = v
							VanasKoSWarnFrame:ZoneChanged()
						end
					},
				},
			},
		},
	}

	VanasKoSGUI:AddModuleToggle("WarnFrame", L["Warning Window"])
	VanasKoSGUI:AddConfigOption("WarnFrame", self.configOptions)
end

function VanasKoSWarnFrame:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("WarnFrame", {
		profile = {
			Enabled = true,
			HideIfInactive = false,
			HideIfPvPOff = true,
			Locked = false,
			WarnFrameBorder = true,

			ShowTargetLevel = true,
			ShowKoS = true,
			ShowHostile = true,
			ShowFriendly = true,
			ShowMouseOverInfos = true,
			ShowClassIcons = true,
			GrowUp = false,

			DefaultBGColorR = 0.5,
			DefaultBGColorG = 0.5,
			DefaultBGColorB = 1.0,
			DefaultBGColorA = 0.5,

			MoreHostileBGColorR = 1.0,
			MoreHostileBGColorG = 0.0,
			MoreHostileBGColorB = 0.0,
			MoreHostileBGColorA = 0.5,

			MoreAlliedBGColorR = 0.0,
			MoreAlliedBGColorG = 1.0,
			MoreAlliedBGColorB = 0.0,
			MoreAlliedBGColorA = 0.5,

			MoreKoSBGColorR = 1.0,
			MoreKoSBGColorG = 0.0,
			MoreKoSBGColorB = 0.0,
			MoreKoSBGColorA = 0.5,

			EnemyTextColorR = 0.9,
			EnemyTextColorG = 0.0,
			EnemyTextColorB = 0.0,

			FriendlyTextColorR = 0.0,
			FriendlyTextColorG = 1.0,
			FriendlyTextColorB = 0.0,

			KoSTextColorR = 1.0,
			KoSTextColorG = 0.82,
			KoSTextColorB = 0.0,

			NormalTextColorR = 1.0,
			NormalTextColorG = 1.0,
			NormalTextColorB = 1.0,

			FriendlyRemoveDelay = 10,
			EnemyRemoveDelay = 10,
			KoSRemoveDelay = 60,

			hideInBg  = true,
			hideInInstance = true,
			showInArena = false,
			showInCombatZone = false,
			showInCity = false,
			showInSanctuary = false,

			FontSize = 10,
			FontAlign = "CENTER",
			WARN_FRAME_WIDTH = 130,
			WARN_FRAME_WIDTH_PADDING = 5,
			WARN_FRAME_WIDTH_EMPTY = 130,
			WARN_FRAME_HEIGHT_PADDING = 5,
			WARN_FRAME_HEIGHT_EMPTY = 5,

			WARN_TOOLTIP_HEIGHT = 24,

			WARN_BUTTON_HEIGHT = 16,
			WARN_BUTTONS = 5,

			MacroText = "/targetexact ${name}",
		}
	})

	nearbyKoS = {}
	nearbyEnemy = {}
	nearbyFriendly = {}
	dataCache = {}
	buttonData = {}

	CreateWarnFrame()
	self:RegisterConfiguration()

	self:SetEnabledState(self.db.profile.Enabled)
	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
end

function VanasKoSWarnFrame:OnEnable()
	CreateOOCButtons()
	CreateCombatButtons()
	CreateClassIcons()
	CreateWarnFrameFonts(self.db.profile.FontSize)
	warnFrame:SetAlpha(1)
	SetProperties(warnFrame, VanasKoSWarnFrame.db.profile)
	self:Update()

	self:RegisterMessage("VanasKoS_Zone_Changed", "ZoneChanged")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_DEAD")
	self:RegisterEvent("UNIT_FACTION")

	self:ZoneChanged()
end

function VanasKoSWarnFrame:OnDisable()
	self:EnablePlayerDetectEvent(false)
	self:UnregisterAllEvents()
	self:CancelAllTimers()
	timer = nil

	currentButtonCount = 0
	wipe(nearbyKoS)
	nearbyKoSCount = 0
	wipe(nearbyEnemy)
	nearbyEnemyCount = 0
	wipe(nearbyFriendly)
	nearbyFriendlyCount = 0
	wipe(dataCache)
	wipe(buttonData)

	HideWarnFrame()
end

function VanasKoSWarnFrame:RefreshConfig()
	SetProperties(warnFrame, self.db.profile)
	CreateWarnFrameFonts(VanasKoSWarnFrame.db.profile.FontSize)
	UpdateWarnSize()
	self:Update()
end

function VanasKoSWarnFrame:PLAYER_REGEN_ENABLED() -- event, ...
	self:Update()
end

function VanasKoSWarnFrame:PLAYER_REGEN_DISABLED() -- event, ...
	self:Update()
end

function VanasKoSWarnFrame:PLAYER_DEAD() -- event, ...
	self:Update()
end

function VanasKoSWarnFrame:UNIT_FACTION(...)
	local unit = select(2, ...)
	if unit == "player" then
		self:Update()
	end
end

local function RemovePlayer(key)
	if(nearbyKoS[key]) then
		nearbyKoS[key] = nil
		nearbyKoSCount = nearbyKoSCount - 1
	end

	if(nearbyEnemy[key]) then
		nearbyEnemy[key] = nil
		nearbyEnemyCount = nearbyEnemyCount - 1
	end

	if(nearbyFriendly[key]) then
		nearbyFriendly[key] = nil
		nearbyFriendlyCount = nearbyFriendlyCount - 1
	end

	if(dataCache[key]) then
		wipe(dataCache[key])
		dataCache[key] = nil
	end
end

function VanasKoSWarnFrame:UpdateList()
	local t = time()
	for k, v in pairs(nearbyKoS) do
		if(t-v > self.db.profile.KoSRemoveDelay) then
			RemovePlayer(k)
		end
	end
	for k, v in pairs(nearbyEnemy) do
		if(t-v > self.db.profile.EnemyRemoveDelay) then
			RemovePlayer(k)
		end
	end
	for k, v in pairs(nearbyFriendly) do
		if(t-v > self.db.profile.FriendlyRemoveDelay) then
			RemovePlayer(k)
		end
	end

	VanasKoSWarnFrame:Update()
end


-- /Script VanasKoSWarnFrame:Player_Detected("xxx", nil, "enemy") VanasKoSWarnFrame:Player_Detected("xxx2", nil, "enemy");
-- /script local x = {  ['name'] = 'x', ['faction'] = 'enemy', ['class'] = 'Poser',  ['race'] = 'GM', ['level'] = "31336"}  for i=1,10000 do x.name = "xxx" .. math.random(1, 1000); VanasKoSWarnFrame:Player_Detected("VanasKoS_Player_Detected", x); end
local UNKNOWNLOWERCASE = UNKNOWN:lower()


function VanasKoSWarnFrame:Player_Detected(message, data)
	if(not self.db.profile.Enabled) then
		return
	end

	assert(data.name ~= nil)

	local key = data.name
	local faction = data.faction
	if data.list == "PLAYERKOS" or data.list == "GUILDKOS" then
		faction = "kos"
	end

	-- exclude unknown entitity entries
	if(key == UNKNOWNLOWERCASE) then
		return
	end

	if(faction == "kos" and self.db.profile.ShowKoS) then
		if(not nearbyKoS[key]) then
			nearbyKoSCount = nearbyKoSCount + 1
		end
		nearbyKoS[key] = time()
	elseif(faction == "enemy" and self.db.profile.ShowHostile) then
		if(not nearbyEnemy[key]) then
			nearbyEnemyCount = nearbyEnemyCount + 1
		end
		nearbyEnemy[key] = time()
	elseif(faction == "friendly" and self.db.profile.ShowFriendly) then
		if(not nearbyFriendly[key]) then
			nearbyFriendlyCount = nearbyFriendlyCount + 1
		end
		nearbyFriendly[key] = time()
	else
		return
	end

	if (not dataCache[key]) then
		dataCache[key] = {}
	end
	dataCache[key].name = data.name
	dataCache[key].guild = data.guild
	dataCache[key].guildrank = data.guildrank
	dataCache[key].class = data.class
	dataCache[key].classEnglish = data.classEnglish
	dataCache[key].race = data.race
	dataCache[key].gender = data.gender
	dataCache[key].faction = faction
	dataCache[key].level = data.level
	dataCache[key].guid = data.guid
	dataCache[key].reason = data.reason
	dataCache[key].owner = data.owner

	self:Update()
end

function VanasKoSWarnFrame:EnablePlayerDetectEvent(enable)
	if (enable and (not playerDetectEventEnabled)) then
		self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected")
		playerDetectEventEnabled = true
	elseif ((not enable) and playerDetectEventEnabled) then
		self:UnregisterMessage("VanasKoS_Player_Detected")
		playerDetectEventEnabled = false
	end
end

function VanasKoSWarnFrame:ZoneChanged(message)
	local hideFrame = (self.db.profile.hideInBg and VanasKoS:IsInBattleground()) or
			  (self.db.profile.hideInInstance and VanasKoS:IsInDungeon()) or
			  (not self.db.profile.showInArena and VanasKoS:IsInArena()) or
			  (not self.db.profile.showInCombatZone and VanasKoS:IsInCombatZone()) or
			  (not self.db.profile.showInCity and VanasKoS:IsInCity()) or
			  (not self.db.profile.showInSanctuary and VanasKoS:IsInSanctuary())
	if (hideFrame) then
		HideWarnFrame()
		if (timer) then
			self:CancelTimer(timer)
			timer = nil
		end
		self:EnablePlayerDetectEvent(false)
	else
		if (not timer) then
			timer = self:ScheduleRepeatingTimer("UpdateList", 1)
		end
		self:EnablePlayerDetectEvent(true)
	end

end

local function GetButtonText(key, data)
	assert(data.name)
	local result = data.name

	if(VanasKoSWarnFrame.db.profile.ShowTargetLevel) then
		local level = nil

		-- If there is a player level coming in, record it.
		if (data and data.level and data.level ~= "") then
			level = data.level
			if (tonumber(level) == -1) then
				level = "??"
			end
		else
			local pdata = VanasKoS:GetPlayerData(key)
			if (pdata and pdata.level) then
				level = pdata.level
			end
		end


		-- If we have a level, append it.
		if (level) then
			result = result .. " [" .. tostring(level) .. "]"
		end

		-- TODO: lookup in last seen list
	end

	return result
end

local function GetFactionFont(faction)
	if(faction == "kos") then
		return "VanasKoS_FontKos"
	elseif(faction == "enemy") then
		return "VanasKoS_FontEnemy"
	elseif(faction == "friendly") then
		return "VanasKoS_FontFriendly"
	end

	return "VanasKoS_FontNormal"
end

local function SetButton(buttonNr, key, faction, data)
	-- Sometimes when changing zones GetBestMapForUnit can return nil
	local mapId = C_Map.GetBestMapForUnit("player")
	local pos = mapId and C_Map.GetPlayerMapPosition(mapId, "player")
	local zx, zy
	if pos then
		zx, zy = pos:GetXY()
	end

	local align = VanasKoSWarnFrame.db.profile.FontAlign
	if(InCombatLockdown()) then
		if(buttonData[buttonNr] ~= key) then
			-- new data for the button, we have to do something
			if(warnButtonsOOC[buttonNr]:GetAlpha() > 0) then
				-- ooc button visible
				warnButtonsOOC[buttonNr]:SetAlpha(0)
			end

			warnButtonsCombat[buttonNr]:SetNormalFontObject(GetFactionFont(faction))
			warnButtonsCombat[buttonNr]:SetText(GetButtonText(key, data))
			UpdateButtonAlignment(buttonNr, align)
			warnButtonsCombat[buttonNr]:Show()
		else
			warnButtonsOOC[buttonNr]:SetText(GetButtonText(key, data))
			warnButtonsCombat[buttonNr]:SetText(GetButtonText(key, data))
		end
	else
		if(buttonData[buttonNr] ~= key or warnButtonsOOC[buttonNr]:GetAlpha() == 0) then
			warnButtonsOOC[buttonNr]:SetAlpha(1)
			warnButtonsCombat[buttonNr]:Hide()
			warnButtonsOOC[buttonNr]:SetNormalFontObject(GetFactionFont(faction))
			warnButtonsOOC[buttonNr]:SetText(GetButtonText(key, data))
			warnButtonsOOC[buttonNr]:EnableMouse(true)
			local macroText = VanasKoSWarnFrame.db.profile.MacroText
			macroText = macroText:gsub("${class}", (data and data.class) or "")
			macroText = macroText:gsub("${classEnglish}", (data and data.classEnglish) or "")
			macroText = macroText:gsub("${race}", (data and data.race) or "")
			macroText = macroText:gsub("${guild}", (data and data.guild) or "")
			macroText = macroText:gsub("${guildRank}", (data and data.guildRank) or "")
			macroText = macroText:gsub("${level}", (data and data.level) or "")
			macroText = macroText:gsub("${shortname}", data.name)
			macroText = macroText:gsub("${name}", key)
			macroText = macroText:gsub("${gender}", (data and data.gender) or "")
			macroText = macroText:gsub("${genderText}", data and (data.gender == 2 and L["male"]) or (data.gender == 3 and L["female"]) or "")
			macroText = macroText:gsub("${zoneX}", zx and floor(zx * 100 + 0.5) or "")
			macroText = macroText:gsub("${zoneY}", zy and floor(zy * 100 + 0.5) or "")
			macroText = macroText:gsub("${zone}", GetZoneText())
			warnButtonsOOC[buttonNr]:SetAttribute("macrotext", macroText)
			UpdateButtonAlignment(buttonNr, align)
			warnButtonsOOC[buttonNr]:Show()
		else
			warnButtonsOOC[buttonNr]:SetText(GetButtonText(key, data))
		end
	end

	buttonData[buttonNr] = key
end

function VanasKoSWarnFrame:Update()
	local newButtonCount
	if(VanasKoSWarnFrame.db.profile.DynamicResize) then
		newButtonCount = nearbyKoSCount + nearbyEnemyCount + nearbyFriendlyCount + 1
		if(newButtonCount > WARN_BUTTONS_MAX) then
			newButtonCount = WARN_BUTTONS_MAX
		end
	else
		newButtonCount = VanasKoSWarnFrame.db.profile.WARN_BUTTONS
	end

	if (newButtonCount ~= currentButtonCount and not InCombatLockdown()) then
		currentButtonCount = newButtonCount
		UpdateWarnSize()
	end

	if(InCombatLockdown()) then
		warnFrame:SetBackdropBorderColor(1.0, 0.0, 0.0)
	else
		warnFrame:SetBackdropBorderColor(0.8, 0.8, 0.8)
	end

	-- more hostile
	if( (nearbyKoSCount+nearbyEnemyCount) > (nearbyFriendlyCount)) then
		if (nearbyKoSCount > nearbyEnemyCount) then
			local r, g, b, a = GetColor("MoreKoSBGColor")
			warnFrame:SetBackdropColor(r, g, b, a)
		else
			local r, g, b, a = GetColor("MoreHostileBGColor")
			warnFrame:SetBackdropColor(r, g, b, a)
		end
	-- more allied
	elseif( (nearbyKoSCount+nearbyEnemyCount) < (nearbyFriendlyCount)) then
		local r, g, b, a = GetColor("MoreAlliedBGColor")
		warnFrame:SetBackdropColor(r, g, b, a)
	-- default
	else
		local r, g, b, a = GetColor("DefaultBGColor")
		warnFrame:SetBackdropColor(r, g, b, a)
	end

	local counter = 0
	if(self.db.profile.GrowUp) then
		counter = currentButtonCount - 1
	end
	if(self.db.profile.ShowKoS) then
		for k, _ in pairs(nearbyKoS) do
			if(counter < currentButtonCount and counter >= 0) then
				SetButton(counter+1, k, "kos", dataCache[k])
				if(self.db.profile.ShowClassIcons) then
					setButtonClassIcon(counter + 1, dataCache[k] and dataCache[k].classEnglish)
				end
			end

			if (self.db.profile.GrowUp == true) then
				counter = counter - 1
			else
				counter = counter + 1
			end
		end
	end

	if(self.db.profile.ShowHostile) then
		for k, _ in pairs(nearbyEnemy) do
			if(counter < currentButtonCount and counter >= 0) then
				SetButton(counter+1, k, "enemy", dataCache[k])
				if(self.db.profile.ShowClassIcons) then
					setButtonClassIcon(counter + 1, dataCache[k] and dataCache[k].classEnglish)
				end
			end

			if (self.db.profile.GrowUp == true) then
				counter = counter - 1
			else
				counter = counter + 1
			end
		end
	end

	if(self.db.profile.ShowFriendly) then
		for k, _ in pairs(nearbyFriendly) do
			if(counter < currentButtonCount and counter >= 0) then
				SetButton(counter+1, k, "friendly", dataCache[k])
				if(self.db.profile.ShowClassIcons) then
					setButtonClassIcon(counter + 1, dataCache[k] and dataCache[k].classEnglish)
				end
			end

			if (self.db.profile.GrowUp == true) then
				counter = counter - 1
			else
				counter = counter + 1
			end
		end
	end

	for i=0,currentButtonCount-1 do
		if ((i <= counter and self.db.profile.GrowUp == true) or
			(i >= counter and self.db.profile.GrowUp == false)) then
			HideButton(i+1)
		end
	end

	-- show or hide/fade frame according to settings
	if(self.db.profile.Enabled) then
		if(self.db.profile.hideInBg and VanasKoS:IsInBattleground()) then
			HideWarnFrame()
		elseif(self.db.profile.hideInInstance and VanasKoS:IsInDungeon()) then
			HideWarnFrame()
		elseif(self.db.profile.HideIfPvPOff and not UnitIsPVP("player")) then
			HideWarnFrame()
		elseif(self.db.profile.HideIfInactive) then
			if((counter > 0 and self.db.profile.GrowUp == false) or (counter < (currentButtonCount - 1) and self.db.profile.GrowUp == true)) then
				ShowWarnFrame()
			else
				HideWarnFrame()
			end
		else
			ShowWarnFrame()
		end
	else
		HideWarnFrame()
	end
end
