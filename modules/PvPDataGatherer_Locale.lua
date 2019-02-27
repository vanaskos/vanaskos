--[[---------------------------------------------------------------------------------------------
      PvPDataGatherer Module - Part of VanasKoS
Gathers PvP Wins and Losses
---------------------------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "enUS", true)
if L then
	L["Enemy"] = true
	L["Player"] = true
	L["Date"] = true
	L["Type"] = true
	L["PvP Log"] = true
	L["PvP Data Gathering"] = true
	L["PvP Loss versus %s registered."] = true
	L["PvP Win versus %s registered."] = true
	L["by name"] = true
	L["sort by name"] = true
	L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = true
	L["Events"] = true
	L["Players"] = true
	L["Zone"] = true
	L["unknown"] = true
	L["by name"] = true
	L["sort by name"] = true
	L["Enable in Battleground"] = true
	L["Toggles logging of PvP events in battlegrounds"] = true
	L["Enable in combat zone"] = true
	L["Toggles logging of PvP events in combat zones (Wintergrasp, Tol Barad)"] = true
	L["Enable in arena"] = true
	L["Toggles logging of PvP events in arenas"] = true
	L["Defeat Logging Method"] = true
	L["Method used to record defeats"] = "Method used to record defeats.\n\nKilling Blow - Blame death on player who made the killing blow to you.\n\nMost Damage - Blame death on player who did the most damage to you.\n\nAll Attackers - Blame death on all players who recently attacked you"
	L["Killing Blow"] = true
	L["Most Damage"] = true
	L["All Attackers"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS/PvPDataGatherer")@
end
