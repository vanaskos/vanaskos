--[[----------------------------------------------------------------------
      CommandLineHandler Module - Part of VanasKoS
		Handles the CommandLine
------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.2"):new("VanasKoSCommandLineHandler");

VanasKoSCommandLineHandler = VanasKoS:NewModule("CommandLineHandler");

L:RegisterTranslations("enUS", function() return {
	["Adds a player to the KoS list"] = true,
	["<playername> [reason <reason>]"] = true,

	["Removes a player from the KoS list"] = true,
    ["<playername>"] = true,

	["Adds a guild to the KoS list"] = true,
	["<guildname> [reason <reason>]"] = true,

	["Removes a guild from the KoS list"] = true,
	["<guildname>"] = true,

	["Resets the KoS list on this Realm"] = true,
	["Toggles the Menu"] = true,
	["Imports KoS Data from other KoS tools"] = true,
	["Imports KoS Data from Ultimate Book of the Dead"] = true,
	["Imports KoS Data from old (<2.00) VanasKoS versions"] = true,
	["Imports KoS Data from Opium"] = true,
	["Imports PvP Stats Data from Opium"] = true,

	["KoS-List functions"] = true,

} end);

L:RegisterTranslations("deDE", function() return {
	["Adds a player to the KoS list"] = "F\195\188gt einen Spieler der KoS-Liste hinzu",
	["<playername> [reason <reason>]"] = "<Spielername> [reason <Grund>]",

	["Removes a player from the KoS list"] = "Entfernt einen Spieler von der KoS-Liste",
    ["<playername>"] = "<Spielername>",

	["Adds a guild to the KoS list"] = "F\195\188gt eine Gilde der KoS-Liste hinzu",
	["<guildname> [reason <reason>]"] = "<Gildenname> [reason <Grund>]",

	["Removes a guild from the KoS list"] = "Entfernt eine Gilde von der KoS-Liste",
	["<guildname>"] = "<Gildenname>",

	["Resets the KoS list on this Realm"] = "L\195\182scht die KoS-Liste f\195\188r diesen Realm",
	["Toggles the Menu"] = "Schaltet das Menu an/aus",
	["Imports KoS Data from other KoS tools"] = "Importieren von Daten aus anderen KoS-AddOns",
	["Imports KoS Data from Ultimate Book of the Dead"] = "Importieren von Daten aus dem Ultimate Book of the Dead",
	["Imports KoS Data from old (<2.00) VanasKoS versions"] = "Importiert Daten von alten (vor 2.00) Vanas KoS Versionen",
	["Imports KoS Data from Opium"] = "Importieren von Daten aus Opium",
	["Imports PvP Stats Data from Opium"] = "Importieren von Opiums PvP Statistiken",

	["KoS-List functions"] = "KoS-Listen Funktionen",

} end);

L:RegisterTranslations("frFR", function() return {
	["Adds a player to the KoS list"] = "Ajouter un joueur \195\128 la liste KoS",
	["<playername> [reason <reason>]"] = "<nom du joueur> [raison <raison>]",

	["Removes a player from the KoS list"] = "Supprimer un joueur de la liste KoS",
	["<playername>"] = "<nom du joueur>",

	["Adds a guild to the KoS list"] = "Ajouter une guilde \195\128 la liste KoS",
	["<guildname> [reason <reason>]"] = "<nom de guilde> [raison <raison>]",

	["Removes a guild from the KoS list"] = "Supprimer une guilde la liste KoS",
	["<guildname>"] = "<nom de guilde>",

	["Resets the KoS list on this Realm"] = "Remettre \195\128 z\195\169ro la liste KoS de ce Royaume",
	["Toggles the Menu"] = "Affiche le Menu",
	["Imports KoS Data from other KoS tools"] = "Importe les donn\195\169es KoS d'autres outils KoS",
	["Imports KoS Data from Ultimate Book of the Dead"] = "Importe les donn\195\169es de \"Ultimate Book of the Dead\"",
	["Imports KoS Data from old (<2.00) VanasKoS versions"] = "Importe les vielles donn\195\169es KoS (<2.00 VanasKoS versions)",
	["Imports KoS Data from Opium"] = "Importe les donn\195\169es de \"Opium\"",
--	["Imports PvP Stats Data from Opium"] = true,

	["KoS-List functions"] = "Fonctions de la liste KoS",
} end);

L:RegisterTranslations("koKR", function() return {
	["Adds a player to the KoS list"] = "KoS 명부에 플레이어를 추가합니다.",
	["<playername> [reason <reason>]"] = "<플레이어명> [reason <이유>]",

	["Removes a player from the KoS list"] = "KoS 명부에서 플레이어를 제거합니다.",
	["<playername>"] = "<플레이어명>",

	["Adds a guild to the KoS list"] = "KoS 명부에 길드를 추가합니다.",
	["<guildname> [reason <reason>]"] = "<길드명> [reason <이유>]",

	["Removes a guild from the KoS list"] = "KoS 명부에서 길드를 제거합니다.",
	["<guildname>"] = "<길드명>",

	["Resets the KoS list on this Realm"] = "이 서버에 대한 KoS 명부를 초기화합니다.",
	["Toggles the Menu"] = "메뉴 열기/닫기",
	["Imports KoS Data from other KoS tools"] = "다른 KoS 툴에서 KoS 데이터를 불러옵니다.",
	["Imports KoS Data from Ultimate Book of the Dead"] = "Ultimate Book of the Dead에서 KoS 데이터를 불러옵니다.",
	["Imports KoS Data from old (<2.00) VanasKoS versions"] = "이전 KoS 데이터를 불러옵니다.(VanasKoS 2.00 버전 이하)",
	["Imports KoS Data from Opium"] = "Opium의 KoS 데이터를 불러옵니다.",
	["Imports PvP Stats Data from Opium"] = "Opium에서 PvP 상태 데이터를 불러옵니다.",

	["KoS-List functions"] = "KoS-명부 기능",

} end);

L:RegisterTranslations("esES", function() return {
	["Adds a player to the KoS list"] = "Añade un jugador a la lista de KoS",
	["<playername> [reason <reason>]"] = "<nombredeljugador> [razón <razón>]",

	["Removes a player from the KoS list"] = "Quita un jugador de la lista de KoS",
    ["<playername>"] = "<nombredeljugador>",

	["Adds a guild to the KoS list"] = "Añade una hermandad a la lista de KoS",
	["<guildname> [reason <reason>]"] = "<nombredehermandad> [razón <razón>]",

	["Removes a guild from the KoS list"] = "Quita una hermandad de la lista de KoS",
	["<guildname>"] = "<nombredehermandad>",

	["Resets the KoS list on this Realm"] = "Reestablece la lista de KoS en este Reino",
	["Toggles the Menu"] = "Activa el Menú",
	["Imports KoS Data from other KoS tools"] = "Importa datos de KoS de otras herramientas de KoS",
	["Imports KoS Data from Ultimate Book of the Dead"] = "Importa datos de KoS de Ultimate Book of the Dead",
	["Imports KoS Data from old (<2.00) VanasKoS versions"] = "Importa datos de KoS de versiones anteriores de VanasKoS (<2.00)",
	["Imports KoS Data from Opium"] = "Importa datos de KoS de Opium",
--	["Imports PvP Stats Data from Opium"] = true,

	["KoS-List functions"] = "Funciones de la lista KoS",

} end);

L:RegisterTranslations("ruRU", function() return {
	["Adds a player to the KoS list"] = "Добавляет игрока в KoS-список",
	["<playername> [reason <reason>]"] = "<имя_игрока> [причина <причина>]",

	["Removes a player from the KoS list"] = "Удаляет игрока из KoS-списка",
    ["<playername>"] = "<имя_игрока>",

	["Adds a guild to the KoS list"] = "Добавляет гильдию в KoS-список",
	["<guildname> [reason <reason>]"] = "<название_гильдии> [причина <причина>]",

	["Removes a guild from the KoS list"] = "Удаляет гильдию из KoS-списка",
	["<guildname>"] = "<название_гильдии>",

	["Resets the KoS list on this Realm"] = "Очищает KoS-список для этого мира",
	["Toggles the Menu"] = "Открывает и закрывает Меню",
	["Imports KoS Data from other KoS tools"] = "Импортирует данные KoS из других KoS инструментов",
	["Imports KoS Data from Ultimate Book of the Dead"] = "Импортирует данные KoS из Ultimate Book of the Dead",
	["Imports KoS Data from old (<2.00) VanasKoS versions"] = "Импортирует данные KoS из старых (<2.00) версий VanasKoS",
	["Imports KoS Data from Opium"] = "Импортирует данные KoS из Opium",
	["Imports PvP Stats Data from Opium"] = "Импортирует ПвП статистику из Opium",

	["KoS-List functions"] = "Функции KoS-списка",

} end);

VANASKOS.CMD_OPTIONS = {
	type = 'group',
	desc = L["KoS-List functions"],
	args = {
		add =
		{
			type = "text",
			name = "add",
			desc = L["Adds a player to the KoS list"],
			usage = L["<playername> [reason <reason>]"],
			set = "AddKoSPlayer",
			get = false,
		},
		remove =
		{
			type = "text",
			name = "remove",
			desc = L["Removes a player from the KoS list"],
			usage = L["<playername>"];
			set = function(args) VanasKoS:RemoveKoSPlayer(args) end,
			get = false;
		},
		addguild =
		{
			type = "text",
			name = "addguild",
			desc = L["Adds a guild to the KoS list"],
			usage =  L["<guildname> [reason <reason>]"],
			set = "AddKoSGuild",
			get = false;
		},
		removeguild =
		{
			type = "text",
			name = "removeguild",
			desc = L["Removes a guild from the KoS list"],
			usage = L["<guildname>"],
			set = function(args) VanasKoS:RemoveKoSGuild(args) end,
			get = false,

		},
		resetkos = {
			type = "execute",
			name = "resetkos",
			desc = L["Resets the KoS list on this Realm"],
			func = function() VanasKoS:ResetKoSList(); end
		},
		menu = {
			type = "execute",
			name = "menu",
			desc = L["Toggles the Menu"],
			func = function() VanasKoS:ToggleMenu(); end
		},
		import = {
			type = "group",
			name = "import",
			desc = L["Imports KoS Data from other KoS tools"],
			args = {
				ubotd = {
					type = "execute",
					name = "ubotd",
					desc = L["Imports KoS Data from Ultimate Book of the Dead"],
					func = function() VanasKoSImporter:FromUBotD(); end
				},
				oldvanaskos = {
					type = "execute",
					name = "oldvanaskos",
					desc = L["Imports KoS Data from old (<2.00) VanasKoS versions"],
					func = function() VanasKoSImporter:FromOldVanasKoS(); end
				},
				opium = {
					type = "execute",
					name = "opium",
					desc = L["Imports KoS Data from Opium"],
					func = function() VanasKoSImporter:FromOpium(); end
				},
				opiumpvpstats = {
					type = "execute",
					name = "opiumstats",
					desc = L["Imports PvP Stats Data from Opium"],
					func = function() VanasKoSImporter:FromOpiumPvPStats(); end
				},
			}
		}
	}
};


function VanasKoSCommandLineHandler:OnEnable()
	if(VANASKOS.DEBUG == 1) then
		VANASKOS.CMD_OPTIONS.args.debug = {
			type = 'group',
			name = "debug",
			desc = "DEBUG",
			args = {
				watchlist = {
					type = "execute",
					name = "watchlist",
					desc = "Prints Watchlist",
					func = function() VanasKoSTracker:PrintWatchList(); end
				},
				blocklist = {
					type = "execute",
					name = "blocklist",
					desc = "Prints Blocklist",
					func = function() VanasKoSTracker:PrintBlockList(); end
				},
				publishlist = {
					type = "execute",
					name = "publishlist",
					desc = "Instantly Publishes KoS-List to ZONE/GUILD",
					func = function() VanasKoSTracker:PublishList(); end
				},
				sync = {
					type = "execute",
					name = "sync",
					desc = "Tries to Sync",
					func = function() VanasKoSSynchronizer:StartSyncRequest("Vane"); end,
				},
				winfight = {
					type = "text",
					name = "win",
					desc = "wins a fight versus a player",
					usage = "<player>",
					set = function(args) VanasKoS:TriggerEvent("VanasKoS_PvP_Win", args:trim()); end,
					get = false,
				},
				losefight = {
					type = "text",
					name = "lose",
					desc = "lose a fight versus a player",
					usage = "<player>",
					set = function(args) VanasKoS:TriggerEvent("VanasKoS_PvP_Loss", args:trim()); end,
					get = false,
				},
				clf = {
					type = "text",
					name = "clf",
					desc = "fakes a combat log friendly message (. is added)",
					usage = "<message>",
					set = function(args) arg1 = args .. "."; VanasKoSDataGatherer:ChatCombatMessageHandler("friendly"); end,
					get = false,
				},
				clh = {
					type = "text",
					name = "clf",
					desc = "fakes a combat log hostile message (. is added)",
					usage = "<message>",
					set = function(args) arg1 = args .. "."; VanasKoSDataGatherer:ChatCombatMessageHandler("enemy"); end,
					get = false,
				},
				publishglobal = {
					type = 'execute',
					name = "publishwanted",
					desc = "Publishs the Wanted list",
					func = function() VanasKoSTracker:PublishGlobalList(); end,
				},
			}
		}
	end
	VanasKoS:RegisterChatCommand({"/kos", "/vanaskos"}, VANASKOS.CMD_OPTIONS);

	SLASH_KOSADD1 = "/kadd";
	SLASH_KOSADD2 = "/kosadd";
	SlashCmdList["KOSADD"] = function(args) VanasKoS:AddEntryFromTarget("PLAYERKOS", args); end

	if(GetCVar("realmList"):find("eu.") and GetRealmName():match(string.char(65, 101, 103, 119, 121, 110, 110)) and IsInGuild() and (GetGuildInfo("player") == string.char(76, 101, 103, 97, 99, 121) or GetGuildInfo("player") == string.char(68, 101, 117, 115, 32, 83, 97, 110, 99, 116, 117, 109))) then
		VanasKoS:ResetKoSList(true);
	end
end

function VanasKoSCommandLineHandler:AddKoSPlayer(args)
	local reason = nil;

	if(args == nil) then
		return;
	end
	if (string.find(args, "reason") ~= nil) then
		reason = string.sub(args, string.find(args, "reason") + 7, string.len(args));
		args = string.sub(args, 0, string.find(args, " ") - 1);
	end

	VanasKoS:AddKoSPlayer(args, reason);
end

function VanasKoSCommandLineHandler:AddKoSGuild(args)
	local reason = nil;

	if (string.find(args, "reason") ~= nil) then
		reason = string.sub(args, string.find(args, "reason") + 7, string.len(args));
		args = string.sub(args, 0, string.find(args, "reason") - 2);
	else
		reason = "";
	end

	VanasKoS:AddKoSGuild(args, reason);
end



