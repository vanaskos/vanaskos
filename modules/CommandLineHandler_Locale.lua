--[[----------------------------------------------------------------------
      CommandLineHandler Module - Part of VanasKoS
		Handles the CommandLine
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/CommandLineHandler", "enUS", true)
if L then
	L["CONFIG_DESC"] = "Open the configuration window"
	L["CONFIG_USAGE %s"] = "Usage: /%s"
	L["KADD_DESC"] = "Adds a player or <guild> to your kos/hate/nice list"
	L["KADD_NAME"] = "name or <guild name>  -- Name of player or <guild name>"
	L["KADD_REASON"] = "reason -- Reason for adding player or <guild>"
	L["KADD_TYPE"] = "list -- hate, nice, kos"
	L["KADD_USAGE %s"] = "Usage: /%s [list] [name] [reason]"
	L["KOS_CMD"] = "cmd -- menu, config, add"
	L["KOS_DESC %s"] = "VanasKoS CLI. Try /%s cmd help"
	L["KOS_USAGE %s"] = "Usage: /%s [cmd] [args ...]"
	L["MENU_DESC"] = "Open the main KoS list window"
	L["MENU_USAGE %s"] = "Usage: /%s"
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/CommandLineHandler", "frFR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/CommandLineHandler
	L["CONFIG_DESC"] = "Ouvrez la fenêtre de configuration"
	L["CONFIG_USAGE %s"] = "Utilisation: /%s"
	L["KADD_DESC"] = "Ajoute un joueur ou à votre <guild> kos / haine / belle liste"
	L["KADD_NAME"] = "nom ou <nom guild> - Nom du joueur ou <nom guild>"
	L["KADD_REASON"] = "raison - la raison pour l'ajout de joueur ou <guild>"
	L["KADD_TYPE"] = "liste - la haine, Nice, Kos"
	L["KADD_USAGE %s"] = "Utilisation: /%s [list] [nom] [raison]"
	L["KOS_CMD"] = "cmd -- menu, config, add"
	L["KOS_DESC %s"] = "CLI VanasKoS. Try / %s  cmd help Essayez /%s cmd aider"
	L["KOS_USAGE %s"] = "Utilisation: /%s [cmd] [args ...]"
	L["MENU_DESC"] = "Ouvrez la fenêtre de la liste principale KoS"
	L["MENU_USAGE %s"] = "Utilisation: /%s"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/CommandLineHandler", "deDE")
if L then
-- auto generated from wowace translation app
-- VanasKoS/CommandLineHandler
	L["CONFIG_DESC"] = "Konfigurationsfenster öffnen"
	L["CONFIG_USAGE %s"] = "Anwendung: /%s"
	L["KADD_DESC"] = "Fügt einen Spieler oder <Gilde> deiner KoS/Hass/Nett-Liste hinzu"
	L["KADD_NAME"] = "name or <guild name> -- Name des Spielers oder <Name der Gilde>"
	L["KADD_REASON"] = "reason -- Grund, diesen Spieler oder <Gilde> hinzuzufügen"
	L["KADD_TYPE"] = "list -- Hass, Nett, KoS"
	L["KADD_USAGE %s"] = "Anwendung: /%s [list] [name] [reason]"
	L["KOS_CMD"] = "cmd -- menu, config, add"
	L["KOS_DESC %s"] = "VanasKoS CLI. Versuche /%s cmd help"
	L["KOS_USAGE %s"] = "Anwendung: /%s [cmd] [args ...]"
	L["MENU_DESC"] = "Hauptfenster von KoS-Liste öffnen"
	L["MENU_USAGE %s"] = "Anwendung: /%s"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/CommandLineHandler", "koKR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/CommandLineHandler
	--[[Translation missing --]]
	--[[ L["CONFIG_DESC"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["CONFIG_USAGE %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_DESC"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_NAME"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_REASON"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_TYPE"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_USAGE %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KOS_CMD"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KOS_DESC %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KOS_USAGE %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["MENU_DESC"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["MENU_USAGE %s"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/CommandLineHandler", "esMX")
if L then
-- auto generated from wowace translation app
-- VanasKoS/CommandLineHandler
	--[[Translation missing --]]
	--[[ L["CONFIG_DESC"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["CONFIG_USAGE %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_DESC"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_NAME"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_REASON"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_TYPE"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_USAGE %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KOS_CMD"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KOS_DESC %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KOS_USAGE %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["MENU_DESC"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["MENU_USAGE %s"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/CommandLineHandler", "ruRU")
if L then
-- auto generated from wowace translation app
-- VanasKoS/CommandLineHandler
	L["CONFIG_DESC"] = "Открыть окно настроек"
	L["CONFIG_USAGE %s"] = "Использование: /%s"
	L["KADD_DESC"] = "Добавляет игрока или <guild> к вашему кос / ненависть / славного списка"
	L["KADD_NAME"] = "имя или <guild name> -- имя игрока или <guild name>"
	L["KADD_REASON"] = "причина -- Причина для добавления игрока или <guild>"
	L["KADD_TYPE"] = "список -- ненавижу, красиво, кос"
	L["KADD_USAGE %s"] = "Использование: /%s [список] [имя] [причина]"
	L["KOS_CMD"] = "cmd - меню, конфигурация, добавить"
	--[[Translation missing --]]
	--[[ L["KOS_DESC %s"] = ""--]] 
	L["KOS_USAGE %s"] = "Использование: /%s [cmd] [аргументы ...]"
	L["MENU_DESC"] = "Открыть главное окно списка Кос"
	L["MENU_USAGE %s"] = "Использование: /%s"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/CommandLineHandler", "zhCN")
if L then
-- auto generated from wowace translation app
-- VanasKoS/CommandLineHandler
	L["CONFIG_DESC"] = "打开配置窗口"
	L["CONFIG_USAGE %s"] = "用法：/%s"
	L["KADD_DESC"] = "添加一个玩家或<公会>到你的仇敌/仇恨/友好列表"
	L["KADD_NAME"] = "name or <guild name> -- 玩家名称或<公会名称>"
	L["KADD_REASON"] = "reason -- 为何添加玩家或<公会>"
	L["KADD_TYPE"] = "list -- 仇恨，友好，仇敌"
	L["KADD_USAGE %s"] = "用法：/%s [list] [name] [reason]"
	L["KOS_CMD"] = "cmd -- 菜单，配置，添加"
	L["KOS_DESC %s"] = "VanasKoS 命令行。尝试 /%s cmd help"
	L["KOS_USAGE %s"] = "用法：/%s [cmd] [args ...]"
	L["MENU_DESC"] = "打开主仇敌列表窗口"
	L["MENU_USAGE %s"] = "用法：/%s"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/CommandLineHandler", "esES")
if L then
-- auto generated from wowace translation app
-- VanasKoS/CommandLineHandler
	--[[Translation missing --]]
	--[[ L["CONFIG_DESC"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["CONFIG_USAGE %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_DESC"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_NAME"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_REASON"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_TYPE"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KADD_USAGE %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KOS_CMD"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KOS_DESC %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KOS_USAGE %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["MENU_DESC"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["MENU_USAGE %s"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/CommandLineHandler", "zhTW")
if L then
-- auto generated from wowace translation app
-- VanasKoS/CommandLineHandler
	L["CONFIG_DESC"] = "打開選項視窗"
	L["CONFIG_USAGE %s"] = "用法: /%s"
	L["KADD_DESC"] = "增加一個玩家或者<公會>到你的仇敵/討厭/好人列表"
	L["KADD_NAME"] = "name or <guild name> -- 玩家的名字還是<行會的名字>"
	L["KADD_REASON"] = "reason -- 加入玩家的原因還是<行會>"
	L["KADD_TYPE"] = "list -- hate (討厭), nice (好), kos (看死亡)"
	L["KADD_USAGE %s"] = "用法: /%s [list] [name] [reason]"
	--[[Translation missing --]]
	--[[ L["KOS_CMD"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KOS_DESC %s"] = ""--]] 
	L["KOS_USAGE %s"] = "用法: /%s [cmd] [args ...]"
	L["MENU_DESC"] = "打開主要的KOS名單視窗"
	L["MENU_USAGE %s"] = "用法: /%s"

end
