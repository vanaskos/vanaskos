--[[----------------------------------------------------------------------
      Notifier Module - Part of VanasKoS
Notifies the user via Tooltip, Chat and Upper Area of a KoS/other List Target
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/Notifier", false)
local SML = LibStub("LibSharedMedia-3.0")
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")
local VanasKoSGUI = VanasKoS:GetModule("GUI")
local VanasKoSNotifier = VanasKoS:NewModule("Notifier", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")

-- Declare some common global functions local
local pairs = pairs
local assert = assert
local tonumber = tonumber
local min = min
local format = format
local wipe = wipe
local getglobal = getglobal
local GetPartyMember = GetPartyMember
local GetGuildInfo = GetGuildInfo
local GetRaidRosterInfo = GetRaidRosterInfo
local UnitName = UnitName
local UnitInRaid = UnitInRaid
local UnitIsPlayer = UnitIsPlayer
local PlaySoundFile = PlaySoundFile

-- Constants
local FADE_IN_TIME = 0.2
local FADE_OUT_TIME = 0.2
local FLASH_TIMES = 1

-- Local Variables
local flasher = nil
local flashNotifyFrame = nil
local flashNotifyTexture = nil
local reasonFrame = nil
local playerDetectEventEnabled = false
local reenableTimer = nil
local mediaList = {}
local partyEventsEnabled = false
local lastPartyUpdate = {}
local listsToCheck = {
	PLAYERKOS = {
		L["KoS: %s"], L["%sKoS: %s"]
	},
	GUILDKOS = {
		L["KoS (Guild): %s"], L["%sKoS (Guild): %s"]
	},
	NICELIST = {
		L["Nicelist: %s"], L["%sNicelist: %s"]
	},
	HATELIST = {
		L["Hatelist: %s"], L["%sHatelist: %s"]
	},
	WANTED = {
		L["Wanted: %s"], L["%sWanted: %s"]
	},
}


-- Register our sounds
SML:Register("sound", "VanasKoS: String fading", "Interface\\AddOns\\VanasKoS\\Artwork\\StringFading.mp3")
SML:Register("sound", "VanasKoS: Zoidbergs whooping", "Interface\\AddOns\\VanasKoS\\Artwork\\Zoidberg-Whoopwhoopwhoop.mp3")
SML:Register("sound", "VanasKoS: Extreme alarm", "Interface\\AddOns\\VanasKoS\\Artwork\\extreme_alarm.mp3")
SML:Register("sound", "VanasKoS: Hell's bell", "Interface\\AddOns\\VanasKoS\\Artwork\\hell_bell.mp3")
SML:Register("sound", "VanasKoS: Glockenspiel", "Interface\\AddOns\\VanasKoS\\Artwork\\glock_N_kloing.mp3")

local function SetProperties(self, profile)
	if(self == nil) then
		return
	end

	if(profile.WARN_FRAME_POINT) then
		self:ClearAllPoints()
		self:SetPoint(profile.REASON_FRAME_POINT,
					"UIParent",
					profile.REASON_FRAME_ANCHOR,
					profile.REASON_FRAME_XOFF,
					profile.REASON_FRAME_XOFF)
	else
		self:SetPoint("CENTER")
	end

	if (profile.notifyExtraReasonFrameLocked) then
		self:EnableMouse(false)
	else
		self:EnableMouse(true)
	end

	if (profile.notifyExtraReasonFrameEnabled) then
		self:Show()
	else
		self:Hide()
	end
end

function VanasKoSNotifier:CreateReasonFrame()
	reasonFrame = CreateFrame("Frame", "VanasKoS_Notifier_ReasonFrame", UIParent)
	reasonFrame:SetMovable(true)
	reasonFrame:SetToplevel(true)

	reasonFrame:SetWidth(300)
	reasonFrame:SetHeight(13)
	reasonFrame:SetPoint("CENTER")

	reasonFrame.background = reasonFrame:CreateTexture("VanasKoS_Notifier_ReasonFrame_Background", "BACKGROUND")
	reasonFrame.background:SetAllPoints()
	reasonFrame.background:SetTexture(1.0, 1.0, 1.0, 0.5)

	reasonFrame.text = reasonFrame:CreateFontString("VanasKoS_Notifier_ReasonFrame_Text", "OVERLAY")
	-- only set the left point, so texts longer than reasonFrame:GetWidth() will show
	reasonFrame.text:SetPoint("LEFT", reasonFrame, "LEFT", 0, 0)
	reasonFrame.text:SetJustifyH("LEFT")
	reasonFrame.text:SetFontObject("GameFontNormalSmall")
	reasonFrame.text:SetTextColor(1.0, 0.0, 1.0)

	reasonFrame.background:SetAlpha(0.0)

	-- allow dragging the window
	reasonFrame:RegisterForDrag("LeftButton")
	reasonFrame:SetScript("OnDragStart", function()
		reasonFrame:StartMoving()
	end)
	reasonFrame:SetScript("OnDragStop", function()
		reasonFrame:StopMovingOrSizing()
		local point, _, anchor, xOff, yOff = reasonFrame:GetPoint()
		VanasKoSNotifier.db.profile.REASON_FRAME_POINT = point
		VanasKoSNotifier.db.profile.REASON_FRAME_ANCHOR = anchor
		VanasKoSNotifier.db.profile.REASON_FRAME_XOFF = xOff
		VanasKoSNotifier.db.profile.REASON_FRAME_YOFF = yOff
	end)

	SetProperties(reasonFrame, self.db.profile)
end

function VanasKoSNotifier:EnableReasonFrame(enable)
	self.db.profile.notifyExtraReasonFrameEnabled = enable
	if (enable) then
		reasonFrame:Show()
	else
		reasonFrame:Hide()
	end
end

function VanasKoSNotifier:LockReasonFrame(lock)
	self.db.profile.notifyExtraReasonFrameLocked = lock
	if (lock) then
		reasonFrame:EnableMouse(false)
	else
		reasonFrame:EnableMouse(true)
	end
end

function VanasKoSNotifier:ShowAnchorReasonFrame(show)
	reasonFrame.showanchor = show
	if (show) then
		reasonFrame.background:SetAlpha(1.0)
		reasonFrame.text:SetText(self:GetKoSString(nil, "Guild", "MyReason", UnitName("player"), nil, "GuildKoS Reason", UnitName("player"), nil))
	else
		reasonFrame.background:SetAlpha(0.0)
		reasonFrame.text:SetText("")
	end
end

local function SetSound(faction, value)
	if (faction == "enemy") then
		VanasKoSNotifier.db.profile.enemyPlayName = value
	elseif (faction == "hate") then
		VanasKoSNotifier.db.profile.hatePlayName = value
	elseif (faction == "nice") then
		VanasKoSNotifier.db.profile.nicePlayName = value
	elseif (faction == "kos") then
		VanasKoSNotifier.db.profile.playName = value
	end

	VanasKoSNotifier:PlaySound(value)
end

local function GetSound(faction)
	if (faction == "enemy") then
		return VanasKoSNotifier.db.profile.enemyPlayName
	elseif (faction == "hate") then
		return VanasKoSNotifier.db.profile.hatePlayName
	elseif (faction == "nice") then
		return VanasKoSNotifier.db.profile.nicePlayName
	elseif(faction == "kos") then
		return VanasKoSNotifier.db.profile.playName
	end
end

local function GetMediaList()
	for _, v in pairs(SML:List("sound")) do
		mediaList[v] = v
	end

	return mediaList
end

function VanasKoSNotifier:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("Notifier", {
		profile = {
			Enabled = true,
			notifyVisual = true,
			notifyChatframe = true,
			notifyTargetFrame = true,
			notifyOnlyMyTargets = true,
			notifyEnemyTargets = false,
			notifyParty = true,
			notifyFlashingBorder = true,
			notifyInShattrathEnabled = false,
			notifyInCitiesEnabled = false,
			notifyInBattlegroundEnabled = false,
			notifyInArenaEnabled = false,
			notifyInCombatZoneEnabled = false,
			notifyExtraReasonFrameEnabled = false,
			notifyExtraReasonFrameLocked = false,
			notifyShowPvPStats = true,
			friendlist = true,
			ignorelist = true,

			NotifyTimerInterval = 60,

			playName = "VanasKoS: String fading",
			enemyPlayName = "None",
			hatePlayName = "VanasKoS: Hell's bell",
			nicePlayName = "VanasKoS: Glockenspiel",
		}
	})

	flashNotifyFrame = CreateFrame("Frame", "VanasKoS_Notifier_Frame", WorldFrame)
	flashNotifyFrame:SetAllPoints()
	flashNotifyFrame:SetToplevel(1)
	flashNotifyFrame:SetAlpha(0)

	flashNotifyTexture = flashNotifyFrame:CreateTexture(nil, "BACKGROUND")
	flashNotifyTexture:SetTexture("Interface\\AddOns\\VanasKoS\\Artwork\\KoSFrame")

	flashNotifyTexture:SetBlendMode("ADD")
	-- important! gets set in the blizzard xml stuff implicit, while we have to do it explicit with .lua
	flashNotifyTexture:SetAllPoints()
	flashNotifyFrame:Hide()

	flasher = flashNotifyFrame:CreateAnimationGroup()
	local fade1 = flasher:CreateAnimation("Alpha")
	fade1:SetDuration(0.5)
	fade1:SetFromAlpha(0)
	fade1:SetToAlpha(1)

	local fade2 = flasher:CreateAnimation("Alpha")
	fade2:SetDuration(0.5)
	fade1:SetFromAlpha(1)
	fade1:SetToAlpha(0)
	fade2:SetOrder(2)

	self:CreateReasonFrame()

	local configOptions = {
		type = 'group',
		childGroups = 'tab',
		name = L["Notifications"],
		desc = L["Notifications"],
		args = {
			upperarea = {
				type = 'toggle',
				name = L["On-screen"],
				desc = L["Notification in the Upper Area"],
				order = 1,
				set = function(frame, v)
					VanasKoSNotifier.db.profile.notifyVisual = v
				end,
				get = function()
					return VanasKoSNotifier.db.profile.notifyVisual
				end,
			},
			chatframe = {
				type = 'toggle',
				name = L["Chat message"],
				desc = L["Notification in the Chatframe"],
				order = 2,
				set = function(frame, v)
					VanasKoSNotifier.db.profile.notifyChatframe = v
				end,
				get = function()
					return VanasKoSNotifier.db.profile.notifyChatframe
				end,
			},
			targetframe = {
				type = 'toggle',
				name = L["Dragon Portrait"],
				desc = L["Notification through Target Portrait"],
				order = 3,
				set = function(frame, v)
					VanasKoSNotifier.db.profile.notifyTargetFrame = v
				end,
				get = function()
					return VanasKoSNotifier.db.profile.notifyTargetFrame
				end,
			},
			flashingborder = {
				type = 'toggle',
				name = L["Flashing Border"],
				desc = L["Notification through flashing Border"],
				order = 4,
				set = function(frame, v)
					VanasKoSNotifier.db.profile.notifyFlashingBorder = v
				end,
				get = function()
					return VanasKoSNotifier.db.profile.notifyFlashingBorder
				end,
			},
			onlymytargets = {
				type = 'toggle',
				name = L["Mine only"],
				desc = L["Notify only on my KoS-Targets"],
				order = 5,
				set = function(frame, v)
					VanasKoSNotifier.db.profile.notifyOnlyMyTargets = v
				end,
				get = function()
					return VanasKoSNotifier.db.profile.notifyOnlyMyTargets
				end,
			},
			notifyenemy = {
				type = 'toggle',
				name = L["All enemies"],
				desc = L["Notify of any enemy target"],
				order = 6,
				set = function(frame, v)
					VanasKoSNotifier.db.profile.notifyEnemyTargets = v
				end,
				get = function()
					return VanasKoSNotifier.db.profile.notifyEnemyTargets
				end,
			},
			notifyparty = {
				type = 'toggle',
				name = L["Party notification"],
				desc = L["Notify when a player in hate list or nice list joins your party"],
				order = 7,
				set = function(frame, v)
					VanasKoSNotifier.db.profile.notifyParty = v
					VanasKoSNotifier:EnablePartyEvents(v)
				end,
				get = function()
					return VanasKoSNotifier.db.profile.notifyParty
				end,
			},
			friendlist = {
				type = 'toggle',
				name = L["Friend list"],
				desc = L["Colors players in friend list based on hated/nice status"],
				order = 8,
				set = function(frame, v)
					VanasKoSNotifier.db.profile.friendlist = v
				end,
				get = function()
					return VanasKoSNotifier.db.profile.friendlist
				end,
			},
			ignorelist = {
				type = 'toggle',
				name = L["Ignore list"],
				desc = L["Colors players in ignore list based on hated/nice status"],
				order = 9,
				set = function(frame, v)
					VanasKoSNotifier.db.profile.ignorelist = v
				end,
				get = function()
					return VanasKoSNotifier.db.profile.ignorelist
				end,
			},
			showpvpstats = {
				type = 'toggle',
				name = L["Stats in Tooltip"],
				desc = L["Show PvP-Stats in Tooltip"],
				order = 10,
				set = function(frame, v)
					VanasKoSNotifier.db.profile.notifyShowPvPStats = v
				end,
				get = function()
					return VanasKoSNotifier.db.profile.notifyShowPvPStats
				end,
			},
			notificationInterval = {
				type = 'range',
				name = L["Interval (seconds)"],
				desc = L["Notification Interval (seconds)"],
				min = 0,
				max = 600,
				step = 5,
				order = 11,
				set = function(frame, value)
					VanasKoSNotifier.db.profile.NotifyTimerInterval = value
				end,
				get = function()
					return VanasKoSNotifier.db.profile.NotifyTimerInterval
				end,
			},
			zonesgroup = {
				type = "group",
				name = L["Zones"],
				desc = L["Notification Zones"],
				order = 12,
				args = {
					insanctuary = {
						type = 'toggle',
						name = L["Sanctuaries"],
						desc = L["Notify in Sanctuaries"],
						order = 1,
						set = function(frame, v)
							VanasKoSNotifier.db.profile.notifyInShattrathEnabled = v
							VanasKoSNotifier:ZoneChanged()
						end,
						get = function()
							return VanasKoSNotifier.db.profile.notifyInShattrathEnabled
						end,
					},
					incity = {
						type = 'toggle',
						name = L["Cities"],
						desc = L["Notify in cities"],
						order = 2,
						set = function(frame, v)
							VanasKoSNotifier.db.profile.notifyInCitiesEnabled = v
							VanasKoSNotifier:ZoneChanged()
						end,
						get = function()
							return VanasKoSNotifier.db.profile.notifyInCitiesEnabled
						end,
					},
					inbattleground = {
						type = 'toggle',
						name = L["Battlegrounds"],
						desc = L["Notify in battleground"],
						order = 3,
						set = function(frame, v)
							VanasKoSNotifier.db.profile.notifyInBattlegroundEnabled = v
							VanasKoSNotifier:ZoneChanged()
						end,
						get = function()
							return VanasKoSNotifier.db.profile.notifyInBattlegroundEnabled
						end,
					},
					inarena = {
						type = 'toggle',
						name = L["Arenas"],
						desc = L["Notify in arenas"],
						order = 4,
						set = function(frame, v)
							VanasKoSNotifier.db.profile.notifyInArenaEnabled = v
							VanasKoSNotifier:ZoneChanged()
						end,
						get = function()
							return VanasKoSNotifier.db.profile.notifyInArenaEnabled
						end,
					},
					incombatzone = {
						type = 'toggle',
						name = L["Combat Zones"],
						desc = L["Notify in combat zones (Wintergrasp, Tol Barad)"],
						order = 5,
						set = function(frame, v)
							VanasKoSNotifier.db.profile.notifyInCombatZoneEnabled = v
							VanasKoSNotifier:ZoneChanged()
						end,
						get = function()
							return VanasKoSNotifier.db.profile.notifyInCombatZoneEnabled
						end,
					},
				},
			},
			soundgroup = {
				type = "group",
				name = L["Sounds"],
				desc = L["Notification sounds"],
				order = 13,
				args = {
					kosSound = {
						type = 'select',
						name = L["KoS Sound"],
						desc = L["Sound on KoS detection"],
						order = 1,
						get = function()
							return GetSound("kos")
						end,
						set = function(frame, value)
							SetSound("kos", value)
						end,
						values = function()
							return GetMediaList()
						end,
					},
					enemySound = {
						type = 'select',
						name = L["Enemy Sound"],
						desc = L["Sound on enemy detection"],
						order = 2,
						get = function()
							return GetSound("enemy")
						end,
						set = function(frame, value)
							SetSound("enemy", value)
						end,
						values = function()
							return GetMediaList()
						end,
					},
					hateSound = {
						type = 'select',
						name = L["Hated sound"],
						desc = L["Sound when a hated player joins your raid or party"],
						order = 3,
						get = function()
							return GetSound("hate")
						end,
						set = function(frame, value)
							SetSound("hate", value)
						end,
						values = function()
							return GetMediaList()
						end,
					},
					niceSound = {
						type = 'select',
						name = L["Nice sound"],
						desc = L["Sound when a nice player joins your raid or party"],
						order = 4,
						get = function()
							return GetSound("nice")
						end,
						set = function(frame, value)
							SetSound("nice", value)
						end,
						values = function()
							return GetMediaList()
						end,
					},
				},
			},
			extrareasongroup = {
				type = "group",
				name = L["Extra Reason"],
				desc = L["Additional Reason Window"],
				order = 14,
				args = {
					extrareasonframeenabled = {
						type = 'toggle',
						name = L["Enabled"],
						desc = L["Enabled"],
						order = 1,
						set = function(frame, v)
							VanasKoSNotifier:EnableReasonFrame(v)
						end,
						get = function()
							return VanasKoSNotifier.db.profile.notifyExtraReasonFrameEnabled
						end,
					},
					extrareasonframelocked = {
						type = 'toggle',
						name = L["Locked"],
						desc = L["Locked"],
						order = 2,
						set = function(frame, v)
							VanasKoSNotifier:LockReasonFrame(v)
						end,
						get = function()
							return VanasKoSNotifier.db.profile.notifyExtraReasonFrameLocked
						end,
					},
					extrareasonframeshowanchor = {
						type = 'toggle',
						name = L["Show Anchor"],
						desc = L["Show Anchor"],
						order = 3,
						set = function(frame, v)
							VanasKoSNotifier:ShowAnchorReasonFrame(v)
						end,
						get = function()
							return reasonFrame.showanchor
						end,
					}
				},
			},
		},
	}

	VanasKoSGUI:AddModuleToggle("Notifier", L["Notifications"])
	VanasKoSGUI:AddConfigOption("Notifier", configOptions)

	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
	self:SetEnabledState(self.db.profile.Enabled)
end

function VanasKoSNotifier:OnEnable()
	self:EnablePlayerDetectedEvents(true)
	self:EnablePartyEvents(self.db.profile.notifyParty)

	self:RegisterMessage("VanasKoS_Player_Target_Changed", "Player_Target_Changed")
	self:RegisterMessage("VanasKoS_Mob_Target_Changed", "Player_Target_Changed")
	self:RegisterMessage("VanasKoS_Zone_Changed", "ZoneChanged")

	self:SecureHook("FriendsFrame_UpdateFriendButton")
	self:SecureHook("FriendsFrameTooltip_Show")
	self:SecureHook("IgnoreList_Update")
	for i=1, FRIENDS_TO_DISPLAY do
		local button = _G["FriendsFrameFriendsScrollFrameButton" .. i]
		self:SecureHookScript(button, "OnEnter", "FriendsFrameTooltip_Show")
	end
	for i=1, IGNORES_TO_DISPLAY do
		local button = _G["FriendsFrameIgnoreButton" .. i]
		local reasonFont = button:CreateFontString("VanasKoSIgnoreButton" .. i .. "ReasonText")
		reasonFont:SetFontObject("GameFontNormalSmall")
		reasonFont:SetPoint("RIGHT")
	end

	self:HookScript(GameTooltip, "OnTooltipSetUnit")
end

function VanasKoSNotifier:RefreshConfig()
	self:SetEnabledState(self.db.profile.Enabled)
	SetProperties(reasonFrame, self.db.profile)
	self:EnablePartyEvents(self.db.profile.notifyParty)
end

function VanasKoSNotifier:FriendsFrame_UpdateFriendButton(button)
	if (self.db.profile.friendlist ~= true) then
		return
	end

	if (button.buttonType == FRIENDS_BUTTON_TYPE_WOW) then
		local friendInfo = C_FriendList.GetFriendInfoByIndex(button.id)
		local nameText = button.name
		local name = friendInfo.name

		if(name) then
			local key = name
			if (VanasKoS:IsOnList("HATELIST", key)) then
				if (friendInfo.connected) then
					nameText:SetTextColor(1, 0, 0)
				else
					nameText:SetTextColor(0.5, 0, 0)
				end
			elseif (VanasKoS:IsOnList("NICELIST", key)) then
				if (friendInfo.connected) then
					nameText:SetTextColor(0, 1, 0)
				else
					nameText:SetTextColor(0, 0.5, 0)
				end
			end
		end
	end
end

function VanasKoSNotifier:FriendsFrameTooltip_Show(button)
	if (button.buttonType == FRIENDS_BUTTON_TYPE_WOW) then
		-- name, level, class, area, connected, status, note, RAF, guid
		local friendInfo = C_FriendList.GetFriendInfoByIndex(button.id)
		local name = friendInfo.name

		if (name) then
			local noteText
			local key = name
			local hate = VanasKoS:IsOnList("HATELIST", key)
			local nice = VanasKoS:IsOnList("NICELIST", key)
			if (hate) then
				noteText = friendInfo.notes or ""
				if noteText ~= "" then
					noteText = noteText .. "\n"
				end
				noteText = noteText .. format(L["Hatelist: %s"], "|cffff0000" .. (hate.reason or "") .. "|r")
			elseif (nice) then
				noteText = friendInfo.notes or ""
				if noteText ~= "" then
					noteText = noteText .. "\n"
				end
				noteText = noteText .. format(L["Nicelist: %s"], "|cff00ff00" .. (nice.reason or "") .. "|r")
			end

			if noteText then
				local tooltip = FriendsTooltip
				local anchor = FriendsTooltipHeader
				if friendInfo.connected then
					anchor = FriendsTooltipGameAccount1Info
				end
				FriendsTooltipNoteIcon:Show()
				FriendsFrameTooltip_SetLine(FriendsTooltipNoteText, anchor, noteText, -8)
				tooltip:SetHeight(tooltip.height + FRIENDS_TOOLTIP_MARGIN_WIDTH)
				tooltip:SetWidth(min(FRIENDS_TOOLTIP_MAX_WIDTH, tooltip.maxWidth + FRIENDS_TOOLTIP_MARGIN_WIDTH))
				tooltip:Show()
			end
		end
	end
end

function VanasKoSNotifier:IgnoreList_Update()
	if (self.db.profile.ignorelist ~= true) then
		return
	end

	for i=1, IGNORES_TO_DISPLAY do
		local ignoreButton = _G["FriendsFrameIgnoreButton"..i]
		if ((ignoreButton.type == SQUELCH_TYPE_IGNORE or ignoreButton.type == SQUELCH_TYPE_MUTE)
		    and ignoreButton.index) then
			local nameText = ignoreButton.name
			local noteText = getglobal("VanasKoSIgnoreButton"..i.."ReasonText")
			local name = C_FriendList.GetIgnoreName(ignoreButton.index)

			if(name) then
				local key = name
				local hate = VanasKoS:IsOnList("HATELIST", key)
				local nice = VanasKoS:IsOnList("NICELIST", key)
				if (hate and hate.reason) then
					nameText:SetText(format("|cffff0000%s|r", name))
					noteText:SetText("("..VanasKoS:IsOnList("HATELIST", key).reason..")")
					noteText:SetPoint("LEFT", nameText, "LEFT", nameText:GetStringWidth(), 0)
				elseif (nice and nice.reason) then
					nameText:SetText(format("|cff00ff00%s|r", name))
					noteText:SetText("("..VanasKoS:IsOnList("NICELIST", key).reason..")")
					noteText:SetPoint("LEFT", nameText, "LEFT", nameText:GetStringWidth(), 0)
				end
			end
		end
	end
end

function VanasKoSNotifier:EnablePartyEvents(enable)
	if(enable and (not partyEventsEnabled)) then
		self:RegisterEvent("GROUP_ROSTER_UPDATE")
		self:RegisterEvent("RAID_ROSTER_UPDATE")
	elseif((not enable) and partyEventsEnabled) then
		self:UnregisterEvent("GROUP_ROSTER_UPDATE")
		self:UnregisterEvent("RAID_ROSTER_UPDATE")
	end
end

function VanasKoSNotifier:GROUP_ROSTER_UPDATE()
	if (UnitInRaid("player")) then
		return
	end

	local newParty = {}
	for i = 1, GetNumSubgroupMembers() do
		-- Certain missions places you in a party with an NPC
		if UnitIsPlayer("party" .. i) then
			local name = UnitName("party" .. i)
			local key = name
			newParty[key] = i
			local hate = VanasKoS:IsOnList("HATELIST", key)
			local nice = VanasKoS:IsOnList("NICELIST", key)
			if(hate) then
				if(self.db.profile.notifyTargetFrame) then
					local texture = getglobal("PartyMemberFrame"..i.."Texture")
					texture:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\KoSPartyFrame")
					texture:SetVertexColor(1.0, 0.0, 0.0, texture:GetAlpha())
				end
				if(not lastPartyUpdate[key]) then
					local msg = format(L["Hated player \"%s\" (%s) is in your party"], name, hate.reason or "")
					if(self.db.profile.notifyVisual) then
						UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
					end
					if(self.db.profile.notifyChatframe) then
						VanasKoS:Print(msg)
					end
					if(self.db.profile.notifyFlashingBorder) then
						flashNotifyTexture:SetVertexColor(1.0, 0.0, 0.0, flashNotifyTexture:GetAlpha())
						self:FlashNotify()
					end
					self:PlaySound(self.db.profile.hatePlayName)
				end
			elseif(nice) then
				if(self.db.profile.notifyTargetFrame) then
					local texture = getglobal("PartyMemberFrame"..i.."Texture")
					texture:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\KoSPartyFrame")
					texture:SetVertexColor(0.0, 1.0, 0.0, texture:GetAlpha())
				end
				if(not lastPartyUpdate[key]) then
					local msg = format(L["Nice player \"%s\" (%s) is in your party"], name, nice.reason or "")
					if(self.db.profile.notifyVisual) then
						UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
					end
					if(self.db.profile.notifyChatframe) then
						VanasKoS:Print(msg)
					end
					if(self.db.profile.notifyFlashingBorder) then
						flashNotifyTexture:SetVertexColor(0.0, 1.0, 0.0, flashNotifyTexture:GetAlpha())
						self:FlashNotify()
					end
					self:PlaySound(self.db.profile.nicePlayName)
				end
			end
		end
	end

	wipe(lastPartyUpdate)
	lastPartyUpdate = newParty
end

function VanasKoSNotifier:RAID_ROSTER_UPDATE()
	local newParty = {}
	for i = 1, GetNumGroupMembers() do
		local name = UnitName("raid" .. i)
		local key = name
		newParty[key] = i
		if(not lastPartyUpdate[key]) then
			local hate = VanasKoS:IsOnList("HATELIST", key)
			local nice = VanasKoS:IsOnList("NICELIST", key)
			if(hate) then
				local msg = format(L["Hated player \"%s\" (%s) is in your raid"], name, hate.reason or "")
				if(self.db.profile.notifyVisual) then
					UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
				end
				if(self.db.profile.notifyChatframe) then
					VanasKoS:Print(msg)
				end
				if(self.db.profile.notifyFlashingBorder) then
					flashNotifyTexture:SetVertexColor(1.0, 0.0, 0.0, flashNotifyTexture:GetAlpha())
					self:FlashNotify()
				end
				self:PlaySound(self.db.profile.hatePlayName)
			elseif(nice) then
				local msg = format(L["Nice player \"%s\" (%s) is in your raid"], name, nice.reason or "")
				if(self.db.profile.notifyVisual) then
					UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
				end
				if(self.db.profile.notifyChatframe) then
					VanasKoS:Print(msg)
				end
				if(self.db.profile.notifyFlashingBorder) then
					flashNotifyTexture:SetVertexColor(0.0, 1.0, 0.0, flashNotifyTexture:GetAlpha())
					self:FlashNotify()
				end
				self:PlaySound(self.db.profile.nicePlayName)
			end
		end
	end

	wipe(lastPartyUpdate)
	lastPartyUpdate = newParty
end

function VanasKoSNotifier:OnDisable()
	self:CancelAllTimers()
	self:UnregisterAllMessages()
	reenableTimer = nil
	playerDetectEventEnabled = false
end

function VanasKoSNotifier:OnTooltipSetUnit(tooltip, ...)
	if(not UnitIsPlayer("mouseover")) then
		return
	end

	local name = UnitName("mouseover")
	local guild = GetGuildInfo("mouseover")
	local key = name
	local guildKey = guild

	-- add the KoS: <text> and KoS (Guild): <text> messages
	for listname,v in pairs(listsToCheck) do
		local data
		if(listname == "GUILDKOS") then
			data = guildKey and VanasKoS:IsOnList(listname, guildKey) or nil
		else
			data = VanasKoS:IsOnList(listname, key)
		end
		if(data) then
			if(data.owner == nil) then
				tooltip:AddLine(format(v[1], data.reason or ""))
			else
				tooltip:AddLine(format(v[2], data.creator or data.owner, data.reason or ""))
			end
		end
	end

	-- add pvp stats line if turned on and data is available
	if(self.db.profile.notifyShowPvPStats) then
		local data = VanasKoS:IsOnList("PVPSTATS", key, 1)
		local playerdata = VanasKoS:IsOnList("PLAYERDATA", key)

		if(data or playerdata) then
			tooltip:AddLine(format(L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"],
				(playerdata and playerdata.seen) or 0, (data and data.wins) or 0, (data and data.losses) or 0))
		end
	end
end

function VanasKoSNotifier:UpdateReasonFrame(name, guild)
	if(self.db.profile.notifyExtraReasonFrameEnabled) then
		if(UnitIsPlayer("target")) then
			local key = name
			local guildKey = guild
			if(not reasonFrame.text) then
				return
			end
			local data = VanasKoS:IsOnList("PLAYERKOS", key)
			local gdata = guildKey and VanasKoS:IsOnList("GUILDKOS", guildKey) or nil

			if(data) then
				reasonFrame.text:SetTextColor(1.0, 0.81, 0.0, 1.0)
				reasonFrame.text:SetText(self:GetKoSString(name, guild, data.reason, data.creator, data.owner,
					gdata and gdata.reason or "",
					gdata and gdata.creator or "",
					gdata and gdata.owner or ""))
				return
			end

			local hdata = VanasKoS:IsOnList("HATELIST", key)
			if(hdata and hdata.reason ~= nil) then
				reasonFrame.text:SetTextColor(1.0, 0.0, 0.0, 1.0)
				if(hdata.creator ~= nil and hdata.owner ~= nil)  then
					reasonFrame.text:SetText(format(L["%sHatelist: %s"], hdata.creator, hdata.reason))
				else
					reasonFrame.text:SetText(format(L["Hatelist: %s"], hdata.reason))
				end
				return
			end

			local ndata = VanasKoS:IsOnList("NICELIST", key)
			if(ndata and ndata.reason ~= nil) then
				reasonFrame.text:SetTextColor(0.0, 1.0, 0.0, 1.0)
				if(ndata.creator ~= nil and ndata.owner ~= nil)  then
					reasonFrame.text:SetText(format(L["%sNicelist: %s"], ndata.creator, ndata.reason))
				else
					reasonFrame.text:SetText(format(L["Nicelist: %s"], ndata.reason))
				end
				return
			end

			reasonFrame.text:SetText("")
		else
			reasonFrame.text:SetText("")
		end
	end
end

function VanasKoSNotifier:Player_Target_Changed(message, data)
	if not data or not data.name then
		return
	end
	if(self.db.profile.notifyTargetFrame) then
		if(UnitIsPlayer("target")) then
			local key = data.name
			local guildKey = data.guild
			if(VanasKoS:BooleanIsOnList("PLAYERKOS", key)) then
				TargetFrameTextureFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite")
				TargetFrameTextureFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTextureFrameTexture:GetAlpha())
			elseif(guildKey and VanasKoS:BooleanIsOnList("GUILDKOS", guildKey)) then
				TargetFrameTextureFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare")
				TargetFrameTextureFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTextureFrameTexture:GetAlpha())
			elseif(VanasKoS:BooleanIsOnList("HATELIST", key)) then
				TargetFrameTextureFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare")
				TargetFrameTextureFrameTexture:SetVertexColor(1.0, 0.0, 0.0, TargetFrameTextureFrameTexture:GetAlpha())
			elseif(VanasKoS:BooleanIsOnList("NICELIST", key)) then
				TargetFrameTextureFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare")
				TargetFrameTextureFrameTexture:SetVertexColor(0.0, 1.0, 0.0, TargetFrameTextureFrameTexture:GetAlpha())
			else
				TargetFrameTextureFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
				TargetFrameTextureFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTextureFrameTexture:GetAlpha())
			end
		else
			TargetFrameTextureFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTextureFrameTexture:GetAlpha())
		end
	end
	self:UpdateReasonFrame(data and data.name or nil, data and data.guild or nil)
end

--/script VanasKoS:SendMessage("VanasKoS_Player_Detected", "Apfelherz", nil, "kos")
function VanasKoSNotifier:GetKoSString(name, guild, list_str, reason, creator, owner, greason, gcreator, gowner)
	local msg = ""

	if(reason ~= nil) then
		if(creator ~= nil and owner ~= nil) then
			if(name == nil) then
				msg = format("%s%s: %s", creator, list_str, reason)
			else
				msg = format("%s%s: %s", creator, list_str, name .. " (" .. reason .. ")")
			end
		else
			if(name == nil) then
				msg = format("%s: %s", list_str, reason)
			else
				msg = format("%s: %s", list_str, name .. " (" .. reason .. ")")
			end
		end
		if(guild) then
			msg = msg .. " <" .. guild .. ">"
			if(greason ~= nil) then
				msg = msg .. " (" .. greason .. ")"
			end
		end
	elseif(greason ~= nil) then
		msg = format(L["KoS (Guild): %s"], name .. " <" .. guild .. "> (" ..  greason .. ")")
	else
		if(creator ~= nil and owner ~= nil) then
			if(name == nil) then
				msg = format("%s%s: %s", creator, list_str, "")
			else
				msg = format("%s%s: %s", creator, list_str, name)
			end
		else
			if(name == nil) then
				msg = format("%s: %s", list_str, "")
			else
				msg = format("%s: %s", list_str, name)
			end
		end
		if(guild) then
			msg = msg .. " <" .. guild .. ">"
		end
	end

	return msg
end

function VanasKoSNotifier:EnablePlayerDetectedEvents(enable)
	if(enable and (not playerDetectEventEnabled)) then
		self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected")
		playerDetectEventEnabled = true
		if (reenableTimer) then
			self:CancelTimer(reenableTimer)
			reenableTimer = nil
		end
	elseif((not enable) and playerDetectEventEnabled) then
		self:UnregisterMessage("VanasKoS_Player_Detected")
		playerDetectEventEnabled = false
	end
end

function VanasKoSNotifier:ZoneChanged(message)
	local enableEvents = true

	if (VanasKoS:IsInSanctuary()) then
		enableEvents = self.db.profile.notifyInShattrathEnabled
	elseif (VanasKoS:IsInCity()) then
		enableEvents = self.db.profile.notifyInCitiesEnabled
	elseif (VanasKoS:IsInBattleground()) then
		enableEvents = self.db.profile.notifyInBattlegroundEnabled
	elseif (VanasKoS:IsInArena()) then
		enableEvents = self.db.profile.notifyInArenaEnabled
	elseif (VanasKoS:IsInCombatZone()) then
		enableEvents = self.db.profile.notifyInCombatZoneEnabled
	end

	if (reenableTimer) then
		if (not enableEvents) then
			self:CancelTimer(reenableTimer)
			reenableTimer = nil
			self:EnablePlayerDetectedEvents(false)
		end
	else
		self:EnablePlayerDetectedEvents(enableEvents)
	end
end

function VanasKoSNotifier:Player_Detected(message, data)
	if data.list == "PLAYERKOS" or data.list == "GUILDKOS" then
		VanasKoSNotifier:KosPlayer_Detected(data)
	elseif data.list == "HATELIST" then
		VanasKoSNotifier:HatedPlayer_Detected(data)
	elseif data.list == "NICELIST" then
		VanasKoSNotifier:NicePlayer_Detected(data)
	elseif data.faction == "enemy" then
		VanasKoSNotifier:EnemyPlayer_Detected(data)
	end
end


local function ReenableNotifications()
	reenableTimer = nil
	VanasKoSNotifier:EnablePlayerDetectedEvents(true)
end

function VanasKoSNotifier:EnemyPlayer_Detected(data)
	if(self.db.profile.notifyEnemyTargets == false) then
		return
	end

	if reenableTimer then
		-- print("oops, should not have detected enemy")
		return
	end

	self:EnablePlayerDetectedEvents(false)

	-- Reallow Notifies in NotifyTimeInterval Time
	reenableTimer = self:ScheduleTimer(ReenableNotifications, self.db.profile.NotifyTimerInterval)

	local msg = format(L["Enemy Detected:|cffff0000"])
	if (data.level ~= nil) then
		--level can now be a string (eg. 44+)
		if ((tonumber(data.level) or 1) < 1) then
			msg = msg .. " [??]"
		else
			msg = msg .. " [" .. data.level .. "]"
		end
	end

	msg = msg .. " " .. data.name

	if (data.guild ~= nil) then
		msg = msg .. " <" .. data.guild .. ">"
	end

	msg = msg .. "|r"

	if(self.db.profile.notifyVisual) then
		UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
	end
	if(self.db.profile.notifyChatframe) then
		VanasKoS:Print(msg)
	end
	if(self.db.profile.notifyFlashingBorder) then
		flashNotifyTexture:SetVertexColor(1.0, 0.0, 1.0, flashNotifyTexture:GetAlpha())
		self:FlashNotify()
	end
	self:PlaySound(self.db.profile.enemyPlayName)
end

function VanasKoSNotifier:KosPlayer_Detected(data)
	assert(data.name)
	local key = data.name
	local guildKey = data.guild

	-- VanasKoS:Print("player detected: " .. data.name)
	-- get reasons for kos (if any)
	local pdata = VanasKoS:IsOnList("PLAYERKOS", key)
	local gdata = guildKey and VanasKoS:IsOnList("GUILDKOS", guildKey) or nil

	local msg = self:GetKoSString(data.name, data and data.guild,
		L["KoS"], pdata and pdata.reason, pdata and pdata.creator,
		pdata and pdata.owner, gdata and gdata.reason,
		gdata and gdata.creator, gdata and gdata.owner)

	if(self.db.profile.notifyOnlyMyTargets and ((pdata and pdata.owner ~= nil) or (gdata and gdata.owner ~= nil))) then
		return
	end

	if reenableTimer then
		-- print("oops, should not have detected kos player")
		return
	end

	self:EnablePlayerDetectedEvents(false)
	-- Reallow Notifies in NotifyTimeInterval Time
	reenableTimer = self:ScheduleTimer(ReenableNotifications, self.db.profile.NotifyTimerInterval)

	if(self.db.profile.notifyVisual) then
		UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
	end
	if(self.db.profile.notifyChatframe) then
		VanasKoS:Print(msg)
	end
	if(self.db.profile.notifyFlashingBorder) then
		flashNotifyTexture:SetVertexColor(1.0, 1.0, 0.0, flashNotifyTexture:GetAlpha())
		self:FlashNotify()
	end

	self:PlaySound(self.db.profile.playName)
end

function VanasKoSNotifier:HatedPlayer_Detected(data)
	assert(data.name)
	local key = data.name
	local guildKey = data.guild

	-- VanasKoS:Print("player detected: " .. data.name)
	-- get reasons for kos (if any)
	local pdata = VanasKoS:IsOnList("HATELIST", key)

	local msg = self:GetKoSString(data.name, data and data.guild,
		L["Hatelist"], pdata and pdata.reason, pdata and pdata.creator,
		pdata and pdata.owner, nil, nil, nil)

	if(self.db.profile.notifyOnlyMyTargets and pdata and pdata.owner ~= nil) then
		return
	end

	if reenableTimer then
		-- print("oops, should not have detected kos player")
		return
	end

	self:EnablePlayerDetectedEvents(false)
	-- Reallow Notifies in NotifyTimeInterval Time
	reenableTimer = self:ScheduleTimer(ReenableNotifications, self.db.profile.NotifyTimerInterval)

	if(self.db.profile.notifyVisual) then
		UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
	end
	if(self.db.profile.notifyChatframe) then
		VanasKoS:Print(msg)
	end
	if(self.db.profile.notifyFlashingBorder) then
		flashNotifyTexture:SetVertexColor(1.0, 0.0, 0.0, flashNotifyTexture:GetAlpha())
		self:FlashNotify()
	end

	self:PlaySound(self.db.profile.hatePlayName)
end

function VanasKoSNotifier:NicePlayer_Detected(data)
	assert(data.name)
	local key = data.name
	local guildKey = data.guild

	-- VanasKoS:Print("player detected: " .. data.name)
	-- get reasons for kos (if any)
	local pdata = VanasKoS:IsOnList("NICELIST", key)

	local msg = self:GetKoSString(data.name, data and data.guild,
		L["Nicelist"], pdata and pdata.reason, pdata and pdata.creator,
		pdata and pdata.owner, nil, nil, nil)

	if(self.db.profile.notifyOnlyMyTargets and pdata and pdata.owner ~= nil) then
		return
	end

	if reenableTimer then
		-- print("oops, should not have detected kos player")
		return
	end

	self:EnablePlayerDetectedEvents(false)
	-- Reallow Notifies in NotifyTimeInterval Time
	reenableTimer = self:ScheduleTimer(ReenableNotifications, self.db.profile.NotifyTimerInterval)

	if(self.db.profile.notifyVisual) then
		UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
	end
	if(self.db.profile.notifyChatframe) then
		VanasKoS:Print(msg)
	end
	if(self.db.profile.notifyFlashingBorder) then
		flashNotifyTexture:SetVertexColor(0.0, 1.0, 0.0, flashNotifyTexture:GetAlpha())
		self:FlashNotify()
	end

	self:PlaySound(self.db.profile.nicePlayName)
end

-- /script VanasKoSNotifier:FlashNotify()
function VanasKoSNotifier:FlashNotify()
	flashNotifyFrame:Show()
	flasher:Play()
end

function VanasKoSNotifier:PlaySound(value)
	local soundFileName = SML:Fetch("sound", value)
	PlaySoundFile(soundFileName)
end
