-- Definitions based on Locales

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "enUS", true)
if L then
-- auto generated from wowace translation app
--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, namespace="VanasKoS")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS")@
end

VANASKOS = { };

VANASKOS.NAME = "VanasKoS";
VANASKOS.COMMANDS = {"/kos"; "/vkos"; "/vanaskos"};
VANASKOS.VERSION = "0"; -- filled later
VANASKOS.LastNameEntered = "";
VANASKOS.AUTHOR = "Vane of EU-Aegwynn";

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS", false);

BINDING_HEADER_VANASKOS_HEADER = L["Vanas KoS"];
BINDING_NAME_VANASKOS_TEXT_TOGGLE_MENU = L["Toggle Menu"];
BINDING_NAME_VANASKOS_TEXT_ADD_PLAYER = L["Add KoS Player"];

VANASKOS.DEBUG = false;
--@debug@
VANASKOS.DEBUG = true;
--@end-debug@
VANASKOS.NewVersionNotice = nil;

