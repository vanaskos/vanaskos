--[[----------------------------------------------------------------------
      EventMap Module - Part of VanasKoS
Displays PvP Events on World Map
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "enUS", true)
if L then
	L["|cffff0000%s - %s killed by %s|r"] = true
	L["|cff00ff00%s - %s killed %s|r"] = true
	L["Colored dots"] = true
	L["Dot Options"] = true
	L["Draw Alts"] = true
	L["Drawing mode"] = true
	L["Draws PvP events on map for all characters"] = true
	L["Dynamic Zoom"] = true
	L["Icon Options"] = true
	L["Icons"] = true
	L["PvP Encounter"] = true
	L["PvP Event Map"] = true
	L["Redraws icons based on Cartographer3 zoom level"] = true
	L["Reset"] = true
	L["Reset dots to default"] = true
	L["Sets the loss color and opacity"] = true
	L["Sets the win color and opacity"] = true
	L["Show tooltips when hovering over PvP events"] = true
	L["Size"] = true
	L["Size of dots"] = true
	L["Toggle showing individual icons or simple dots"] = true
	L["Tooltips"] = true
	L["Remove events"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS/EventMap")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS/EventMap")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS/EventMap")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS/EventMap")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS/EventMap")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS/EventMap")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS/EventMap")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS/EventMap")@
end
