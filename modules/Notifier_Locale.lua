--[[----------------------------------------------------------------------
      Notifier Module - Part of VanasKoS
Notifies the user via Tooltip, Chat and Upper Area of a KoS/other List Target
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "enUS", true)
if L then
	L["Additional Reason Window"] = true
	L["Enabled"] = true
	L["Enemy Detected:|cffff0000"] = true
	L["Locked"] = true
	L["Notification Interval (seconds)"] = true
	L["Notification in the Chatframe"] = true
	L["Notification in the Upper Area"] = true
	L["Notifications"] = true
	L["Notification through flashing Border"] = true
	L["Notification through Target Portrait"] = true
	L["Notify in Sanctuary"] = true
	L["Notify of any enemy target"] = true
	L["Notify only on my KoS-Targets"] = true
	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = true
	L["Show Anchor"] = true
	L["Show PvP-Stats in Tooltip"] = true
	L["Sound on enemy detection"] = true
	L["Sound on KoS detection"] = true

	L["KoS: %s"]         = true
	L["KoS (Guild): %s"] = true
	L["Hatelist: %s"]    = true
	L["Nicelist: %s"]    = true
	L["Wanted: %s"]      = true
	L["%sKoS: %s"]         = "|cffff00ff%s's|r KoS: %s"
	L["%sKoS (Guild): %s"] = "|cffff00ff%s's|r KoS (Guild): %s"
	L["%sHatelist: %s"]    = "|cffff00ff%s's|r Hatelist: %s"
	L["%sNicelist: %s"]    = "|cffff00ff%s's|r Nicelist: %s"
	L["%sWanted: %s"]      = "|cffff00ff%s's|r Wanted: %s"
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS/Notifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS/Notifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS/Notifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS/Notifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS/Notifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS/Notifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS/Notifier")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS/Notifier")@
end
