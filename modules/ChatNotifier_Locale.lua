--[[----------------------------------------------------------------------
	ChatNotifier Module - Part of VanasKoS
modifies the ChatMessage if a player speaks whom is on your hatelist
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "enUS", true)
if L then
	L["Add Lookup in VanasKoS"] = true
	L["Chat Modifications"] = true
	L["Hatelist Color"] = true
	L["Lookup in VanasKoS"] = true
	L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = true
	L["Modifies the Chat only for your Entries"] = true
	L["Modifies the Chat Window for Hate/Nicelist Entries."] = true
	L["Modify only my Entries"] = true
	L["Nicelist Color"] = true
	L["No entry for |cff00ff00%s|r"] = true
	L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = true
	L["Sets the Foreground Color for Hatelist Entries"] = true
	L["Sets the Foreground Color for Nicelist Entries"] = true
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
