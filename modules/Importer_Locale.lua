--[[----------------------------------------------------------------------
      Importer Module - Part of VanasKoS
Handles import of other AddOns KoS Data
------------------------------------------------------------------------]]
local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Importer", "enUS", true)
if L then
	L["Import Data"] = true
	L["imported"] = true
	L["Imported %d PVP events"] = true
	L["Imported %d player data"] = true
	L["Imported %d list entries"] = true
	L["Imports KoS Data from other KoS tools"] = true
	L["Converted %d PvP stats to %d PvP log events"] = true
	L["Old VanasKoS"] = true
	L["Imports Data from old VanasKoS (backup WTF first)"] = true
	L["unknown"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Importer", "frFR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Importer
	--[[Translation missing --]]
	--[[ L["Converted %d PvP stats to %d PvP log events"] = ""--]] 
	L["Import Data"] = "Importer des données"
	L["imported"] = "importé"
	L["Imported %d KoS entries (%d duplicates)"] = "%d Importés Kos entrées (%d doublons)"
	--[[Translation missing --]]
	--[[ L["Imported %d list entries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d player data"] = ""--]] 
	L["Imported %d PVP events"] = "%d Importés événements PVP"
	L["Imports Data from old VanasKoS"] = "L'importation de données à partir de vieux VanasKoS"
	--[[Translation missing --]]
	--[[ L["Imports Data from old VanasKoS (backup WTF first)"] = ""--]] 
	L["Imports KoS Data from other KoS tools"] = "Importe les données KoS d'autres outils KoS"
	L["Old VanasKoS"] = "Ancien VanasKoS"
	L["Opium data couldn't be loaded"] = "Des données d'Opium n'ont pas pu être chargées"
	L["Opium data was imported"] = "Des données d'Opium ont été importées"
	--[[Translation missing --]]
	--[[ L["unknown"] = ""--]] 
	L["Updated %d PVP statistics"] = "Mise à jour des statistiques %d PVP"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Importer", "deDE")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Importer
	L["Converted %d PvP stats to %d PvP log events"] = "Übertrage %d PvP Statistiken zu %d PvP Ereigniss Protokoll"
	L["Import Data"] = "Daten importieren"
	L["imported"] = "importiert"
	L["Imported %d KoS entries (%d duplicates)"] = "%d KoS-Einträge wurden importiert (%d Duplikate)"
	L["Imported %d list entries"] = "%d Einträge wurden importiert"
	L["Imported %d player data"] = "Importiere %d Spieler Daten"
	L["Imported %d PVP events"] = "%d PvP-Events importiert"
	L["Imports Data from old VanasKoS"] = "Alte VanasKoS-Daten importieren"
	L["Imports Data from old VanasKoS (backup WTF first)"] = "Alte VanasKoS-Daten importieren (sichere WTF zuerst)"
	L["Imports KoS Data from other KoS tools"] = "Importieren von Daten aus anderen KoS-AddOns"
	L["Old VanasKoS"] = "Altes VanasKoS"
	L["Opium data couldn't be loaded"] = "Opium Daten konnten nicht geladen werden"
	L["Opium data was imported"] = "Opium Daten wurden importiert"
	L["unknown"] = "unbekannt"
	L["Updated %d PVP statistics"] = "%d PvP-Statisttik-Einträge aktualisiert"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Importer", "koKR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Importer
	--[[Translation missing --]]
	--[[ L["Converted %d PvP stats to %d PvP log events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Import Data"] = ""--]] 
	L["imported"] = "로드됨"
	--[[Translation missing --]]
	--[[ L["Imported %d KoS entries (%d duplicates)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d list entries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d player data"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d PVP events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imports Data from old VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imports Data from old VanasKoS (backup WTF first)"] = ""--]] 
	L["Imports KoS Data from other KoS tools"] = "다른 KoS 툴에서 KoS 데이터를 불러옵니다."
	--[[Translation missing --]]
	--[[ L["Old VanasKoS"] = ""--]] 
	L["Opium data couldn't be loaded"] = "Opium 데이터를 불러올 수 없습니다."
	L["Opium data was imported"] = "Opium 데이터를 로드하였습니다."
	--[[Translation missing --]]
	--[[ L["unknown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Updated %d PVP statistics"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Importer", "esMX")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Importer
	--[[Translation missing --]]
	--[[ L["Converted %d PvP stats to %d PvP log events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Import Data"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["imported"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d KoS entries (%d duplicates)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d list entries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d player data"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d PVP events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imports Data from old VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imports Data from old VanasKoS (backup WTF first)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imports KoS Data from other KoS tools"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Old VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Opium data couldn't be loaded"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Opium data was imported"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["unknown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Updated %d PVP statistics"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Importer", "ruRU")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Importer
	--[[Translation missing --]]
	--[[ L["Converted %d PvP stats to %d PvP log events"] = ""--]] 
	L["Import Data"] = "Импорт данных"
	L["imported"] = "импортировано"
	L["Imported %d KoS entries (%d duplicates)"] = "Импортировано %d KoS записей (%d совпадает)"
	--[[Translation missing --]]
	--[[ L["Imported %d list entries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d player data"] = ""--]] 
	L["Imported %d PVP events"] = "Импортировано %d PVP событий"
	L["Imports Data from old VanasKoS"] = "Импортирует данные из старых версий VanasKoS"
	--[[Translation missing --]]
	--[[ L["Imports Data from old VanasKoS (backup WTF first)"] = ""--]] 
	L["Imports KoS Data from other KoS tools"] = "Импортирует данные KoS из других KoS инструментов"
	--[[Translation missing --]]
	--[[ L["Old VanasKoS"] = ""--]] 
	L["Opium data couldn't be loaded"] = "Не удалось загрузить данные Opium"
	L["Opium data was imported"] = "Данные Opium импортированы"
	L["unknown"] = "неизвестно"
	L["Updated %d PVP statistics"] = "Обновлено %d PVP наблюдений"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Importer", "zhCN")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Importer
	--[[Translation missing --]]
	--[[ L["Converted %d PvP stats to %d PvP log events"] = ""--]] 
	L["Import Data"] = "导入数据"
	L["imported"] = "已导入"
	L["Imported %d KoS entries (%d duplicates)"] = "已导入%d仇敌条目（%d重复）"
	L["Imported %d list entries"] = "导入 %d 记录"
	L["Imported %d player data"] = "导入 %d 玩家数据"
	L["Imported %d PVP events"] = "已导入%d PvP 事件"
	L["Imports Data from old VanasKoS"] = "从旧的 VanasKoS 导入数据"
	--[[Translation missing --]]
	--[[ L["Imports Data from old VanasKoS (backup WTF first)"] = ""--]] 
	L["Imports KoS Data from other KoS tools"] = "从其他仇敌工具导入仇敌数据"
	L["Old VanasKoS"] = "旧的 VanasKoS"
	L["Opium data couldn't be loaded"] = "不能加载 Opium 数据"
	L["Opium data was imported"] = "已导入 Opium 数据"
	L["unknown"] = "未知"
	L["Updated %d PVP statistics"] = "已更新%s PvP状态"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Importer", "esES")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Importer
	--[[Translation missing --]]
	--[[ L["Converted %d PvP stats to %d PvP log events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Import Data"] = ""--]] 
	L["imported"] = "importados"
	--[[Translation missing --]]
	--[[ L["Imported %d KoS entries (%d duplicates)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d list entries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d player data"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d PVP events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imports Data from old VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imports Data from old VanasKoS (backup WTF first)"] = ""--]] 
	L["Imports KoS Data from other KoS tools"] = "Importa datos de KoS de otras herramientas de KoS"
	--[[Translation missing --]]
	--[[ L["Old VanasKoS"] = ""--]] 
	L["Opium data couldn't be loaded"] = "Los datos de Opium no han podido ser cargados"
	L["Opium data was imported"] = "Los datos de Opium han sido importados"
	--[[Translation missing --]]
	--[[ L["unknown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Updated %d PVP statistics"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Importer", "zhTW")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Importer
	--[[Translation missing --]]
	--[[ L["Converted %d PvP stats to %d PvP log events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Import Data"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["imported"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d KoS entries (%d duplicates)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d list entries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d player data"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imported %d PVP events"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imports Data from old VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imports Data from old VanasKoS (backup WTF first)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Imports KoS Data from other KoS tools"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Old VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Opium data couldn't be loaded"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Opium data was imported"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["unknown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Updated %d PVP statistics"] = ""--]] 

end
