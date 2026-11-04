--[[----------------------------------------------------------------------
      VanasKoSLocals - Part of VanasKoS
Global variables local to VanasKoS
------------------------------------------------------------------------]]
local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS", false)

VANASKOS = {}

VANASKOS.DEBUG = false
--[===[@debug@
VANASKOS.DEBUG = true
--@end-debug@]===]

VANASKOS.NAME = "VanasKoS"
VANASKOS.COMMANDS = {"/kos"; "/vkos"; "/vanaskos"}
VANASKOS.VERSION = "0" -- filled later
VANASKOS.AUTHOR = "Vane of EU-Aegwynn"
VANASKOS.MAX_LIST_BUTTONS = 17
VANASKOS.MAX_LIST_COLS = 9

BINDING_HEADER_VANASKOS_HEADER = "VanasKoS"
BINDING_NAME_VANASKOS_TEXT_TOGGLE_MENU = "Toggle VanasKoS window"

VANASKOS.NewVersionNotice = nil
VANASKOS.Lists = {}
VANASKOS.selectedEntry = nil
VANASKOS.showList = nil
VANASKOS.showGroup = 1
