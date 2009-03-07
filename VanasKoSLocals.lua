-- Definitions based on Locales

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "enUS", true);
if L then
	L["Vanas KoS"] = true;
	L["Add KoS Player"] = true;
	L["Add Entry"] = true;
	L["Remove Entry"] = true;
	L["Change Entry"] = true;
	L["Reason"] = true;
	L["Players:"] = true;
	L["Guilds:"] = true;
	L["Lists"] = true;

	L["Entry %s (Reason: %s) added."] = true;
	L["Entry \"%s\" removed from list"] = true;
	L["KoS List for Realm \"%s\" now purged."] = true;

	L["Adds a KoS-Target"] = true;

	L["Lists"] = true;

	-- about
	L["About"] = true;

	--config frame
	L["Configuration"] = true;

	L["KoS List for Realm: %s"] = true;

	L["Toggle Menu"] = true;

	L["Accept"] = true;
	L["Cancel"] = true;
	L["Name"] = true;
	L["Name of Player to add"] = true;

	L["%s set to %s"] = "|cffffff00%s|r set to |cff00ff00%s|r";
	L[true] = "|cff00ff00on|r";
	L[false] = "|cffff0000off|r";

	L["sync"] = true;
	L["show"] = true;
	L["sort"] = true;

	L["Locked"] = true;
	L["Locks the Main Window"] = true;
	L["Reset Position"] = true;
	L["Resets the Position of the Main Window"] = true;
	L["Donate"] = true;
	L["Performance"] = true;
	L["Version: "] = true;
	L["Use Combat Log"] = true;
	L["Toggles if the combatlog should be used to detect nearby player (Needs UI-Reload)"] = true;
	L["Permanent Player-Data-Storage"] = true;
	L["Toggles if the data about players (level, class, etc) should be saved permanently."] = true;
	L["Profiles"] = true;
	L["Save data gathered in cities"] = true;
	L["Toggles if data from players gathered in cities should be (temporarily) saved."] = true;
	L["Enable in Sanctuaries"] = true;
	L["Toggles detection of players in sanctuaries"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "zhCN", false);
if L then
-- Simplified Chinese by Taburiss
	L["Vanas KoS"] = "Vanas KoS";
	L["Add KoS Player"] = "登录仇敌";
	L["Add Entry"] = "增加条目";
	L["Remove Entry"] = "删除条目";
	L["Change Entry"] = "编辑条目";
	L["Reason"] = "原因";
	L["Players:"] = "玩家：";
	L["Guilds:"] = "公会：";
	L["Lists"] = "列表";

	L["Toggle Menu"] = "菜单开启/关闭";

	L["Entry %s (Reason: %s) added."] = "因原因“%s”而添加“%s”条目";
	L["Entry \"%s\" removed from list"] = "条目“%s”已从列表中删除";
	L["KoS List for Realm \"%s\" now purged."] = "服务器“%s”的对应列表已清空";

	L["Lists"] = "列表";

	-- About dialog
	L["About"] = "关于";

	-- config frame
	L["Configuration"] = "设置";

	-- list frame

	L["KoS List for Realm: %s"] = "服务器“%s”的对应列表";


	L["Accept"] = "确定";
	L["Cancel"] = "取消";
	L["Name"] = "姓名";
	L["Name of Player to add"] = "添加玩家姓名";

	L["%s set to %s"] = "“|cffffff00%s|r”设置为“|cff00ff00%s|r”";
	L[true] = "|cff00ff00an|r";
	L[false] = "|cffff0000aus|r";

	L["sync"] = "同步";
	L["show"] = "显示";
	L["sort"] = "归类";

	L["Locked"] = "锁定";
	L["Locks the Main Window"] = "主窗口已锁定";
	L["Reset Position"] = "重置位置";
	L["Resets the Position of the Main Window"] = "重置主窗口位置";

	L["Adds a KoS-Target"] = "添加仇敌目标";
	L["Donate"] = "捐赠";
--	L["Permanent Player-Data-Storage"] = true;
--	L["Toggles if the data about players (level, class, etc) should be saved permanently."] = true;
--	L["Save data gathered in cities"] = true;
--	L["Toggles if data from players gathered in cities should be (temporarily) saved."] = true;
--	L["Enable in Sanctuaries"] = true;
--	L["Toggles detection of players in sanctuaries"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "deDE", false);
if L then
	L["Vanas KoS"] = "Vanas KoS";
	L["Add KoS Player"] = "KoS Spieler hinzufügen";
	L["Add Entry"] = "Eintrag hinzuf\195\188gen";
	L["Remove Entry"] = "L\195\182schen";
	L["Change Entry"] = "\195\132ndern";
	L["Reason"] = "Grund";
	L["Players:"] = "Spieler:";
	L["Guilds:"] = "Gilden:";
	L["Lists"] = "Listen";

	L["Toggle Menu"] = "Menu ein-/ausblenden";

	L["Entry %s (Reason: %s) added."] = "Eintrag %s (Grund %s) hinzugef\195\188gt";
	L["Entry \"%s\" removed from list"] = "Eintrag \"%s\" von der KoS-Liste entfernt";
	L["KoS List for Realm \"%s\" now purged."] = "KoS-Liste f\195\188r den Realm \"%s\" gel\195\182scht.";

	L["Lists"] = "Listen";

	-- About dialog
	L["About"] = "\195\156ber";

	-- config frame
	L["Configuration"] = "Konfiguration";

	-- list frame

	L["KoS List for Realm: %s"] = "KoS-Liste f\195\188r den Realm: %s";


	L["Accept"] = "Akzeptieren";
	L["Cancel"] = "Abbrechen";
	L["Name"] = "Name";
	L["Name of Player to add"] = "Name des Spielers zum hinzuf\195\188gen";

	L["%s set to %s"] = "|cffffff00%s|r gesetzt auf |cff00ff00%s|r";
	L[true] = "|cff00ff00an|r";
	L[false] = "|cffff0000aus|r";

	L["sync"] = "Sync";
	L["show"] = "Zeige";
	L["sort"] = "Sort";

	L["Locked"] = "Verriegelt";
	L["Locks the Main Window"] = "Verriegelt das Hauptfenster an seiner derzeitigen Position";
	L["Reset Position"] = "Position zurücksetzen";
	L["Resets the Position of the Main Window"] = "Setzt die Position des Hauptfensters zurück";

	L["Adds a KoS-Target"] = "KoS-Ziel hinzuf\195\188gen";
	L["Donate"] = "Spenden";
--	L["Permanent Player-Data-Storage"] = true;
--	L["Toggles if the data about players (level, class, etc) should be saved permanently."] = true;
--	L["Save data gathered in cities"] = true;
--	L["Toggles if data from players gathered in cities should be (temporarily) saved."] = true;
--	L["Enable in Sanctuaries"] = true;
--	L["Toggles detection of players in sanctuaries"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "frFR", false);
if L then
	L["Vanas KoS"] = "Vanas KoS";
	L["Add KoS Player"] = "Ajouter joueur KoS";
	L["Add Entry"] = "Ajouter entr\195\169e";
	L["Remove Entry"] = "Supprimer entr\195\169e";
	L["Change Entry"] = "Modifier entr\195\169e";
	L["Reason"] = "Raison";
	L["Players:"] = "Joueurs";
	L["Guilds:"] = "Guildes";
	L["Lists"] = "Listes";

	L["Entry %s (Reason: %s) added."] = "Entr\195\169e %s (Raison: %s) ajout\195\169.";
	L["Entry \"%s\" removed from list"] = "Entr\195\169e \"%s\" supprim\195\169 de la liste";
	L["KoS List for Realm \"%s\" now purged."] = "La liste KoS du Royaume \"%s\" est maintenant purg\195\169.";

	L["Lists"] = "Listes";

	-- about
	L["About"] = "\195\128 propos...";

	--config frame
	L["Configuration"] = "Configuration";



	L["KoS List for Realm: %s"] = "Liste KoS du Royaume: %s";

	L["Toggle Menu"] = "Toggle Menu";

	L["Accept"] = "Accepter";
	L["Cancel"] = "Annuler";
	L["Name"] = "Nom";
	L["Name of Player to add"] = "Nom du joueur \195\160 rajouter";

	L["%s set to %s"] = "Modifier |cffffff00%s|r \195\160 |cff00ff00%s|r";
	L[true] = "|cff00ff00on|r";
	L[false] = "|cffff0000off|r";

	L["show"] = "voir";
	L["sync"] = "sync";
	L["sort"] = "tri";

	L["Locked"] = "Verrouillé";
	L["Locks the Main Window"] = "Verrouillé la fenêtre principale";
	L["Reset Position"] = "Remettre à zéro la position";
	L["Resets the Position of the Main Window"] = "Remettre à zéro la position de la fenêtre principale";

	L["Adds a KoS-Target"] = "Ajouter une KoS-Target (cible)";
--	L["Permanent Player-Data-Storage"] = true;
--	L["Toggles if the data about players (level, class, etc) should be saved permanently."] = true;
--	L["Save data gathered in cities"] = true;
--	L["Toggles if data from players gathered in cities should be (temporarily) saved."] = true;
--	L["Enable in Sanctuaries"] = true;
--	L["Toggles detection of players in sanctuaries"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "koKR", false);
if L then
	L["Vanas KoS"] = "Vanas KoS";
	L["Add KoS Player"] = "KoS 플레이어 추가";
	L["Add Entry"] = "추가";
	L["Remove Entry"] = "삭제";
	L["Change Entry"] = "변경";
	L["Reason"] = "이유";
	L["Players:"] = "플레이어:";
	L["Guilds:"] = "길드:";
	L["Lists"] = "명부";

	L["Entry %s (Reason: %s) added."] = "%s 플레이어가 추가되었습니다.(이유: %s)";
	L["Entry \"%s\" removed from list"] = "\"%s\" 명부에서 제거되었습니다.";
	L["KoS List for Realm \"%s\" now purged."] = "서버 \"%s\"의 KoS 명부를 삭제하였습니다.";

	L["Adds a KoS-Target"] = "KoS-대상 추가";

	L["Lists"] = "명부";

	-- about
	L["About"] = "정보";

	--config frame
	L["Configuration"] = "환경 설정";

	L["KoS List for Realm: %s"] = "서버에 대한 KoS 명부: %s";

	L["Toggle Menu"] = "메뉴 열기/닫기";

	L["Accept"] = "확인";
	L["Cancel"] = "취소";
	L["Name"] = "이름";
	L["Name of Player to add"] = "추가 할 플레이어명";

	L["%s set to %s"] = "|cffffff00%s|r - |cff00ff00%s|r로 설정";
	L[true] = "|cff00ff00켬|r";
	L[false] = "|cffff0000끔|r";

	L["sync"] = "동기화";

	L["show"] = "보기";
	L["sort"] = "정렬";

	L["Locked"] = "고정";
	L["Locks the Main Window"] = "메인창을 고정합니다.";
	L["Reset Position"] = "위치 초기화";
	L["Resets the Position of the Main Window"] = "메인창의 위치를 초기화합니다.";
	L["Donate"] = "지원";
--	L["Permanent Player-Data-Storage"] = true;
--	L["Toggles if the data about players (level, class, etc) should be saved permanently."] = true;
--	L["Save data gathered in cities"] = true;
--	L["Toggles if data from players gathered in cities should be (temporarily) saved."] = true;
--	L["Enable in Sanctuaries"] = true;
--	L["Toggles detection of players in sanctuaries"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "esES", false);
if L then
	L["Vanas KoS"] = "Vanas KoS";
	L["Add KoS Player"] = "Añadir Jugador KoS";
	L["Add Entry"] = "Añadir";
	L["Remove Entry"] = "Quitar";
	L["Change Entry"] = "Cambiar";
	L["Reason"] = "Razón";
	L["Players:"] = "Jugadores:";
	L["Guilds:"] = "Hermandades:";
	L["Lists"] = "Listas";

	L["Entry %s (Reason: %s) added."] = "Entrada %s (Razón: %s) añadida";
	L["Entry \"%s\" removed from list"] = "Entrada \"%s\" quitada de la lista";
	L["KoS List for Realm \"%s\" now purged."] = "El listado KoS para el reino \"%s\" ha sido purgado.";

	L["Adds a KoS-Target"] = "Añade un objetivo Matar-al-Ver (KoS)";

	L["Lists"] = "Listas";

	-- about
	L["About"] = "Acerca de";

	--config frame
	L["Configuration"] = "Configuración";

	L["KoS List for Realm: %s"] = "Lista KoS para Reino: %s";

	L["Toggle Menu"] = "Activar Menú";

	L["Accept"] = "Aceptar";
	L["Cancel"] = "Cancelar";
	L["Name"] = "Nombre";
	L["Name of Player to add"] = "Nombre del jugador a añadir";

	L["%s set to %s"] = "|cffffff00%s|r establecido a |cff00ff00%s|r";
	L[true] = "|cff00ff00activado|r";
	L[false] = "|cffff0000desactivado|r";

	L["sync"] = "sinc";
	L["show"] = "mostrar";
	L["sort"] = "ordenar";

	L["Locked"] = "Bloqueado";
	L["Locks the Main Window"] = "Bloquea la ventana principal";
	L["Reset Position"] = "Reestablecer Posición";
	L["Resets the Position of the Main Window"] = "Reestablece la posición de la ventana principal";
--	L["Permanent Player-Data-Storage"] = true;
--	L["Toggles if the data about players (level, class, etc) should be saved permanently."] = true;
--	L["Save data gathered in cities"] = true;
--	L["Toggles if data from players gathered in cities should be (temporarily) saved."] = true;
--	L["Enable in Sanctuaries"] = true;
--	L["Toggles detection of players in sanctuaries"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", "ruRU", false);
if L then
	L["Vanas KoS"] = "Vanas KoS";
	L["Add KoS Player"] = "Добавить игрока в KoS";
	L["Add Entry"] = "Добавить запись";
	L["Remove Entry"] = "Удалить запись";
	L["Change Entry"] = "Изменить запись";
	L["Reason"] = "Причина";
	L["Players:"] = "Игроки:";
	L["Guilds:"] = "Гильдии:";
	L["Lists"] = "Списки";

	L["Toggle Menu"] = "Откр-закр. Меню";

	L["Entry %s (Reason: %s) added."] = "Запись %s (Причина: %s) добавлена";
	L["Entry \"%s\" removed from list"] = "Запись \"%s\" удалена из списка";
	L["KoS List for Realm \"%s\" now purged."] = "Список KoS для мира \"%s\" очищен.";

	L["Lists"] = "Списки";

	-- About dialog
	L["About"] = "О KoS";

	-- config frame
	L["Configuration"] = "Настройка";

	-- list frame

	L["KoS List for Realm: %s"] = "Список KoSдля мира: %s";


	L["Accept"] = "Принять";
	L["Cancel"] = "Отмена";
	L["Name"] = "Имя";
	L["Name of Player to add"] = "Имя добавляемого игрока";

	L["%s set to %s"] = "|cffffff00%s|r установлено в |cff00ff00%s|r";
	L[true] = "|cff00ff00Включено|r";
	L[false] = "|cffff0000Выключено|r";

	L["sync"] = "Синхр";
	L["show"] = "Показ";
	L["sort"] = "Сорт";

	L["Locked"] = "Зафиксировано";
	L["Locks the Main Window"] = "Фиксирует главное окно";
	L["Reset Position"] = "Сброс расположения";
	L["Resets the Position of the Main Window"] = "Сбрасывает расположение главного окна";

	L["Adds a KoS-Target"] = "Добавляет цель в KoS";
	L["Donate"] = "Donate";
--	L["Permanent Player-Data-Storage"] = true;
--	L["Toggles if the data about players (level, class, etc) should be saved permanently."] = true;
--	L["Save data gathered in cities"] = true;
--	L["Toggles if data from players gathered in cities should be (temporarily) saved."] = true;
--	L["Enable in Sanctuaries"] = true;
--	L["Toggles detection of players in sanctuaries"] = true;
end

VANASKOS = { };

VANASKOS.NAME = "VanasKoS";
VANASKOS.COMMANDS = {"/kos"; "/vkos"; "/vanaskos"};
VANASKOS.VERSION = "0"; -- filled later
VANASKOS.LastNameEntered = "";
VANASKOS.AUTHOR = "Vane of EU-Aegwynn";

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS", false);

BINDING_HEADER_VANASKOS_HEADER = L["Vanas KoS"];
BINDING_NAME_VANASKOS_TEXT_TOGGLE_MENU = L["Toggle Menu"];
BINDING_NAME_VANASKOS_TEXT_ADD_PLAYER = L["Add KoS Player"];

VANASKOS.DEBUG = 0;
