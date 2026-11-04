--[[----------------------------------------------------------------------
      Notifier Module - Part of VanasKoS
Notifies the user via Tooltip, Chat and Upper Area of a KoS/other List Target
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "enUS", true)
if L then
	L["Interval (seconds)"] = true
	L["Notification Interval (seconds)"] = true
	L["Chat message"] = true
	L["Notification in the Chatframe"] = true
	L["On-screen"] = true
	L["Notification in the Upper Area"] = true
	L["Notifications"] = true
	L["Party notification"] = true
	L["Notify when a player in hate list or nice list joins your party"] = true
	L["Flashing Border"] = true
	L["Notification through flashing Border"] = true
	L["Dragon Portrait"] = true
	L["Notification through Target Portrait"] = true
	L["Notify in Sanctuary"] = true
	L["All enemies"] = true
	L["Notify of any enemy target"] = true
	L["Mine only"] = true
	L["Notify only on my KoS-Targets"] = true
	L["Raid Browser"] = true
	L["Colors players in raid browser based on hated/nice status"] = true
	L["Friend list"] = true
	L["Colors players in friend list based on hated/nice status"] = true
	L["Ignore list"] = true
	L["Colors players in ignore list based on hated/nice status"] = true
	L["Stats in Tooltip"] = true
	L["Show PvP-Stats in Tooltip"] = true
	L["Sounds"] = true
	L["Notification sounds"] = true
	L["Enemy Sound"] = true
	L["Sound on enemy detection"] = true
	L["KoS Sound"] = true
	L["Sound on KoS detection"] = true
	L["Hated sound"] = true
	L["Sound when a hated player joins your raid or party"] = true
	L["Nice sound"] = true
	L["Sound when a nice player joins your raid or party"] = true
	L["Extra Reason"] = true
	L["Additional Reason Window"] = true
	L["Enabled"] = true
	L["Show Anchor"] = true
	L["Locked"] = true

	L["Zones"] = true
	L["Notification Zones"] = true
	L["Sanctuaries"] = true
	L["Notify in Sanctuaries"] = true
	L["Cities"] = true
	L["Notify in cities"] = true
	L["Battlegrounds"] = true
	L["Notify in battleground"] = true
	L["Arenas"] = true
	L["Notify in arenas"] = true
	L["Combat Zones"] = true
	L["Notify in combat zones (Wintergrasp, Tol Barad)"] = true

	L["Enemy Detected:|cffff0000"] = true
	L["Hated player \"%s\" (%s) is in your party"] = true
	L["Nice player \"%s\" (%s) is in your party"] = true
	L["Hated player \"%s\" (%s) is in your raid"] = true
	L["Nice player \"%s\" (%s) is in your raid"] = true

	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = true
	L["KoS: %s"]         = true
	L["KoS (Guild): %s"] = true
	L["Hatelist: %s"]    = true
	L["Nicelist: %s"]    = true
	L["Wanted: %s"]      = true
	L["%sKoS: %s"]         = "|cffff00ff%s's|r KoS: %s"
	L["%sKoS (Guild): %s"] = "|cffff00ff%s's|r KoS (Guild): %s"
	L["%sHatelist: %s"]    = "|cffff00ff%s's|r Hatelist: %s"
	L["%sNicelist: %s"]    = "|cffff00ff%s's|r Nicelist: %s"
	L["%sWanted: %s"]      = "|cffff00ff%s's|r Wanted: %s"
	L["KoS"]               = true
	L["Hatelist"]          = true
	L["Nicelist"]          = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "frFR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Notifier
	L["%sHatelist: %s"] = "Liste noire à |cffff00ff%s|r: %s"
	L["%sKoS (Guild): %s"] = "KoS (Guilde) à |cffff00ff%s|r: %s"
	L["%sKoS: %s"] = "KoS à |cffff00ff%s|r: %s"
	L["%sNicelist: %s"] = "Liste blanche à |cffff00ff%s|r: %s"
	L["%sWanted: %s"] = "|cffff00ff%s's|r Wanted: %s"
	L["Additional Reason Window"] = "Fenêtre additionnelle de raison"
	L["All enemies"] = "Tous les ennemis"
	--[[Translation missing --]]
	--[[ L["Arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Battlegrounds"] = ""--]] 
	L["Chat message"] = "Chat message"
	--[[Translation missing --]]
	--[[ L["Cities"] = ""--]] 
	L["Colors players in friend list based on hated/nice status"] = "Couleurs joueurs en liste d'amis sur haï / statut de Nice"
	L["Colors players in ignore list based on hated/nice status"] = "Couleurs joueurs en liste noire basée sur haï / statut de Nice"
	L["Colors players in raid browser based on hated/nice status"] = "Couleurs joueurs dans le navigateur basé sur raid haï / statut de Nice"
	--[[Translation missing --]]
	--[[ L["Combat Zones"] = ""--]] 
	L["Dragon Portrait"] = "Portrait dragon"
	L["Enabled"] = "Actif"
	L["Enemy Detected:|cffff0000"] = "Ennemis détectés: | ffff0000"
	L["Enemy Sound"] = "Son Ennemi"
	L["Extra Reason"] = "Raison supplémentaire"
	L["Flashing Border"] = "Clignotant frontaliers"
	L["Friend list"] = "liste d'amis"
	L["Hated player \"%s\" (%s) is in your party"] = "Détesté lecteur \"%s\" (%s) est dans votre groupe"
	L["Hated player \"%s\" (%s) is in your raid"] = "Détesté lecteur \"%s\" (%s) est dans votre raid"
	L["Hated sound"] = "son Hated"
	--[[Translation missing --]]
	--[[ L["Hatelist"] = ""--]] 
	L["Hatelist: %s"] = "Liste noire: %s"
	L["Ignore list"] = "Ignorer la liste"
	L["Interval (seconds)"] = "Intervalle (secondes)"
	--[[Translation missing --]]
	--[[ L["KoS"] = ""--]] 
	L["KoS (Guild): %s"] = "KoS (Guilde): %s"
	L["KoS Sound"] = "Kos Sound"
	L["KoS: %s"] = "KoS: %s"
	L["Locked"] = "Verrouillé"
	L["Mine only"] = "Mon seul"
	L["Nice player \"%s\" (%s) is in your party"] = "joueur de Nice \"%s\" (%s) est dans votre groupe"
	L["Nice player \"%s\" (%s) is in your raid"] = "oueur de Nice \"%s\" (%s) est dans votre raid"
	L["Nice sound"] = "son Nice"
	--[[Translation missing --]]
	--[[ L["Nicelist"] = ""--]] 
	L["Nicelist: %s"] = "Liste blanche: %s"
	L["Notification in the Chatframe"] = "Notification dans la fenêtre de discussion"
	L["Notification in the Upper Area"] = "Notification en message principal central"
	L["Notification Interval (seconds)"] = "Intervalle entre notifications (secondes)"
	L["Notification sounds"] = "Notification des sons"
	L["Notification through flashing Border"] = "Notification avec bordure flash"
	L["Notification through Target Portrait"] = "Notification avec portrait (dragon élite)"
	--[[Translation missing --]]
	--[[ L["Notification Zones"] = ""--]] 
	L["Notifications"] = "Notifications"
	--[[Translation missing --]]
	--[[ L["Notify in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in Sanctuaries"] = ""--]] 
	L["Notify in Sanctuary"] = "Avertissez dans Sanctuaire"
	L["Notify of any enemy target"] = "L'informent de toute cible ennemie"
	L["Notify only on my KoS-Targets"] = "Notification de mes propres cibles seulement"
	L["Notify when a player in hate list or nice list joins your party"] = "Avertissez quand un joueur dans la haine ou la liste Nice rejoint votre groupe"
	L["On-screen"] = "Sur l'écran"
	L["Party notification"] = "notification des Parties"
	L["Raid Browser"] = "Raid navigateur"
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "seen: |cffffffff%d|r victoires: |cff00ff00%d|r défaites: |cffff0000%d|r"
	L["Show Anchor"] = "Voir Anchor"
	L["Show PvP-Stats in Tooltip"] = "Afficher PvP-Stats dans le Tooltip"
	L["Sound on enemy detection"] = "Son ennemi sur la détection"
	L["Sound on KoS detection"] = "Son de détection KoS"
	L["Sound when a hated player joins your raid or party"] = "Sound quand un joueur rejoint haï votre raid ou de la partie"
	L["Sound when a nice player joins your raid or party"] = "Sound quand un joueur se joint à votre raid Nice ou de la partie"
	L["Sounds"] = "Sons"
	L["Stats in Tooltip"] = "Stat en info-bulle"
	L["Wanted: %s"] = "Wanted: %s"
	--[[Translation missing --]]
	--[[ L["Zones"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "deDE")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Notifier
	L["%sHatelist: %s"] = "|cffff00ff%ss|r Hassliste: %s"
	L["%sKoS (Guild): %s"] = "|cffff00ff%ss|r KoS (Gilde): %s"
	L["%sKoS: %s"] = "|cffff00ff%ss|r KoS: %s"
	L["%sNicelist: %s"] = "|cffff00ff%ss|r Nette-Leute-Liste: %s"
	L["%sWanted: %s"] = "|cffff00ff%s's|r Gesucht-Liste: %s"
	L["Additional Reason Window"] = "Fenster für zusätzlichen Grund"
	L["All enemies"] = "Alle Feinde"
	L["Arenas"] = "Arenen"
	L["Battlegrounds"] = "Schlachtfelder"
	L["Chat message"] = "Chat-Mitteilung"
	L["Cities"] = "Städte"
	L["Colors players in friend list based on hated/nice status"] = "Färbt Spieler  in der Freundesliste basierend auf ihrem Status \"verhaßt\" / \"nett\" ein."
	L["Colors players in ignore list based on hated/nice status"] = "Färbt Spieler  in der Ignorierliste basierend auf ihrem Status \"verhaßt\" / \"nett\" ein."
	L["Colors players in raid browser based on hated/nice status"] = "Färbt Spieler im Schlachtzugs-Browser basierend auf ihrem Status \"verhaßt\" / \"nett\" ein."
	L["Combat Zones"] = "Kampfzonen"
	L["Dragon Portrait"] = "Drachen-Portrait"
	L["Enabled"] = "Aktiviert"
	L["Enemy Detected:|cffff0000"] = "Feind entdeckt:|cffff0000"
	L["Enemy Sound"] = "Warnsignal - Feind"
	L["Extra Reason"] = "Besonderer Grund"
	L["Flashing Border"] = "Blinkende Umrandung"
	L["Friend list"] = "Freundesliste"
	L["Hated player \"%s\" (%s) is in your party"] = "Verhaßter Spieler \"%s\" (%s) ist in deiner Gruppe"
	L["Hated player \"%s\" (%s) is in your raid"] = "Verhaßter Spieler \"%s\" (%s) ist in deinem Schlachtzug"
	L["Hated sound"] = "Warnsignal - verhaßt"
	L["Hatelist"] = "Hassliste"
	L["Hatelist: %s"] = "Hassliste: %s"
	L["Ignore list"] = "Ignorierliste"
	L["Interval (seconds)"] = "Intervall (Sekunden)"
	L["KoS"] = "KoS"
	L["KoS (Guild): %s"] = "KoS (Gilde): %s"
	L["KoS Sound"] = "Warnsignal - KoS"
	L["KoS: %s"] = "KoS: %s"
	L["Locked"] = "Versperrt"
	L["Mine only"] = "Nur meine"
	L["Nice player \"%s\" (%s) is in your party"] = "Netter Spieler \"%s\" (%s) ist in deiner Gruppe"
	L["Nice player \"%s\" (%s) is in your raid"] = "Netter Spieler \"%s\" (%s) ist in deinem Schlachtzug"
	L["Nice sound"] = "Schönes Tonsignal"
	L["Nicelist"] = "Nett-Liste"
	L["Nicelist: %s"] = "Nette-Leute-Liste: %s"
	L["Notification in the Chatframe"] = "Benachrichtigung im Chat-Fenster"
	L["Notification in the Upper Area"] = "Benachrichtigung im oberen Bereich"
	L["Notification Interval (seconds)"] = "Benachrichtigungsinterval (Sekunden)"
	L["Notification sounds"] = "Meldungs-Tonsignale"
	L["Notification through flashing Border"] = "Benachrichtigung durch Aufleuchten des Rahmens"
	L["Notification through Target Portrait"] = "Benachrichtigung über das Ziel-Fenster"
	L["Notification Zones"] = "Benachrichtigungsbereich"
	L["Notifications"] = "Benachrichtigungen"
	L["Notify in arenas"] = "Benachrichtigungen in Arena"
	L["Notify in battleground"] = "Benachrichtigungen im Schlachtfeld"
	L["Notify in cities"] = "Benachrichtigen in Städten"
	L["Notify in combat zones (Wintergrasp, Tol Barad)"] = "Benachrichtigungen in kampfgebieten (Wintergrasp, Tol Barad)"
	L["Notify in Sanctuaries"] = "In friedlichen Gebieten benachrichtigen"
	L["Notify in Sanctuary"] = "In friedlichen Gebieten benachrichtigen"
	L["Notify of any enemy target"] = "Alle feindlichen Ziele melden"
	L["Notify only on my KoS-Targets"] = "Nur bei meinen KoS-Ziele benachrichtigen"
	L["Notify when a player in hate list or nice list joins your party"] = "Meldung, wenn ein Spieler in der Haß-Liste oder Nett-Liste deiner Gruppe beitritt."
	L["On-screen"] = "Auf dem Bildschirm"
	L["Party notification"] = "Gruppen-Mitteilung"
	L["Raid Browser"] = "Schlachtzugs-Browser"
	L["Sanctuaries"] = "Sicheres Gebiete"
	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "Gesehen: |cffffffff%d|r Siege: |cff00ff00%d|r Niederlagen: |cffff0000%d|r"
	L["Show Anchor"] = "Anker anzeigen"
	L["Show PvP-Stats in Tooltip"] = "Anzeigen von PvP-Statistiken im Tooltip"
	L["Sound on enemy detection"] = "Ton bei Feinderkennung"
	L["Sound on KoS detection"] = "Audio-Benachrichtigung bei KoS"
	L["Sound when a hated player joins your raid or party"] = "Warnsignal, wenn ein verhaßter Spieler deinem Schlachtzug oder deiner Gruppe beitritt."
	L["Sound when a nice player joins your raid or party"] = "Tonsignal, wenn ein netter Spieler deinem Schlachtzug oder deiner Gruppe beitritt."
	L["Sounds"] = "Tonsignale"
	L["Stats in Tooltip"] = "Statistik im Tooltip"
	L["Wanted: %s"] = "Gesucht: %s"
	L["Zones"] = "Zonen"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "koKR")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Notifier
	L["%sHatelist: %s"] = "|cffff00ff%s|r의 악인명부: %s"
	L["%sKoS (Guild): %s"] = "|cffff00ff%s|r의 KoS (길드): %s"
	L["%sKoS: %s"] = "|cffff00ff%s|r의 KoS: %s"
	L["%sNicelist: %s"] = "|cffff00ff%s|r의 호인명부: %s"
	L["%sWanted: %s"] = "|cffff00ff%s|r의 수배: %s"
	L["Additional Reason Window"] = "이유창 추가"
	--[[Translation missing --]]
	--[[ L["All enemies"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Chat message"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in friend list based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in ignore list based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in raid browser based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Combat Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Dragon Portrait"] = ""--]] 
	L["Enabled"] = "사용"
	--[[Translation missing --]]
	--[[ L["Enemy Detected:|cffff0000"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy Sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Extra Reason"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Flashing Border"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Friend list"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated player \"%s\" (%s) is in your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated player \"%s\" (%s) is in your raid"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hatelist"] = ""--]] 
	L["Hatelist: %s"] = "악인명부: %s"
	--[[Translation missing --]]
	--[[ L["Ignore list"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Interval (seconds)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS"] = ""--]] 
	L["KoS (Guild): %s"] = "KoS (길드): %s"
	--[[Translation missing --]]
	--[[ L["KoS Sound"] = ""--]] 
	L["KoS: %s"] = "KoS: %s"
	L["Locked"] = "고정"
	--[[Translation missing --]]
	--[[ L["Mine only"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice player \"%s\" (%s) is in your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice player \"%s\" (%s) is in your raid"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist"] = ""--]] 
	L["Nicelist: %s"] = "호인명부: %s"
	L["Notification in the Chatframe"] = "대화창에 알림"
	L["Notification in the Upper Area"] = "상단 영역에 알림"
	L["Notification Interval (seconds)"] = "알림 간격(초)"
	--[[Translation missing --]]
	--[[ L["Notification sounds"] = ""--]] 
	L["Notification through flashing Border"] = "테두리 반짝임을 통해 알림"
	L["Notification through Target Portrait"] = "대상 사진을 통해 알림"
	--[[Translation missing --]]
	--[[ L["Notification Zones"] = ""--]] 
	L["Notifications"] = "알림"
	--[[Translation missing --]]
	--[[ L["Notify in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in Sanctuary"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify of any enemy target"] = ""--]] 
	L["Notify only on my KoS-Targets"] = "나의 KoS-대상일 경우만 알림"
	--[[Translation missing --]]
	--[[ L["Notify when a player in hate list or nice list joins your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["On-screen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Party notification"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Raid Browser"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "seen: |cffffffff%d|r 승: |cff00ff00%d|r 패: |cffff0000%d|r"
	--[[Translation missing --]]
	--[[ L["Show Anchor"] = ""--]] 
	L["Show PvP-Stats in Tooltip"] = "툴팁에 PvP-현황 표시"
	--[[Translation missing --]]
	--[[ L["Sound on enemy detection"] = ""--]] 
	L["Sound on KoS detection"] = "KoS 발견 효과음"
	--[[Translation missing --]]
	--[[ L["Sound when a hated player joins your raid or party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sound when a nice player joins your raid or party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Stats in Tooltip"] = ""--]] 
	L["Wanted: %s"] = "수배: %s"
	--[[Translation missing --]]
	--[[ L["Zones"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "esMX")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Notifier
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
	--[[ L["Additional Reason Window"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["All enemies"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Chat message"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in friend list based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in ignore list based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in raid browser based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Combat Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Dragon Portrait"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enabled"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy Detected:|cffff0000"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy Sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Extra Reason"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Flashing Border"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Friend list"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated player \"%s\" (%s) is in your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated player \"%s\" (%s) is in your raid"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hatelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hatelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Ignore list"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Interval (seconds)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS (Guild): %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS Sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Locked"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Mine only"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice player \"%s\" (%s) is in your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice player \"%s\" (%s) is in your raid"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification in the Chatframe"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification in the Upper Area"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification Interval (seconds)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification sounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification through flashing Border"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification through Target Portrait"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notifications"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in Sanctuary"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify of any enemy target"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify only on my KoS-Targets"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify when a player in hate list or nice list joins your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["On-screen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Party notification"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Raid Browser"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show Anchor"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show PvP-Stats in Tooltip"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sound on enemy detection"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sound on KoS detection"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sound when a hated player joins your raid or party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sound when a nice player joins your raid or party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Stats in Tooltip"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Wanted: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zones"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "ruRU")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Notifier
	L["%sHatelist: %s"] = "Ненавистный |cffff00ff%s'а|r: %s"
	L["%sKoS (Guild): %s"] = "KoS (Гильдия) |cffff00ff%s'а|r: %s"
	L["%sKoS: %s"] = "KoS |cffff00ff%s'а|r: %s"
	L["%sNicelist: %s"] = "Хороший |cffff00ff%s'а|r: %s"
	L["%sWanted: %s"] = "Розыск |cffff00ff%s'а|r: %s"
	L["Additional Reason Window"] = "Дополнительное окно Причин"
	L["All enemies"] = "Все враги"
	--[[Translation missing --]]
	--[[ L["Arenas"] = ""--]] 
	L["Battlegrounds"] = "Поле битвы"
	L["Chat message"] = "Сообщение в чате"
	L["Cities"] = "Города"
	--[[Translation missing --]]
	--[[ L["Colors players in friend list based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in ignore list based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in raid browser based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Combat Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Dragon Portrait"] = ""--]] 
	L["Enabled"] = "Включено"
	L["Enemy Detected:|cffff0000"] = "Обнаружен противник:|cffff0000"
	--[[Translation missing --]]
	--[[ L["Enemy Sound"] = ""--]] 
	L["Extra Reason"] = "Дополнительная причина"
	L["Flashing Border"] = "Мерцающая граница"
	L["Friend list"] = "Список друзей"
	L["Hated player \"%s\" (%s) is in your party"] = "Игрок, которого вы ненавидите \"%s\" (%s) в вашей команде"
	L["Hated player \"%s\" (%s) is in your raid"] = "Игрок, которого вы ненавидите \"%s\" (%s) в вашем рейде"
	--[[Translation missing --]]
	--[[ L["Hated sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hatelist"] = ""--]] 
	L["Hatelist: %s"] = "Ненавистный: %s"
	L["Ignore list"] = "Список игнорируемых"
	L["Interval (seconds)"] = "Интервал (секунд)"
	--[[Translation missing --]]
	--[[ L["KoS"] = ""--]] 
	L["KoS (Guild): %s"] = "KoS (Гильдия): %s"
	L["KoS Sound"] = "KoS Звук"
	L["KoS: %s"] = "KoS: %s"
	L["Locked"] = "Зафиксировано"
	L["Mine only"] = "Только мой"
	L["Nice player \"%s\" (%s) is in your party"] = "Хороший игрок \"%s\" (%s) находиться в Вашей группе"
	L["Nice player \"%s\" (%s) is in your raid"] = "Хороший игрок \"%s\" (%s) находиться в Вашем рейде"
	L["Nice sound"] = "Приятный звук"
	--[[Translation missing --]]
	--[[ L["Nicelist"] = ""--]] 
	L["Nicelist: %s"] = "Хороший: %s"
	L["Notification in the Chatframe"] = "Уведомление в Окне чата"
	L["Notification in the Upper Area"] = "Уведомление в Верхней части"
	L["Notification Interval (seconds)"] = "Интевал Уведомлений (в секундах)"
	L["Notification sounds"] = "Звук предупреждений"
	L["Notification through flashing Border"] = "Уведомлять мерцанием краев экрана"
	L["Notification through Target Portrait"] = "Уведомление через Портрет цели"
	--[[Translation missing --]]
	--[[ L["Notification Zones"] = ""--]] 
	L["Notifications"] = "Уведомления"
	--[[Translation missing --]]
	--[[ L["Notify in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	L["Notify in Sanctuaries"] = "Оповещать в убежищах"
	L["Notify in Sanctuary"] = "Оповещать в убежищах"
	L["Notify of any enemy target"] = "Оповещать о любой враждебной цели"
	L["Notify only on my KoS-Targets"] = "Уведомлять только о моих KoS-целях"
	--[[Translation missing --]]
	--[[ L["Notify when a player in hate list or nice list joins your party"] = ""--]] 
	L["On-screen"] = "На экране"
	L["Party notification"] = "Оповещать группу"
	L["Raid Browser"] = "Обзор рейда"
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "видел: |cffffffff%d|r побед: |cff00ff00%d|r поражений: |cffff0000%d|r"
	L["Show Anchor"] = "Показать якорь"
	L["Show PvP-Stats in Tooltip"] = "Показывать PvP-статистику в Тултипе"
	L["Sound on enemy detection"] = "Проигрывать звук при обнаружении противника"
	L["Sound on KoS detection"] = "Звук при обнаружении KoS"
	L["Sound when a hated player joins your raid or party"] = "Проигрывать звук, когда игрок которого вы ненавидите присоединяется к вашей группе или рейду"
	--[[Translation missing --]]
	--[[ L["Sound when a nice player joins your raid or party"] = ""--]] 
	L["Sounds"] = "Звуки"
	--[[Translation missing --]]
	--[[ L["Stats in Tooltip"] = ""--]] 
	L["Wanted: %s"] = "Розыск: %s"
	L["Zones"] = "Зоны"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "zhCN")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Notifier
	L["%sHatelist: %s"] = "%s仇恨列表：%s"
	L["%sKoS (Guild): %s"] = "%s仇敌（公会）：%s"
	L["%sKoS: %s"] = "%s仇敌：%s"
	L["%sNicelist: %s"] = "%s友好列表：%s"
	L["%sWanted: %s"] = "%s通缉：%s"
	L["Additional Reason Window"] = "其他原因窗口"
	L["All enemies"] = "所有敌人"
	L["Arenas"] = "竞技场"
	L["Battlegrounds"] = "战场"
	L["Chat message"] = "聊天信息"
	L["Cities"] = "城市"
	L["Colors players in friend list based on hated/nice status"] = "基于好友仇恨/友好状态玩家列表颜色"
	L["Colors players in ignore list based on hated/nice status"] = "基于好友仇恨/友好状态忽略列表颜色"
	L["Colors players in raid browser based on hated/nice status"] = "基于好友仇恨/友好状态玩家团队浏览器颜色"
	L["Combat Zones"] = "战斗区域"
	L["Dragon Portrait"] = "龙头像"
	L["Enabled"] = "已启用"
	L["Enemy Detected:|cffff0000"] = "侦测到敌人：|cffff0000"
	L["Enemy Sound"] = "敌人音效"
	L["Extra Reason"] = "附加原因"
	L["Flashing Border"] = "闪屏边框"
	L["Friend list"] = "好友列表"
	L["Hated player \"%s\" (%s) is in your party"] = "仇恨玩家\"%s\"（%s）在你的小队"
	L["Hated player \"%s\" (%s) is in your raid"] = "仇恨玩家\"%s\"（%s）在你的团队"
	L["Hated sound"] = "仇恨音效"
	L["Hatelist"] = "仇恨列表"
	L["Hatelist: %s"] = "仇恨列表：%s"
	L["Ignore list"] = "忽略列表"
	L["Interval (seconds)"] = "间隔（秒）"
	L["KoS"] = "仇敌"
	L["KoS (Guild): %s"] = "仇敌（公会）：%s"
	L["KoS Sound"] = "仇敌音效"
	L["KoS: %s"] = "仇敌：%s"
	L["Locked"] = "已锁定"
	L["Mine only"] = "只是我的"
	L["Nice player \"%s\" (%s) is in your party"] = "友好玩家\"%s\"（%s）在你的小队"
	L["Nice player \"%s\" (%s) is in your raid"] = "友好玩家\"%s\"（%s）在你的团队"
	L["Nice sound"] = "友好音效"
	L["Nicelist"] = "友好列表"
	L["Nicelist: %s"] = "友好列表：%s"
	L["Notification in the Chatframe"] = "通知到聊天框体"
	L["Notification in the Upper Area"] = "通知到上层区域"
	L["Notification Interval (seconds)"] = "通知间隔（秒）"
	L["Notification sounds"] = "通知音效"
	L["Notification through flashing Border"] = "通知通过闪屏边框"
	L["Notification through Target Portrait"] = "通知通过目标头像"
	L["Notification Zones"] = "通知区域"
	L["Notifications"] = "通知"
	L["Notify in arenas"] = "在竞技场通知"
	L["Notify in battleground"] = "在战场通知"
	L["Notify in cities"] = "在城里通知"
	L["Notify in combat zones (Wintergrasp, Tol Barad)"] = "在战斗区域通知（冬拥湖，托尔巴拉德）"
	L["Notify in Sanctuaries"] = "在多个安全区域通知"
	L["Notify in Sanctuary"] = "在安全区域通知"
	L["Notify of any enemy target"] = "通知任何敌对目标"
	L["Notify only on my KoS-Targets"] = "只通知我的仇敌目标"
	L["Notify when a player in hate list or nice list joins your party"] = "当仇恨列表或友好列表玩家加入到你的小队时通知"
	L["On-screen"] = "屏幕上"
	L["Party notification"] = "小队通知"
	L["Raid Browser"] = "团队浏览器"
	L["Sanctuaries"] = "多个安全区域"
	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "发现：|cffffffff%d|r - 胜利：|cff00ff00%d|r - 失败：|cffff0000%d|r"
	L["Show Anchor"] = "显示锚点"
	L["Show PvP-Stats in Tooltip"] = "显示 PvP 状态提示"
	L["Sound on enemy detection"] = "敌对侦测音效"
	L["Sound on KoS detection"] = "仇敌侦测音效"
	L["Sound when a hated player joins your raid or party"] = "当仇恨列表玩家加入到你的团队或小队的音效"
	L["Sound when a nice player joins your raid or party"] = "当友好列表玩家加入到你的团队或小队的音效"
	L["Sounds"] = "音效"
	L["Stats in Tooltip"] = "状态提示"
	L["Wanted: %s"] = "通缉：%s"
	L["Zones"] = "区域"

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "esES")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Notifier
	L["%sHatelist: %s"] = "Lista de odiado |cffff00ff%s|r: %s"
	L["%sKoS (Guild): %s"] = "KoS (Hermandad) de |cffff00ff%s|r: %s"
	L["%sKoS: %s"] = "KoS |cffff00ff%s|r: %s"
	L["%sNicelist: %s"] = "Lista de Simpatico |cffff00ff%s|r: %s"
	L["%sWanted: %s"] = "Se Busca de |cffff00ff%s|r: %s"
	L["Additional Reason Window"] = "Ventana adicional de Razón"
	--[[Translation missing --]]
	--[[ L["All enemies"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Chat message"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in friend list based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in ignore list based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in raid browser based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Combat Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Dragon Portrait"] = ""--]] 
	L["Enabled"] = "Activado"
	--[[Translation missing --]]
	--[[ L["Enemy Detected:|cffff0000"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy Sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Extra Reason"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Flashing Border"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Friend list"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated player \"%s\" (%s) is in your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated player \"%s\" (%s) is in your raid"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hatelist"] = ""--]] 
	L["Hatelist: %s"] = "Odiado: %s"
	--[[Translation missing --]]
	--[[ L["Ignore list"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Interval (seconds)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS"] = ""--]] 
	L["KoS (Guild): %s"] = "KoS (Hermandad): %s"
	--[[Translation missing --]]
	--[[ L["KoS Sound"] = ""--]] 
	L["KoS: %s"] = "KoS: %s"
	L["Locked"] = "Bloqueado"
	--[[Translation missing --]]
	--[[ L["Mine only"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice player \"%s\" (%s) is in your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice player \"%s\" (%s) is in your raid"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist"] = ""--]] 
	L["Nicelist: %s"] = "Simpático: %s"
	L["Notification in the Chatframe"] = "Notificar en la ventana de chat"
	L["Notification in the Upper Area"] = "Notificar en el área superior"
	L["Notification Interval (seconds)"] = "Intervalo de notificación (segundos)"
	--[[Translation missing --]]
	--[[ L["Notification sounds"] = ""--]] 
	L["Notification through flashing Border"] = "Notificar mediante borde intermitente"
	L["Notification through Target Portrait"] = "Notificar mediante el retrato del Objetivo"
	--[[Translation missing --]]
	--[[ L["Notification Zones"] = ""--]] 
	L["Notifications"] = "Notificaciones"
	--[[Translation missing --]]
	--[[ L["Notify in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in Sanctuary"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify of any enemy target"] = ""--]] 
	L["Notify only on my KoS-Targets"] = "Notificar solo mis objetivos de KoS"
	--[[Translation missing --]]
	--[[ L["Notify when a player in hate list or nice list joins your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["On-screen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Party notification"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Raid Browser"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = "visto: |cffffffff%d|r ganados: |cff00ff00%d|r perdidos: |cffff0000%d|r"
	--[[Translation missing --]]
	--[[ L["Show Anchor"] = ""--]] 
	L["Show PvP-Stats in Tooltip"] = "Mostrar las estadísticas de JcJ en el tooltip"
	--[[Translation missing --]]
	--[[ L["Sound on enemy detection"] = ""--]] 
	L["Sound on KoS detection"] = "Sonido al detectar KoS"
	--[[Translation missing --]]
	--[[ L["Sound when a hated player joins your raid or party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sound when a nice player joins your raid or party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Stats in Tooltip"] = ""--]] 
	L["Wanted: %s"] = "Se Busca: %s"
	--[[Translation missing --]]
	--[[ L["Zones"] = ""--]] 

end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Notifier", "zhTW")
if L then
-- auto generated from wowace translation app
-- VanasKoS/Notifier
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
	--[[ L["Additional Reason Window"] = ""--]] 
	L["All enemies"] = "所有敵人"
	--[[Translation missing --]]
	--[[ L["Arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Battlegrounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Chat message"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in friend list based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in ignore list based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Colors players in raid browser based on hated/nice status"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Combat Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Dragon Portrait"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enabled"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Enemy Detected:|cffff0000"] = ""--]] 
	L["Enemy Sound"] = "敵對音效"
	--[[Translation missing --]]
	--[[ L["Extra Reason"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Flashing Border"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Friend list"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated player \"%s\" (%s) is in your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated player \"%s\" (%s) is in your raid"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hated sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Hatelist"] = ""--]] 
	L["Hatelist: %s"] = "討厭列表︰%s"
	--[[Translation missing --]]
	--[[ L["Ignore list"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Interval (seconds)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS (Guild): %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS Sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["KoS: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Locked"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Mine only"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice player \"%s\" (%s) is in your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice player \"%s\" (%s) is in your raid"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nice sound"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Nicelist: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification in the Chatframe"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification in the Upper Area"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification Interval (seconds)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification sounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification through flashing Border"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification through Target Portrait"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notification Zones"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notifications"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in arenas"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in battleground"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in cities"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in combat zones (Wintergrasp, Tol Barad)"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify in Sanctuary"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify of any enemy target"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify only on my KoS-Targets"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Notify when a player in hate list or nice list joins your party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["On-screen"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Party notification"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Raid Browser"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sanctuaries"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["seen: |cffffffff%d|r - wins: |cff00ff00%d|r - losses: |cffff0000%d|r"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show Anchor"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Show PvP-Stats in Tooltip"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sound on enemy detection"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sound on KoS detection"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sound when a hated player joins your raid or party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sound when a nice player joins your raid or party"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Sounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Stats in Tooltip"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Wanted: %s"] = ""--]] 
	--[[Translation missing --]]
	--[[ L["Zones"] = ""--]] 

end
