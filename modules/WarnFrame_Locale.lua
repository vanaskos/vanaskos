--[[----------------------------------------------------------------------
      WarnFrame Module - Part of VanasKoS
Creates the WarnFrame to alert of nearby KoS, Hostile and Friendly
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "enUS", true)
if L then
	L["Background"] = true
	L["Background Color"] = true
	L["Configuration"] = true
	L["Content"] = true
	L["Controls the design of the warning window"] = true
	L["Default Background Color"] = true
	L["Design"] = true
	L["female"] = true
	L["Font Size"] = true
	L["Friendly"] = true
	L["Grow list from the bottom of the WarnFrame"] = true
	L["Grow list upwards"] = true
	L["Hide if inactive"] = true
	L["Hostile"] = true
	L["How friendly content is shown"] = true
	L["How hostile content is shown"] = true
	L["How kos content is shown"] = true
	L["How neutral content is shown"] = true
	L["KoS"] = true
	L["KoS/Enemy/Friendly Warning Window"] = true
	L["Locked"] = true
	L["male"] = true
	L["Macro"] = true
	L["Macro Text"] = true
	L["Macro to execute on click"] = true
	L["More Allied than Hostiles Background Color"] = true
	L["More Hostiles than Allied Background Color"] = true
	L["Neutral"] = true
	L["No Information Available"] = true
	L["Number of lines"] = true
	L["Dynamic resize"] = true
	L["Sets number of entries to display in the WarnFrame based on nearby player count"] = true
	L["Remove delay"] = true
	L["Reset"] = true
	L["Reset macro to default"] = true
	L["Reset Position"] = true
	L["Reset Settings"] = true
	L["Sets the default Background Color and Opacity"] = true
	L["Sets the KoS majority Color and Opacity"] = true
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = true
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = true
	L["Sets the normal text color"] = true
	L["Sets the number of entries to display in the Warnframe"] = true
	L["Sets the number of seconds before entry is removed"] = true
	L["Sets the size of the font in the Warnframe"] = true
	L["Sets the text of the macro to be executed when a name is clicked"] = true
	L["Sets the text of the macro to be executed when a name is clicked. An example can be found in the macros.txt file"] = true
	L["Show additional Information on Mouse Over"] = true
	L["Show border"] = true
	L["Show class icons"] = true
	L["Show Friendly Targets"] = true
	L["Show Hostile Targets"] = true
	L["Show KoS Targets"] = true
	L["Show Target Level When Possible"] = true
	L["Text"] = true
	L["Toggles the display of additional Information on Mouse Over"] = true
	L["Toggles the display of Class icons in the Warnframe"] = true
	L["Warning Window"] = true
	L["What to show in the warning window"] = true

	L["Zones"] = true
	L["Zones to show the warning window in"] = true
	L["Battlegrounds"] = true
	L["Show in battlegrounds and pvp zones"] = true
	L["Dungeon"] = true
	L["Show in dungeon instances"] = true
	L["Arena"] = true
	L["Show in arenas"] = true
	L["Cities"] = true
	L["Show in cities"] = true
	L["Sanctuaries"] = true
	L["Show in sanctuaries"] = true
	L["Combat Zones"] = true
	L["Show in combat zones"] = true

	L["KoS: %s"] = true
	L["%sKoS: %s"] = true
	L["KoS (Guild): %s"] = true
	L["%sKoS (Guild): %s"] = true
	L["Nicelist: %s"] = true
	L["%sNicelist: %s"] = true
	L["Hatelist: %s"] = true
	L["%sHatelist: %s"] = true
	L["Wanted: %s"] = true
	L["%sWanted: %s"] = true

	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = true
	L["Alignment"] = true
	L["Sets warnframe font alignment"] = true
	L["LEFT"] = true
	L["CENTER"] = true
	L["RIGHT"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS/WarnFrame")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS/WarnFrame")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS/WarnFrame")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS/WarnFrame")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS/WarnFrame")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS/WarnFrame")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS/WarnFrame")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS/WarnFrame")@
end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/WarnFrame", false);
