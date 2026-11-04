--[[----------------------------------------------------------------------
      WarnFrame Module - Part of VanasKoS
Creates the WarnFrame to alert of nearby KoS, Hostile and Friendly
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "enUS", true)
if L then
	L["Background"] = true
	L["Background Color"] = true
	L["Configuration"] = true
	L["Content"] = true
	L["Controls the design of the warning window"] = true
	L["Default Background Color"] = true
	L["Design"] = true
	L["female"] = true
	L["Font Size"] = true
	L["Friendly"] = true
	L["Grow list from the bottom of the WarnFrame"] = true
	L["Grow list upwards"] = true
	L["Hide if inactive"] = true
	L["Hide if PvP flag off"] = true
	L["Hide if War Mode off"] = true
	L["Hostile"] = true
	L["How friendly content is shown"] = true
	L["How hostile content is shown"] = true
	L["How kos content is shown"] = true
	L["How neutral content is shown"] = true
	L["KoS"] = true
	L["KoS/Enemy/Friendly Warning Window"] = true
	L["Locked"] = true
	L["male"] = true
	L["Macro"] = true
	L["Macro Text"] = true
	L["Macro to execute on click"] = true
	L["More Allied than Hostiles Background Color"] = true
	L["More Hostiles than Allied Background Color"] = true
	L["Neutral"] = true
	L["No Information Available"] = true
	L["Number of lines"] = true
	L["Dynamic resize"] = true
	L["Sets number of entries to display in the WarnFrame based on nearby player count"] = true
	L["Remove delay"] = true
	L["Reset"] = true
	L["Reset macro to default"] = true
	L["Reset Position"] = true
	L["Reset Settings"] = true
	L["Sets the default Background Color and Opacity"] = true
	L["Sets the KoS majority Color and Opacity"] = true
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = true
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = true
	L["Sets the normal text color"] = true
	L["Sets the number of entries to display in the Warnframe"] = true
	L["Sets the number of seconds before entry is removed"] = true
	L["Sets the size of the font in the Warnframe"] = true
	L["Sets the text of the macro to be executed when a name is clicked"] = true
	L["Sets the text of the macro to be executed when a name is clicked. An example can be found in the macros.txt file"] = true
	L["Show additional Information on Mouse Over"] = true
	L["Show border"] = true
	L["Show class icons"] = true
	L["Show Friendly Targets"] = true
	L["Show Hostile Targets"] = true
	L["Show KoS Targets"] = true
	L["Show Target Level When Possible"] = true
	L["Text"] = true
	L["Toggles the display of additional Information on Mouse Over"] = true
	L["Toggles the display of Class icons in the Warnframe"] = true
	L["Warning Window"] = true
	L["What to show in the warning window"] = true

	L["Zones"] = true
	L["Zones to show the warning window in"] = true
	L["Battlegrounds"] = true
	L["Show in battlegrounds and pvp zones"] = true
	L["Dungeon"] = true
	L["Show in dungeon instances"] = true
	L["Arena"] = true
	L["Show in arenas"] = true
	L["Cities"] = true
	L["Show in cities"] = true
	L["Sanctuaries"] = true
	L["Show in sanctuaries"] = true
	L["Combat Zones"] = true
	L["Show in combat zones"] = true

	L["KoS: %s"] = true
	L["%sKoS: %s"] = true
	L["KoS (Guild): %s"] = true
	L["%sKoS (Guild): %s"] = true
	L["Nicelist: %s"] = true
	L["%sNicelist: %s"] = true
	L["Hatelist: %s"] = true
	L["%sHatelist: %s"] = true
	L["Wanted: %s"] = true
	L["%sWanted: %s"] = true

	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = true
	L["Alignment"] = true
	L["Sets warnframe font alignment"] = true
	L["LEFT"] = true
	L["CENTER"] = true
	L["RIGHT"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "frFR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/WarnFrame
	--[[Translation missing --]]
	--[[ L["%sHatelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS (Guild): %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sNicelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sWanted: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Alignment"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Arena"] = ""--]] 
	L["Background"] = "Fond"
	L["Background Color"] = "Couleur de fond"
	--[[Translation missing --]]
	--[[ L["Battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["CENTER"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Combat Zones"] = ""--]] 
	L["Configuration"] = "Configuration"
	L["Content"] = "Contenu"
	L["Controls the design of the warning window"] = "Contrôle de la conception de la fenêtre d'avertissement"
	L["Default Background Color"] = "Couleur de fond"
	L["Design"] = "Apparence"
	--[[Translation missing --]]
	--[[ L["Dungeon"] = ""--]] 
	L["Dynamic resize"] = "Dynamique redimensionner"
	L["female"] = "féminin"
	L["Font Size"] = "Taille de fonte"
	L["Friendly"] = "Amical"
	L["Grow list from the bottom of the WarnFrame"] = "Accroissez la liste du bas du WarnFrame"
	L["Grow list upwards"] = "Accroissez la liste ascendante"
	--[[Translation missing --]]
	--[[ L["Hatelist: %s"] = ""--]] 
	L["Hide if inactive"] = "Cacher si inactif"
	--[[Translation missing --]]
	--[[ L["Hide if PvP flag off"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hide if War Mode off"] = ""--]] 
	L["Hostile"] = "Hostile"
	L["How friendly content is shown"] = "Comment le contenu convivial est montré"
	L["How hostile content is shown"] = "Comment le contenu est affiché hostile"
	L["How kos content is shown"] = "Comment le contenu est affiché kos"
	L["How neutral content is shown"] = "Comment contenu neutre est montré"
	L["KoS"] = "KoS"
	--[[Translation missing --]]
	--[[ L["KoS (Guild): %s"] = ""--]] 
	L["KoS/Enemy/Friendly Warning Window"] = "Fenêtre d'avertissement KoS/Ennemi/Amis"
	--[[Translation missing --]]
	--[[ L["KoS: %s"] = ""--]] 
	L["LEFT"] = "GAUCHE"
	L["Locked"] = "Verrouillé"
	L["Macro"] = "Macro"
	L["Macro Text"] = "Macro Texte"
	L["Macro to execute on click"] = "Macro à exécuter sur cliquez sur"
	L["male"] = "mâle"
	L["More Allied than Hostiles Background Color"] = "Couleur de fond pour cible amical"
	L["More Hostiles than Allied Background Color"] = "Couleur de fond pour cible hostile"
	L["Neutral"] = "Neutre"
	--[[Translation missing --]]
	--[[ L["Nicelist: %s"] = ""--]] 
	L["No Information Available"] = "No Information Available"
	L["Number of lines"] = "Nombre de lignes"
	L["Remove delay"] = "Retirer retard"
	L["Reset"] = "Remise"
	L["Reset macro to default"] = "macro Reset par défaut"
	L["Reset Position"] = "Remettre à zéro la position"
	L["Reset Settings"] = "Réinitialisation des paramètres"
	L["RIGHT"] = "DROITE"
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = ""--]] 
	L["Sets number of entries to display in the WarnFrame based on nearby player count"] = "Fixe le nombre d'entrées à afficher dans la WarnFrame fonction du nombre de joueur à proximité"
	L["Sets the default Background Color and Opacity"] = "Choisir la couleur et l'opacité"
	L["Sets the KoS majority Color and Opacity"] = "Définit la majorité Kos couleur et l'opacité"
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "Choisir la couleur de fond pour cible amical"
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "Choisir la couleur de fond pour cible hostile"
	L["Sets the normal text color"] = "Définit la couleur du texte normal"
	L["Sets the number of entries to display in the Warnframe"] = "Ajustez le nombre de lignes dans WarnFrame"
	L["Sets the number of seconds before entry is removed"] = "Définit le nombre de secondes avant l'entrée est supprimée"
	L["Sets the size of the font in the Warnframe"] = "Ajustez la taille de fonte dans le WarnFrame"
	L["Sets the text of the macro to be executed when a name is clicked"] = "Définit le texte de la macro à exécuter lorsque vous cliquez sur un nom"
	L["Sets the text of the macro to be executed when a name is clicked. An example can be found in the macros.txt file"] = "Définit le texte de la macro à exécuter lorsque le nom est cliqué. Un exemple peut être trouvé dans le fichier macros.txt"
	L["Sets warnframe font alignment"] = "Définit l'alignement de la police de la fenêtre d'alerte"
	L["Show additional Information on Mouse Over"] = "Montrer les informations additionnelles"
	L["Show border"] = "Montrez le cadre"
	L["Show class icons"] = "Montrez les graphismes de classe"
	L["Show Friendly Targets"] = "Afficher cibles amis"
	L["Show Hostile Targets"] = "Afficher cibles hostiles"
	--[[Translation missing --]]
	--[[ L["Show in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in battlegrounds and pvp zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in combat zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in dungeon instances"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in sanctuaries"] = ""--]] 
	L["Show KoS Targets"] = "Afficher cibles KoS"
	L["Show Target Level When Possible"] = "Afficher le level des cibles quand c'est possible"
	L["Text"] = "Texte"
	L["Toggles the display of additional Information on Mouse Over"] = "Afficher/cacher les informations additionnelles quand vous passez la souris sur un nom"
	L["Toggles the display of Class icons in the Warnframe"] = "Afficher/cacher les graphismes de classe dans WarnFrame"
	--[[Translation missing --]]
	--[[ L["Wanted: %s"] = ""--]] 
	L["Warning Window"] = "Fenêtre d'Alerte"
	L["What to show in the warning window"] = "Que montrer à la fenêtre d'avertissement"
	--[[Translation missing --]]
	--[[ L["Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zones to show the warning window in"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "deDE")
if L then
-- auto generated from wowace translation app
-- VanasKoS/WarnFrame
	L["%sHatelist: %s"] = "%sHassliste: %s"
	L["%sKoS (Guild): %s"] = "%sKoS (Gilde): %s"
	L["%sKoS: %s"] = "%sKoS: %s"
	L["%sNicelist: %s"] = "%sNettliste: %s"
	L["%sWanted: %s"] = "%sGesucht: %s"
	L["Alignment"] = "Ausrichtung"
	L["Arena"] = "Arena"
	L["Background"] = "Hintergrund"
	L["Background Color"] = "Hintergrundfarbe"
	L["Battlegrounds"] = "Schlachtfelder"
	L["CENTER"] = "MITTIG"
	L["Cities"] = "Städte"
	L["Combat Zones"] = "Kampfzonen"
	L["Configuration"] = "Konfiguration"
	L["Content"] = "Inhalt"
	L["Controls the design of the warning window"] = "Kontrolliert die Darstellung des Warnfensters"
	L["Default Background Color"] = "Standard Hintergrundfarbe"
	L["Design"] = "Aussehen"
	L["Dungeon"] = "Verlies"
	L["Dynamic resize"] = "Dynamische Größenveränderung"
	L["female"] = "weiblich"
	L["Font Size"] = "Schrifttypgröße"
	L["Friendly"] = "Freundlich"
	L["Grow list from the bottom of the WarnFrame"] = "Liste an der Unterseite des WarnFrames expandieren lassen"
	L["Grow list upwards"] = "Liste an der Oberseite expandieren lassen"
	L["Hatelist: %s"] = "Hassliste: %s"
	L["Hide if inactive"] = "Verstecken, wenn inaktiv"
	L["Hide if PvP flag off"] = "Verstecken, wenn PVP Modus aus"
	--[[Translation missing --]]
	--[[ L["Hide if War Mode off"] = ""--]] 
	L["Hostile"] = "Feindlich"
	L["How friendly content is shown"] = "Wie freundlicher Inhalt angezeigt wird."
	L["How hostile content is shown"] = "Wie feindlicher Inhalt angezeigt wird."
	L["How kos content is shown"] = "Wie \"KoS\"-Inhalt angezeigt wird."
	L["How neutral content is shown"] = "Wie neutraler Inhalt angezeigt wird."
	L["KoS"] = "KoS"
	L["KoS (Guild): %s"] = "KoS (Gilde): %s"
	L["KoS/Enemy/Friendly Warning Window"] = "KoS/Feind/Freund Warn-Fenster"
	L["KoS: %s"] = "KoS: %s"
	L["LEFT"] = "VERLASSEN"
	L["Locked"] = "Versperrt"
	L["Macro"] = "Makro"
	L["Macro Text"] = "Makro-Text"
	L["Macro to execute on click"] = "Makro bei Klick ausführen."
	L["male"] = "männlich"
	L["More Allied than Hostiles Background Color"] = "Mehr Verbündete als Feinde Hintergrundfarbe"
	L["More Hostiles than Allied Background Color"] = "Mehr Feinde als Verbündete Hintergrundfarbe"
	L["Neutral"] = "Neutral"
	L["Nicelist: %s"] = "Nettliste: %s"
	L["No Information Available"] = "Keine Informationen verfügbar"
	L["Number of lines"] = "Anzahl der Zeilen"
	L["Remove delay"] = "Verzögerung entfernen."
	L["Reset"] = "Zurücksetzen."
	L["Reset macro to default"] = "Makro auf Voreinstellungen zurücksetzen."
	L["Reset Position"] = "Position zurücksetzen"
	L["Reset Settings"] = "Einstellungen zurücksetzen."
	L["RIGHT"] = "RICHTIG"
	L["Sanctuaries"] = "Sicheres Gebiete"
	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "Gesehen: |cffffffff%d|r Siege: |cff00ff00%d|r Niederlagen: |cffff0000%d|r"
	L["Sets number of entries to display in the WarnFrame based on nearby player count"] = "Stellt die im \"WarnFrame\" darzustellende Anzahl der Einträge ein, basierend auf der Zählung in der Nähe befindlicher Spieler."
	L["Sets the default Background Color and Opacity"] = "Setzt die standardmäßige Hintergrundfarbe und Transparenz"
	L["Sets the KoS majority Color and Opacity"] = "Stellt die vorrangige Farbe und die Deckkraft von KoS ein."
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "Setzt die Hintergrundfarbe und Transparenz wenn mehr Verbündete als Feinde da sind"
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "Setzt die Hintergrundfarbe und Transparenz wenn mehr Feinde als Verbündete da sind"
	L["Sets the normal text color"] = "Die normale Textfarbe einstellen."
	L["Sets the number of entries to display in the Warnframe"] = "Setzt die Zahl der Einträge im Warnframe"
	L["Sets the number of seconds before entry is removed"] = "Stellt die Anzahl der Sekunden ein, ehe ein Eintrag entfernt wird."
	L["Sets the size of the font in the Warnframe"] = "Setzt die Schrifttypgröße im Warnframe"
	L["Sets the text of the macro to be executed when a name is clicked"] = "Stellt den Text des auszuführenden Makros ein, wenn ein Name angeklickt wird."
	L["Sets the text of the macro to be executed when a name is clicked. An example can be found in the macros.txt file"] = "Stellt den Text des auszuführenden Makros ein, wenn ein Name angeklickt wird. Ein Beispiel kann in der Datei macros.txt gefunden werden."
	--[[Translation missing --]]
	--[[ L["Sets warnframe font alignment"] = ""--]] 
	L["Show additional Information on Mouse Over"] = "Zusätzliche Informationen, Maus darübergelegt wird"
	L["Show border"] = "Zeige den Rand"
	L["Show class icons"] = "Zeige Klassen-Symbole"
	L["Show Friendly Targets"] = "Freundliche Ziele anzeigen"
	L["Show Hostile Targets"] = "Feindliche Ziele anzeigen"
	--[[Translation missing --]]
	--[[ L["Show in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in battlegrounds and pvp zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in combat zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in dungeon instances"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in sanctuaries"] = ""--]] 
	L["Show KoS Targets"] = "KoS-Ziele anzeigen"
	L["Show Target Level When Possible"] = "Level von Zielen anzeigen (wenn möglich)"
	L["Text"] = "Text"
	L["Toggles the display of additional Information on Mouse Over"] = "Zusätzliche Informationen beim Darüberlegen der Maus anzeigen"
	L["Toggles the display of Class icons in the Warnframe"] = "Schaltet die Anzeige der Klassensymbole im Warnframe an/aus"
	L["Wanted: %s"] = "Gesucht: %s"
	L["Warning Window"] = "Warnfenster"
	L["What to show in the warning window"] = "Was im Warnfenster angezeigt werden soll."
	L["Zones"] = "Zonen"
	--[[Translation missing --]]
	--[[ L["Zones to show the warning window in"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "koKR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/WarnFrame
	--[[Translation missing --]]
	--[[ L["%sHatelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS (Guild): %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sNicelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sWanted: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Alignment"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Arena"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Background"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Background Color"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["CENTER"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Combat Zones"] = ""--]] 
	L["Configuration"] = "환경설정"
	L["Content"] = "내용"
	--[[Translation missing --]]
	--[[ L["Controls the design of the warning window"] = ""--]] 
	L["Default Background Color"] = "기본 배경 색상"
	L["Design"] = "디자인"
	--[[Translation missing --]]
	--[[ L["Dungeon"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Dynamic resize"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["female"] = ""--]] 
	L["Font Size"] = "폰트 사이즈"
	--[[Translation missing --]]
	--[[ L["Friendly"] = ""--]] 
	L["Grow list from the bottom of the WarnFrame"] = "경고 창의 바닥에서 명부를 위로 성장하십시오"
	L["Grow list upwards"] = "상승 명부를 성장하십시오"
	--[[Translation missing --]]
	--[[ L["Hatelist: %s"] = ""--]] 
	L["Hide if inactive"] = "사용하지 않으면 숨김"
	--[[Translation missing --]]
	--[[ L["Hide if PvP flag off"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hide if War Mode off"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hostile"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How friendly content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How hostile content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How kos content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How neutral content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS (Guild): %s"] = ""--]] 
	L["KoS/Enemy/Friendly Warning Window"] = "KoS/적대적/우호적 알림창"
	--[[Translation missing --]]
	--[[ L["KoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["LEFT"] = ""--]] 
	L["Locked"] = "고정"
	--[[Translation missing --]]
	--[[ L["Macro"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Macro Text"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Macro to execute on click"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["male"] = ""--]] 
	L["More Allied than Hostiles Background Color"] = "우호적 배경 색상"
	L["More Hostiles than Allied Background Color"] = "적대적 배경 색상"
	--[[Translation missing --]]
	--[[ L["Neutral"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist: %s"] = ""--]] 
	L["No Information Available"] = "이용가능한 정보가 없습니다."
	L["Number of lines"] = "행수"
	--[[Translation missing --]]
	--[[ L["Remove delay"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset macro to default"] = ""--]] 
	L["Reset Position"] = "위치 초기화"
	--[[Translation missing --]]
	--[[ L["Reset Settings"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["RIGHT"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets number of entries to display in the WarnFrame based on nearby player count"] = ""--]] 
	L["Sets the default Background Color and Opacity"] = "기본 배경의 색상과 투명도를 설정합니다."
	--[[Translation missing --]]
	--[[ L["Sets the KoS majority Color and Opacity"] = ""--]] 
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "우호적 배경 색상과 투명도를 설정합니다."
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "적대적 배경 색상과 투명도를 설정합니다."
	--[[Translation missing --]]
	--[[ L["Sets the normal text color"] = ""--]] 
	L["Sets the number of entries to display in the Warnframe"] = "경고 창에 있는 전시에 입장의 수를 놓는다"
	--[[Translation missing --]]
	--[[ L["Sets the number of seconds before entry is removed"] = ""--]] 
	L["Sets the size of the font in the Warnframe"] = "경고 창에 있는 글꼴의 크기를 놓는다"
	--[[Translation missing --]]
	--[[ L["Sets the text of the macro to be executed when a name is clicked"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the text of the macro to be executed when a name is clicked. An example can be found in the macros.txt file"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets warnframe font alignment"] = ""--]] 
	L["Show additional Information on Mouse Over"] = "마우스 오버 시 추가 정보 표시"
	L["Show border"] = "쇼 국경"
	L["Show class icons"] = "직업 아이콘 표시"
	L["Show Friendly Targets"] = "우호적 대상 표시"
	L["Show Hostile Targets"] = "적대적 대상 표시"
	--[[Translation missing --]]
	--[[ L["Show in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in battlegrounds and pvp zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in combat zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in dungeon instances"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in sanctuaries"] = ""--]] 
	L["Show KoS Targets"] = "KoS 대상 표시"
	L["Show Target Level When Possible"] = "대상의 레벨 표시"
	--[[Translation missing --]]
	--[[ L["Text"] = ""--]] 
	L["Toggles the display of additional Information on Mouse Over"] = "마우스 오버 시 추가 정보 표시를 전환합니다."
	L["Toggles the display of Class icons in the Warnframe"] = "경고창에 직업 아이콘을 표시합니다."
	--[[Translation missing --]]
	--[[ L["Wanted: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Warning Window"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["What to show in the warning window"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zones to show the warning window in"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "esMX")
if L then
-- auto generated from wowace translation app
-- VanasKoS/WarnFrame
	--[[Translation missing --]]
	--[[ L["%sHatelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS (Guild): %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sNicelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sWanted: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Alignment"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Arena"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Background"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Background Color"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["CENTER"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Combat Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Configuration"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Content"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Controls the design of the warning window"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Default Background Color"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Design"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Dungeon"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Dynamic resize"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["female"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Font Size"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Friendly"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Grow list from the bottom of the WarnFrame"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Grow list upwards"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hatelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hide if inactive"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hide if PvP flag off"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hide if War Mode off"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hostile"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How friendly content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How hostile content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How kos content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How neutral content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS (Guild): %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS/Enemy/Friendly Warning Window"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["LEFT"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Locked"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Macro"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Macro Text"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Macro to execute on click"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["male"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["More Allied than Hostiles Background Color"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["More Hostiles than Allied Background Color"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Neutral"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["No Information Available"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Number of lines"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Remove delay"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset macro to default"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset Position"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset Settings"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["RIGHT"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets number of entries to display in the WarnFrame based on nearby player count"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the default Background Color and Opacity"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the KoS majority Color and Opacity"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the more Allied than Hostiles Background Color and Opacity"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the more Hostiles than Allied Background Color and Opacity"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the normal text color"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the number of entries to display in the Warnframe"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the number of seconds before entry is removed"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the size of the font in the Warnframe"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the text of the macro to be executed when a name is clicked"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the text of the macro to be executed when a name is clicked. An example can be found in the macros.txt file"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets warnframe font alignment"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show additional Information on Mouse Over"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show border"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show class icons"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show Friendly Targets"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show Hostile Targets"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in battlegrounds and pvp zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in combat zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in dungeon instances"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show KoS Targets"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show Target Level When Possible"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Text"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles the display of additional Information on Mouse Over"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Toggles the display of Class icons in the Warnframe"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Wanted: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Warning Window"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["What to show in the warning window"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zones to show the warning window in"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "ruRU")
if L then
-- auto generated from wowace translation app
-- VanasKoS/WarnFrame
	--[[Translation missing --]]
	--[[ L["%sHatelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS (Guild): %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sNicelist: %s"] = ""--]] 
	L["%sWanted: %s"] = "%sРозыск: %s"
	--[[Translation missing --]]
	--[[ L["Alignment"] = ""--]] 
	L["Arena"] = "Арена"
	L["Background"] = "Фон"
	L["Background Color"] = "Цвет фона"
	L["Battlegrounds"] = "Поле битвы"
	--[[Translation missing --]]
	--[[ L["CENTER"] = ""--]] 
	L["Cities"] = "Города"
	L["Combat Zones"] = "Зоны боевых действий"
	L["Configuration"] = "Настройка"
	L["Content"] = "Содержимое"
	--[[Translation missing --]]
	--[[ L["Controls the design of the warning window"] = ""--]] 
	L["Default Background Color"] = "Цвет фона по умолчанию"
	L["Design"] = "Дизайн"
	L["Dungeon"] = "Подземелье"
	L["Dynamic resize"] = "Изменяющийся размер"
	L["female"] = "Женский"
	L["Font Size"] = "Размер шрифта"
	L["Friendly"] = "Дружелюбный"
	L["Grow list from the bottom of the WarnFrame"] = "Вырастите список от дна WarnFrame"
	L["Grow list upwards"] = "Вырастите список верхний"
	L["Hatelist: %s"] = "Ненавистный: %s"
	L["Hide if inactive"] = "Скрывать, если не активно"
	--[[Translation missing --]]
	--[[ L["Hide if PvP flag off"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hide if War Mode off"] = ""--]] 
	L["Hostile"] = "Враждебный"
	--[[Translation missing --]]
	--[[ L["How friendly content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How hostile content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How kos content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How neutral content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS (Guild): %s"] = ""--]] 
	L["KoS/Enemy/Friendly Warning Window"] = "Окно предупреждений о KoS/Враге/Друге"
	L["KoS: %s"] = "KoS: %s"
	--[[Translation missing --]]
	--[[ L["LEFT"] = ""--]] 
	L["Locked"] = "Зафиксировано"
	L["Macro"] = "Макрос"
	L["Macro Text"] = "Текст макроса"
	--[[Translation missing --]]
	--[[ L["Macro to execute on click"] = ""--]] 
	L["male"] = "Мужской"
	L["More Allied than Hostiles Background Color"] = "Цвет фона для \"Больше дружественных, чем враждебных\""
	L["More Hostiles than Allied Background Color"] = "Цвет фона для \"Больше враждебных, чем дружественных\""
	--[[Translation missing --]]
	--[[ L["Neutral"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist: %s"] = ""--]] 
	L["No Information Available"] = "Нет доступной информации"
	L["Number of lines"] = "Количество линий"
	--[[Translation missing --]]
	--[[ L["Remove delay"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset macro to default"] = ""--]] 
	L["Reset Position"] = "Сбросить расположение"
	--[[Translation missing --]]
	--[[ L["Reset Settings"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["RIGHT"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets number of entries to display in the WarnFrame based on nearby player count"] = ""--]] 
	L["Sets the default Background Color and Opacity"] = "Задает цвет фона и прозрачность"
	--[[Translation missing --]]
	--[[ L["Sets the KoS majority Color and Opacity"] = ""--]] 
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "Задает цвет и прозрачность фона для \"Больше дружественных, чем враждебных\""
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "Задает цвет и прозрачность фона для \"Больше враждебных, чем дружественных\""
	L["Sets the normal text color"] = "Устанавливает нормальный цвет текста"
	L["Sets the number of entries to display in the Warnframe"] = "Отрегулируйте количество линий в окне предупреждений"
	--[[Translation missing --]]
	--[[ L["Sets the number of seconds before entry is removed"] = ""--]] 
	L["Sets the size of the font in the Warnframe"] = "Настроить размер шрифта в Окне предупреждений"
	--[[Translation missing --]]
	--[[ L["Sets the text of the macro to be executed when a name is clicked"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the text of the macro to be executed when a name is clicked. An example can be found in the macros.txt file"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets warnframe font alignment"] = ""--]] 
	L["Show additional Information on Mouse Over"] = "Показывать дополнительную информацию при наводе мышки"
	L["Show border"] = "Показывать границу"
	L["Show class icons"] = "Показывать иконки класса"
	L["Show Friendly Targets"] = "Показывать дружественные цели"
	L["Show Hostile Targets"] = "Показывать, враждебные цели"
	--[[Translation missing --]]
	--[[ L["Show in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in battlegrounds and pvp zones"] = ""--]] 
	L["Show in cities"] = "Показывать в городе"
	L["Show in combat zones"] = "Показывать в боевой зоне"
	L["Show in dungeon instances"] = "Показывать в подземелье"
	--[[Translation missing --]]
	--[[ L["Show in sanctuaries"] = ""--]] 
	L["Show KoS Targets"] = "Показывать цели KoS"
	L["Show Target Level When Possible"] = "Показывать уровень цели когда это возможно"
	L["Text"] = "Текст"
	L["Toggles the display of additional Information on Mouse Over"] = "Вкл-выкл отображение дополнительной информации при наведении мышки"
	L["Toggles the display of Class icons in the Warnframe"] = "Показывать или нет классовые иконки в окне предупреждений"
	L["Wanted: %s"] = "Розыск: %s"
	L["Warning Window"] = "Окно предупреждений"
	L["What to show in the warning window"] = "Что показывать в окне оповещений"
	L["Zones"] = "Зоны"
	L["Zones to show the warning window in"] = "Зоны, в которых показывать окно предупреждений"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "zhCN")
if L then
-- auto generated from wowace translation app
-- VanasKoS/WarnFrame
	L["%sHatelist: %s"] = "%s仇恨列表：%s"
	L["%sKoS (Guild): %s"] = "%s仇敌（公会）：%s"
	L["%sKoS: %s"] = "%s仇敌：%s"
	L["%sNicelist: %s"] = "%s友好列表：%s"
	L["%sWanted: %s"] = "%s通缉：%s"
	L["Alignment"] = "对齐"
	L["Arena"] = "竞技场"
	L["Background"] = "背景"
	L["Background Color"] = "背景颜色"
	L["Battlegrounds"] = "战场"
	L["CENTER"] = "中"
	L["Cities"] = "城市"
	L["Combat Zones"] = "战斗区域"
	L["Configuration"] = "配置"
	L["Content"] = "内容"
	L["Controls the design of the warning window"] = "控制设计的警报窗口"
	L["Default Background Color"] = "默认背景颜色"
	L["Design"] = "设计"
	L["Dungeon"] = "地下城"
	L["Dynamic resize"] = "动态缩放"
	L["female"] = "女"
	L["Font Size"] = "字体尺寸"
	L["Friendly"] = "友好的"
	L["Grow list from the bottom of the WarnFrame"] = "警报框架从下到上生长列表"
	L["Grow list upwards"] = "向上生长列表"
	L["Hatelist: %s"] = "仇恨列表：%s"
	L["Hide if inactive"] = "不活动时隐藏"
	--[[Translation missing --]]
	--[[ L["Hide if PvP flag off"] = ""--]] 
	L["Hide if War Mode off"] = "战争模式关闭时隐藏"
	L["Hostile"] = "敌对的"
	L["How friendly content is shown"] = "怎样显示友好内容"
	L["How hostile content is shown"] = "怎样显示敌对内容"
	L["How kos content is shown"] = "怎样显示仇敌内容"
	L["How neutral content is shown"] = "怎样显示中立内容"
	L["KoS"] = "仇敌"
	L["KoS (Guild): %s"] = "仇敌（公会）：%s"
	L["KoS/Enemy/Friendly Warning Window"] = "仇敌/都对/友好警报窗口"
	L["KoS: %s"] = "仇敌：%s"
	L["LEFT"] = "左"
	L["Locked"] = "已锁定"
	L["Macro"] = "宏"
	L["Macro Text"] = "宏文本"
	L["Macro to execute on click"] = "宏执行点击"
	L["male"] = "男"
	L["More Allied than Hostiles Background Color"] = "友好背景颜色比敌对背景颜色更深"
	L["More Hostiles than Allied Background Color"] = "敌对背景颜色比友好背景颜色更深"
	L["Neutral"] = "中立"
	L["Nicelist: %s"] = "友好列表：%s"
	L["No Information Available"] = "没有可用消息"
	L["Number of lines"] = "行数"
	L["Remove delay"] = "移除延迟"
	L["Reset"] = "重置"
	L["Reset macro to default"] = "重置宏到默认"
	L["Reset Position"] = "重置位置"
	L["Reset Settings"] = "重置设置"
	L["RIGHT"] = "右"
	L["Sanctuaries"] = "多个安全区域"
	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "发现：|cffffffff%d|r - 胜利：|cff00ff00%d|r - 失败：|cffff0000%d|r"
	L["Sets number of entries to display in the WarnFrame based on nearby player count"] = "基于周围玩家计数设置警报框体条目数字显示"
	L["Sets the default Background Color and Opacity"] = "设置默认背景颜色和不透明度"
	L["Sets the KoS majority Color and Opacity"] = "设置仇敌主颜色和不透明度"
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "设置友好背景颜色比敌对背景颜色更深"
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "设置敌对背景颜色比友好背景颜色更深"
	L["Sets the normal text color"] = "设置普通文本颜色"
	L["Sets the number of entries to display in the Warnframe"] = "设置在警报框体显示的项数"
	L["Sets the number of seconds before entry is removed"] = "设置删除之前的秒数项"
	L["Sets the size of the font in the Warnframe"] = "设置警报框体的字体尺寸"
	L["Sets the text of the macro to be executed when a name is clicked"] = "设置当一个名称被点击时执行的宏文本"
	L["Sets the text of the macro to be executed when a name is clicked. An example can be found in the macros.txt file"] = "设置当一个名称被点击时执行的宏文本。可在 macros.txt 文件内找到举例。"
	L["Sets warnframe font alignment"] = "设置警报框体字体对齐"
	L["Show additional Information on Mouse Over"] = "鼠标悬停是显示附加信息"
	L["Show border"] = "显示边框"
	L["Show class icons"] = "显示职业图标"
	L["Show Friendly Targets"] = "显示友好目标"
	L["Show Hostile Targets"] = "显示敌对目标"
	L["Show in arenas"] = "在竞技场中显示"
	L["Show in battlegrounds and pvp zones"] = "战场和竞技场显示"
	L["Show in cities"] = "城中显示"
	L["Show in combat zones"] = "战斗区域显示"
	L["Show in dungeon instances"] = "地下城副本显示"
	L["Show in sanctuaries"] = "安全区域显示"
	L["Show KoS Targets"] = "显示仇敌目标"
	L["Show Target Level When Possible"] = "显示可能的目标等级"
	L["Text"] = "文本"
	L["Toggles the display of additional Information on Mouse Over"] = "切换鼠标悬停附加信息显示"
	L["Toggles the display of Class icons in the Warnframe"] = "切换警报框体职业图标显示"
	L["Wanted: %s"] = "通缉：%s"
	L["Warning Window"] = "警报窗口"
	L["What to show in the warning window"] = "警报窗口显示"
	L["Zones"] = "区域"
	L["Zones to show the warning window in"] = "显示警报窗口区域"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "esES")
if L then
-- auto generated from wowace translation app
-- VanasKoS/WarnFrame
	--[[Translation missing --]]
	--[[ L["%sHatelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS (Guild): %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sNicelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sWanted: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Alignment"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Arena"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Background"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Background Color"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["CENTER"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Combat Zones"] = ""--]] 
	L["Configuration"] = "Configuración"
	L["Content"] = "Contenido"
	--[[Translation missing --]]
	--[[ L["Controls the design of the warning window"] = ""--]] 
	L["Default Background Color"] = "Color de fondo por defecto"
	L["Design"] = "Diseño"
	--[[Translation missing --]]
	--[[ L["Dungeon"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Dynamic resize"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["female"] = ""--]] 
	L["Font Size"] = "Talla de fuente"
	--[[Translation missing --]]
	--[[ L["Friendly"] = ""--]] 
	L["Grow list from the bottom of the WarnFrame"] = "Crezca la lista de la parte inferior del WarnFrame"
	L["Grow list upwards"] = "Crezca la lista ascendente"
	--[[Translation missing --]]
	--[[ L["Hatelist: %s"] = ""--]] 
	L["Hide if inactive"] = "Ocultar si inactivo"
	--[[Translation missing --]]
	--[[ L["Hide if PvP flag off"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hide if War Mode off"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hostile"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How friendly content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How hostile content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How kos content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How neutral content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS (Guild): %s"] = ""--]] 
	L["KoS/Enemy/Friendly Warning Window"] = "Ventana de Aviso de KoS/Enemigo/Amistoso"
	--[[Translation missing --]]
	--[[ L["KoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["LEFT"] = ""--]] 
	L["Locked"] = "Bloqueado"
	--[[Translation missing --]]
	--[[ L["Macro"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Macro Text"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Macro to execute on click"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["male"] = ""--]] 
	L["More Allied than Hostiles Background Color"] = "Color de fondo de más aliados que hostiles"
	L["More Hostiles than Allied Background Color"] = "Color de fondo de más hostiles que aliados"
	--[[Translation missing --]]
	--[[ L["Neutral"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist: %s"] = ""--]] 
	L["No Information Available"] = "Ninguna información disponible"
	L["Number of lines"] = "Número de líneas"
	--[[Translation missing --]]
	--[[ L["Remove delay"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset macro to default"] = ""--]] 
	L["Reset Position"] = "Reestablecer Posición"
	--[[Translation missing --]]
	--[[ L["Reset Settings"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["RIGHT"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets number of entries to display in the WarnFrame based on nearby player count"] = ""--]] 
	L["Sets the default Background Color and Opacity"] = "Establece el color de fondo y la opacidad por defecto"
	--[[Translation missing --]]
	--[[ L["Sets the KoS majority Color and Opacity"] = ""--]] 
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "Establece el color de fondo y la opacidad de más aliados que hostiles"
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "Establece el color de fondo y la opacidad de más hostiles que aliados"
	--[[Translation missing --]]
	--[[ L["Sets the normal text color"] = ""--]] 
	L["Sets the number of entries to display in the Warnframe"] = "Fije la cantidad de líneas en el WarnFrame"
	--[[Translation missing --]]
	--[[ L["Sets the number of seconds before entry is removed"] = ""--]] 
	L["Sets the size of the font in the Warnframe"] = "Ajuste la talla de fuente en el Warnframe"
	--[[Translation missing --]]
	--[[ L["Sets the text of the macro to be executed when a name is clicked"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the text of the macro to be executed when a name is clicked. An example can be found in the macros.txt file"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets warnframe font alignment"] = ""--]] 
	L["Show additional Information on Mouse Over"] = "Demuestre la información adicional encendido mouse-sobre"
	L["Show border"] = "Muestre la frontera"
	L["Show class icons"] = "Demuestre los iconos de la clase"
	L["Show Friendly Targets"] = "Mostrar objetivos amistosos"
	L["Show Hostile Targets"] = "Mostrar objetivos hostiles"
	--[[Translation missing --]]
	--[[ L["Show in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in battlegrounds and pvp zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in combat zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in dungeon instances"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in sanctuaries"] = ""--]] 
	L["Show KoS Targets"] = "Mostrar objetivos KoS"
	L["Show Target Level When Possible"] = "Mostrar el nivel del objetivo cuando sea posible"
	--[[Translation missing --]]
	--[[ L["Text"] = ""--]] 
	L["Toggles the display of additional Information on Mouse Over"] = "Acciona la palanca de la exhibición de la información adicional encendido mouse-sobre"
	L["Toggles the display of Class icons in the Warnframe"] = "Acciona la palanca de la exhibición de los iconos de la clase en el Warnframe"
	--[[Translation missing --]]
	--[[ L["Wanted: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Warning Window"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["What to show in the warning window"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zones to show the warning window in"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/WarnFrame", "zhTW")
if L then
-- auto generated from wowace translation app
-- VanasKoS/WarnFrame
	--[[Translation missing --]]
	--[[ L["%sHatelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS (Guild): %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sKoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sNicelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["%sWanted: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Alignment"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Arena"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Background"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Background Color"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["CENTER"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Combat Zones"] = ""--]] 
	L["Configuration"] = "配置"
	L["Content"] = "内容"
	--[[Translation missing --]]
	--[[ L["Controls the design of the warning window"] = ""--]] 
	L["Default Background Color"] = "默認背景顔色"
	L["Design"] = "設計"
	--[[Translation missing --]]
	--[[ L["Dungeon"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Dynamic resize"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["female"] = ""--]] 
	L["Font Size"] = "字體大小"
	--[[Translation missing --]]
	--[[ L["Friendly"] = ""--]] 
	L["Grow list from the bottom of the WarnFrame"] = "列表顯示在警告窗體下方"
	L["Grow list upwards"] = "列表顯示在警告窗體上方"
	--[[Translation missing --]]
	--[[ L["Hatelist: %s"] = ""--]] 
	L["Hide if inactive"] = "當無效時隱藏"
	--[[Translation missing --]]
	--[[ L["Hide if PvP flag off"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hide if War Mode off"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hostile"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How friendly content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How hostile content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How kos content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["How neutral content is shown"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS (Guild): %s"] = ""--]] 
	L["KoS/Enemy/Friendly Warning Window"] = "仇敵/敵人/友善警告窗體"
	--[[Translation missing --]]
	--[[ L["KoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["LEFT"] = ""--]] 
	L["Locked"] = "已鎖定"
	--[[Translation missing --]]
	--[[ L["Macro"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Macro Text"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Macro to execute on click"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["male"] = ""--]] 
	L["More Allied than Hostiles Background Color"] = "同盟數量超過敵方數量的背景顔色"
	L["More Hostiles than Allied Background Color"] = "敵方數量超過同盟數量的背景顔色"
	--[[Translation missing --]]
	--[[ L["Neutral"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist: %s"] = ""--]] 
	L["No Information Available"] = "沒有任何信息"
	L["Number of lines"] = "行數"
	--[[Translation missing --]]
	--[[ L["Remove delay"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Reset macro to default"] = ""--]] 
	L["Reset Position"] = "重置位置"
	--[[Translation missing --]]
	--[[ L["Reset Settings"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["RIGHT"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets number of entries to display in the WarnFrame based on nearby player count"] = ""--]] 
	L["Sets the default Background Color and Opacity"] = "重置默認背景顔色,顯示為不透明"
	--[[Translation missing --]]
	--[[ L["Sets the KoS majority Color and Opacity"] = ""--]] 
	L["Sets the more Allied than Hostiles Background Color and Opacity"] = "設置同盟數量超過敵方時的背景顔色,顯示為不透明"
	L["Sets the more Hostiles than Allied Background Color and Opacity"] = "設置敵方數量超過同盟的背景顔色,顯示為不透明"
	--[[Translation missing --]]
	--[[ L["Sets the normal text color"] = ""--]] 
	L["Sets the number of entries to display in the Warnframe"] = "設置顯示在警告框條目的數量"
	--[[Translation missing --]]
	--[[ L["Sets the number of seconds before entry is removed"] = ""--]] 
	L["Sets the size of the font in the Warnframe"] = "設置警告框的字體大小"
	--[[Translation missing --]]
	--[[ L["Sets the text of the macro to be executed when a name is clicked"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets the text of the macro to be executed when a name is clicked. An example can be found in the macros.txt file"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sets warnframe font alignment"] = ""--]] 
	L["Show additional Information on Mouse Over"] = "在滑鼠移過的時候顯示更多的信息"
	L["Show border"] = "顯示邊框"
	L["Show class icons"] = "顯示職業圖標"
	L["Show Friendly Targets"] = "顯示友好的目標"
	L["Show Hostile Targets"] = "顯示敵對的目標"
	--[[Translation missing --]]
	--[[ L["Show in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in battlegrounds and pvp zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in combat zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in dungeon instances"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show in sanctuaries"] = ""--]] 
	L["Show KoS Targets"] = "顯示仇敵目標"
	L["Show Target Level When Possible"] = "在可以的情況下顯示目標等級"
	--[[Translation missing --]]
	--[[ L["Text"] = ""--]] 
	L["Toggles the display of additional Information on Mouse Over"] = "(啓用)在滑鼠移過的時候顯示更多的信息"
	L["Toggles the display of Class icons in the Warnframe"] = "(啓用)在警告框顯示職業圖標"
	--[[Translation missing --]]
	--[[ L["Wanted: %s"] = ""--]] 
	L["Warning Window"] = "警告窗体"
	--[[Translation missing --]]
	--[[ L["What to show in the warning window"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zones to show the warning window in"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/WarnFrame", false);
