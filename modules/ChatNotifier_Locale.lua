--[[----------------------------------------------------------------------
	ChatNotifier Module - Part of VanasKoS
modifies the ChatMessage if a player speaks whom is on your hatelist
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "enUS", true)
if L then
	L["Add Lookup in VanasKoS"] = true
	L["Chat Modifications"] = true
	L["Hatelist Color"] = true
	L["Lookup in VanasKoS"] = true
	L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = true
	L["Modifies the Chat only for your Entries"] = true
	L["Modifies the Chat Window for Hate/Nicelist Entries."] = true
	L["Modify only my Entries"] = true
	L["Nicelist Color"] = true
	L["No entry for |cff00ff00%s|r"] = true
	L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = true
	L["Sets the Foreground Color for Hatelist Entries"] = true
	L["Sets the Foreground Color for Nicelist Entries"] = true
	L["Liked"] = true
	L["Hated"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "frFR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/ChatNotifier
	L["Add Lookup in VanasKoS"] = "Ajouter Recherche dans VanasKoS"
	L["Chat Modifications"] = "Modifications du chat"
	--[[Translation missing --]]
	--[[ L["Hated"] = ""--]] 
	L["Hatelist Color"] = "Couleur pour liste noire"
	--[[Translation missing --]]
	--[[ L["Liked"] = ""--]] 
	L["Lookup in VanasKoS"] = "Recherche dans VanasKoS"
	L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = "Modifie le Chat du menu contextuel pour ajouter un Lookup \"dans VanasKoS option."
	L["Modifies the Chat only for your Entries"] = "Modifie le chat seulement pour vos entrées"
	L["Modifies the Chat Window for Hate/Nicelist Entries."] = "Modifie la fenêtre du chat pour les entrées des listes blanche/noire"
	L["Modify only my Entries"] = "Modifier seulement mes entrées"
	L["Nicelist Color"] = "Couleur pour liste blanche"
	L["No entry for |cff00ff00%s|r"] = "Aucune inscription pour |cff00ff00%s|r"
	L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = "Lecteur: |cff00ff00%s|r est sur la liste: |cff00ff00%s|r - Motif: |cff00ff00%s|r"
	L["Sets the Foreground Color for Hatelist Entries"] = "Choisir la couleur de texte pour les entrées de la liste noire"
	L["Sets the Foreground Color for Nicelist Entries"] = "Choisir la couleur de texte pour les entrées de la liste blanche"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "deDE")
if L then
-- auto generated from wowace translation app
-- VanasKoS/ChatNotifier
	L["Add Lookup in VanasKoS"] = "\"In-VanasKoS-suchen\" hinzufügen"
	L["Chat Modifications"] = "Chat-Modifikationen"
	L["Hated"] = "verhaßt"
	L["Hatelist Color"] = "Farbe für Hassliste"
	--[[Translation missing --]]
	--[[ L["Liked"] = ""--]] 
	L["Lookup in VanasKoS"] = "In VanasKoS suchen"
	L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = "Fügt die Suche in VanasKoS zum Kontextmenü hinzu"
	L["Modifies the Chat only for your Entries"] = "Modifiziert den Chat nur für meine Einträge"
	L["Modifies the Chat Window for Hate/Nicelist Entries."] = "Modifiziert das Chatfenster für Spieler auf der Hass- und Nette-Leuteliste"
	L["Modify only my Entries"] = "Nur meine Einträge modifizieren"
	L["Nicelist Color"] = "Farbe für Nette-Leute-Liste"
	L["No entry for |cff00ff00%s|r"] = "Kein Eintrag für |cff00ff00%s|r"
	L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = "Spieler: |cff00ff00%s|r ist auf Liste: |cff00ff00%s|r - Grund: |cff00ff00%s|r"
	L["Sets the Foreground Color for Hatelist Entries"] = "Setzt die Vordergrundfarbe für Einträge der Hassliste"
	L["Sets the Foreground Color for Nicelist Entries"] = "Setzt die Hintergrundfarbe für Einträge der Nette-Leute-Liste"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "koKR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/ChatNotifier
	--[[Translation missing --]]
	--[[ L["Add Lookup in VanasKoS"] = ""--]] 
	L["Chat Modifications"] = "대화창 변경"
	--[[Translation missing --]]
	--[[ L["Hated"] = ""--]] 
	L["Hatelist Color"] = "악인명부 색상"
	--[[Translation missing --]]
	--[[ L["Liked"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lookup in VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = ""--]] 
	L["Modifies the Chat only for your Entries"] = "당신의 명부에 대한 대화만 변경합니다."
	L["Modifies the Chat Window for Hate/Nicelist Entries."] = "악인/호인에 대해 대화창을 변경합니다."
	L["Modify only my Entries"] = "내 명부만 변경"
	L["Nicelist Color"] = "호인명부 색상"
	--[[Translation missing --]]
	--[[ L["No entry for |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = ""--]] 
	L["Sets the Foreground Color for Hatelist Entries"] = "싫어하는 사람에 대한 전경 색상을 설정합니다."
	L["Sets the Foreground Color for Nicelist Entries"] = "좋아하는 사람에 대한 전경 색상을 설정합니다."

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "esMX")
if L then
-- auto generated from wowace translation app
-- VanasKoS/ChatNotifier
	--[[Translation missing --]]
	--[[ L["Add Lookup in VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Chat Modifications"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hatelist Color"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Liked"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lookup in VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Modifies the Chat only for your Entries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Modifies the Chat Window for Hate/Nicelist Entries."] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Modify only my Entries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist Color"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["No entry for |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the Foreground Color for Hatelist Entries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the Foreground Color for Nicelist Entries"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "ruRU")
if L then
-- auto generated from wowace translation app
-- VanasKoS/ChatNotifier
	L["Add Lookup in VanasKoS"] = "Добавить проверку в меню"
	L["Chat Modifications"] = "Модификации чата"
	--[[Translation missing --]]
	--[[ L["Hated"] = ""--]] 
	L["Hatelist Color"] = "Цвет списка ненавистных"
	L["Liked"] = "Нравится"
	L["Lookup in VanasKoS"] = "Проверить в VanasKoS"
	L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = "Добавляет в контекстное меню пункт \"Проверить в Vanas KoS\""
	L["Modifies the Chat only for your Entries"] = "Модифицирует чат только для записей, сделанных мной"
	L["Modifies the Chat Window for Hate/Nicelist Entries."] = "Вносит изменения в окно чата для записей из списка ненавистных/хороших."
	L["Modify only my Entries"] = "Модифицировать только для моих"
	L["Nicelist Color"] = "Цвет списка хороших"
	L["No entry for |cff00ff00%s|r"] = "Записей с |cff00ff00%s|r не найдено"
	L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = "Игрок: |cff00ff00%s|r в Списке: |cff00ff00%s|r - Причина: |cff00ff00%s|r"
	L["Sets the Foreground Color for Hatelist Entries"] = "Задает цвет для записей из списка ненавистных"
	L["Sets the Foreground Color for Nicelist Entries"] = "Задает цвет для записей из списка хороших"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "zhCN")
if L then
-- auto generated from wowace translation app
-- VanasKoS/ChatNotifier
	L["Add Lookup in VanasKoS"] = "在 VanasKoS 添加查找"
	L["Chat Modifications"] = "聊天修改"
	L["Hated"] = "仇恨"
	L["Hatelist Color"] = "仇恨列表颜色"
	L["Liked"] = "喜欢"
	L["Lookup in VanasKoS"] = "在 VanasKoS 查找"
	L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = "修改在聊天菜单添加一个\"在 VanasKoS 查找\"选项。"
	L["Modifies the Chat only for your Entries"] = "只修改聊天你的条目。"
	L["Modifies the Chat Window for Hate/Nicelist Entries."] = "修改聊天窗口的仇恨/友好列表条目。"
	L["Modify only my Entries"] = "只修改我的条目"
	L["Nicelist Color"] = "友好列表颜色"
	L["No entry for |cff00ff00%s|r"] = "没有|cff00ff00%s|r条目"
	L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = "玩家：|cff00ff00%s|r在列表：|cff00ff00%s|r - 原因：|cff00ff00%s|r"
	L["Sets the Foreground Color for Hatelist Entries"] = "设置仇恨列表条目前景颜色"
	L["Sets the Foreground Color for Nicelist Entries"] = "设置友好列表条目前景颜色"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "esES")
if L then
-- auto generated from wowace translation app
-- VanasKoS/ChatNotifier
	--[[Translation missing --]]
	--[[ L["Add Lookup in VanasKoS"] = ""--]] 
	L["Chat Modifications"] = "Modificaciones de Chat"
	--[[Translation missing --]]
	--[[ L["Hated"] = ""--]] 
	L["Hatelist Color"] = "Color de Odiados"
	--[[Translation missing --]]
	--[[ L["Liked"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Lookup in VanasKoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = ""--]] 
	L["Modifies the Chat only for your Entries"] = "Modifica el chat sólo para tus entradas"
	L["Modifies the Chat Window for Hate/Nicelist Entries."] = "Modifica la ventana de chat para las entradas de Simpáticos/Odiados"
	L["Modify only my Entries"] = "Modificar sólo mis entradas"
	L["Nicelist Color"] = "Color de Simpáticos"
	--[[Translation missing --]]
	--[[ L["No entry for |cff00ff00%s|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = ""--]] 
	L["Sets the Foreground Color for Hatelist Entries"] = "Establece el color de las entradas de Odiados"
	L["Sets the Foreground Color for Nicelist Entries"] = "Establece el color de las entradas de Simpáticos"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/ChatNotifier", "zhTW")
if L then
-- auto generated from wowace translation app
-- VanasKoS/ChatNotifier
	L["Add Lookup in VanasKoS"] = "新增條目在本UI"
	L["Chat Modifications"] = "修改顯示訊息"
	--[[Translation missing --]]
	--[[ L["Hated"] = ""--]] 
	L["Hatelist Color"] = "討厭列表顏色"
	--[[Translation missing --]]
	--[[ L["Liked"] = ""--]] 
	L["Lookup in VanasKoS"] = "查詢"
	L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = "在選單中增加“在仇敵管理工具中查找”"
	--[[Translation missing --]]
	--[[ L["Modifies the Chat only for your Entries"] = ""--]] 
	L["Modifies the Chat Window for Hate/Nicelist Entries."] = "修改聊天窗口討厭/好人列表項"
	--[[Translation missing --]]
	--[[ L["Modify only my Entries"] = ""--]] 
	L["Nicelist Color"] = "好人列表顏色"
	L["No entry for |cff00ff00%s|r"] = "進入為|cff0ff00%s|r"
	--[[Translation missing --]]
	--[[ L["Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r"] = ""--]] 
	L["Sets the Foreground Color for Hatelist Entries"] = "設字的顏色為討厭名單"
	L["Sets the Foreground Color for Nicelist Entries"] = "設字的顏色為好的名單"

end
