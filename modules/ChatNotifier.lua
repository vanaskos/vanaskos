--[[----------------------------------------------------------------------
	ChatNotifier Module - Part of VanasKoS
modifies the ChatMessage if a player speaks whom is on your hatelist
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "enUS", true, VANASKOS.DEBUG)
if L then
-- auto generated from wowace translation app
--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, namespace="VanasKoS/ChatNotifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS/ChatNotifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS/ChatNotifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS/ChatNotifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS/ChatNotifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS/ChatNotifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS/ChatNotifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS/ChatNotifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS/ChatNotifier")@
end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/ChatNotifier", false);

VanasKoSChatNotifier = VanasKoS:NewModule("ChatNotifier", "AceHook-3.0");

local VanasKoSChatNotifier = VanasKoSChatNotifier;
local VanasKoS = VanasKoS;

local function SetLookup(enable)
	if(enable) then
		if(not VanasKoSChatNotifier:IsHooked("UnitPopup_ShowMenu")) then
			VanasKoSChatNotifier:SecureHook("UnitPopup_ShowMenu");
		end
	else
		if(VanasKoSChatNotifier:IsHooked("UnitPopup_ShowMenu")) then
			VanasKoSChatNotifier:Unhook("UnitPopup_ShowMenu");
		end
	end
end

local function GetColor(which)
	return VanasKoSChatNotifier.db.profile[which .. "R"], VanasKoSChatNotifier.db.profile[which .. "G"], VanasKoSChatNotifier.db.profile[which .. "B"], VanasKoSChatNotifier.db.profile[which .. "A"];
end

local function SetColor(which, r, g, b)
	VanasKoSChatNotifier.db.profile[which .. "R"] = r;
	VanasKoSChatNotifier.db.profile[which .. "G"] = g;
	VanasKoSChatNotifier.db.profile[which .. "B"] = b;
end

local function GetColorHex(which)
	local r,g,b,a = GetColor(which);

	return string.format("%02x%02x%02x", r*255, g*255, b*255);
end

function VanasKoSChatNotifier:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("ChatNotifier", {
		profile = {
			Enabled = true,
			OnlyMyEntries = false,
			AddLookupEntry = true,

			HateListColorR = 1.0,
			HateListColorG = 0.0,
			HateListColorB = 0.0,

			NiceListColorR = 0.0,
			NiceListColorG = 1.0,
			NiceListColorB = 0.0,
		}
	});

	self.configOptions = {
		type = 'group',
		name = L["Chat Modifications"],
		desc = L["Modifies the Chat Window for Hate/Nicelist Entries."],
		args = {
			hateListColor = {
				type = 'color',
				name = L["Hatelist Color"],
				desc = L["Sets the Foreground Color for Hatelist Entries"],
				order = 1,
				get = function() return GetColor("HateListColor") end,
				set = function(frame, r, g, b, a) SetColor("HateListColor", r, g, b); VanasKoSChatNotifier:Update(); end,
				hasAlpha = false,
			},
			niceListColor = {
				type = 'color',
				name = L["Nicelist Color"],
				desc = L["Sets the Foreground Color for Nicelist Entries"],
				order = 2,
				get = function() return GetColor("NiceListColor") end,
				set = function(frame, r, g, b, a) SetColor("NiceListColor", r, g, b); VanasKoSChatNotifier:Update(); end,
				hasAlpha = false,
			},
			modifyOnlyMyEntries = {
				type = 'toggle',
				name = L["Modify only my Entries"],
				desc = L["Modifies the Chat only for your Entries"],
				order = 3,
				set = function(frame, v) VanasKoSChatNotifier.db.profile.OnlyMyEntries = v; end,
				get = function() return VanasKoSChatNotifier.db.profile.OnlyMyEntries; end,
			},
			addLookupEntry = {
				type = 'toggle',
				name = L["Add Lookup in VanasKoS"],
				desc = L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."],
				order = 4,
				set = function(frame, v) VanasKoSChatNotifier.db.profile.AddLookupEntry = v; SetLookup(v); end,
				get = function() return VanasKoSChatNotifier.db.profile.AddLookupEntry; end,
			},
		}
	};

	VanasKoSGUI:AddModuleToggle("ChatNotifier", L["Chat Modifications"])
	VanasKoSGUI:AddConfigOption("ChatNotifier", self.configOptions);
	
	self:SetEnabledState(self.db.profile.Enabled);
end

function VanasKoSChatNotifier:OnEnable()
	self:Update();
	self:RawHook("ChatFrame_OnEvent", true);
	SetLookup(self.db.profile.AddLookupEntry);
end

function VanasKoSChatNotifier:OnDisable()
	self:Unhook("ChatFrame_OnEvent");
	if(self.db.profile.AddLookupEntry) then
		SetLookup(false);
	end
end

function VanasKoSChatNotifier:UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
	if(which ~= "FRIEND") then
		return;
	end

	-- Only create menus for the top level
	if (UIDROPDOWNMENU_MENU_LEVEL > 1) then
		return;
	end

	local info = UIDropDownMenu_CreateInfo();
	info.text = L["Lookup in VanasKoS"];
	info.value = "VANASKOS_LOOKUP";
	info.owner = which;
	info.func = VanasKoSChatNotifier_UnitPopup_OnClick;
	info.arg1 = name;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
end

function VanasKoSChatNotifier_UnitPopup_OnClick(self, name)
	assert(name);

	local data, list = VanasKoS:IsOnList(nil, name);
	if(list ~= nil) then
		VanasKoS:Print(format(L["Player: %s is on List: %s - Reason: %s"], name, VanasKoS:GetListNameByShortName(list), data.reason or ""));
	else
		VanasKoS:Print(format(L["No entry for %s"], name));
	end
end

-- tnx to tastethenaimbow for the idea on how to do it
local channelWatchList = {
	["CHAT_MSG_CHANNEL"] = "CHAT_CHANNEL_GET",
	["CHAT_MSG_GUILD"] = "CHAT_GUILD_GET",
	["CHAT_MSG_PARTY"] = "CHAT_PARTY_GET",
	["CHAT_MSG_RAID"] = "CHAT_RAID_GET",
	["CHAT_MSG_RAID_LEADER"] = "CHAT_RAID_LEADER_GET",
	["CHAT_MSG_SAY"] = "CHAT_SAY_GET",
	["CHAT_MSG_WHISPER"] = "CHAT_WHISPER_GET",
	["CHAT_MSG_OFFICER"] = "CHAT_OFFICER_GET",
	["CHAT_MSG_WHISPER_INFORM"] = "CHAT_WHISPER_INFORM_GET",
}

local HATELISTCOLOR = "ff0000";
local NICELISTCOLOR = "00ff00";

function VanasKoSChatNotifier:ChatFrame_OnEvent(frame, event, ...)

	-- if switched to disabled, remove hook on first intercept
	if(not VanasKoSChatNotifier.enabledState) then
		local ret = self.hooks["ChatFrame_OnEvent"](frame, event, ...);
		self:Unhook("ChatFrame_OnEvent");
		return ret;
	end
	if(channelWatchList[event]) then
		local listColor = (VanasKoS:BooleanIsOnList("HATELIST", arg2) and HATELISTCOLOR) or
							(VanasKoS:BooleanIsOnList("NICELIST", arg2) and NICELISTCOLOR);

		if(listColor) then
			if(self.db.profile.OnlyMyEntries) then
				local data1 = VanasKoS:IsOnList("HATELIST", arg2);
				local data2 = VanasKoS:IsOnList("NICELIST", arg2);

				if( (data1 and data1.owner and not data2) or -- hatelist entry from someone else, no nicelist entry
					(data2 and data2.owner and not data1) or -- nicelist entry from someone else, no hatelist entry
					(data1 and data1.owner and data2 and data2.owner) -- hatelist and nicelist entry from someone else
					) then
					return self.hooks["ChatFrame_OnEvent"](frame, event, ...);
				end

				if(data1 and not data1.owner) then
					listColor = HATELISTCOLOR;
				elseif(data2 and not data2.owner) then
					listColor = NICELISTCOLOR;
				end
			end

			local originalText = getglobal(channelWatchList[event]);
			setglobal(channelWatchList[event], gsub(originalText, "%%s", "|cff" .. listColor .. "%%s|r"));

			local ret = self.hooks["ChatFrame_OnEvent"](frame, event, ...);

			setglobal(channelWatchList[event], originalText);

			return ret;
		end
	end

	return self.hooks["ChatFrame_OnEvent"](frame, event, ...);
end

function VanasKoSChatNotifier:Update()
	HATELISTCOLOR = GetColorHex("HateListColor");
	NICELISTCOLOR = GetColorHex("NiceListColor");
end
