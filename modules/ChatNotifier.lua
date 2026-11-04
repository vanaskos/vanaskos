--[[----------------------------------------------------------------------
	ChatNotifier Module - Part of VanasKoS
modifies the ChatMessage if a player speaks whom is on your hatelist
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/ChatNotifier", false)
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")
local VanasKoSGUI = VanasKoS:GetModule("GUI")
local VanasKoSChatNotifier = VanasKoS:NewModule("ChatNotifier", "AceHook-3.0")

-- declare common globals local
local format = format
local select = select
local pairs = pairs
local type = type
local assert = assert
local hashName = VanasKoS.hashName
local splitNameRealm = VanasKoS.splitNameRealm
local Compat = VANASKOS.Compat
local AddMessageEventFilter = (ChatFrameUtil and ChatFrameUtil.AddMessageEventFilter) or ChatFrame_AddMessageEventFilter
local RemoveMessageEventFilter = (ChatFrameUtil and ChatFrameUtil.RemoveMessageEventFilter) or ChatFrame_RemoveMessageEventFilter

-- Constants
local HATELISTCOLOR = "ff0000"
local NICELISTCOLOR = "00ff00"
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

function VanasKoSChatNotifier:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("ChatNotifier", {
		profile = {
			Enabled = true,
			OnlyMyEntries = false,

			HateListColorR = 1.0,
			HateListColorG = 0.0,
			HateListColorB = 0.0,

			NiceListColorR = 0.0,
			NiceListColorG = 1.0,
			NiceListColorB = 0.0,
		}
	})

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
				get = function()
					return VanasKoSChatNotifier:GetColor("HateListColor")
				end,
				set = function(frame, r, g, b, a)
					VanasKoSChatNotifier:SetColor("HateListColor", r, g, b)
					VanasKoSChatNotifier:Update()
				end,
				hasAlpha = false,
			},
			niceListColor = {
				type = 'color',
				name = L["Nicelist Color"],
				desc = L["Sets the Foreground Color for Nicelist Entries"],
				order = 2,
				get = function()
				    return VanasKoSChatNotifier:GetColor("NiceListColor")
				end,
				set = function(frame, r, g, b, a)
					VanasKoSChatNotifier:SetColor("NiceListColor", r, g, b)
					VanasKoSChatNotifier:Update()
				end,
				hasAlpha = false,
			},
			modifyOnlyMyEntries = {
				type = 'toggle',
				name = L["Modify only my Entries"],
				desc = L["Modifies the Chat only for your Entries"],
				order = 3,
				set = function(frame, v)
					VanasKoSChatNotifier.db.profile.OnlyMyEntries = v
				end,
				get = function()
					return VanasKoSChatNotifier.db.profile.OnlyMyEntries
				end,
			}
		}
	}

	VanasKoSGUI:AddModuleToggle("ChatNotifier", L["Chat Modifications"])
	VanasKoSGUI:AddConfigOption("ChatNotifier", self.configOptions)

	self:SetEnabledState(self.db.profile.Enabled)
end

-- Chat message filter: adds a "(Hated)"/"(Liked)" tag in front of messages
-- from players on the hate/nice list. (Older versions hooked
-- ChatFrame_OnEvent, which modern clients no longer allow addons to do safely.)
local function ChatFilter(chatFrame, event, msg, author, ...)
	return VanasKoSChatNotifier:FilterMessage(event, msg, author, ...)
end

function VanasKoSChatNotifier:OnEnable()
	self:Update()
	if AddMessageEventFilter and not self.filtersAdded then
		for event in pairs(channelWatchList) do
			AddMessageEventFilter(event, ChatFilter)
		end
		self.filtersAdded = true
	end
end

function VanasKoSChatNotifier:OnDisable()
	if RemoveMessageEventFilter and self.filtersAdded then
		for event in pairs(channelWatchList) do
			RemoveMessageEventFilter(event, ChatFilter)
		end
		self.filtersAdded = nil
	end
end

function VanasKoSChatNotifier:GetColor(w)
	return self.db.profile[w .. "R"], self.db.profile[w .. "G"], self.db.profile[w .. "B"], 1
end

function VanasKoSChatNotifier:SetColor(which, r, g, b, a)
	self.db.profile[which .. "R"] = r
	self.db.profile[which .. "G"] = g
	self.db.profile[which .. "B"] = b
end

function VanasKoSChatNotifier:GetColorHex(which)
	local r, g, b = self:GetColor(which)

	return format("%02x%02x%02x", r*255, g*255, b*255)
end

function VanasKoSChatNotifier:FilterMessage(event, msg, author, ...)
	if(not self.enabledState or not channelWatchList[event]) then
		return false, msg, author, ...
	end
	-- chat can carry secret values on newer clients (e.g. in instances); leave those alone
	if(Compat.IsSecret(msg) or Compat.IsSecret(author) or type(msg) ~= "string" or type(author) ~= "string" or author == "") then
		return false, msg, author, ...
	end

	local name, realm = splitNameRealm(author)
	if not realm or realm == "" then
		realm = GetRealmName()
	end
	local key = name and hashName(name, realm)
	if not key then
		return false, msg, author, ...
	end

	local listColor
	local listName
	if VanasKoS:BooleanIsOnList("HATELIST", key) then
		listColor = HATELISTCOLOR
		listName = L["Hated"]
	elseif VanasKoS:BooleanIsOnList("NICELIST", key) then
		listColor = NICELISTCOLOR
		listName = L["Liked"]
	end

	if(listColor) then
		if(self.db.profile.OnlyMyEntries) then
			local data1 = VanasKoS:IsOnList("HATELIST", key)
			local data2 = VanasKoS:IsOnList("NICELIST", key)

			if( (data1 and data1.owner and not data2) or -- hatelist entry from someone else, no nicelist entry
				(data2 and data2.owner and not data1) or -- nicelist entry from someone else, no hatelist entry
				(data1 and data1.owner and data2 and data2.owner) -- hatelist and nicelist entry from someone else
				) then
				return false, msg, author, ...
			end

			if(data1 and not data1.owner) then
				listColor = HATELISTCOLOR
				listName = L["Hated"]
			elseif(data2 and not data2.owner) then
				listColor = NICELISTCOLOR
				listName = L["Liked"]
			end
		end

		return false, "|cff" .. listColor .. "(" .. listName .. ")|r " .. msg, author, ...
	end
	return false, msg, author, ...
end

function VanasKoSChatNotifier:Update()
	HATELISTCOLOR = self:GetColorHex("HateListColor")
	NICELISTCOLOR = self:GetColorHex("NiceListColor")
end
