-- Definitions based on Locales

local function RegisterTranslations(locale, translationfunction)
	local defaultLocale = false;
	if(locale == "enUS") then
		defaultLocale = true;
	end
	
	local liblocale = LibStub("AceLocale-3.0"):NewLocale("VanasKoS", locale, defaultLocale);
	if liblocale then
		for k, v in pairs(translationfunction()) do
			liblocale[k] = v;
		end
	end
end

RegisterTranslations("enUS", function() return {
	["Vanas KoS"] = true,
	["Add KoS Player"] = true,
	["Add Entry"] = true,
	["Remove Entry"] = true,
	["Change Entry"] = true,
	["Reason"] = true,
	["Players:"] = true,
	["Guilds:"] = true,
	["Lists"] = true,

	["Entry %s (Reason: %s) added."] = true,
	["Entry \"%s\" removed from list"] = true,
	["KoS List for Realm \"%s\" now purged."] = true,

	["Adds a KoS-Target"] = true,

	["Lists"] = true,

	-- about
	["About"] = true,

	--config frame
	["Configuration"] = true,

	["KoS List for Realm: %s"] = true,

	["Toggle Menu"] = true,

	["Accept"] = true,
	["Cancel"] = true,
	["Name"] = true,
	["Name of Player to add"] = true,

	["%s set to %s"] = "|cffffff00%s|r set to |cff00ff00%s|r",
	[true] = "|cff00ff00on|r",
	[false] = "|cffff0000off|r",

	["sync"] = true,
	["show"] = true,
	["sort"] = true,

	["Locked"] = true,
	["Locks the Main Window"] = true,
	["Reset Position"] = true,
	["Resets the Position of the Main Window"] = true,
	["Donate"] = true,
	["Performance"] = true,
	["Version: "] = true,
	["Use Combat Log"] = true,
	["Toggles if the combatlog should be used to detect nearby player (Needs UI-Reload)"] = true,
} end);

RegisterTranslations("zhCN", function() return {
-- Simplified Chinese by Taburiss
	["Vanas KoS"] = "Vanas KoS",
	["Add KoS Player"] = "登录仇敌",
	["Add Entry"] = "增加条目",
	["Remove Entry"] = "删除条目",
	["Change Entry"] = "编辑条目",
	["Reason"] = "原因",
	["Players:"] = "玩家：",
	["Guilds:"] = "公会：",
	["Lists"] = "列表",

	["Toggle Menu"] = "菜单开启/关闭",

	["Entry %s (Reason: %s) added."] = "因原因“%s”而添加“%s”条目",
	["Entry \"%s\" removed from list"] = "条目“%s”已从列表中删除",
	["KoS List for Realm \"%s\" now purged."] = "服务器“%s”的对应列表已清空",

	["Lists"] = "列表",

	-- About dialog
	["About"] = "关于",

	-- config frame
	["Configuration"] = "设置",

	-- list frame

	["KoS List for Realm: %s"] = "服务器“%s”的对应列表",


	["Accept"] = "确定",
	["Cancel"] = "取消",
	["Name"] = "姓名",
	["Name of Player to add"] = "添加玩家姓名",

	["%s set to %s"] = "“|cffffff00%s|r”设置为“|cff00ff00%s|r”",
	[true] = "|cff00ff00an|r",
	[false] = "|cffff0000aus|r",

	["sync"] = "同步",
	["show"] = "显示",
	["sort"] = "归类",

	["Locked"] = "锁定",
	["Locks the Main Window"] = "主窗口已锁定",
	["Reset Position"] = "重置位置",
	["Resets the Position of the Main Window"] = "重置主窗口位置",

	["Adds a KoS-Target"] = "添加仇敌目标",
	["Donate"] = "捐赠",
} end);

RegisterTranslations("deDE", function() return {
	["Vanas KoS"] = "Vanas KoS",
	["Add KoS Player"] = "KoS Spieler hinzufügen",
	["Add Entry"] = "Eintrag hinzuf\195\188gen",
	["Remove Entry"] = "L\195\182schen",
	["Change Entry"] = "\195\132ndern",
	["Reason"] = "Grund",
	["Players:"] = "Spieler:",
	["Guilds:"] = "Gilden:",
	["Lists"] = "Listen",

	["Toggle Menu"] = "Menu ein-/ausblenden",

	["Entry %s (Reason: %s) added."] = "Eintrag %s (Grund %s) hinzugef\195\188gt",
	["Entry \"%s\" removed from list"] = "Eintrag \"%s\" von der KoS-Liste entfernt",
	["KoS List for Realm \"%s\" now purged."] = "KoS-Liste f\195\188r den Realm \"%s\" gel\195\182scht.",

	["Lists"] = "Listen",

	-- About dialog
	["About"] = "\195\156ber",

	-- config frame
	["Configuration"] = "Konfiguration",

	-- list frame

	["KoS List for Realm: %s"] = "KoS-Liste f\195\188r den Realm: %s",


	["Accept"] = "Akzeptieren",
	["Cancel"] = "Abbrechen",
	["Name"] = "Name",
	["Name of Player to add"] = "Name des Spielers zum hinzuf\195\188gen",

	["%s set to %s"] = "|cffffff00%s|r gesetzt auf |cff00ff00%s|r",
	[true] = "|cff00ff00an|r",
	[false] = "|cffff0000aus|r",

	["sync"] = "Sync",
	["show"] = "Zeige",
	["sort"] = "Sort",

	["Locked"] = "Verriegelt",
	["Locks the Main Window"] = "Verriegelt das Hauptfenster an seiner derzeitigen Position",
	["Reset Position"] = "Position zurücksetzen",
	["Resets the Position of the Main Window"] = "Setzt die Position des Hauptfensters zurück",

	["Adds a KoS-Target"] = "KoS-Ziel hinzuf\195\188gen",
	["Donate"] = "Spenden",
} end);

RegisterTranslations("frFR", function() return {
	["Vanas KoS"] = "Vanas KoS",
	["Add KoS Player"] = "Ajouter joueur KoS",
	["Add Entry"] = "Ajouter entr\195\169e",
	["Remove Entry"] = "Supprimer entr\195\169e",
	["Change Entry"] = "Modifier entr\195\169e",
	["Reason"] = "Raison",
	["Players:"] = "Joueurs",
	["Guilds:"] = "Guildes",
	["Lists"] = "Listes",

	["Entry %s (Reason: %s) added."] = "Entr\195\169e %s (Raison: %s) ajout\195\169.",
	["Entry \"%s\" removed from list"] = "Entr\195\169e \"%s\" supprim\195\169 de la liste",
	["KoS List for Realm \"%s\" now purged."] = "La liste KoS du Royaume \"%s\" est maintenant purg\195\169.",

	["Lists"] = "Listes",

	-- about
	["About"] = "\195\128 propos...",

	--config frame
	["Configuration"] = "Configuration",



	["KoS List for Realm: %s"] = "Liste KoS du Royaume: %s",

	["Toggle Menu"] = "Toggle Menu",

	["Accept"] = "Accepter",
	["Cancel"] = "Annuler",
	["Name"] = "Nom",
	["Name of Player to add"] = "Nom du joueur \195\160 rajouter",

	["%s set to %s"] = "Modifier |cffffff00%s|r \195\160 |cff00ff00%s|r",
	[true] = "|cff00ff00on|r",
	[false] = "|cffff0000off|r",

	["show"] = "voir",
	["sync"] = "sync",
	["sort"] = "tri",

	["Locked"] = "Verrouillé",
	["Locks the Main Window"] = "Verrouillé la fenêtre principale",
	["Reset Position"] = "Remettre à zéro la position",
	["Resets the Position of the Main Window"] = "Remettre à zéro la position de la fenêtre principale",

	["Adds a KoS-Target"] = "Ajouter une KoS-Target (cible)",
} end);

RegisterTranslations("koKR", function() return {
	["Vanas KoS"] = "Vanas KoS",
	["Add KoS Player"] = "KoS 플레이어 추가",
	["Add Entry"] = "추가",
	["Remove Entry"] = "삭제",
	["Change Entry"] = "변경",
	["Reason"] = "이유",
	["Players:"] = "플레이어:",
	["Guilds:"] = "길드:",
	["Lists"] = "명부",

	["Entry %s (Reason: %s) added."] = "%s 플레이어가 추가되었습니다.(이유: %s)",
	["Entry \"%s\" removed from list"] = "\"%s\" 명부에서 제거되었습니다.",
	["KoS List for Realm \"%s\" now purged."] = "서버 \"%s\"의 KoS 명부를 삭제하였습니다.",

	["Adds a KoS-Target"] = "KoS-대상 추가",

	["Lists"] = "명부",

	-- about
	["About"] = "정보",

	--config frame
	["Configuration"] = "환경 설정",

	["KoS List for Realm: %s"] = "서버에 대한 KoS 명부: %s",

	["Toggle Menu"] = "메뉴 열기/닫기",

	["Accept"] = "확인",
	["Cancel"] = "취소",
	["Name"] = "이름",
	["Name of Player to add"] = "추가 할 플레이어명",

	["%s set to %s"] = "|cffffff00%s|r - |cff00ff00%s|r로 설정",
	[true] = "|cff00ff00켬|r",
	[false] = "|cffff0000끔|r",

	["sync"] = "동기화",

	["show"] = "보기",
	["sort"] = "정렬",

	["Locked"] = "고정",
	["Locks the Main Window"] = "메인창을 고정합니다.",
	["Reset Position"] = "위치 초기화",
	["Resets the Position of the Main Window"] = "메인창의 위치를 초기화합니다.",
	["Donate"] = "지원",
} end);

RegisterTranslations("esES", function() return {
	["Vanas KoS"] = "Vanas KoS",
	["Add KoS Player"] = "Añadir Jugador KoS",
	["Add Entry"] = "Añadir",
	["Remove Entry"] = "Quitar",
	["Change Entry"] = "Cambiar",
	["Reason"] = "Razón",
	["Players:"] = "Jugadores:",
	["Guilds:"] = "Hermandades:",
	["Lists"] = "Listas",

	["Entry %s (Reason: %s) added."] = "Entrada %s (Razón: %s) añadida",
	["Entry \"%s\" removed from list"] = "Entrada \"%s\" quitada de la lista",
	["KoS List for Realm \"%s\" now purged."] = "El listado KoS para el reino \"%s\" ha sido purgado.",

	["Adds a KoS-Target"] = "Añade un objetivo Matar-al-Ver (KoS)",

	["Lists"] = "Listas",

	-- about
	["About"] = "Acerca de",

	--config frame
	["Configuration"] = "Configuración",

	["KoS List for Realm: %s"] = "Lista KoS para Reino: %s",

	["Toggle Menu"] = "Activar Menú",

	["Accept"] = "Aceptar",
	["Cancel"] = "Cancelar",
	["Name"] = "Nombre",
	["Name of Player to add"] = "Nombre del jugador a añadir",

	["%s set to %s"] = "|cffffff00%s|r establecido a |cff00ff00%s|r",
	[true] = "|cff00ff00activado|r",
	[false] = "|cffff0000desactivado|r",

	["sync"] = "sinc",
	["show"] = "mostrar",
	["sort"] = "ordenar",

	["Locked"] = "Bloqueado",
	["Locks the Main Window"] = "Bloquea la ventana principal",
	["Reset Position"] = "Reestablecer Posición",
	["Resets the Position of the Main Window"] = "Reestablece la posición de la ventana principal",
} end);

RegisterTranslations("ruRU", function() return {
	["Vanas KoS"] = "Vanas KoS",
	["Add KoS Player"] = "Добавить игрока в KoS",
	["Add Entry"] = "Добавить запись",
	["Remove Entry"] = "Удалить запись",
	["Change Entry"] = "Изменить запись",
	["Reason"] = "Причина",
	["Players:"] = "Игроки:",
	["Guilds:"] = "Гильдии:",
	["Lists"] = "Списки",

	["Toggle Menu"] = "Откр-закр. Меню",

	["Entry %s (Reason: %s) added."] = "Запись %s (Причина: %s) добавлена",
	["Entry \"%s\" removed from list"] = "Запись \"%s\" удалена из списка",
	["KoS List for Realm \"%s\" now purged."] = "Список KoS для мира \"%s\" очищен.",

	["Lists"] = "Списки",

	-- About dialog
	["About"] = "О KoS",

	-- config frame
	["Configuration"] = "Настройка",

	-- list frame

	["KoS List for Realm: %s"] = "Список KoSдля мира: %s",


	["Accept"] = "Принять",
	["Cancel"] = "Отмена",
	["Name"] = "Имя",
	["Name of Player to add"] = "Имя добавляемого игрока",

	["%s set to %s"] = "|cffffff00%s|r установлено в |cff00ff00%s|r",
	[true] = "|cff00ff00Включено|r",
	[false] = "|cffff0000Выключено|r",

	["sync"] = "Синхр",
	["show"] = "Показ",
	["sort"] = "Сорт",

	["Locked"] = "Зафиксировано",
	["Locks the Main Window"] = "Фиксирует главное окно",
	["Reset Position"] = "Сброс расположения",
	["Resets the Position of the Main Window"] = "Сбрасывает расположение главного окна",

	["Adds a KoS-Target"] = "Добавляет цель в KoS",
	["Donate"] = "Donate",
} end);

VANASKOS = { };

VANASKOS.NAME = "VanasKoS";
VANASKOS.COMMANDS = {"/kos", "/vkos", "/vanaskos"};
VANASKOS.VERSION = "0"; -- filled later
VANASKOS.LastNameEntered = "";
VANASKOS.AUTHOR = "Vane of EU-Aegwynn";

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS", false);

BINDING_HEADER_VANASKOS_HEADER = L["Vanas KoS"];
BINDING_NAME_VANASKOS_TEXT_TOGGLE_MENU = L["Toggle Menu"];
BINDING_NAME_VANASKOS_TEXT_ADD_PLAYER = L["Add KoS Player"];

VANASKOS.DEBUG = 0;
