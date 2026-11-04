--[[----------------------------------------------------------------------
      EventMap Module - Part of VanasKoS
Displays PvP Events on World Map
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "enUS", true)
if L then
	L["|cffff0000%s - %s killed by %s|r"] = true
	L["|cff00ff00%s - %s killed %s|r"] = true
	L["Draw Alts"] = true
	L["Draws PvP events on map for all characters"] = true
	L["PvP Encounter"] = true
	L["Event Map"] = true
	L["PvP Event Map"] = true
	L["Reset"] = true
	L["Show tooltips when hovering over PvP events"] = true
	L["Tooltips"] = true
	L["Remove events"] = true
	L["Show PvP Encounters"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "frFR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/EventMap
	--[[Translation missing --]]
	--[[ L["|cff00ff00%s - %s killed %s|r"] = ""--]] 
	L["|cffff0000%s - %s killed by %s|r"] = "|cffff0000%s -%s tué par %s|r"
	L["Draw Alts"] = "Dessiner Alts"
	L["Draws PvP events on map for all characters"] = "Dessine événements PvP sur la carte pour tous les caractères"
	--[[Translation missing --]]
	--[[ L["Event Map"] = ""--]] 
	L["PvP Encounter"] = "Rencontre PvP"
	L["PvP Event Map"] = "Carte de l'événement PvP"
	--[[Translation missing --]]
	--[[ L["Remove events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show PvP Encounters"] = ""--]] 
	L["Show tooltips when hovering over PvP events"] = " Afficher les bulles lors du survol des événements PvP"
	L["Tooltips"] = "Les info-bulles"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "deDE")
if L then
-- auto generated from wowace translation app
-- VanasKoS/EventMap
	L["|cff00ff00%s - %s killed %s|r"] = "|cff00ff00%s: %s hat %s getötet|r"
	L["|cffff0000%s - %s killed by %s|r"] = "|cffff0000%s: %s wurde getötet von %s|r"
	L["Draw Alts"] = "Alts aufzeichnen"
	L["Draws PvP events on map for all characters"] = "Zeichnet PvP-Aktionen für alle Charaktere auf der Karte auf"
	L["Event Map"] = "Ereignis Karte"
	L["PvP Encounter"] = "PvP-Kampf"
	L["PvP Event Map"] = "PvP-Aktionskarte"
	L["Remove events"] = "Ereignis löschen"
	L["Reset"] = "Zurücksetzen"
	L["Show PvP Encounters"] = "Anzeigen von PvP Begegnungen"
	L["Show tooltips when hovering over PvP events"] = "Tooltipps anzeigen, wenn die Maus über PvP-Aktionen geführt wird"
	L["Tooltips"] = "Tooltips"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "koKR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/EventMap
	--[[Translation missing --]]
	--[[ L["|cff00ff00%s - %s killed %s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["|cffff0000%s - %s killed by %s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Draw Alts"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Draws PvP events on map for all characters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Event Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Encounter"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Event Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Remove events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show PvP Encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show tooltips when hovering over PvP events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Tooltips"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "esMX")
if L then
-- auto generated from wowace translation app
-- VanasKoS/EventMap
	--[[Translation missing --]]
	--[[ L["|cff00ff00%s - %s killed %s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["|cffff0000%s - %s killed by %s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Draw Alts"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Draws PvP events on map for all characters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Event Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Encounter"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Event Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Remove events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show PvP Encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show tooltips when hovering over PvP events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Tooltips"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "ruRU")
if L then
-- auto generated from wowace translation app
-- VanasKoS/EventMap
	--[[Translation missing --]]
	--[[ L["|cff00ff00%s - %s killed %s|r"] = ""--]] 
	L["|cffff0000%s - %s killed by %s|r"] = " |cffff0000%s - %s убит %s|r"
	L["Draw Alts"] = "сделать все альт"
	L["Draws PvP events on map for all characters"] = "Рисует PvP события на карте для всех символов"
	--[[Translation missing --]]
	--[[ L["Event Map"] = ""--]] 
	L["PvP Encounter"] = "PvP Событие"
	L["PvP Event Map"] = "PvP событий Карта"
	--[[Translation missing --]]
	--[[ L["Remove events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show PvP Encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show tooltips when hovering over PvP events"] = ""--]] 
	L["Tooltips"] = "Подсказки"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "zhCN")
if L then
-- auto generated from wowace translation app
-- VanasKoS/EventMap
	L["|cff00ff00%s - %s killed %s|r"] = "|cff00ff00%s - %s 杀了 %s|r"
	L["|cffff0000%s - %s killed by %s|r"] = "|cffff0000%s - %s被%s杀死|r"
	L["Draw Alts"] = "绘制亮点"
	L["Draws PvP events on map for all characters"] = "在地图上为全部角色绘制 PvP 事件"
	L["Event Map"] = "事件地图"
	L["PvP Encounter"] = "PvP 战斗"
	L["PvP Event Map"] = "PvP 事件地图"
	L["Remove events"] = "移除事件"
	L["Reset"] = "重置"
	L["Show PvP Encounters"] = "显示PVP遇到"
	L["Show tooltips when hovering over PvP events"] = "悬停 PvP 事件时显示提示"
	L["Tooltips"] = "提示"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "esES")
if L then
-- auto generated from wowace translation app
-- VanasKoS/EventMap
	--[[Translation missing --]]
	--[[ L["|cff00ff00%s - %s killed %s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["|cffff0000%s - %s killed by %s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Draw Alts"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Draws PvP events on map for all characters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Event Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Encounter"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Event Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Remove events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show PvP Encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show tooltips when hovering over PvP events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Tooltips"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/EventMap", "zhTW")
if L then
-- auto generated from wowace translation app
-- VanasKoS/EventMap
	--[[Translation missing --]]
	--[[ L["|cff00ff00%s - %s killed %s|r"] = ""--]] 
	L["|cffff0000%s - %s killed by %s|r"] = "|cffff0000%s - %s 被 %s殺害|r"
	--[[Translation missing --]]
	--[[ L["Draw Alts"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Draws PvP events on map for all characters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Event Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Encounter"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Event Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Remove events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show PvP Encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show tooltips when hovering over PvP events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Tooltips"] = ""--]] 

end
