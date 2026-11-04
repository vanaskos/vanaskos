--[[----------------------------------------------------------------------
      LastSeenList Module - Part of VanasKoS
Keeps track of recently seen players
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "enUS", true)
if L then
	L["0 Secs ago"] = true
	L["Add to Hatelist"] = true
	L["Add to Nicelist"] = true
	L["Add to Player KoS"] = true
	L["by last seen"] = true
	L["Last seen"] = true
	L["Last Seen List"] = true
	L["never seen"] = true
	L["%s ago"] = true
	L["sort by last seen"] = true
	L["by name"] = true
	L["sort by name"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "frFR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/LastSeenList
	L["%s ago"] = "Il ya %s"
	L["0 Secs ago"] = "Il ya 0 sec"
	L["Add to Hatelist"] = "Ajouter à Hatelist"
	L["Add to Nicelist"] = "Ajouter à Nicelist"
	L["Add to Player KoS"] = "Ajouter à Kos Player"
	L["by last seen"] = "par Dernière visite"
	L["by name"] = "par nom"
	L["Last seen"] = "Dernière visite"
	L["Last Seen List"] = "Dernière Liste Vu"
	L["never seen"] = "jamais vu"
	L["sort by last seen"] = "Trier par Dernière visite"
	L["sort by name"] = "trier par nom"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "deDE")
if L then
-- auto generated from wowace translation app
-- VanasKoS/LastSeenList
	L["%s ago"] = "Vor %s"
	L["0 Secs ago"] = "Vor 0 Sekunden"
	L["Add to Hatelist"] = "Zur Hassliste hinzufügen"
	L["Add to Nicelist"] = "Zur Nette-Leute-Liste hinzufügen"
	L["Add to Player KoS"] = "Zur KoS-Liste hinzufügen"
	L["by last seen"] = "nach zuletzt-gesehen"
	L["by name"] = "nach Name"
	L["Last seen"] = "Zuletzt gesehen"
	L["Last Seen List"] = "Zuletzt gesehen Liste"
	L["never seen"] = "noch nie gesehen"
	L["sort by last seen"] = "sortieren nach wann-zuletzt-gesehen"
	L["sort by name"] = "sortiere nach Name"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "koKR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/LastSeenList
	L["%s ago"] = "%s 이전"
	L["0 Secs ago"] = "0초 이전"
	L["Add to Hatelist"] = "악인명부에 추가"
	L["Add to Nicelist"] = "호인명부에 추가"
	L["Add to Player KoS"] = "플레이어 KoS에 추가"
	L["by last seen"] = "마지막 발견에 의해"
	--[[Translation missing --]]
	--[[ L["by name"] = ""--]] 
	L["Last seen"] = "마지막 발견"
	--[[Translation missing --]]
	--[[ L["Last Seen List"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["never seen"] = ""--]] 
	L["sort by last seen"] = "마지막 발견에 의한 정렬"
	--[[Translation missing --]]
	--[[ L["sort by name"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "esMX")
if L then
-- auto generated from wowace translation app
-- VanasKoS/LastSeenList
	--[[Translation missing --]]
	--[[ L["%s ago"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["0 Secs ago"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Hatelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Nicelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Player KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by last seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last Seen List"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["never seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by last seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by name"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "ruRU")
if L then
-- auto generated from wowace translation app
-- VanasKoS/LastSeenList
	L["%s ago"] = "%s назад"
	L["0 Secs ago"] = "0 сек. назад"
	L["Add to Hatelist"] = "Добавить к списку ненавистных"
	L["Add to Nicelist"] = "Добавить к списку хороших"
	L["Add to Player KoS"] = "Добавить к KoS-игрокам"
	L["by last seen"] = "по последней встрече"
	L["by name"] = "по имени"
	L["Last seen"] = "Последние встречи"
	L["Last Seen List"] = "Последние встречи"
	L["never seen"] = "Ни разу не замечено"
	L["sort by last seen"] = "сортировать по последней встрече"
	L["sort by name"] = "Сортировать по Имени"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "zhCN")
if L then
-- auto generated from wowace translation app
-- VanasKoS/LastSeenList
	L["%s ago"] = "%s之前"
	L["0 Secs ago"] = "0秒之前"
	L["Add to Hatelist"] = "添加到仇恨列表"
	L["Add to Nicelist"] = "添加到友好列表"
	L["Add to Player KoS"] = "添加仇敌玩家"
	L["by last seen"] = "按上次看到"
	L["by name"] = "按名称"
	L["Last seen"] = "上次看到"
	L["Last Seen List"] = "上次看到列表"
	L["never seen"] = "从未看到"
	L["sort by last seen"] = "按上次看到排序"
	L["sort by name"] = "按名称排序"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "esES")
if L then
-- auto generated from wowace translation app
-- VanasKoS/LastSeenList
	--[[Translation missing --]]
	--[[ L["%s ago"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["0 Secs ago"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Hatelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Nicelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Add to Player KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by last seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last Seen List"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["never seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by last seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by name"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "zhTW")
if L then
-- auto generated from wowace translation app
-- VanasKoS/LastSeenList
	--[[Translation missing --]]
	--[[ L["%s ago"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["0 Secs ago"] = ""--]] 
	L["Add to Hatelist"] = "增加到討厭列表"
	L["Add to Nicelist"] = "增加到好人列表"
	L["Add to Player KoS"] = "增加到玩家仇敵"
	--[[Translation missing --]]
	--[[ L["by last seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["by name"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Last Seen List"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["never seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by last seen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["sort by name"] = ""--]] 

end
