--[[---------------------------------------------------------------------------------------------
      PvPDataGatherer Module - Part of VanasKoS
Gathers PvP Wins and Losses
---------------------------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "enUS", true)
if L then
	L["Name"] = true
	L["Win"] = true
	L["Lost"] = true
	L["PvP"] = true
	L["Score"] = true
	L["PvP Data Gathering"] = true
	L["PvP Loss versus %s registered."] = true
	L["PvP Stats"] = true
	L["PvP Win versus %s registered."] = true
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
	L["wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = true
	L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = true
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
