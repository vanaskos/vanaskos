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
-- VanasKoS/PvPDataGatherer
	--[[Translation missing --]]
	--[[ L["All Attackers"] = ""--]] 
	L["by encounters"] = "par des rencontres"
	L["by losses"] = "par des pertes"
	L["by name"] = "par des nom"
	L["by score"] = "par des score"
	L["by wins"] = "par gagne"
	--[[Translation missing --]]
	--[[ L["Date"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Defeat Logging Method"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in arena"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in Battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in combat zone"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Killing Blow"] = ""--]] 
	L["Lost"] = "Perdu"
	--[[Translation missing --]]
	--[[ L["Method used to record defeats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Most Damage"] = ""--]] 
	L["Name"] = "Nom"
	L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = "statistiques PvP Old détecté. Vous devez importer des données anciennes en allant à l'importateur en vertu VanasKoS configuration"
	--[[Translation missing --]]
	--[[ L["Player"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Players"] = ""--]] 
	L["PvP"] = "PvP"
	L["PvP Data Gathering"] = "Rassemblement de données PvP"
	--[[Translation missing --]]
	--[[ L["PvP Log"] = ""--]] 
	L["PvP Loss versus %s registered."] = "PvP pertes par rapport aux %s enregistré."
	L["PvP Stats"] = "PvP Stats"
	L["PvP Win versus %s registered."] = "PvP Win versus %s enregistré."
	L["Score"] = "Score"
	L["sort by most losses"] = "Trier par la plupart des pertes"
	L["sort by most PVP encounters"] = "Trier par des rencontres les plus PVP"
	L["sort by most wins"] = "Trier par plus de victoires"
	L["sort by most wins to losses"] = "Trier par plus de victoires à des pertes"
	L["sort by name"] = "Trier par nom"
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Type"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["unknown"] = ""--]] 
	L["Win"] = "Gagner"
	L["wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "victoires: |cff00ff00%d|r défaites: |cffff0000%d|r"
	--[[Translation missing --]]
	--[[ L["Zone"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "deDE")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPDataGatherer
	L["All Attackers"] = "Alle Angreifer"
	L["by encounters"] = "nach Gefechten"
	L["by losses"] = "nach Niederlagen"
	L["by name"] = "nach Namen"
	L["by score"] = "nach Ergebnissen"
	L["by wins"] = "Nach Siegen"
	L["Date"] = "Datum"
	--[[Translation missing --]]
	--[[ L["Defeat Logging Method"] = ""--]] 
	L["Enable in arena"] = "Aktivieren in der Arena"
	L["Enable in Battleground"] = "Aktivieren auf Schlachtfeldern"
	--[[Translation missing --]]
	--[[ L["Enable in combat zone"] = ""--]] 
	L["Enemy"] = "Feind"
	L["Events"] = "Ereignisse"
	L["Killing Blow"] = "tödlicher Schlag"
	L["Lost"] = "Verloren"
	--[[Translation missing --]]
	--[[ L["Method used to record defeats"] = ""--]] 
	L["Most Damage"] = "meiste Schaden"
	L["Name"] = "Name"
	L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = "Alte PvP-Statistiken entdeckt. Du solltest die alten Daten importieren, indem du das Import-Modul in der VanasKoS-Konfiguration verwendest."
	L["Player"] = "Spieler"
	L["Players"] = "Spieler"
	L["PvP"] = "PvP"
	L["PvP Data Gathering"] = "PvP-Daten sammeln"
	L["PvP Log"] = "PvP Logbuch"
	L["PvP Loss versus %s registered."] = "PvP-Niederlage gegen %s registriert."
	L["PvP Stats"] = "PvP-Statistik"
	L["PvP Win versus %s registered."] = "PvP-Sieg gegen %s registriert."
	L["Score"] = "Wertung"
	L["sort by most losses"] = "sortiere nach den meisten Niederlagen"
	L["sort by most PVP encounters"] = "sortiere nach den meisten PvP-Gefechten"
	L["sort by most wins"] = "sortiere nach den meisten Siegen"
	L["sort by most wins to losses"] = "sortiere nach den meisten Siegen gegenüber Niederlagen"
	L["sort by name"] = "sortiere nach Namen"
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Type"] = ""--]] 
	L["unknown"] = "unbekannt"
	L["Win"] = "Sieg"
	L["wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "Siege: |cff00ff00%d|r Niederlagen: |cffff0000%d|r"
	L["Zone"] = "Zone"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "koKR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPDataGatherer
	--[[Translation missing --]]
	--[[ L["All Attackers"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by score"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by wins"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Date"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Defeat Logging Method"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in arena"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in Battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in combat zone"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Killing Blow"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lost"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Method used to record defeats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Most Damage"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Players"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP"] = ""--]] 
	L["PvP Data Gathering"] = "PvP 데이터 수집"
	--[[Translation missing --]]
	--[[ L["PvP Log"] = ""--]] 
	L["PvP Loss versus %s registered."] = "%s에 대한 PvP 패배가 기록되었습니다."
	L["PvP Stats"] = "PvP 현황"
	L["PvP Win versus %s registered."] = "%s에 대한 PvP 승리가 기록되었습니다."
	--[[Translation missing --]]
	--[[ L["Score"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most PVP encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most wins"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most wins to losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Type"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["unknown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Win"] = ""--]] 
	L["wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "승: |cff00ff00%d|r 패: |cffff0000%d|r"
	--[[Translation missing --]]
	--[[ L["Zone"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "esMX")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPDataGatherer
	--[[Translation missing --]]
	--[[ L["All Attackers"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by score"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by wins"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Date"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Defeat Logging Method"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in arena"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in Battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in combat zone"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Killing Blow"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lost"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Method used to record defeats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Most Damage"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Players"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Data Gathering"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Log"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Loss versus %s registered."] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Stats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Win versus %s registered."] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Score"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most PVP encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most wins"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most wins to losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Type"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["unknown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Win"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zone"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "ruRU")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPDataGatherer
	L["All Attackers"] = "Все атаковавшие"
	L["by encounters"] = "по событиям"
	L["by losses"] = "по проигрышам"
	L["by name"] = "по имени"
	L["by score"] = "по очкам"
	L["by wins"] = "по победам"
	L["Date"] = "Дата"
	--[[Translation missing --]]
	--[[ L["Defeat Logging Method"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in arena"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in Battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in combat zone"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Killing Blow"] = ""--]] 
	L["Lost"] = "Потерянный"
	--[[Translation missing --]]
	--[[ L["Method used to record defeats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Most Damage"] = ""--]] 
	L["Name"] = "Название"
	--[[Translation missing --]]
	--[[ L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player"] = ""--]] 
	L["Players"] = "Игроки"
	L["PvP"] = "PvP"
	L["PvP Data Gathering"] = "Сбор PvP-статистики"
	--[[Translation missing --]]
	--[[ L["PvP Log"] = ""--]] 
	L["PvP Loss versus %s registered."] = "PvP поражений от %s."
	L["PvP Stats"] = "Статистика PvP "
	L["PvP Win versus %s registered."] = "PvP побед над %s."
	L["Score"] = "Счет"
	L["sort by most losses"] = "сортировать по большинству поражений"
	L["sort by most PVP encounters"] = "сортировать по большинству PvP событий"
	L["sort by most wins"] = "сортировать по большинству побед"
	L["sort by most wins to losses"] = "сортировать по лучшему отношению побед к поражениям"
	L["sort by name"] = "сортировать по имени"
	L["Toggles logging of PvP events in arenas"] = "Вкл/выкл логирования PvP-событий на арене"
	L["Toggles logging of PvP events in battlegrounds"] = "Вкл/выкл логирования PvP-событий на полях боя"
	L["Toggles logging of PvP events in combat zones (Wintergrasp, Tol Barad)"] = "Вкл/выкл логирования PvP-событий в боевых зонах (таких, как ОЛО, Тол Барад)"
	L["Type"] = "Тип"
	L["unknown"] = "неизвестно"
	L["Win"] = "Победа"
	L["wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "побед: |cff00ff00%d|r поражений: |cffff0000%d|r"
	L["Zone"] = "Зона"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "zhCN")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPDataGatherer
	L["All Attackers"] = "所有攻击者"
	L["by encounters"] = "按战斗"
	L["by losses"] = "按失败"
	L["by name"] = "按名称"
	L["by score"] = "按分数"
	L["by wins"] = "按胜利"
	L["Date"] = "日期"
	--[[Translation missing --]]
	--[[ L["Defeat Logging Method"] = ""--]] 
	L["Enable in arena"] = "竞技场内启用"
	L["Enable in Battleground"] = "战场内启用"
	L["Enable in combat zone"] = "战斗区域内启用"
	L["Enemy"] = "敌人"
	L["Events"] = "事件"
	--[[Translation missing --]]
	--[[ L["Killing Blow"] = ""--]] 
	L["Lost"] = "失败"
	--[[Translation missing --]]
	--[[ L["Method used to record defeats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Most Damage"] = ""--]] 
	L["Name"] = "名称"
	L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = "侦测到旧的 PvP 状态。应去 VanasKoS 导入功能配置导入旧数据"
	L["Player"] = "玩家"
	L["Players"] = "玩家"
	L["PvP"] = "PvP"
	L["PvP Data Gathering"] = "PvP 数据收集"
	L["PvP Log"] = "PVP记录"
	L["PvP Loss versus %s registered."] = "已注册 PvP 失败交战%s。"
	L["PvP Stats"] = "PvP 状态"
	L["PvP Win versus %s registered."] = "已注册 PvP 胜利交战%s。"
	L["Score"] = "分数"
	L["sort by most losses"] = "按最多失败排序"
	L["sort by most PVP encounters"] = "按最多 PvP 战斗排序"
	L["sort by most wins"] = "按最多胜利排序"
	L["sort by most wins to losses"] = "按最多胜利到失败排序"
	L["sort by name"] = "按名称排序"
	L["Toggles logging of PvP events in arenas"] = "切换竞技场中PvP事件的日志记录"
	L["Toggles logging of PvP events in battlegrounds"] = "切换战场中PvP事件的日志记录"
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	L["Type"] = "类型"
	L["unknown"] = "未知"
	L["Win"] = "胜利"
	L["wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "胜利：|cff00ff00%d|r - 失败：|cffff0000%d|r"
	L["Zone"] = "区域"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "esES")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPDataGatherer
	--[[Translation missing --]]
	--[[ L["All Attackers"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by score"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by wins"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Date"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Defeat Logging Method"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in arena"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in Battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in combat zone"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Killing Blow"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lost"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Method used to record defeats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Most Damage"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Players"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP"] = ""--]] 
	L["PvP Data Gathering"] = "Recolección de Datos JcJ"
	--[[Translation missing --]]
	--[[ L["PvP Log"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Loss versus %s registered."] = ""--]] 
	L["PvP Stats"] = "Estadísticas JcJ"
	--[[Translation missing --]]
	--[[ L["PvP Win versus %s registered."] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Score"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most PVP encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most wins"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most wins to losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Type"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["unknown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Win"] = ""--]] 
	L["wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "ganados: |cff00ff00%d|r perdidos: |cffff0000%d|r"
	--[[Translation missing --]]
	--[[ L["Zone"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPDataGatherer", "zhTW")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPDataGatherer
	--[[Translation missing --]]
	--[[ L["All Attackers"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by score"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by wins"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Date"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Defeat Logging Method"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in arena"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in Battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enable in combat zone"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Killing Blow"] = ""--]] 
	L["Lost"] = "輸了"
	--[[Translation missing --]]
	--[[ L["Method used to record defeats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Most Damage"] = ""--]] 
	L["Name"] = "名字"
	--[[Translation missing --]]
	--[[ L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Players"] = ""--]] 
	L["PvP"] = "PvP"
	--[[Translation missing --]]
	--[[ L["PvP Data Gathering"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Log"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Loss versus %s registered."] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Stats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Win versus %s registered."] = ""--]] 
	L["Score"] = "分數"
	--[[Translation missing --]]
	--[[ L["sort by most losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most PVP encounters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most wins"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by most wins to losses"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles logging of PvP events in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Type"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["unknown"] = ""--]] 
	L["Win"] = "勝利"
	--[[Translation missing --]]
	--[[ L["wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zone"] = ""--]] 

end
