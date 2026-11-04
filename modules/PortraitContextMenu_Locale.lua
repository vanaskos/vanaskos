--[[----------------------------------------------------------------------
	TargetPortraitContextMenu Module - Part of VanasKoS
modifies the TargetPortrait to add context menu options for adding targets to lists
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PortraitContextMenu", "enUS", true)
if L then
	L["Add to %s"] = true
	L["Context Menu"] = true
	L["Vanas|cffff0000KoS|r"] = true
	L["Lookup in VanasKoS"] = true
	L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = true
	L["No entry for |cff00ff00%s|r"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PortraitContextMenu", "frFR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PortraitContextMenu
	L["Add to %s"] = "Ajouter - %s"
	L["Context Menu"] = "Menu contextuel"
	--[[Translation missing --]]
	--[[ L["Lookup in VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["No entry for |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Vanas|cffff0000KoS|r"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PortraitContextMenu", "deDE")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PortraitContextMenu
	L["Add to %s"] = "Zu %s hinzufügen"
	L["Context Menu"] = "Kontextmenü"
	L["Lookup in VanasKoS"] = "In VanasKoS suchen"
	L["No entry for |cff00ff00%s|r"] = "Kein Eintrag für |cff00ff00%s|r"
	L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = "Spieler: |cff00ff00%s|r ist auf Liste: |cff00ff00%s|r - Grund: |cff00ff00%s|r"
	L["Vanas|cffff0000KoS|r"] = "Vanas|cffff0000KoS|r"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PortraitContextMenu", "koKR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PortraitContextMenu
	L["Add to %s"] = "%s에 추가"
	--[[Translation missing --]]
	--[[ L["Context Menu"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lookup in VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["No entry for |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Vanas|cffff0000KoS|r"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PortraitContextMenu", "esMX")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PortraitContextMenu
	--[[Translation missing --]]
	--[[ L["Add to %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Context Menu"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lookup in VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["No entry for |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Vanas|cffff0000KoS|r"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PortraitContextMenu", "ruRU")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PortraitContextMenu
	L["Add to %s"] = "Добавить в %s"
	L["Context Menu"] = "Контекстное меню"
	L["Lookup in VanasKoS"] = "Проверить в VanasKoS"
	--[[Translation missing --]]
	--[[ L["No entry for |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = ""--]] 
	L["Vanas|cffff0000KoS|r"] = "Vanas|cffff0000KoS|r"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PortraitContextMenu", "zhCN")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PortraitContextMenu
	L["Add to %s"] = "添加到%s"
	L["Context Menu"] = "菜单"
	L["Lookup in VanasKoS"] = "在 VanasKoS 查找"
	L["No entry for |cff00ff00%s|r"] = "没有|cff00ff00%s|r条目"
	L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = "玩家：|cff00ff00%s|r在列表：|cff00ff00%s|r - 原因：|cff00ff00%s|r"
	--[[Translation missing --]]
	--[[ L["Vanas|cffff0000KoS|r"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PortraitContextMenu", "esES")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PortraitContextMenu
	L["Add to %s"] = "Añadir a %s"
	--[[Translation missing --]]
	--[[ L["Context Menu"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lookup in VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["No entry for |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Vanas|cffff0000KoS|r"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PortraitContextMenu", "zhTW")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PortraitContextMenu
	L["Add to %s"] = "增加到 %s"
	--[[Translation missing --]]
	--[[ L["Context Menu"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lookup in VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["No entry for |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Vanas|cffff0000KoS|r"] = ""--]] 

end
