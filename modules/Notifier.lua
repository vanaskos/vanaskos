--[[----------------------------------------------------------------------
      Notifier Module - Part of VanasKoS
Notifies the user via Tooltip, Chat and Upper Area of a KoS/other List Target
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/Notifier", false);
VanasKoSNotifier = VanasKoS:NewModule("Notifier", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0");
local VanasKoSNotifier = VanasKoSNotifier;
local VanasKoS = VanasKoS;

local FADE_IN_TIME = 0.2;
local FADE_OUT_TIME = 0.2;
local FLASH_TIMES = 1;

local SML = LibStub("LibSharedMedia-3.0");
SML:Register("sound", "VanasKoS: String fading", "Interface\\AddOns\\VanasKoS\\Artwork\\StringFading.mp3");
SML:Register("sound", "VanasKoS: Zoidbergs whooping", "Interface\\AddOns\\VanasKoS\\Artwork\\Zoidberg-Whoopwhoopwhoop.mp3");
SML:Register("sound", "VanasKoS: Extreme alarm", "Interface\\AddOns\\VanasKoS\\Artwork\\extreme_alarm.mp3");
SML:Register("sound", "VanasKoS: Hell's bell", "Interface\\AddOns\\VanasKoS\\Artwork\\hell_bell.mp3");
SML:Register("sound", "VanasKoS: Glockenspiel", "Interface\\AddOns\\VanasKoS\\Artwork\\glock_N_kloing.mp3");

local notifyAllowed = true;
local flashNotifyFrame = nil;
local reasonFrame = nil

function VanasKoSNotifier:CreateReasonFrame()
	reasonFrame = CreateFrame("Frame", "VanasKoS_Notifier_ReasonFrame");
	reasonFrame:SetWidth(300);
	reasonFrame:SetHeight(13);
	reasonFrame:SetPoint("CENTER");
	reasonFrame:SetMovable(true);
	reasonFrame:SetToplevel(true);

	reasonFrame.background = reasonFrame:CreateTexture("VanasKoS_Notifier_ReasonFrame_Background", "BACKGROUND");
	reasonFrame.background:SetAllPoints();
	reasonFrame.background:SetTexture(1.0, 1.0, 1.0, 0.5);

	reasonFrame.text = reasonFrame:CreateFontString("VanasKoS_Notifier_ReasonFrame_Text", "OVERLAY");
	-- only set the left point, so texts longer than reasonFrame:GetWidth() will show
	reasonFrame.text:SetPoint("LEFT", reasonFrame, "LEFT", 0, 0);
	reasonFrame.text:SetJustifyH("LEFT");
	reasonFrame.text:SetFontObject("GameFontNormalSmall");
	reasonFrame.text:SetTextColor(1.0, 0.0, 1.0);

	reasonFrame:RegisterForDrag("leftbutton");
	reasonFrame:SetScript("OnDragStart", function() reasonFrame:StartMoving(); end);
	reasonFrame:SetScript("OnDragStart", function() reasonFrame:StartMoving(); end);
	reasonFrame:SetScript("OnDragStop", function() reasonFrame:StopMovingOrSizing(); end);
	reasonFrame.background:SetAlpha(0.0);

	if (self.db.profile.notifyExtraReasonFrameLocked) then
		reasonFrame:EnableMouse(false);
	else
		reasonFrame:EnableMouse(true);
	end

	if (self.db.profile.notifyExtraReasonFrameEnabled) then
		reasonFrame:Show();
	else
		reasonFrame:Hide();
	end
end

function VanasKoSNotifier:EnableReasonFrame(enable)
	self.db.profile.notifyExtraReasonFrameEnabled = enable;
	if (enable) then
		reasonFrame:Show();
	else
		reasonFrame:Hide();
	end
end

function VanasKoSNotifier:LockReasonFrame(lock)
	self.db.profile.notifyExtraReasonFrameLocked = lock;
	if (lock) then
		reasonFrame:EnableMouse(false);
	else
		reasonFrame:EnableMouse(true);
	end
end

function VanasKoSNotifier:ShowAnchorReasonFrame(show)
	reasonFrame.showanchor = show;
	if (show) then
		reasonFrame.background:SetAlpha(1.0);
		reasonFrame.text:SetText(self:GetKoSString(nil, "Guild", "MyReason", UnitName("player"), nil, "GuildKoS Reason", UnitName("player"), nil));
	else
		reasonFrame.background:SetAlpha(0.0);
		reasonFrame.text:SetText("");
	end
end

local function SetSound(faction, value)
	if (faction == "enemy") then
		VanasKoSNotifier.db.profile.enemyPlayName = value;
	elseif (faction == "hate") then
		VanasKoSNotifier.db.profile.hatePlayName = value;
	elseif (faction == "nice") then
		VanasKoSNotifier.db.profile.nicePlayName = value;
	elseif (faction == "kos") then
		VanasKoSNotifier.db.profile.playName = value;
	end
	
	VanasKoSNotifier:PlaySound(value);
end

local function GetSound(faction)
	if (faction == "enemy") then
		return VanasKoSNotifier.db.profile.enemyPlayName;
	elseif (faction == "hate") then
		return VanasKoSNotifier.db.profile.hatePlayName;
	elseif (faction == "nice") then
		return VanasKoSNotifier.db.profile.nicePlayName;
	elseif(faction == "kos") then
		return VanasKoSNotifier.db.profile.playName;
	end
end

local mediaList = { };
local function GetMediaList()
	for k,v in pairs(SML:List("sound")) do
		mediaList[v] = v;
	end
	
	return mediaList;
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
			notifyRaidBrowser = true,
			notifyFlashingBorder = true,
			notifyInShattrathEnabled = false,
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
	});

	flashNotifyFrame = CreateFrame("Frame", "VanasKoS_Notifier_Frame", WorldFrame);
	flashNotifyFrame:SetAllPoints();
	flashNotifyFrame:SetToplevel(1);
	flashNotifyFrame:SetAlpha(0);

	local texture = flashNotifyFrame:CreateTexture(nil, "BACKGROUND");
	texture:SetTexture("Interface\\AddOns\\VanasKoS\\Artwork\\KoSFrame");

	texture:SetBlendMode("ADD");
	texture:SetAllPoints(); -- important! gets set in the blizzard xml stuff implicit, while we have to do it explicit with .lua
	flashNotifyFrame:Hide();

	self:CreateReasonFrame();

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
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyVisual = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyVisual; end,
			},
			chatframe = {
				type = 'toggle',
				name = L["Chat message"],
				desc = L["Notification in the Chatframe"],
				order = 2,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyChatframe = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyChatframe; end,
			},
			targetframe = {
				type = 'toggle',
				name = L["Dragon Portrait"],
				desc = L["Notification through Target Portrait"],
				order = 3,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyTargetFrame = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyTargetFrame; end,
			},
			flashingborder = {
				type = 'toggle',
				name = L["Flashing Border"],
				desc = L["Notification through flashing Border"],
				order = 4,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyFlashingBorder = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyFlashingBorder; end,
			},
			raidbrowser = {
				type = 'toggle',
				name = L["Raid Browser"],
				desc = L["Colors players in raid browser based on hated/nice status"],
				order = 5,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyRaidBrowser = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyRaidBrowser; end,
			},
			onlymytargets = {
				type = 'toggle',
				name = L["Mine only"],
				desc = L["Notify only on my KoS-Targets"],
				order = 6,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyOnlyMyTargets = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyOnlyMyTargets; end,
			},
			notifyenemy = {
				type = 'toggle',
				name = L["All enemies"],
				desc = L["Notify of any enemy target"],
				order = 7,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyEnemyTargets = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyEnemyTargets; end,
			},
			notifyparty = {
				type = 'toggle',
				name = L["Party notification"],
				desc = L["Notify when a player in hate list or nice list joins your party"],
				order = 8,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyParty = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyParty; end,
			},
			friendlist = {
				type = 'toggle',
				name = L["Friend list"],
				desc = L["Colors players in friend list based on hated/nice status"],
				order = 9,
				set = function(frame, v) VanasKoSNotifier.db.profile.friendlist = v; end,
				get = function() return VanasKoSNotifier.db.profile.friendlist; end,
			},
			ignorelist = {
				type = 'toggle',
				name = L["Ignore list"],
				desc = L["Colors players in ignore list based on hated/nice status"],
				order = 10,
				set = function(frame, v) VanasKoSNotifier.db.profile.ignorelist = v; end,
				get = function() return VanasKoSNotifier.db.profile.ignorelist; end,
			},
			insanctuary = {
				type = 'toggle',
				name = L["Notify in Sanctuary"],
				desc = L["Notify in Sanctuary"],
				order = 11,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyInShattrathEnabled = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyInShattrathEnabled; end,
			},
			showpvpstats = {
				type = 'toggle',
				name = L["Stats in Tooltip"],
				desc = L["Show PvP-Stats in Tooltip"],
				order = 12,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyShowPvPStats = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyShowPvPStats; end,
			},
			notificationInterval = {
				type = 'range',
				name = L["Interval (seconds)"],
				desc = L["Notification Interval (seconds)"],
				min = 0,
				max = 600,
				step = 5,
				order = 13,
				set = function(frame, value) VanasKoSNotifier.db.profile.NotifyTimerInterval = value; end,
				get = function() return VanasKoSNotifier.db.profile.NotifyTimerInterval; end,
			},
			soundgroup = {
				type = "group",
				name = L["Sounds"],
				name = L["Notification sounds"],
				order = 14,
				args = {
					kosSound = {
						type = 'select',
						name = L["KoS Sound"],
						desc = L["Sound on KoS detection"],
						order = 1,
						get = function() return GetSound("kos"); end,
						set = function(frame, value) SetSound("kos", value); end,
						values = function() return GetMediaList(); end,
					},
					enemySound = {
						type = 'select',
						name = L["Enemy Sound"],
						desc = L["Sound on enemy detection"],
						order = 2,
						get = function() return GetSound("enemy"); end,
						set = function(frame, value) SetSound("enemy", value); end,
						values = function() return GetMediaList(); end,
					},
					hateSound = {
						type = 'select',
						name = L["Hated sound"],
						desc = L["Sound when a hated player joins your raid or party"],
						order = 3,
						get = function() return GetSound("hate"); end,
						set = function(frame, value) SetSound("hate", value); end,
						values = function() return GetMediaList(); end,
					},
					niceSound = {
						type = 'select',
						name = L["Nice sound"],
						desc = L["Sound when a nice player joins your raid or party"],
						order = 4,
						get = function() return GetSound("nice"); end,
						set = function(frame, value) SetSound("nice", value); end,
						values = function() return GetMediaList(); end,
					},
				},
			},
			extrareasongroup = {
				type = "group",
				name = L["Extra Reason"],
				desc = L["Additional Reason Window"],
				order = 15,
				args = {
					extrareasonframeenabled = {
						type = 'toggle',
						name = L["Enabled"],
						desc = L["Enabled"],
						order = 1,
						set = function(frame, v) VanasKoSNotifier:EnableReasonFrame(v); end,
						get = function() return VanasKoSNotifier.db.profile.notifyExtraReasonFrameEnabled; end,
					},
					extrareasonframelocked = {
						type = 'toggle',
						name = L["Locked"],
						desc = L["Locked"],
						order = 2,
						set = function(frame, v) VanasKoSNotifier:LockReasonFrame(v); end,
						get = function() return VanasKoSNotifier.db.profile.notifyExtraReasonFrameLocked; end,
					},
					extrareasonframeshowanchor = {
						type = 'toggle',
						name = L["Show Anchor"],
						desc = L["Show Anchor"],
						order = 3,
						set = function(frame, v) VanasKoSNotifier:ShowAnchorReasonFrame(v); end,
						get = function() return reasonFrame.showanchor; end,

					}
				},
			},
		},
	};

	VanasKoSGUI:AddModuleToggle("Notifier", L["Notifications"]);
	VanasKoSGUI:AddConfigOption("Notifier", configOptions);
	self:SetEnabledState(self.db.profile.Enabled);
end

function VanasKoSNotifier:OnEnable()
	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected");
	self:RegisterMessage("VanasKoS_Player_Target_Changed", "Player_Target_Changed");
	self:RegisterMessage("VanasKoS_Mob_Target_Changed", "Player_Target_Changed");
	self:RegisterEvent("PARTY_MEMBERS_CHANGED");
	self:RegisterEvent("RAID_ROSTER_UPDATE");
	self:SecureHook("FriendsList_Update");
	self:SecureHook("IgnoreList_Update");
	for i=1,IGNORES_TO_DISPLAY do
		local button = getglobal("FriendsFrameIgnoreButton" .. i .. "ButtonText");
		local reasonFont = button:CreateFontString("VanasKoSIgnoreButton" .. i .. "ReasonText");
		reasonFont:SetFontObject("GameFontNormalSmall");
		reasonFont:SetPoint("RIGHT", 10, 0);
	end
	self:SecureHook("LFRBrowseFrameListButton_SetData");
	--self:SecureHook("LFRBrowseButton_OnEnter");
	for i=1, NUM_LFR_LIST_BUTTONS do
		self:SecureHookScript(getglobal("LFRBrowseFrameListButton" .. i), "OnEnter", "LFRBrowseButton_OnEnter");
	end

	self:HookScript(GameTooltip, "OnTooltipSetUnit");
end

function VanasKoSNotifier:FriendsList_Update()
	if (self.db.profile.friendlist ~= true) then
		return
	end

	local friendOffset = FauxScrollFrame_GetOffset(FriendsFrameFriendsScrollFrame);
	local friendIndex;
	for i=1, FRIENDS_TO_DISPLAY do
		friendIndex = friendOffset + i;
		-- name, level, class, area, connected, status, note, RAF
		local name, _, _, _, connected, _, note = GetFriendInfo(friendIndex);
		local nameText = getglobal("FriendsFrameFriendButton"..i.."ButtonTextName");
		local noteText = getglobal("FriendsFrameFriendButton"..i.."ButtonTextNoteText");

		if(name) then
			local lname = name:lower();
			if (VanasKoS:IsOnList("HATELIST", lname)) then
				if (connected) then
					local cname = gsub(nameText:GetText(), name, "|cffff0000"..name.."|r");
					nameText:SetText(cname);
				else
					local cname = gsub(nameText:GetText(), name, "|cff770000"..name.."|r|cff888888");
					nameText:SetText(cname);
				end
				if (not note or note == "") then
					noteText:SetText("("..VanasKoS:IsOnList("HATELIST", lname).reason..")");
				end
			elseif (VanasKoS:IsOnList("NICELIST", lname)) then
				if (connected) then
					local cname = gsub(nameText:GetText(), name, "|cff00ff00"..name.."|r");
					nameText:SetText(cname);
				else
					local cname = gsub(nameText:GetText(), name, "|cff007700"..name.."|r|cff888888");
					nameText:SetText(cname);
				end
				if (not note or note == "") then
					noteText:SetText("("..VanasKoS:IsOnList("NICELIST", lname).reason..")");
				end
			end
		end
	end
end

function VanasKoSNotifier:IgnoreList_Update()
	if (self.db.profile.ignorelist ~= true) then
		return;
	end

	local ignoreOffset = FauxScrollFrame_GetOffset(FriendsFrameIgnoreScrollFrame);
	local ignoreIndex;
	for i=1, IGNORES_TO_DISPLAY do
		ignoreIndex = ignoreOffset + i;
		-- name, level, class, area, connected, status, note, RAF
		local name = GetIgnoreName(ignoreIndex);
		local nameText = getglobal("FriendsFrameIgnoreButton"..i.."ButtonTextName");
		local noteText = getglobal("VanasKoSIgnoreButton"..i.."ReasonText");

		if(name) then
			local lname = name:lower();
			if (VanasKoS:IsOnList("HATELIST", lname)) then
				nameText:SetText(format("|cffff0000%s|r", name));
				if (not note or note == "") then
					noteText:SetText("("..VanasKoS:IsOnList("HATELIST", lname).reason..")");
					noteText:SetPoint("LEFT", nameText, "RIGHT");
				end
			elseif (VanasKoS:IsOnList("NICELIST", lname)) then
				nameText:SetText(format("|cff00ff00%s|r", name));
				if (not note or note == "") then
					noteText:SetText("("..VanasKoS:IsOnList("NICELIST", lname).reason..")");
					noteText:SetPoint("LEFT", nameText, "RIGHT");
				end
			end
		end
	end
end

local lastPartyUpdate = {}
function VanasKoSNotifier:PARTY_MEMBERS_CHANGED()
	if (self.db.profile.notifyParty ~= true or UnitInRaid("player")) then
		return
	end

	local newParty = {};
	for i = 1, 4 do
		if(GetPartyMember(i)) then
			local name, realm = UnitName("party" .. i);
			local guild = GetGuildInfo("party" .. i);
			if (realm and realm ~= "") then
				if (name) then
					name = name .. "-" .. realm;
				end
				if (guild) then
					guild = guild .. "-" .. realm;
				end
			end
			newParty[name] = i;
			local hate = VanasKoS:IsOnList("HATELIST", name);
			local nice = VanasKoS:IsOnList("NICELIST", name);
			if(hate) then
				if(self.db.profile.notifyTargetFrame) then
					local texture = getglobal("PartyMemberFrame"..i.."Texture");
					texture:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\KoSPartyFrame");
					texture:SetVertexColor(1.0, 0.0, 0.0, texture:GetAlpha());
				end
				if(not lastPartyUpdate[name]) then
					local msg = format(L["Hated player \"%s\" (%s) is in your party"], name, hate.reason or "");
					if(self.db.profile.notifyVisual) then
						UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
					end
					if(self.db.profile.notifyChatframe) then
						VanasKoS:Print(msg);
					end
					if(self.db.profile.notifyFlashingBorder) then
						self:FlashNotify();
					end
					self:PlaySound(self.db.profile.hatePlayName);
				end
			elseif(nice) then
				if(self.db.profile.notifyTargetFrame) then
					local texture = getglobal("PartyMemberFrame"..i.."Texture");
					texture:SetTexture("Interface\\Addons\\VanasKoS\\Artwork\\KoSPartyFrame");
					texture:SetVertexColor(0.0, 1.0, 0.0, texture:GetAlpha());
				end
				if(not lastPartyUpdate[name]) then
					local msg = format(L["Nice player \"%s\" (%s) is in your party"], name, nice.reason or "");
					if(self.db.profile.notifyVisual) then
						UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
					end
					if(self.db.profile.notifyChatframe) then
						VanasKoS:Print(msg);
					end
					if(self.db.profile.notifyFlashingBorder) then
						self:FlashNotify();
					end
					self:PlaySound(self.db.profile.nicePlayName);
				end
			end
		end
	end

	wipe(lastPartyUpdate);
	lastPartyUpdate = newParty;
end

function VanasKoSNotifier:RAID_ROSTER_UPDATE()
	if (self.db.profile.notifyParty ~= true) then
		return
	end

	local newParty = {};
	for i = 1, 40 do
		if(GetRaidRosterInfo(i)) then
			local name, realm = UnitName("raid" .. i);
			local guild = GetGuildInfo("raid" .. i);
			if (realm and realm ~= "") then
				if (name) then
					name = name .. "-" .. realm;
				end
				if (guild) then
					guild = guild .. "-" .. realm;
				end
			end
			newParty[name] = i;
			if(not lastPartyUpdate[name]) then
				local hate = VanasKoS:IsOnList("HATELIST", name);
				local nice = VanasKoS:IsOnList("NICELIST", name);
				if(hate) then
					local msg = format(L["Hated player \"%s\" (%s) is in your raid"], name, hate.reason or "");
					if(self.db.profile.notifyVisual) then
						UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
					end
					if(self.db.profile.notifyChatframe) then
						VanasKoS:Print(msg);
					end
					if(self.db.profile.notifyFlashingBorder) then
						self:FlashNotify();
					end
					self:PlaySound(self.db.profile.hatePlayName);
				elseif(nice) then
					local msg = format(L["Nice player \"%s\" (%s) is in your raid"], name, nice.reason or "");
					if(self.db.profile.notifyVisual) then
						UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
					end
					if(self.db.profile.notifyChatframe) then
						VanasKoS:Print(msg);
					end
					if(self.db.profile.notifyFlashingBorder) then
						self:FlashNotify();
					end
					self:PlaySound(self.db.profile.nicePlayName);
				end
			end
		end
	end

	wipe(lastPartyUpdate);
	lastPartyUpdate = newParty;
end

function VanasKoSNotifier:LFRBrowseFrameListButton_SetData(button, index)
	if (self.db.profile.notifyRaidBrowser ~= true) then
		return;
	end

	-- name, level, areaName, className, comment, partyMembers, status, class, encountersTotal, encountersComplete, isLeader, isTank, isHealer, isDamage
	local name = SearchLFGGetResults(index);
	local lname = name:lower();
	local hate = VanasKoS:IsOnList("HATELIST", lname);
	local nice = VanasKoS:IsOnList("NICELIST", lname);
	if (hate) then
		button.name:SetTextColor(1, 0, 0);
	elseif (nice) then
		button.name:SetTextColor(0, 1, 0);
	end
end

function VanasKoSNotifier:LFRBrowseButton_OnEnter(frame)
	if (self.db.profile.notifyRaidBrowser ~= true) then
		return;
	end

	local name = SearchLFGGetResults(frame.index);
	local lname = name:lower();
	local hate = VanasKoS:IsOnList("HATELIST", lname);
	local nice = VanasKoS:IsOnList("NICELIST", lname);
	if (hate) then
		GameTooltip:AddLine("|cffff0000" .. hate.reason .. "|r");
		GameTooltip:Show();
	elseif (nice) then
		GameTooltip:AddLine("|cff00ff00" .. nice.reason .. "|r");
		GameTooltip:Show();
	end
end

function VanasKoSNotifier:OnDisable()
	self:UnregisterAllMessages();
end

local listsToCheck = {
		['PLAYERKOS'] = { L["KoS: %s"], L["%sKoS: %s"] },
		['GUILDKOS'] = { L["KoS (Guild): %s"], L["%sKoS (Guild): %s"] },
		['NICELIST'] = { L["Nicelist: %s"], L["%sNicelist: %s"] },
		['HATELIST'] = { L["Hatelist: %s"], L["%sHatelist: %s"] },
		['WANTED'] = {  L["Wanted: %s"], L["%sWanted: %s"] },
	};

function VanasKoSNotifier:OnTooltipSetUnit(tooltip, ...)
	if(not UnitIsPlayer("mouseover")) then
		--return self.hooks[tooltip].OnTooltipSetUnit(tooltip, ...);
		return;
	end

	local name, realm = UnitName("mouseover");
	if(name and realm and realm ~= "") then
		name = name .. "-" .. realm;
	end
	local guild = GetGuildInfo("mouseover");

	-- add the KoS: <text> and KoS (Guild): <text> messages
	for k,v in pairs(listsToCheck) do
		local data = nil;
		if(k ~= "GUILDKOS") then
			data = VanasKoS:IsOnList(k, name);
		else
			data = VanasKoS:IsOnList(k, guild);
		end
		if(data) then
			local reason = data.reason or "";
			if(data.owner == nil) then
				tooltip:AddLine(format(v[1], reason));
			else
				tooltip:AddLine(format(v[2], data.creator or data.owner, reason));
			end
		end
	end

	-- add pvp stats line if turned on and data is available
	if(self.db.profile.notifyShowPvPStats) then
		local data = VanasKoS:IsOnList("PVPSTATS", name, 1);
		local playerdata = VanasKoS:IsOnList("PLAYERDATA", name);

		if(data or playerdata) then
			tooltip:AddLine(format(L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"], (playerdata and playerdata.seen) or 0, (data and data.wins) or 0, (data and data.losses) or 0));
		end
	end

	--return self.hooks[tooltip].OnTooltipSetUnit(tooltip, ...);
end

function VanasKoSNotifier:UpdateReasonFrame(name, guild)
	if(self.db.profile.notifyExtraReasonFrameEnabled) then
		if(UnitIsPlayer("target")) then
			if(not VanasKoS_Notifier_ReasonFrame_Text) then
				return;
			end
			local data = VanasKoS:IsOnList("PLAYERKOS", name);
			local gdata = VanasKoS:IsOnList("GUILDKOS", guild);

			if(data) then
				VanasKoS_Notifier_ReasonFrame_Text:SetTextColor(1.0, 0.81, 0.0, 1.0);
				VanasKoS_Notifier_ReasonFrame_Text:SetText(self:GetKoSString(name, guild, data.reason, data.creator, data.owner, gdata and gdata.reason, gdata and gdata.creator, gdata and gdata.owner));
				return;
			end

			local hdata = VanasKoS:IsOnList("HATELIST", name);
			if(hdata and hdata.reason ~= nil) then
				VanasKoS_Notifier_ReasonFrame_Text:SetTextColor(1.0, 0.0, 0.0, 1.0);
				if(hdata.creator ~= nil and hdata.owner ~= nil)  then
					VanasKoS_Notifier_ReasonFrame_Text:SetText(format(L["%sHatelist: %s"], hdata.creator, hdata.reason));
				else
					VanasKoS_Notifier_ReasonFrame_Text:SetText(format(L["Hatelist: %s"], hdata.reason));
				end
				return;
			end

			local ndata = VanasKoS:IsOnList("NICELIST", name);
			if(ndata and ndata.reason ~= nil) then
				VanasKoS_Notifier_ReasonFrame_Text:SetTextColor(0.0, 1.0, 0.0, 1.0);
				if(ndata.creator ~= nil and ndata.owner ~= nil)  then
					VanasKoS_Notifier_ReasonFrame_Text:SetText(format(L["%sNicelist: %s"], ndata.creator, ndata.reason));
				else
					VanasKoS_Notifier_ReasonFrame_Text:SetText(format(L["Nicelist: %s"], ndata.reason));
				end
				return;
			end

			VanasKoS_Notifier_ReasonFrame_Text:SetText("");
		else
			VanasKoS_Notifier_ReasonFrame_Text:SetText("");
		end

	end
end

function VanasKoSNotifier:Player_Target_Changed(message, data)
	-- data is nil if target was changed to a mob, and the name and guild
	-- are null if the target was changed to self.
	local name = data and data.name;
	local realm = nil;
	if (not name) then
		name, realm = UnitName("target");
		if(realm and realm ~= "") then
			name = name .. "-" .. realm;
		end
	end
	local guild = data and data.guild or GetGuildInfo("target");
	if(self.db.profile.notifyTargetFrame) then
		if(UnitIsPlayer("target")) then
			if(VanasKoS:BooleanIsOnList("PLAYERKOS", name)) then
				TargetFrameTextureFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
				TargetFrameTextureFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTextureFrameTexture:GetAlpha());
			elseif(VanasKoS:BooleanIsOnList("GUILDKOS", guild)) then
				TargetFrameTextureFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
				TargetFrameTextureFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTextureFrameTexture:GetAlpha());
			elseif(VanasKoS:BooleanIsOnList("HATELIST", name)) then
				TargetFrameTextureFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
				TargetFrameTextureFrameTexture:SetVertexColor(1.0, 0.0, 0.0, TargetFrameTextureFrameTexture:GetAlpha());
			elseif(VanasKoS:BooleanIsOnList("NICELIST", name)) then
				TargetFrameTextureFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
				TargetFrameTextureFrameTexture:SetVertexColor(0.0, 1.0, 0.0, TargetFrameTextureFrameTexture:GetAlpha());
			else
				TargetFrameTextureFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
				TargetFrameTextureFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTextureFrameTexture:GetAlpha());
			end
		else
			TargetFrameTextureFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTextureFrameTexture:GetAlpha());
		end
	end
	self:UpdateReasonFrame(name, guild);
end

--/script VanasKoS:SendMessage("VanasKoS_Player_Detected", "Apfelherz", nil, "kos");
function VanasKoSNotifier:GetKoSString(name, guild, reason, creator, owner, greason, gcreator, gowner)
	local msg = "";

	if(reason ~= nil) then
		if(creator ~= nil and owner ~= nil) then
			if(name == nil) then
				msg = format(L["%sKoS: %s"], creator, reason);
			else
				msg = format(L["%sKoS: %s"], creator, name .. " (" .. reason .. ")");
			end
		else
			if(name == nil) then
				msg = format(L["KoS: %s"], reason);
			else
				msg = format(L["KoS: %s"], name .. " (" .. reason .. ")");
			end
		end
		if(guild) then
			msg = msg .. " <" .. guild .. ">";
			if(greason ~= nil) then
				msg = msg .. " (" .. greason .. ")";
			end
		end
	elseif(greason ~= nil) then
		msg = format(L["KoS (Guild): %s"], name .. " <" .. guild .. "> (" ..  greason .. ")");
	else
		if(creator ~= nil and owner ~= nil) then
			if(name == nil) then
				msg = format(L["%sKoS: %s"], creator, "");
			else
				msg = format(L["%sKoS: %s"], creator, name);
			end
		else
			if(name == nil) then
				msg = format(L["KoS: %s"], "");
			else
				msg = format(L["KoS: %s"], name);
			end
		end
		if(guild) then
			msg = msg .. " <" .. guild .. ">";
		end
	end

	return msg;
end

local function ReenableNotifications()
	notifyAllowed = true;
end

function VanasKoSNotifier:Player_Detected(message, data)
	assert(data.name ~= nil);
	
	if (data.faction == nil) then
		return
	end

	if (notifyAllowed ~= true) then
		return;
	end

	-- don't notify if we're in shattrah
	if(VanasKoSDataGatherer:IsInSanctuary() and not self.db.profile.notifyInShattrathEnabled) then
		return;
	end

	-- don't notify if we're in battleground
	if(VanasKoSDataGatherer:IsInBattleground()) then
		return;
	end

	if (data.faction == "kos") then
		VanasKoSNotifier:KosPlayer_Detected(data);
	elseif (data.faction == "enemy") then
		VanasKoSNotifier:EnemyPlayer_Detected(data);
	end
end

function VanasKoSNotifier:EnemyPlayer_Detected(data)
	assert(data.name ~= nil);

	if(self.db.profile.notifyEnemyTargets == false) then
		return;
	end
	notifyAllowed = false;
	-- Reallow Notifies in NotifyTimeInterval Time
	self:ScheduleTimer(ReenableNotifications, self.db.profile.NotifyTimerInterval);

	local msg = format(L["Enemy Detected:|cffff0000"]);
	if (data.level ~= nil) then
		--level can now be a string (eg. 44+)
		if ((tonumber(data.level) or 1) < 1) then
			msg = msg .. " [??]";
		else
			msg = msg .. " [" .. data.level .. "]";
		end
	end

	msg = msg .. " " .. data.name;

	if (data.guild ~= nil) then
		msg = msg .. " <" .. data.guild .. ">";
	end

	msg = msg .. "|r";

	if(self.db.profile.notifyVisual) then
		UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
	end
	if(self.db.profile.notifyChatframe) then
		VanasKoS:Print(msg);
	end
	if(self.db.profile.notifyFlashingBorder) then
		self:FlashNotify();
	end
	self:PlaySound(self.db.profile.enemyPlayName);
end

function VanasKoSNotifier:KosPlayer_Detected(data)
	assert(data.name ~= nil);

	-- get reasons for kos (if any)
	local pdata = VanasKoS:IsOnList("PLAYERKOS", data.name);
	local gdata = VanasKoS:IsOnList("GUILDKOS", data.guild);

	local msg = self:GetKoSString(data.name, data and data.guild, pdata and pdata.reason, pdata and pdata.creator, pdata and pdata.owner, gdata and gdata.reason, gdata and gdata.creator, gdata and gdata.owner);

	if(self.db.profile.notifyOnlyMyTargets and ((pdata and pdata.owner ~= nil) or (gdata and gdata.owner ~= nil))) then
		return;
	end

	notifyAllowed = false;
	-- Reallow Notifies in NotifyTimeInterval Time
	self:ScheduleTimer(ReenableNotifications, self.db.profile.NotifyTimerInterval);

	if(self.db.profile.notifyVisual) then
		UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
	end
	if(self.db.profile.notifyChatframe) then
		VanasKoS:Print(msg);
	end
	if(self.db.profile.notifyFlashingBorder) then
		self:FlashNotify();
	end
	
	self:PlaySound(self.db.profile.playName);
end

-- /script VanasKoSNotifier:FlashNotify()
function VanasKoSNotifier:FlashNotify()
	flashNotifyFrame:Show();
	UIFrameFlash(VanasKoS_Notifier_Frame, FADE_IN_TIME, FADE_OUT_TIME, FLASH_TIMES*(FADE_IN_TIME + FADE_OUT_TIME));
end

function VanasKoSNotifier:PlaySound(value)
	local soundFileName = SML:Fetch("sound", value);
	PlaySoundFile(soundFileName);
end
