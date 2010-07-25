--[[----------------------------------------------------------------------
      Notifier Module - Part of VanasKoS
Notifies the user via Tooltip, Chat and Upper Area of a KoS/other List Target
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "enUS", true)
if L then
	L["Interval (seconds)"] = true
	L["Notification Interval (seconds)"] = true
	L["Chat message"] = true
	L["Notification in the Chatframe"] = true
	L["On-screen"] = true
	L["Notification in the Upper Area"] = true
	L["Notifications"] = true
	L["Party notification"] = true
	L["Notify when a player in hate list or nice list joins your party"] = true
	L["Flashing Border"] = true
	L["Notification through flashing Border"] = true
	L["Dragon Portrait"] = true
	L["Notification through Target Portrait"] = true
	L["Notify in Sanctuary"] = true
	L["All enemies"] = true
	L["Notify of any enemy target"] = true
	L["Mine only"] = true
	L["Notify only on my KoS-Targets"] = true
	L["Raid Browser"] = true
	L["Colors players in raid browser based on hated/nice status"] = true
	L["Friend list"] = true
	L["Colors players in friend list based on hated/nice status"] = true
	L["Ignore list"] = true
	L["Colors players in ignore list based on hated/nice status"] = true
	L["Stats in Tooltip"] = true
	L["Show PvP-Stats in Tooltip"] = true
	L["Sounds"] = true
	L["Notification sounds"] = true
	L["Enemy Sound"] = true
	L["Sound on enemy detection"] = true
	L["KoS Sound"] = true
	L["Sound on KoS detection"] = true
	L["Hated sound"] = true
	L["Sound when a hated player joins your raid or party"] = true
	L["Nice sound"] = true
	L["Sound when a nice player joins your raid or party"] = true
	L["Extra Reason"] = true
	L["Additional Reason Window"] = true
	L["Enabled"] = true
	L["Show Anchor"] = true
	L["Locked"] = true

	L["Enemy Detected:|cffff0000"] = true
	L["Hated player \"%s\" (%s) is in your party"] = true
	L["Nice player \"%s\" (%s) is in your party"] = true
	L["Hated player \"%s\" (%s) is in your raid"] = true
	L["Nice player \"%s\" (%s) is in your raid"] = true

	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = true
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
