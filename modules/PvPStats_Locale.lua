--[[----------------------------------------------------------------------
      PvPStats Module - Part of VanasKoS
Displays Stats about PvP in a window
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "enUS", true)
if L then
	L["All Characters"] = true
	L["All Time"] = true
	L["Last 24 hours"] = true
	L["Last Month"] = true
	L["Last Week"] = true
	L["Losses: |cffff0000%d|r (%.1f%%)"] = true
	L["PvP Stats"] = true
	L["Wins: |cff00ff00%d|r (%.1f%%)"] = true
	L["Enemies"] = true
	L["Map"] = true
	L["Date"] = true
	L["Total"] = true
	L["Average Level"] = true

	L["Lost"] = true
	L["Score"] = true
	L["PvP Data Gathering"] = true
	L["PvP Stats"] = true
	L["by losses"] = true
	L["sort by most losses"] = true
	L["by encounters"] = true
	L["sort by most PVP encounters"] = true
	L["by wins"] = true
	L["sort by most wins"] = true
	L["by score"] = true
	L["sort by most wins to losses"] = true
	L["by name"] = true
	L["sort by name"] = true

	L["Players"] = true
	L["Enemy level"] = true
	L["My level"] = true
	L["Level difference"] = true

	L["Add to Player KoS"] = true
	L["Add to Hatelist"] = true
	L["Add to Nicelist"] = true
	L["Remove Entry"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end
