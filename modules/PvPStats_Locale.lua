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

	L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "frFR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPStats
	--[[Translation missing --]]
	--[[ L["Add to Hatelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Nicelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Player KoS"] = ""--]] 
	L["All Characters"] = "Tous les caractères"
	L["All Time"] = "Tous Les Temps"
	L["Average Level"] = "Niveau moyen"
	L["by encounters"] = "par des rencontres"
	L["by losses"] = "par des pertes"
	L["by name"] = "par nom"
	L["by score"] = "par score"
	L["by wins"] = "par gagne"
	L["Date"] = "Date"
	L["Enemies"] = "Ennemis"
	L["Enemy level"] = "niveau Enemy"
	L["Last 24 hours"] = "Dernières 24 heures"
	L["Last Month"] = "Le mois dernier"
	L["Last Week"] = "La semaine dernière"
	L["Level difference"] = "différence de niveau"
	L["Losses: |cffff0000%d|r (%.1f%%)"] = "Pertes: |cffff0000%d|r (%.1f%%)"
	L["Lost"] = "Perdu"
	L["Map"] = "Carte"
	L["My level"] = "Mon niveau"
	--[[Translation missing --]]
	--[[ L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = ""--]] 
	L["Players"] = "Joueurs"
	L["PvP Data Gathering"] = "Collecte de données PvP"
	L["PvP Stats"] = "Stats PvP"
	--[[Translation missing --]]
	--[[ L["Remove Entry"] = ""--]] 
	L["Score"] = "Score"
	L["sort by most losses"] = "trier par la plupart des pertes"
	L["sort by most PVP encounters"] = "trier par des rencontres les plus PVP"
	L["sort by most wins"] = "trier par plus de victoires"
	L["sort by most wins to losses"] = "trier par plus de victoires à des pertes"
	L["sort by name"] = "trier par nom"
	L["Total"] = "Total"
	L["Wins: |cff00ff00%d|r (%.1f%%)"] = "Victoires: |cff00ff00%d|r (%.1f%%)"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "deDE")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPStats
	L["Add to Hatelist"] = "Zur Hassliste hinzufügen"
	L["Add to Nicelist"] = "Zur Nettliste hinzufügen"
	L["Add to Player KoS"] = "Zur Spieler-KoS-Liste hinzufügen"
	L["All Characters"] = "Alle Charaktere"
	L["All Time"] = "Komplette Zeit"
	L["Average Level"] = "Durchschnittliche Stufe"
	L["by encounters"] = "nach Gefechten"
	L["by losses"] = "nach Niederlagen"
	L["by name"] = "nach Namen"
	L["by score"] = "nach Wertung"
	L["by wins"] = "nach Siegen"
	L["Date"] = "Datum"
	L["Enemies"] = "Feinde"
	L["Enemy level"] = "Stufe des Feindes"
	L["Last 24 hours"] = "die letzten 24 Stunden"
	L["Last Month"] = "letzten Monat"
	L["Last Week"] = "letzte Woche"
	L["Level difference"] = "Stufenunterschied"
	L["Losses: |cffff0000%d|r (%.1f%%)"] = "Niederlagen: |cffff0000%d|r (%.1f%%)"
	L["Lost"] = "Tode"
	L["Map"] = "Karte"
	L["My level"] = "Meine Stufe"
	L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = "Alte PvP-Statistiken entdeckt. Du solltest die alten Daten importieren, indem du das Import-Modul in der VanasKoS-Konfiguration verwendest."
	L["Players"] = "Spieler"
	L["PvP Data Gathering"] = "PvP-Datensammlung"
	L["PvP Stats"] = "PvP-Stats"
	L["Remove Entry"] = "Eintrag löschen"
	L["Score"] = "Wertung"
	L["sort by most losses"] = "Sortieren nach den meisten Niederlagen"
	L["sort by most PVP encounters"] = "Sortieren nach den meisten PVP-Gefechten"
	L["sort by most wins"] = "Sortieren nach den meisten Siegen"
	L["sort by most wins to losses"] = "Sortieren nach den meisten Siegen bis Niedelagen"
	L["sort by name"] = "Nach Namen sortieren"
	L["Total"] = "Insgesamt"
	L["Wins: |cff00ff00%d|r (%.1f%%)"] = "Siege: |cff00ff00%d|r (%.1f%%)"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "koKR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPStats
	--[[Translation missing --]]
	--[[ L["Add to Hatelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Nicelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Player KoS"] = ""--]] 
	L["All Characters"] = "모든 케릭터"
	L["All Time"] = "모든 시간"
	--[[Translation missing --]]
	--[[ L["Average Level"] = ""--]] 
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
	--[[ L["Enemies"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy level"] = ""--]] 
	L["Last 24 hours"] = "마지막 24 시간"
	L["Last Month"] = "마지막 월"
	L["Last Week"] = "마지막 주"
	--[[Translation missing --]]
	--[[ L["Level difference"] = ""--]] 
	L["Losses: |cffff0000%d|r (%.1f%%)"] = "패: |cffff0000%d|r (%.1f%%)"
	--[[Translation missing --]]
	--[[ L["Lost"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["My level"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Players"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Data Gathering"] = ""--]] 
	L["PvP Stats"] = "PvP 현황"
	--[[Translation missing --]]
	--[[ L["Remove Entry"] = ""--]] 
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
	--[[ L["Total"] = ""--]] 
	L["Wins: |cff00ff00%d|r (%.1f%%)"] = "승: |cff00ff00%d|r (%.1f%%)"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "esMX")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPStats
	--[[Translation missing --]]
	--[[ L["Add to Hatelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Nicelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Player KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["All Characters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["All Time"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Average Level"] = ""--]] 
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
	--[[ L["Enemies"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy level"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last 24 hours"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last Month"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last Week"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Level difference"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Losses: |cffff0000%d|r (%.1f%%)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lost"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["My level"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Players"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Data Gathering"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Stats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Remove Entry"] = ""--]] 
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
	--[[ L["Total"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Wins: |cff00ff00%d|r (%.1f%%)"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "ruRU")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPStats
	L["Add to Hatelist"] = "Добавить к списку ненавистных"
	L["Add to Nicelist"] = "Добавить к списку хороших"
	L["Add to Player KoS"] = "Добавить к KoS-игрокам"
	L["All Characters"] = "Все персонажи"
	L["All Time"] = "Все время"
	L["Average Level"] = "Средний уровень"
	L["by encounters"] = "по событиям"
	--[[Translation missing --]]
	--[[ L["by losses"] = ""--]] 
	L["by name"] = "по имени"
	L["by score"] = "по очкам"
	L["by wins"] = "по победам"
	L["Date"] = "Дата"
	L["Enemies"] = "Противники"
	L["Enemy level"] = "Уровень противника"
	L["Last 24 hours"] = "Последние 24 часа"
	L["Last Month"] = "Последний месяц"
	L["Last Week"] = "Последняя неделя"
	L["Level difference"] = "Разница в уровне"
	L["Losses: |cffff0000%d|r (%.1f%%)"] = "Поражений: |cffff0000%d|r (%.1f%%)"
	--[[Translation missing --]]
	--[[ L["Lost"] = ""--]] 
	L["Map"] = "Карта"
	L["My level"] = "Мой уровень"
	--[[Translation missing --]]
	--[[ L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = ""--]] 
	L["Players"] = "Игроки"
	--[[Translation missing --]]
	--[[ L["PvP Data Gathering"] = ""--]] 
	L["PvP Stats"] = "Статистика PvP"
	--[[Translation missing --]]
	--[[ L["Remove Entry"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Score"] = ""--]] 
	L["sort by most losses"] = "сортировать по большинству поражений"
	L["sort by most PVP encounters"] = "сортировать по большему количеству PvP событий"
	L["sort by most wins"] = "сортировать по большинству побед"
	L["sort by most wins to losses"] = "сортировать по лучшему отношению побед к поражениям"
	L["sort by name"] = "сортировать по имени"
	L["Total"] = "Всего"
	L["Wins: |cff00ff00%d|r (%.1f%%)"] = "Побед: |cff00ff00%d|r (%.1f%%)"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "zhCN")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPStats
	L["Add to Hatelist"] = "添加到仇恨列表"
	L["Add to Nicelist"] = "添加到友好列表"
	L["Add to Player KoS"] = "添加到玩家仇敌"
	L["All Characters"] = "全部角色"
	L["All Time"] = "全部时间"
	L["Average Level"] = "平均等级"
	L["by encounters"] = "按战斗"
	L["by losses"] = "按失败"
	L["by name"] = "按名称"
	L["by score"] = "按分数"
	L["by wins"] = "按胜利"
	L["Date"] = "日期"
	L["Enemies"] = "敌人"
	L["Enemy level"] = "敌对等级"
	L["Last 24 hours"] = "最后24小时"
	L["Last Month"] = "上个月"
	L["Last Week"] = "上星期"
	L["Level difference"] = "等级差异"
	L["Losses: |cffff0000%d|r (%.1f%%)"] = "失败：|cffff0000%d|r（%.1f%%）"
	L["Lost"] = "失败"
	L["Map"] = "地图"
	L["My level"] = "我的等级"
	L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = "侦测到旧的 PvP 状态。应去 VanasKoS 导入功能配置导入旧数据"
	L["Players"] = "玩家"
	L["PvP Data Gathering"] = "PvP 数据收集"
	L["PvP Stats"] = "PvP 状态"
	L["Remove Entry"] = "移除条目"
	L["Score"] = "分数"
	L["sort by most losses"] = "按最多失败排序"
	L["sort by most PVP encounters"] = "按最多 PvP 战斗排序"
	L["sort by most wins"] = "按最多胜利排序"
	L["sort by most wins to losses"] = "按最多胜利到失败排序"
	L["sort by name"] = "按名称排序"
	L["Total"] = "总共"
	L["Wins: |cff00ff00%d|r (%.1f%%)"] = "胜利：|cff00ff00%d|r（%.1f%%）"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "esES")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPStats
	--[[Translation missing --]]
	--[[ L["Add to Hatelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Nicelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Player KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["All Characters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["All Time"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Average Level"] = ""--]] 
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
	--[[ L["Enemies"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy level"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last 24 hours"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last Month"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last Week"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Level difference"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Losses: |cffff0000%d|r (%.1f%%)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lost"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["My level"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Players"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Data Gathering"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Stats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Remove Entry"] = ""--]] 
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
	--[[ L["Total"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Wins: |cff00ff00%d|r (%.1f%%)"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "zhTW")
if L then
-- auto generated from wowace translation app
-- VanasKoS/PvPStats
	--[[Translation missing --]]
	--[[ L["Add to Hatelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Nicelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Player KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["All Characters"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["All Time"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Average Level"] = ""--]] 
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
	--[[ L["Enemies"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy level"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last 24 hours"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last Month"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last Week"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Level difference"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Losses: |cffff0000%d|r (%.1f%%)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lost"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Map"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["My level"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Players"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Data Gathering"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["PvP Stats"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Remove Entry"] = ""--]] 
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
	L["sort by name"] = "按名稱排序"
	--[[Translation missing --]]
	--[[ L["Total"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Wins: |cff00ff00%d|r (%.1f%%)"] = ""--]] 

end
