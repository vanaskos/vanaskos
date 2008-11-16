local L = AceLibrary("AceLocale-2.2"):new("VanasKoSDefaultLists");

VanasKoSDefaultLists = VanasKoS:NewModule("DefaultLists");

local VanasKoSDefaultLists = VanasKoSDefaultLists;
local VanasKoS = VanasKoS;
local VanasKoSGUI = VanasKoSGUI;

local dewdrop = AceLibrary("Dewdrop-2.0");
local tablet = AceLibrary("Tablet-2.0");

L:RegisterTranslations("enUS", function() return {
	["Player KoS"] = true,
	["Guild KoS"] = true,
	["Nicelist"] = true,
	["Hatelist"] = true,
	["Entry %s is already on Hatelist"] = true,
	["Entry %s is already on Nicelist"] = true,
	["%s  Level %s %s %s %s"] = "%s  |cffffffffLevel %s %s %s |r|cffff00ff%s|r",
	["%s (last seen: %s ago)"] = true,
	["%s (never seen)"] = true,
	["0 Secs"] = true,
	["%s  %s"] = "%s  |cffff00ff%s|r",

	["Level %s %s %s"] = "Level |cffffffff%s %s %s|r",
	["Last seen at %s in %s"] = "Last seen at |cff00ff00%s|r |cffffffffin|r |cff00ff00%s|r|r",
	["Owner: %s"] = "Owner: |cffffffff%s|r",
	["Creator: %s"] = "Creator: |cffffffff%s|r",
	["Created: %s"] = "Created: |cffffffff%s|r",
	["Received from: %s"] = "Received from: |cffffffff%s|r",
	["Last updated: %s"] = "Last updated: |cffffffff%s|r",

	["PvP Encounter:"] = true,
	["%s: Win in %s (%s)"] = "%s: |cff00ff00Win|r |cffffffffin|r |cffffffff%s (|r|cffff00ff%s|r|cffffffff)|r",
	["%s: Loss in %s (%s)"] = "%s: |cffff0000Loss|r |cffffffffin|r |cffffffff%s (|r|cffff00ff%s|r|cffffffff)|r",

	["Move to Player KoS"] = true,
	["Move to Hatelist"] = true,
	["Move to Nicelist"] = true,
	["Wanted"] = true,
	["Remove Entry"] = true,

	["by name"] = true,
	["by level"] = true,
	["by reason"] = true,
	["by last seen"] = true,
	["by create date"] = true,
	["by creator"] = true,
	["by owner"] = true,

	["sort by name"] = true,
	["sort by level"] = true,
	["sort by reason"] = true,
	["sort by last seen"] = true,
	["sort by date created"] = true,
	["sort by creator"] = true,
	["sort by owner"] = true,

	["%s (%s) - Reason: %s"] = true,
	["[%s] %s (%s) - Reason: %s"] = true,
	["Show only my entries"] = true,

	["_Reason Unknown_"] = "unknown",
} end);

L:RegisterTranslations("deDE", function() return {
	["Player KoS"] = "Spieler KoS",
	["Guild KoS"] = "Gilden KoS",
	["Nicelist"] = "Nette Leute Liste",
	["Hatelist"] = "Hassliste",
	["Entry %s is already on Hatelist"] = "Eintrag %s ist bereits auf Hassliste",
	["Entry %s is already on Nicelist"] = "Eintrag %s ist bereits auf Nette-Leuteliste",
	["%s  Level %s %s %s %s"] = "%s  |cffffffffLevel %s %s %s |r|cffff00ff%s|r",
	["%s (last seen: %s ago)"] = "%s (zuletzt vor %s gesehen)",
	["%s (never seen)"] = "%s (noch nicht gesehen)",
	["0 Secs"] = "0 Seks",
	["%s  %s"] = "%s  |cffff00ff%s|r",

	["Level %s %s %s"] = "Level |cffffffff%s %s %s|r",
	["Last seen at %s in %s"] = "Zuletzt gesehen am |cff00ff00%s|r |cffffffffin|r |cff00ff00%s|r|r",
	["Owner: %s"] = "Eigentümer: |cffffffff%s|r",
	["Creator: %s"] = "Ersteller: |cffffffff%s|r",
	["Created: %s"] = "Erstellt am: |cffffffff%s|r",
	["Received from: %s"] = "Erhalten von: |cffffffff%s|r",
	["Last updated: %s"] = "Zuletzt geändert: |cffffffff%s|r",

	["PvP Encounter:"] = "PvP-Begegnungen:",
	["%s: Win in %s (%s)"] = "%s: |cff00ff00Sieg|r |cffffffffin|r |cffffffff%s (|r|cffff00ff%s|r|cffffffff)|r",
	["%s: Loss in %s (%s)"] = "%s: |cffff0000Verl.|r |cffffffffin|r |cffffffff%s (|r|cffff00ff%s|r|cffffffff)|r",

	["Move to Player KoS"] = "Auf Spieler-KoS Liste verschieben",
	["Move to Hatelist"] = "Auf Hassliste verschieben",
	["Move to Nicelist"] = "Auf Nette-Leute-Liste verschieben",
	["Wanted"] = "Gesucht",
	["Remove Entry"] = "Eintrag löschen",

	["by name"] = "nach Name",
	["by level"] = "nach Level",
	["by reason"] = "nach Grund",
	["by last seen"] = "nach letzter Sichtung",
	["by create date"] = "nach erstellen Datum",
	["by creator"] = "nach Ersteller",
	["by owner"] = "nach Eigentümer",

	["sort by name"] = "Sortieren nach Name",
	["sort by level"] = "Sortieren nach Level",
	["sort by reason"] = "Sortieren nach Grund",
	["sort by last seen"] = "Sortieren nach letzter Sichtung",
	["sort by date created"] = "Sortieren nach erstellen Datum",
	["sort by creator"] = "Sortieren nach Ersteller",
	["sort by owner"] = "Sortieren nach Eigentümer",

	["%s (%s) - Reason: %s"] = "%s (%s) - Grund: %s",
	["[%s] %s (%s) - Reason: %s"] = "[%s] %s (%s) - Grund: %s",
	["Show only my entries"] = "Nur meine Einträge anzeigen",
	["_Reason Unknown_"] = "unbekannt",
} end);

L:RegisterTranslations("frFR", function() return {
	["Player KoS"] = "Joueur KoS",
	["Guild KoS"] = "Guilde KoS",
	["Nicelist"] = "Liste blanche",
	["Hatelist"] = "Liste noire",
	["Entry %s is already on Hatelist"] = "L'entr\195\169e %s est d\195\169j\195\160 dans la liste noire",
	["Entry %s is already on Nicelist"] = "L'entr\195\169e %s est d\195\169j\195\160 dans la liste blanche",
	["%s  Level %s %s %s %s"] = "%s  |cffffffffLevel %s %s %s |r|cffff00ff%s|r",
	["%s (last seen: %s ago)"] = "%s (vu pour la derni\195\168re fois: %s)",
	["%s (never seen)"] = "%s (jamais vu)",
	["0 Secs"] = "0 Sec.",
	["%s  %s"] = "%s  |cffff00ff%s|r",

	["Level %s %s %s"] = "Level |cffffffff%s %s %s|r",
	["Last seen at %s in %s"] = "Dernièrement vu le |cff00ff00%s|r |cffffffffà|r |cff00ff00%s|r|r",
	["Owner: %s"] = "Propriétaire: |cffffffff%s|r",
	["Creator: %s"] = "Créateur: |cffffffff%s|r",
	["Created: %s"] = "Créé: |cffffffff%s|r",
	["Received from: %s"] = "Reçu de: |cffffffff%s|r",
	["Last updated: %s"] = "Dernière mise à jour: |cffffffff%s|r",
	["PvP Encounter:"] = "Rencontre PvP:",
	["%s: Win in %s (%s)"] = "%s: |cff00ff00Victoire|r |cffffffffà|r |cffffffff%s (|r|cffff00ff%s|r|cffffffff)|r",
	["%s: Loss in %s (%s)"] = "%s: |cffff0000Défaite|r |cffffffffà|r |cffffffff%s (|r|cffff00ff%s|r|cffffffff)|r",

	["by name"] = "par nom",
	["by level"] = "par niveau",
	["by reason"] = "par raison",
	["by last seen"] = "par dernier vu",
	["by create date"] = "par créez la date",
	["by creator"] = "par auteur",
	["by owner"] = "par propriétaire",
	["sort by name"] = "tri par nom",
	["sort by level"] = "tri par niveau",
	["sort by reason"] = "tri par raison",
	["sort by last seen"] = "tri par dernier vu",
	["sort by date created"] = "tri par créez la date",
	["sort by creator"] = "tri par auteur",
	["sort by owner"] = "tri par propriétaire",

	["Move to Player KoS"] = "Déplacer vers Joueur KoS",
	["Move to Hatelist"] = "Déplacer vers Liste noire",
	["Move to Nicelist"] = "Déplacer vers Liste blanche",
	["Wanted"] = "Wanted",
	["Remove Entry"] = "Supprimer l'entrée",

	["%s (%s) - Reason: %s"] = "%s (%s) - Raison: %s",
	["[%s] %s (%s) - Reason: %s"] = "[%s] %s (%s) - Raison: %s",
	["Show only my entries"] = "Montrez seulement mes entrées",
	["_Reason Unknown_"] = "inconnu",
} end);

L:RegisterTranslations("koKR", function() return {
	["Player KoS"] = "KoS 플레이어",
	["Guild KoS"] = "KoS 길드",
	["Nicelist"] = "호인명부",
	["Hatelist"] = "악인명부",
	["Entry %s is already on Hatelist"] = "%s|1은;는; 이미 악인명부에 존재합니다.",
	["Entry %s is already on Nicelist"] = "%s|1은;는; 이미 호인명부에 존재합니다.",
	["%s  Level %s %s %s %s"] = "%s  |cffffffff레벨 %s %s %s |r|cffff00ff%s|r",
	["%s (last seen: %s ago)"] = "%s (최종 발견: %s 전)",
	["%s (never seen)"] = "%s (본적 없음)",
	["0 Secs"] = "0 초",
	["%s  %s"] = "%s  |cffff00ff%s|r",

	["Level %s %s %s"] = "레벨 |cffffffff%s %s %s |r",
	["Last seen at %s in %s"] = "|cff00ff00%s|r 마지막 발견 |cff00ff00%s|r |cffffffff내|r|r",
	["Owner: %s"] = "소유자: |cffffffff%s|r",
	["Creator: %s"] = "작성자: |cffffffff%s|r",
	["Created: %s"] = "작성: |cffffffff%s|r",
	["Received from: %s"] = "수신: |cffffffff%s|r",
	["Last updated: %s"] = "마지막 갱신: |cffffffff%s|r",
	["PvP Encounter:"] = "PvP 교전:",
	["%s: Win in %s (%s)"] = "%s: |cffffffff%s|r |cffffffff에서|r |cff00ff00승|r |cffffffff(|r|cffff00ff%s|r|cffffffff)|r",
	["%s: Loss in %s (%s)"] = "%s: |cffffffff%s|r |cffffffff에서|r |cffff0000패|r |cffffffff(|r|cffff00ff%s|r|cffffffff)|r",

	["Move to Player KoS"] = "플레이어 KoS로 이동",
	["Move to Hatelist"] = "악인명부로 이동",
	["Move to Nicelist"] = "호인명부로 이동",
	["Wanted"] = "수배",
	["Remove Entry"] = "제거",

	["by name"] = "이름순",
	["by level"] = "레벨순",
	["by reason"] = "이유순",
	["by last seen"] = "최종 발견순",
	["by create date"] = "에 의하여 날짜를 창조하십시오",
	["by creator"] = "제작자순",
	["by owner"] = "소유자순",

	["sort by name"] = "이름으로 정렬",
	["sort by level"] = "레벨로 정렬",
	["sort by reason"] = "이유로 정렬",
	["sort by last seen"] = "최종 발견으로 정렬",
	["sort by date created"] = "날짜까지 종류는 창조했다",
	["sort by creator"] = "제작자순으로 정렬",
	["sort by owner"] = "소유자순으로 정렬",

	["%s (%s) - Reason: %s"] = "%s (%s) - 이유: %s",
	["[%s] %s (%s) - Reason: %s"] = "[%s] %s (%s) - 이유: %s",
	["Show only my entries"] = "내 명부만 표시",
	["_Reason Unknown_"] = "아무 이유 없음",
} end);

L:RegisterTranslations("esES", function() return {
	["Player KoS"] = "Jugador KoS",
	["Guild KoS"] = "Hermandad KoS",
	["Nicelist"] = "Simpáticos",
	["Hatelist"] = "Odiados",
	["Entry %s is already on Hatelist"] = "La entrada %s ya está en la lista de Odiados",
	["Entry %s is already on Nicelist"] = "La entrada %s ya está en la lista de Simpáticos",
	["%s  Level %s %s %s %s"] = "%s  |cffffffffNivel %s %s %s |r|cffff00ff%s|r",
	["%s (last seen: %s ago)"] = "%s (visto por última vez: hace %s)",
	["%s (never seen)"] = "%s (nunca visto)",
	["0 Secs"] = "0 Segs",
	["%s  %s"] = "%s  |cffff00ff%s|r",

	["Level %s %s %s"] = "Nivel |cffffffff%s %s %s|r",
	["Last seen at %s in %s"] = "Visto por última vez el |cff00ff00%s|r |cffffffffen|r |cff00ff00%s|r|r",
	["Owner: %s"] = "Propietario: |cffffffff%s|r",
	["Creator: %s"] = "Creador: |cffffffff%s|r",
	["Created: %s"] = "Creado: |cffffffff%s|r",
	["Received from: %s"] = "Recibido desde: |cffffffff%s|r",
	["Last updated: %s"] = "Última actualización: |cffffffff%s|r",

	["PvP Encounter:"] = "Encuentro JcJ:",
	["%s: Win in %s (%s)"] = "%s: |cff00ff00Ganado|r |cffffffffen|r |cffffffff%s (|r|cffff00ff%s|r|cffffffff)|r",
	["%s: Loss in %s (%s)"] = "%s: |cffff0000Perdido|r |cffffffffen|r |cffffffff%s (|r|cffff00ff%s|r|cffffffff)|r",

	["Move to Player KoS"] = "Mover a Jugador KoS",
	["Move to Hatelist"] = "Mover a Odiados",
	["Move to Nicelist"] = "Mover a Simpáticos",
	["Wanted"] = "Se Busca",
	["Remove Entry"] = "Quitar Entrada",

	["by name"] = "por nombre",
	["by level"] = "por nivel",
	["by reason"] = "por razón",
	["by last seen"] = "por visto por última vez",
	["by create date"] = "por cree la fecha",
	["by creator"] = "por creador",
	["by owner"] = "por propietario",

	["sort by name"] = "ordenar por nombre",
	["sort by level"] = "ordenar por nivel",
	["sort by reason"] = "ordenar por razón",
	["sort by last seen"] = "ordenar por visto por última vez",
	["sort by date created"] = "ordenar por cree la fecha",
	["sort by creator"] = "ordenar por creador",
	["sort by owner"] = "ordenar por propietario",

	["_Reason Unknown_"] = "desconocida",

	["%s (%s) - Reason: %s"] = "%s (%s) - Razón: %s",
	["[%s] %s (%s) - Reason: %s"] = "[%s] %s (%s) - Razón: %s",
	["Show only my entries"] = "Muestre solamente mis entradas",
} end);

L:RegisterTranslations("ruRU", function() return {
	["Player KoS"] = "KoS-игроки",
	["Guild KoS"] = "KoS-гильдии",
	["Nicelist"] = "Хорошие",
	["Hatelist"] = "Ненавистные",
	["Entry %s is already on Hatelist"] = "Запись %s уже есть в Списке ненавистных",
	["Entry %s is already on Nicelist"] = "Запись %s уже есть в Списке хороших",
	["%s  Level %s %s %s %s"] = "%s  |cffffffffУровень %s %s %s |r|cffff00ff%s|r",
	["%s (last seen: %s ago)"] = "%s (замечен: %s назад)",
	["%s (never seen)"] = "%s (никогда не видели)",
	["0 Secs"] = "0 Сек",
	["%s  %s"] = "%s  |cffff00ff%s|r",

	["Level %s %s %s"] = "Уровень |cffffffff%s %s %s|r",
	["Last seen at %s in %s"] = "Замечен |cff00ff00%s|r |cffffffffв|r |cff00ff00%s|r|r",
	["Owner: %s"] = "Владелец: |cffffffff%s|r",
	["Creator: %s"] = "Создал: |cffffffff%s|r",
	["Created: %s"] = "Создано: |cffffffff%s|r",
	["Received from: %s"] = "Получено от: |cffffffff%s|r",
	["Last updated: %s"] = "Обновлено: |cffffffff%s|r",

	["PvP Encounter:"] = "PvP-стычки:",
	["%s: Win in %s (%s)"] = "%s: |cff00ff00Победил|r |cffffffffв|r |cffffffff%s (|r|cffff00ff%s|r|cffffffff)|r",
	["%s: Loss in %s (%s)"] = "%s: |cffff0000Проиграл|r |cffffffffв|r |cffffffff%s (|r|cffff00ff%s|r|cffffffff)|r",

	["Move to Player KoS"] = "Переместить к KoS-игрокам",
	["Move to Hatelist"] = "Переместить в Список ненавистных",
	["Move to Nicelist"] = "Переместить в Список хороших",
	["Wanted"] = "Розыск",
	["Remove Entry"] = "Удалить запись",

	["by name"] = "по имени",
	["by level"] = "по уровню",
	["by reason"] = "по причине",
	["by last seen"] = "по последней встрече",
	["by create date"] = "по создайте дату",
	["by creator"] = "по создателю",
	["by owner"] = "по владельцу",

	["sort by name"] = "сортировать по имени",
	["sort by level"] = "сортировать по уровню",
	["sort by reason"] = "сортировать по причине",
	["sort by last seen"] = "сортировать по последней встрече",
	["sort by date created"] = "сортировать по создайте дату",
	["sort by creator"] = "сортировать по создателю",
	["sort by owner"] = "сортировать по владельцу",

	["%s (%s) - Reason: %s"] = "%s (%s) - Причина: %s",
	["[%s] %s (%s) - Reason: %s"] = "[%s] %s (%s) - Причина: %s",
	["Show only my entries"] = "Показывать только мои записи",

	["_Reason Unknown_"] = "не известна",
} end);

-- sort functions

-- sorts by index
local SortByName = nil;

-- sorts from highest to lowest level
local function SortByLevel(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list ~= nil) then
		local cmp1 = 0;
		local cmp2 = 0;
		if(list[val1] ~= nil and list[val1].level ~= nil) then
			cmp1 = list[val1].level;
		end
		if(list[val2] ~= nil and list[val2].level ~= nil) then
			cmp2 = list[val2].level;
		end
		if(cmp1 > cmp2) then
			return true;
		else
			return false;
		end
	end
end

-- sorts from early to later
local function SortByLastSeen(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list ~= nil) then
		local cmp1 = 2^30;
		local cmp2 = 2^30;
		if(list[val1] ~= nil and list[val1].lastseen ~= nil) then
			cmp1 = time() - list[val1].lastseen;
		end
		if(list[val2] ~= nil and list[val2].lastseen ~= nil) then
			cmp2 = time() - list[val2].lastseen;
		end

		if(cmp1 < cmp2) then
			return true;
		else
			return false;
		end
	end
end

-- sorts from a-Z
local function SortByReason(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].reason;
	local str2 = list[val2].reason;
	if(str1 == nil or str1 == "") then
		str1 = L["_Reason Unknown_"];
	end
	if(str2 == nil or str2 == "") then
		str2 = L["_Reason Unknown_"];
	end
	if(str1:lower() < str2:lower()) then
		return true;
	else
		return false;
	end
end

-- sorts from a-Z
local function SortByCreateDate(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	if(list ~= nil) then
		local cmp1 = 2^30;
		local cmp2 = 2^30;
		if(list[val1] ~= nil and list[val1].created ~= nil) then
			cmp1 = list[val1].created;
		end
		if(list[val2] ~= nil and list[val2].created ~= nil) then
			cmp2 = list[val2].created;
		end

		if(cmp1 > cmp2) then
			return true;
		else
			return false;
		end
	end
end

-- sorts from a-Z
local function SortByCreator(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].creator;
	local str2 = list[val2].creator;
	if(str1 == nil or str1 == "") then
		str1 = "";
	end
	if(str2 == nil or str2 == "") then
		str2 = "";
	end
	if(str1:lower() < str2:lower()) then
		return true;
	else
		return false;
	end
end

-- sorts from a-Z
local function SortByOwner(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].owner;
	local str2 = list[val2].owner;
	if(str1 == nil or str1 == "") then
		str1 = "";
	end
	if(str2 == nil or str2 == "") then
		str2 = "";
	end
	if(str1:lower() < str2:lower()) then
		return true;
	else
		return false;
	end
end


function VanasKoSDefaultLists:OnInitialize()
	VanasKoS:RegisterDefaults("DefaultLists", "realm", {
		koslist = {
			players = {
			},
			guilds = {
			}
		},
		hatelist = {
			players = {
			},
		},
		nicelist = {
			players = {
			},
		},
	});

	VanasKoS:RegisterDefaults("DefaultLists", "profile", {
		ShowOnlyMyEntries = false,
	});

	self.db = VanasKoS:AcquireDBNamespace("DefaultLists");

	-- import of old data, will be removed in some version in the future
	if(VanasKoS.db.realm.koslist) then
		self.db.realm.koslist = VanasKoS.db.realm.koslist;
		VanasKoS.db.realm.koslist = nil;
	end
	if(VanasKoS.db.realm.hatelist) then
		self.db.realm.hatelist = VanasKoS.db.realm.hatelist;
		VanasKoS.db.realm.hatelist = nil;
	end
	if(VanasKoS.db.realm.nicelist) then
		self.db.realm.nicelist = VanasKoS.db.realm.nicelist;
		VanasKoS.db.realm.nicelist = nil;
	end

	-- register lists this modules provides at the core
	VanasKoS:RegisterList(1, "PLAYERKOS", L["Player KoS"], self);
	VanasKoS:RegisterList(2, "GUILDKOS", L["Guild KoS"], self);
	VanasKoS:RegisterList(3, "HATELIST", L["Hatelist"], self);
	VanasKoS:RegisterList(4, "NICELIST", L["Nicelist"], self);

	-- register lists this modules provides in the GUI
	VanasKoSGUI:RegisterList("PLAYERKOS", self);
	VanasKoSGUI:RegisterList("GUILDKOS", self);
	VanasKoSGUI:RegisterList("HATELIST", self);
	VanasKoSGUI:RegisterList("NICELIST", self);

	-- register sort options for the lists this module provides
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST", "LASTSEEN"}, 1, "byname", L["by name"], L["sort by name"], SortByName)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST" }, 2, "bylevel", L["by level"], L["sort by level"], SortByLevel)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, 3, "byreason", L["by reason"], L["sort by reason"], SortByReason)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST"}, 4, "bylastseen", L["by last seen"], L["sort by last seen"], SortByLastSeen)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, 5, "bycreatedate", L["by create date"], L["sort by date created"], SortByCreateDate)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, 5, "bycreator", L["by creator"], L["sort by creator"], SortByCreator)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, 6, "byowner", L["by owner"], L["sort by owner"], SortByOwner)

	VanasKoSGUI:SetDefaultSortFunction({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, SortByName);

	-- first sort function is sorting by name
	VanasKoSGUI:SetSortFunction(SortByName);

	-- show the PLAYERKOS list after startup
	VanasKoSGUI:ShowList("PLAYERKOS");

	tablet:Register("VanasKoS_DefaultLists_MouseOverFrame",
						'children', self.UpdateMouseOverFrame,
						'parent', VanasKoSListFrame,
						'positionFunc', function(this)
												this:SetPoint("TOPLEFT", VanasKoSListFrame, "TOPRIGHT", -33, -28);
												this:SetPoint("BOTTOMLEFT", VanasKoSListFrame, "TOPRIGHT", -33, -370);
										end,
						'cantAttach', true,
						'strata', "HIGH",
						'frameLevel', 11,
						'dontHook', true
					);

	local showOptions = VanasKoSGUI:GetShowButtonOptions();
	if(showOptions.args["onlymyentries"]) then
		return;
	end
	showOptions.args["onlymyentries"] = {
		type = "toggle",
		name = L["Show only my entries"],
		desc = L["Show only my entries"],
		set = function(value) VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries = value; VanasKoSGUI:UpdateShownList(); end,
		get = function() return VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries; end,
	};

end

function VanasKoSDefaultLists:OnEnable()
end

function VanasKoSDefaultLists:OnDisable()
end


-- FilterFunction as called by VanasKoSGUI - key is the index from the table entry that gets displayed, value the data associated with the index. searchBoxText the text entered in the searchBox
-- returns true if the entry should be shown, false otherwise
function VanasKoSDefaultLists:FilterFunction(key, value, searchBoxText)
	if(VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries and value.owner ~= nil) then
		return false;
	end
	if(searchBoxText == "") then
		return true;
	end

	if(key:find(searchBoxText) ~= nil) then
		return true;
	end

	if(value.reason and (value.reason:lower():find(searchBoxText) ~= nil)) then
		return true;
	end

	if(value.owner and (value.owner:lower():find(searchBoxText) ~= nil)) then
		return true;
	end

	return false;
end



function VanasKoSDefaultLists:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2)
	if(list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST") then
		local data = VanasKoS:GetPlayerData(key);
		-- displayname, guild, level, race, class, gender, zone, lastseen
		local owner = "";
		if(value.owner ~= nil and value.owner ~= "") then
			owner = string.Capitalize(value.owner);
		end
		if(data and data.displayname and data.level and data.race and data.class) then
			local displayname = data.displayname;
			if(value.wanted) then
				displayname = "|cffff0000" .. displayname;
			end
			buttonText1:SetText(format(L["%s  Level %s %s %s %s"], displayname, data.level, data.race, data.class, owner));
		else
			local displayname;
			if(value.wanted) then
				displayname = "|cffff0000" .. string.Capitalize(key);
			else
				displayname = string.Capitalize(key);
			end
			buttonText1:SetText(format(L["%s  %s"], displayname, owner));
		end
		if(data and data.lastseen) then
			local timespan = SecondsToTime(time() - data.lastseen);
			if(timespan == "") then
				timespan = L["0 Secs"];
			end

			if(value.reason) then
				buttonText2:SetText(format(L["%s (last seen: %s ago)"], string.Capitalize(value.reason), timespan));
			else
				buttonText2:SetText(format(L["%s (last seen: %s ago)"], L["_Reason Unknown_"], timespan));
			end
		else
			if(value.reason) then
				buttonText2:SetText(format(L["%s (never seen)"], string.Capitalize(value.reason)));
			else
				buttonText2:SetText(format(L["%s (never seen)"], L["_Reason Unknown_"]));
			end
		end
	elseif(VANASKOS.showList == "GUILDKOS") then
		local guildname = VanasKoS:GetGuildData(key);
		if(guildname ~= nil and guildname ~= "") then
			if(value.owner ~= nil and value.owner ~= "") then
				local owner = string.Capitalize(value.owner);
				buttonText1:SetText(format(L["%s  %s"], guildname, owner));
			else
				buttonText1:SetText(format(L["%s  %s"], guildname, ""));
			end
		else
			buttonText1:SetText(string.Capitalize(key));
		end
		if(value.reason) then
			buttonText2:SetText(string.Capitalize(value.reason));
		else
			buttonText2:SetText(L["_Reason Unknown_"]);
		end
	end

	button:Show();
end

function VanasKoSDefaultLists:IsOnList(list, name)
	local listVar = VanasKoS:GetList(list);
	if(listVar and listVar[name]) then
		return listVar[name];
	else
		return nil;
	end
end

-- don't call this directly, call it via VanasKoS:AddEntry - it expects name to be lower case!
function VanasKoSDefaultLists:AddEntry(list, name, data)
	if(list == "PLAYERKOS") then
		self.db.realm.koslist.players[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player") };
	elseif(list == "GUILDKOS") then
		self.db.realm.koslist.guilds[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player") };
	elseif(list == "HATELIST") then
		if(VanasKoS:IsOnList("NICELIST", name)) then
			self:Print(format(L["Entry %s is already on Nicelist"], name));
			return;
		end
		self.db.realm.hatelist.players[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player")  };
	elseif(list == "NICELIST") then
		if(VanasKoS:IsOnList("HATELIST", name)) then
			self:Print(format(L["Entry %s is already on Hatelist"], name));
			return;
		end
		self.db.realm.nicelist.players[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player")  };
	end

	self:TriggerEvent("VanasKoS_List_Entry_Added", list, name, data);
end

function VanasKoSDefaultLists:RemoveEntry(listname, name)
	local list = VanasKoS:GetList(listname);
	if(list and list[name]) then
		list[name] = nil;
		self:TriggerEvent("VanasKoS_List_Entry_Removed", list, name);
	end
end

function VanasKoSDefaultLists:GetList(list)
	if(list == "PLAYERKOS") then
		return self.db.realm.koslist.players;
	elseif(list == "GUILDKOS") then
		return self.db.realm.koslist.guilds;
	elseif(list == "HATELIST") then
		return self.db.realm.hatelist.players;
	elseif(list == "NICELIST") then
		return self.db.realm.nicelist.players;
	else
		return nil;
	end
end

local entry, value;

local function ListButtonOnClickMenu()
	dewdrop:AddLine(
			'text', string.Capitalize(entry),
			'isTitle', true
	);

	if(value.owner == nil) then
		if(VANASKOS.showList ~= "PLAYERKOS") then
			dewdrop:AddLine(
				'text', L["Move to Player KoS"],
				'func', function()
						VanasKoS:RemoveEntry(VANASKOS.showList, entry);
						VanasKoS:AddEntry("PLAYERKOS", entry, value);
					end
			);
		end
		if(VANASKOS.showList ~= "HATELIST") then
			dewdrop:AddLine(
				'text', L["Move to Hatelist"],
				'func', function()
						VanasKoS:RemoveEntry(VANASKOS.showList, entry);
						VanasKoS:AddEntry("HATELIST", entry, value);
					end
			);
		end
		if(VANASKOS.showList ~= "NICELIST") then
			dewdrop:AddLine(
				'text', L["Move to Nicelist"],
				'func', function()
						VanasKoS:RemoveEntry(VANASKOS.showList, entry);
						VanasKoS:AddEntry("NICELIST", entry, value);
					end
			);
		end
	end
	if(VANASKOS.showList == "PLAYERKOS" and value.owner == nil) then
		dewdrop:AddLine(
			'text', L["Wanted"],
			'func', function()
						if(VANASKOS.showList ~= "PLAYERKOS" or
							value.owner ~= nil) then
							return;
						end
						if(not value.wanted) then
							value.wanted = true;
						else
							value.wanted = nil;
						end
						VanasKoSGUI:ScrollFrameUpdate();
				end,
			'checked', value.wanted
		);
	end
	dewdrop:AddLine(
		'text', L["Remove Entry"],
		'func', function()
				VanasKoS:RemoveEntry(VANASKOS.showList, entry);
			end
	);
end

function VanasKoSDefaultLists:ListButtonOnClick(button, frame)
	local id = frame:GetID();
	entry, value = VanasKoSGUI:GetListEntryForID(id);
	if(id == nil or entry == nil) then
		return;
	end
	if(button == "LeftButton") then
		if(IsShiftKeyDown()) then
			local name;

			if(not value) then
				return;
			end
			if(value.displayname) then
				name = value.displayname;
			else
				name = string.Capitalize(entry);
			end

			local str = nil;
			if(value.owner) then
				str = format(L["[%s] %s (%s) - Reason: %s"], value.owner, name, VanasKoSGUI:GetListName(VANASKOS.showList), value.reason);
			else
				str = format(L["%s (%s) - Reason: %s"], name, VanasKoSGUI:GetListName(VANASKOS.showList), value.reason);
			end
			if(DEFAULT_CHAT_FRAME.editBox and str) then
				if(DEFAULT_CHAT_FRAME.editBox:IsVisible()) then
					DEFAULT_CHAT_FRAME.editBox:SetText(DEFAULT_CHAT_FRAME.editBox:GetText() .. str .. " ");
				end
			end
		end
		return;
	end

	if(button == "RightButton") then
		dewdrop:Open(frame,
						'children', ListButtonOnClickMenu,
						'point', "TOP",
						'cursorX', true,
						'cursorY', true);
	end
end

local selectedPlayer, selectedPlayerData = nil;

-- /script local tablet = AceLibrary("Tablet-2.0"); for i=1,10000 do tablet:Open("VanasKoS_DefaultLists_MouseOverFrame"); tablet:Close("VanasKoS_DefaultLists_MouseOverFrame"); end
function VanasKoSDefaultLists:UpdateMouseOverFrame()
	local catBasisInfo = tablet:AddCategory('id', "basisinfo");
	local catListEntryInfo = tablet:AddCategory('id', "listentryinfo");
	local catPvPLog = tablet:AddCategory('id', "pvplog");

	if(not selectedPlayer) then
		catBasisInfo:AddLine('text', "----");
		return;
	end
	local pdatalist = VanasKoS:GetList("PLAYERDATA")[selectedPlayer];

	if(pdatalist and pdatalist['displayname']) then
		text = pdatalist['displayname'];
	else
		text = string.Capitalize(selectedPlayer);
	end
	catBasisInfo:AddLine(
			'text', text,
			'textR', 1.0,
			'textG', 1.0,
			'textB', 1.0,
			'size', 16
		);

	if(pdatalist) then
		-- guild
		if(pdatalist['guild']) then
			catBasisInfo:AddLine(
					'text', pdatalist['guild'],
					'textR', 0.0,
					'textG', 1.0,
					'textB', 0.0
				);
		end

		-- level, race, class
		if(pdatalist['level'] and pdatalist['race'] and pdatalist['class']) then
			catBasisInfo:AddLine(
					'text', format(L['Level %s %s %s'], pdatalist['level'], pdatalist['race'], pdatalist['class'])
				);
		end

		-- last seen
		if(pdatalist['zone'] and pdatalist['lastseen']) then
			catBasisInfo:AddLine(
					'text', format(L['Last seen at %s in %s'], date("%x", pdatalist['lastseen']), pdatalist['zone'])
				);
		end
	end

	-- infos about creator, sender, owner, last updated
	if(selectedPlayerData) then
		if(selectedPlayerData['owner']) then
			catListEntryInfo:AddLine(
					'text', format(L['Owner: %s'], selectedPlayerData['owner'])
				);
		end

		if(selectedPlayerData['creator']) then
			catListEntryInfo:AddLine(
					'text', format(L['Creator: %s'], selectedPlayerData['creator'])
				);
		end

		if(selectedPlayerData['created']) then
			catListEntryInfo:AddLine(
					'text', format(L['Created: %s'], date("%x", selectedPlayerData['created']))
				);
		end

		if(selectedPlayerData['sender']) then
			catListEntryInfo:AddLine(
					'text', format(L['Received from: %s'], selectedPlayerData['sender'])
				);
		end

		if(selectedPlayerData['lastupdated']) then
			catListEntryInfo:AddLine(
					'text', format(L['Last updated: %s'], date("%x", selectedPlayerData['lastupdated']))
				);
		end
	end

	local pvplog = VanasKoS:GetList("PVPLOG");
	if(pvplog) then
		pvplog = pvplog[selectedPlayer];
		if(pvplog) then
			catPvPLog:AddLine(
				'text', L["PvP Encounter:"],
				'textR', 1.0,
				'textG', 1.0,
				'textB', 1.0
			);
			local i = 0;

			for k,v in VanasKoSGUI:pairsByKeys(pvplog, nil, nil) do -- sorted from old to new
				if(v.type and (v.zoneid or v.zone) and v.myname) then
					if(v.type == 'win') then
						if(v.zone) then
							catPvPLog:AddLine(
								'text', format(L["%s: Win in %s (%s)"], date("%c", k), v.zone, v.myname)
							);
						else
							local zone = VanasKoSDataGatherer:GetZoneName(v.continent, v.zoneid);
							if(zone == nil) then
								-- because it's possible there is is no zone, and continent/zoneid aren't valid
								zone = UNKNOWN;
							end
							catPvPLog:AddLine(
								'text', format(L["%s: Win in %s (%s)"], date("%c", k), zone, v.myname)
							);
						end
					else
						if(v.zone) then
							catPvPLog:AddLine(
								'text', format(L["%s: Loss in %s (%s)"], date("%c", k), v.zone, v.myname)
							);
						else
							local zone = VanasKoSDataGatherer:GetZoneName(v.continent, v.zoneid);
							if(zone == nil) then
								-- because it's possible there is is no zone, and continent/zoneid aren't valid
								zone = UNKNOWN;
							end
							catPvPLog:AddLine(
								'text', format(L["%s: Loss in %s (%s)"], date("%c", k), zone, v.myname)
							);
						end
					end
				end

				i = i + 1;
			end
		end
	end
end

function VanasKoSDefaultLists:ListButtonOnEnter(button, frame)
	selectedPlayer, selectedPlayerData = VanasKoSGUI:GetListEntryForID(frame:GetID());
	tablet:Open("VanasKoS_DefaultLists_MouseOverFrame");
	--tablet:Refresh("VanasKoS_DefaultLists_MouseOverFrame");
end

function VanasKoSDefaultLists:ListButtonOnLeave(button, frame)
	tablet:Close("VanasKoS_DefaultLists_MouseOverFrame")
end

function VanasKoSDefaultLists:SetSelectedPlayerData(selPlayer, selPlayerData)
	selectedPlayer = selPlayer;
	selectedPlayerData = selPlayerData;
end
