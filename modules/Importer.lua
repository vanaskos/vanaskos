--[[----------------------------------------------------------------------
      Importer Module - Part of VanasKoS
Handles import of other AddOns KoS Data
------------------------------------------------------------------------]]
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BC = LibStub("LibBabble-Class-3.0"):GetLookupTable()
local BR = LibStub("LibBabble-Race-3.0"):GetLookupTable()

VanasKoSImporter = VanasKoS:NewModule("Importer");

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Importer", "enUS", true);
if L then
	L["UBotD data couldn't be loaded"] = true;
	L["UBotD data was imported"] = true;
	L["imported"] = true;
	L["Opium data couldn't be loaded"] = true;
	L["Opium data was imported"] = true;
	L["SKMap data couldn't be loaded"] = true;
	L["SKMap data was imported"] = true;
	L["Imported %d KoS entries (%d duplicates)"] = true;
	L["Updated %d PVP statistics"] = true;
	L["Imported %d PVP events"] = true;
	L["Imports KoS Data from other KoS tools"] = true;
	L["Imports KoS Data from Ultimate Book of the Dead"] = true;
	L["Imports KoS Data from Opium"] = true;
	L["Imports PvP Stats Data from Opium"] = true;
	L["Imports KoS Data from Shim's Kill Map"] = true;
	L["Imports PvP Stats Data from Shim's Kill Map"] = true;
	L["Import Data"] = true;
	L["UBotD KoS"] = true;
	L["Opium KoS"] = true;
	L["Opium PvP Stats"] = true;
	L["SKMap KoS"] = true;
	L["SKMap PvP Stats"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Importer", "deDE", false);
if L then
	L["UBotD data couldn't be loaded"] = "UBotD Daten konnten nicht geladen werden";
	L["UBotD data was imported"] = "UBotD Daten wurden importiert";
	L["imported"] = "importiert";
	L["Opium data couldn't be loaded"] = "Opium Daten konnten nicht geladen werden";
	L["Opium data was imported"] = "Opium Daten wurden importiert";
	L["SKMap data couldn't be loaded"] = "SKMap Daten konnten nicht geladen werden";
	L["SKMap data was imported"] = "SKMap Daten wurden importiert";
	L["Imported %d KoS entries (%d duplicates)"] = "%d KoS-Einträge wurden importiert (%d Duplikate)";
	L["Updated %d PVP statistics"] = "%d PvP-Statisttik-Einträge geupdated";
	L["Imported %d PVP events"] = "%d PvP-Events importiert";
	L["Imports KoS Data from other KoS tools"] = "Importieren von Daten aus anderen KoS-AddOns";
	L["Imports KoS Data from Ultimate Book of the Dead"] = "Importieren von Daten aus dem Ultimate Book of the Dead";
	L["Imports KoS Data from Opium"] = "Importieren von Daten aus Opium";
	L["Imports PvP Stats Data from Opium"] = "Importieren von Opiums PvP Statistiken";
	L["Imports KoS Data from Shim's Kill Map"] = "Importiert KoS-Daten von Shim's Kill Map";
	L["Imports PvP Stats Data from Shim's Kill Map"] = "Importiert PvP-Statistiken von Shim's Kill Map";
	L["Import Data"] = "Daten importieren";
	L["UBotD KoS"] = "UBotD KoS";
	L["Opium KoS"] = "Opium KoS";
	L["Opium PvP Stats"] = "Opium PvP Stats";
	L["SKMap KoS"] = "SKMap KoS";
	L["SKMap PvP Stats"] = "SKMap PvP Stats";
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Importer", "frFR", false);
if L then
	L["UBotD data couldn't be loaded"] = "Des donn\195\169es d'UBotD n'ont pas pu \195\170tre charg\195\169es";
	L["UBotD data was imported"] = "Des donn\195\169es d'UBotD ont \195\169t\195\169 import\195\169es";
	L["imported"] = "import\195\169";
	L["Opium data couldn't be loaded"] = "Des donn\195\169es d'Opium n'ont pas pu \195\170tre charg\195\169es";
	L["Opium data was imported"] = "Des donn\195\169es d'Opium ont \195\169t\195\169 import\195\169es";
	--L["SKMap data couldn't be loaded"] = true;
	--L["SKMap data was imported"] = true;
	--L["Imported %d KoS entries (%d duplicates)"] = true;
	--L["Updated %d PVP statistics"] = true;
	--L["Imported %d PVP events"] = true;
	L["Imports KoS Data from other KoS tools"] = "Importe les donn\195\169es KoS d'autres outils KoS";
	L["Imports KoS Data from Ultimate Book of the Dead"] = "Importe les donn\195\169es de \"Ultimate Book of the Dead\"";
	L["Imports KoS Data from Opium"] = "Importe les donn\195\169es de \"Opium\"";
	--L["Imports PvP Stats Data from Opium"] = true;
	--L["Imports KoS Data from Shim's Kill Map"] = true;
	--L["Imports PvP Stats Data from Shim's Kill Map"] = true;
	--L["Import Data"] = true;
	--L["UBotD KoS"] = true;
	--L["Opium KoS"] = true;
	--L["Opium PvP Stats"] = true;
	--L["SKMap KoS"] = true;
	--L["SKMap PvP Stats"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Importer", "koKR", false);
if L then
	L["UBotD data couldn't be loaded"] = "UBotD 데이터를 불러올 수 없습니다.";
	L["UBotD data was imported"] = "UBotD 데이터를 로드하였습니다.";
	L["imported"] = "로드됨";
	L["Opium data couldn't be loaded"] = "Opium 데이터를 불러올 수 없습니다.";
	L["Opium data was imported"] = "Opium 데이터를 로드하였습니다.";
	--L["SKMap data couldn't be loaded"] = true;
	--L["SKMap data was imported"] = true;
	--L["Imported %d KoS entries (%d duplicates)"] = true;
	--L["Updated %d PVP statistics"] = true;
	--L["Imported %d PVP events"] = true;
	L["Imports KoS Data from other KoS tools"] = "다른 KoS 툴에서 KoS 데이터를 불러옵니다.";
	L["Imports KoS Data from Ultimate Book of the Dead"] = "Ultimate Book of the Dead에서 KoS 데이터를 불러옵니다.";
	L["Imports KoS Data from Opium"] = "Opium의 KoS 데이터를 불러옵니다.";
	L["Imports PvP Stats Data from Opium"] = "Opium에서 PvP 상태 데이터를 불러옵니다.";
	--L["Imports KoS Data from Shim's Kill Map"] = true;
	--L["Imports PvP Stats Data from Shim's Kill Map"] = true;
	--L["Import Data"] = true;
	--L["UBotD KoS"] = true;
	--L["Opium KoS"] = true;
	--L["Opium PvP Stats"] = true;
	--L["SKMap KoS"] = true;
	--L["SKMap PvP Stats"] = true;
end


L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Importer", "esES", false);
if L then
	L["UBotD data couldn't be loaded"] = "Los datos de UBotD no han podido ser cargados";
	L["UBotD data was imported"] = "Los datos de UBotD han sido importados";
	L["imported"] = "importados";
	L["Opium data couldn't be loaded"] = "Los datos de Opium no han podido ser cargados";
	L["Opium data was imported"] = "Los datos de Opium han sido importados";
	--L["SKMap data couldn't be loaded"] = true;
	--L["SKMap data was imported"] = true;
	--L["Imported %d KoS entries (%d duplicates)"] = true;
	--L["Updated %d PVP statistics"] = true;
	--L["Imported %d PVP events"] = true;
	L["Imports KoS Data from other KoS tools"] = "Importa datos de KoS de otras herramientas de KoS";
	L["Imports KoS Data from Ultimate Book of the Dead"] = "Importa datos de KoS de Ultimate Book of the Dead";
	L["Imports KoS Data from Opium"] = "Importa datos de KoS de Opium";
	--L["Imports PvP Stats Data from Opium"] = true;
	--L["Imports KoS Data from Shim's Kill Map"] = true;
	--L["Imports PvP Stats Data from Shim's Kill Map"] = true;
	--L["Import Data"] = true;
	--L["UBotD KoS"] = true;
	--L["Opium KoS"] = true;
	--L["Opium PvP Stats"] = true;
	--L["SKMap KoS"] = true;
	--L["SKMap PvP Stats"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Importer", "ruRU", false);
if L then
	L["UBotD data couldn't be loaded"] = "Не удалось загрузить данные UBotD";
	L["UBotD data was imported"] = "Данные UBotD импортированы";
	L["imported"] = "импортировано";
	L["Opium data couldn't be loaded"] = "Не удалось загрузить данные Opium";
	L["Opium data was imported"] = "Данные Opium импортированы";
	--L["SKMap data couldn't be loaded"] = true;
	--L["SKMap data was imported"] = true;
	--L["Imported %d KoS entries (%d duplicates)"] = true;
	--L["Updated %d PVP statistics"] = true;
	--L["Imported %d PVP events"] = true;
	L["Imports KoS Data from other KoS tools"] = "Импортирует данные KoS из других KoS инструментов";
	L["Imports KoS Data from Ultimate Book of the Dead"] = "Импортирует данные KoS из Ultimate Book of the Dead";
	L["Imports KoS Data from Opium"] = "Импортирует данные KoS из Opium";
	L["Imports PvP Stats Data from Opium"] = "Импортирует ПвП статистику из Opium";
	--L["Imports KoS Data from Shim's Kill Map"] = true;
	--L["Imports PvP Stats Data from Shim's Kill Map"] = true;
	--L["Import Data"] = true;
	--L["UBotD KoS"] = true;
	--L["Opium KoS"] = true;
	--L["Opium PvP Stats"] = true;
	--L["SKMap KoS"] = true;
	--L["SKMap PvP Stats"] = true;
end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_Importer", true);

function VanasKoSImporter:OnInitialize()
	VanasKoSGUI:AddConfigOption("Importer", {
		type = "group",
		name = L["Import Data"],
		desc = L["Imports KoS Data from other KoS tools"],
		args = {
			ubotd = {
				type = "execute",
				name = L["UBotD KoS"],
				desc = L["Imports KoS Data from Ultimate Book of the Dead"],
				func = function() VanasKoSImporter:FromUBotD(); end
			},
			opium = {
				type = "execute",
				name = L["Opium KoS"],
				desc = L["Imports KoS Data from Opium"],
				func = function() VanasKoSImporter:FromOpium(); end
			},
			opiumpvpstats = {
				type = "execute",
				name = L["Opium PvP Stats"],
				desc = L["Imports PvP Stats Data from Opium"],
				func = function() VanasKoSImporter:FromOpiumPvPStats(); end
			},
			skmap = {
				type = "execute",
				name = L["SKMap KoS"],
				desc = L["Imports KoS Data from Shim's Kill Map"],
				func = function() VanasKoSImporter:FromSKMap(); end
			},
			skmappvpstats = {
				type = "execute",
				name = L["SKMap PvP Stats"],
				desc = L["Imports PvP Stats Data from Shim's Kill Map"],
				func = function() VanasKoSImporter:FromSKMapPvPStats(); end
			},
		}
	});
end

function VanasKoSImporter:OnEnable()
	self:ConvertFromOldVanasKoSList();
end

function VanasKoSImporter:OnDisable()
end

function VanasKoSImporter:ConvertFromOldVanasKoSList()
	local koslist = VanasKoS:GetList("PLAYERKOS");
	local datalist = VanasKoS:GetList("PLAYERDATA");
	-- split old koslist data to koslist and playerdata
	for k,v in pairs(koslist) do
		if(koslist[k].lastseen ~= nil and koslist[k].lastseen ~= -1) then
			local name = koslist[k].displayname;
			if(name == "") then
				name = k;
			end
			local level = koslist[k].level;
			local class = koslist[k].class;
			local race = koslist[k].race;
			local lastseen = koslist[k].lastseen;
			if(lastseen == -1) then
				lastseen = nil;
			end

			local data = {
				['guild'] = nil,
				['level'] = level,
				['race'] = race,
				['class'] = class,
				['gender'] = 0,
				['zone'] = nil
			};

			self:SendMessage("VanasKoS_Player_Data_Gathered", "PLAYERKOS", name, data);
			-- fix lastseen:
			datalist[k].lastseen = lastseen;

		end
		-- delete old entries
		koslist[k].displayname = nil;
		koslist[k].level = nil;
		koslist[k].class = nil;
		koslist[k].race = nil;
		koslist[k].lastseen = nil;
	end

	-- convert old foreign entries to the new format
	local lists = { "PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST" };
	for index, listname in pairs(lists) do
		local list = VanasKoS:GetList(listname);

		for k,v in pairs(list) do
			if(list[k].owner == nil and list[k].creator ~= nil and list[k].sender ~= nil) then
				list[k].owner = list[k].creator:lower();
			end
		end
	end
end
--[[----------------------------------------------------------------------
	Import Functions
------------------------------------------------------------------------]]

local SKMZoneTranslate = {
	["KA_01"] = {1,  1, BZ["Ashenvale"],},
	["KA_02"] = {1,  2, BZ["Azshara"],},
	["KA_03"] = {1,  3, BZ["Azuremyst Isle"],},
	["KA_04"] = {1,  4, BZ["Bloodmyst Isle"],},
	["KA_05"] = {1,  5, BZ["Darkshore"],},
	["KA_06"] = {1,  6, BZ["Darnassus"],},
	["KA_07"] = {1,  7, BZ["Desolace"],},
	["KA_08"] = {1,  8, BZ["Durotar"],},
	["KA_09"] = {1,  9, BZ["Dustwallow Marsh"],},
	["KA_10"] = {1, 10, BZ["Felwood"],},
	["KA_11"] = {1, 11, BZ["Feralas"],},
	["KA_12"] = {1, 12, BZ["Moonglade"],},
	["KA_13"] = {1, 13, BZ["Mulgore"],},
	["KA_14"] = {1, 14, BZ["Orgrimmar"],},
	["KA_15"] = {1, 15, BZ["Silithus"],},
	["KA_16"] = {1, 16, BZ["Stonetalon Mountains"],},
	["KA_17"] = {1, 17, BZ["Tanaris"],},
	["KA_18"] = {1, 18, BZ["Teldrassil"],},
	["KA_19"] = {1, 19, BZ["The Barrens"],},
	["KA_20"] = {1, 20, BZ["The Exodar"],},
	["KA_21"] = {1, 21, BZ["Thousand Needles"],},
	["KA_22"] = {1, 22, BZ["Thunder Bluff"],},
	["KA_23"] = {1, 23, BZ["Un'Goro Crater"],},
	["KA_24"] = {1, 24, BZ["Winterspring"],},
	["EK_01"] = {2,  1, BZ["Alterac Mountains"],},
	["EK_02"] = {2,  2, BZ["Arathi Highlands"],},
	["EK_03"] = {2,  3, BZ["Badlands"],},
	["EK_04"] = {2,  4, BZ["Blasted Lands"],},
	["EK_05"] = {2,  5, BZ["Burning Steppes"],},
	["EK_06"] = {2,  6, BZ["Deadwind Pass"],},
	["EK_07"] = {2,  7, BZ["Dun Morogh"],},
	["EK_08"] = {2,  8, BZ["Duskwood"],},
	["EK_09"] = {2,  9, BZ["Eastern Plaguelands"],},
	["EK_10"] = {2, 10, BZ["Elwynn Forest"],},
	["EK_11"] = {2, 11, BZ["Eversong Woods"],},
	["EK_12"] = {2, 12, BZ["Ghostlands"],},
	["EK_13"] = {2, 13, BZ["Hillsbrad Foothills"],},
	["EK_14"] = {2, 14, BZ["Ironforge"],},
	["EK_15"] = {2, 16, BZ["Loch Modan"],},
	["EK_16"] = {2, 17, BZ["Redridge Mountains"],},
	["EK_17"] = {2, 18, BZ["Searing Gorge"],},
	["EK_18"] = {2, 19, BZ["Silvermoon City"],},
	["EK_19"] = {2, 20, BZ["Silverpine Forest"],},
	["EK_20"] = {2, 21, BZ["Stormwind City"],},
	["EK_21"] = {2, 22, BZ["Stranglethorn Vale"],},
	["EK_22"] = {2, 23, BZ["Swamp of Sorrows"],},
	["EK_23"] = {2, 24, BZ["The Hinterlands"],},
	["EK_24"] = {2, 25, BZ["Tirisfal Glades"],},
	["EK_25"] = {2, 26, BZ["Undercity"],},
	["EK_26"] = {2, 27, BZ["Western Plaguelands"],},
	["EK_27"] = {2, 28, BZ["Westfall"],},
	["EK_28"] = {2, 29, BZ["Wetlands"],},
	--["EK_29"] = {2, 14, BZ["Isle of Quel'Danas"],},
	["OL_01"] = {3,  1, BZ["Blade's Edge Mountains"],},
	["OL_02"] = {3,  2, BZ["Hellfire Peninsula"],},
	["OL_03"] = {3,  3, BZ["Nagrand"],},
	["OL_04"] = {3,  4, BZ["Netherstorm"],},
	["OL_05"] = {3,  5, BZ["Shadowmoon Valley"],},
	["OL_06"] = {3,  6, BZ["Shattrath City"],},
	["OL_07"] = {3,  7, BZ["Terokkar Forest"],},
	["OL_08"] = {3,  8, BZ["Zangarmarsh"],},
	-- These are not defined in current skmap
	--["NR_01"] = {4,  1, BZ["Borean Tundra"],},
	--["NR_02"] = {4,  2, BZ["Crystalsong Forest"],},
	--["NR_03"] = {4,  3, BZ["Dalaran"],},
	--["NR_04"] = {4,  4, BZ["Dragonblight"],},
	--["NR_05"] = {4,  5, BZ["Grizzly Hills"],},
	--["NR_06"] = {4,  6, BZ["Howling Fjord"],},
	--["NR_07"] = {4,  7, BZ["Icecrown"],},
	--["NR_08"] = {4,  8, BZ["Sholazar Basin"],},
	--["NR_09"] = {4,  9, BZ["The Storm Peaks"],},
	--["NR_10"] = {4, 10, BZ["Wintergrasp"],},
	--["NR_11"] = {4, 11, BZ["Zul'Drak"],},
};

local SKMRaceTranslate = {BR["Dwarf"], BR["Gnome"], BR["Human"], BR["Night Elf"], BR["Orc"], BR["Tauren"], BR["Troll"], BR["Undead"], BR["Draenei"], BR["Blood Elf"]};
local SKMClassTranslate = {BC["Druid"], BC["Hunter"], BC["Mage"], BC["Paladin"], BC["Priest"], BC["Rogue"], BC["Shaman"], BC["Warrior"], BC["Warlock"]};

local function SKMGetContinent(ZoI)
	if (ZoI ~= nil and SKMZoneTranslate[ZoI] ~= nil) then
		return SKMZoneTranslate[ZoI][1];
	end
	return nil;
end

local function SKMGetZoneId(ZoI)
	if (ZoI ~= nil and SKMZoneTranslate[ZoI] ~= nil) then
		return SKMZoneTranslate[ZoI][2];
	end
	return nil;
end

local function SKMGetZoneName(ZoI)
	if (ZoI ~= nil and SKMZoneTranslate[ZoI] ~= nil) then
		return SKMZoneTranslate[ZoI][3];
	end
	return nil;
end

local function SKMTypeResult(enemyType, killType)
	if (enemyType == "EPl" or enemyType == "enemyPlayer") then
		if (killType == "PK" or killType == "PaK" or killType == "PfK" or
			killType == "LwK" or killType == "playerKill" or
			killType == "playerAssistKill" or 
			killType == "playerFullKill" or
			killType == "loneWolfKill") then
			return "win";
		elseif (killType == "PDp" or killType == "playerDeathPvP") then
			return "loss";
		else
			return nil;
		end
	end
	return nil;
end

local function SKMTimeTranslate(strDate)
	if (strDate == nil) then
		return nil;
	end

	local skDate = {string.match(strDate, "(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)")};
	return time({year = skDate[3], month = skDate[2], day = skDate[1],
			hour=skDate[4], min = skDate[5], sec = skDate[6]});
end

-- returns imported
local function importSKMapPoint(player, idx)
	local point = assert(SKM_Data[GetRealmName()][player].GlobalMapData[idx]);
	local myname = SKM_Data[GetRealmName()][player]["PlayerName"] or player;
	local posX = point["x"] or point["xpos"];
	local posY = point["y"] or point["ypos"];
	local continent = point["continent"] or SKMGetContinent(point["ZoI"]);
	local zoneid = point["zone"] or SKMGetZoneId(point["ZoI"]);
	local zone = point["zoneName"] or SKMGetZoneName(point["ZoI"]);
	local info = point["Inf"] or point["storedInfo"];
	local name, sktype, sktime;
	if (info ~= nil) then
		local enemyType = info["ETy"] or info["enemyType"];
		local killType = info["Ty"] or info["type"];
		sktype = SKMTypeResult(enemyType, killType);
		name = info["Na"] or info["name"];
		sktime = SKMTimeTranslate(info["Da"] or info["date"]) or date();
	end
	if (not (posX and posY and continent and zoneid and zone and name and
			sktype and sktime)) then
		return 0;
	end

	VanasKoS:AddEntry("PVPLOG", name:lower(), { ['time'] = sktime,
					['myname'] = myname,
					['type'] = sktype,
					['continent'] = continent,
					['zoneid'] = zoneid,
					['zone']  = zone,
					['posX'] = posX,
					['posY'] = posY });
	return 1;
end

-- returns imported
local function importSKMapEnemyStats(player, enemy)
	local etable = assert(SKM_Data[GetRealmName()][player].EnemyHistory[enemy]);
	local pvpstats = VanasKoS:GetList("PVPSTATS");
	local wins = tonumber(etable["PK"] or etable["playerKill"]) or 0;
	local losses = tonumber(etable["EKP"] or etable["enemyKillPlayer"]) or 0;
	local name = etable["Na"] or etable["name"] or enemy;
	local lname = name:lower();

	if (wins + losses > 0) then
		if (not pvpstats[lname]) then
			pvpstats[lname] = {['wins'] = wins, ['losses'] = losses};
		else
			pvpstats[lname].wins = wins + (pvpstats[lname].wins or 0);
			pvpstats[lname].losses = losses + (pvpstats[lname].losses or 0);
		end

		return 1;
	end

	return 0;
end

-- returns imported, already_exists
local function importSKMapEnemy(player, enemy)
	local etable = assert(SKM_Data[GetRealmName()][player].EnemyHistory[enemy]);
	local myname = SKM_Data[GetRealmName()][player]["PlayerName"] or player;
	local playerkos = VanasKoS:GetList("PLAYERKOS");
	local datalist = VanasKoS:GetList("PLAYERDATA");
	local name = etable["Na"] or etable["name"] or enemy;
	local lname = name:lower();

	if (etable["Wr"] == true or etable["atWar"] == true) then
		local reason = etable["PlN"] or etable["playerNote"];
		local created = SKMTimeTranslate(etable["WD"] or etable["warDate"]) or date();
		local guild = etable["Gu"] or etable["guild"];
		local level = etable["Lv"] or etable["level"];
		level = (level ~= -1 and level) or nil;
		local class = SKMClassTranslate[etable["Cl"] or etable["class"]];
		local race = SKMRaceTranslate[etable["Ra"] or etable["race"]];
		local lastseen = SKMTimeTranslate(etable["lV"] or etable["lastView"]);
		local zone = etable["zoneName"] or SKMGetZoneName(etable["ZoI"]);
		if (not datalist[lname]) then
			datalist[lname] = { 	['guild'] = guild,
						['level'] = level,
						['class'] = class,
						['race'] = race,
						['lastseen'] = lastseen,
						['zone'] = zone
					};
		elseif (lastseen > datalist[lname].lastseen) then
			datalist[lname].guild = guild;
			datalist[lname].level = level;
			datalist[lname].class = class;
			datalist[lname].race = race;
			datalist[lname].lastseen = lastseen;
			datalist[lname].zone = zone;
		end
		if (not playerkos[lname]) then
			playerkos[lname] = {['reason'] = reason, ['created'] = created, ['creator'] = myname};
			return 1, 0;
		end

		return 0, 1;
	end

	return 0, 0;
end

-- returns imported, already_exists
local function importSKMapGuild(player, guild)
	local gtable = assert(SKM_Data[GetRealmName()][player].GuildHistory[guild]);
	local myname = SKM_Data[GetRealmName()][player]["PlayerName"] or player;
	local guildkos = VanasKoS:GetList("GUILDKOS");

	if (gtable["Wr"] == true or gtable["atWar"] == true) then
		local name = gtable["Na"] or gtable["name"] or guild;
		local lname = name:lower();
		local reason = nil;
		local created = SKMTimeTranslate(gtable["WD"] or gtable["warDate"]) or date();
		if (gtable["playerNote"] ~= nil) then
			reason = gtable["playerNote"];
		elseif (gtable["plN"] ~= nil) then
			reason = gtable["plN"];
		end
		if (not guildkos[lname]) then
			guildkos[lname] = {	['reason'] = reason,
						['created'] = created,
						['creator'] = myname,
					};
			return 1, 0;
		end

		return 0, 1;
	end

	return 0, 0;
end

function VanasKoSImporter:FromSKMap()
	if (SKM_Data == nil or SKM_Data[GetRealmName()] == nil) then
		VanasKoS:Print(L["SKMap data couldn't be loaded"]);
		return;
	end

	local kos_add = 0;
	local kos_dup = 0;

	for player, p in pairs(SKM_Data[GetRealmName()]) do
		if (p["EnemyHistory"] ~= nil) then 
			for enemy, e in pairs(p["EnemyHistory"]) do
				local tmp_add, tmp_dup = importSKMapEnemy(player, enemy);
				kos_add = kos_add + tmp_add;
				kos_dup = kos_dup + tmp_dup;
			end
		end
		if (p["GuildHistory"] ~= nil) then
			for guild, g in pairs(p["GuildHistory"]) do
				local tmp_add, tmp_dup = importSKMapGuild(player, guild);
				kos_add = kos_add + tmp_add;
				kos_dup = kos_dup + tmp_dup;
			end
		end
	end

	VanasKoS:Print(format(L["Imported %d KoS entries (%d duplicates)"], kos_add, kos_dup));
	VanasKoS:Print(L["SKMap data was imported"]);
	VanasKoSGUI:Update();
end

function VanasKoSImporter:FromSKMapPvPStats()
	if (SKM_Data == nil or SKM_Data[GetRealmName()] == nil) then
		VanasKoS:Print(L["SKMap data couldn't be loaded"]);
		return;
	end

	local stats = 0;
	local events = 0;

	for player, p in pairs(SKM_Data[GetRealmName()]) do
		if (p["EnemyHistory"] ~= nil) then 
			for enemy, e in pairs(p["EnemyHistory"]) do
				local tmp_stats = importSKMapEnemyStats(player, enemy);
				stats = stats + tmp_stats;
			end
		end
		if (p["GlobalMapData"] ~= nil) then
			for i, p in ipairs(p["GlobalMapData"]) do
				tmp_events = importSKMapPoint(player, i);
				events = events + tmp_events;
			end
		end
	end

	VanasKoS:Print(format(L["Updated %d PVP statistics"], stats));
	VanasKoS:Print(format(L["Imported %d PVP events"], events));
	VanasKoS:Print(L["SKMap data was imported"]);
	VanasKoSGUI:Update();
end

function VanasKoSImporter:FromUBotD()
	if(ubdKos == nil) then
		VanasKoS:Print(L["UBotD data couldn't be loaded"]);
		return nil;
	end
	if(ubdKos.kos == nil) then
		VanasKoS:Print(L["UBotD data couldn't be loaded"]);
		return nil;
	end
	for index, value in pairs(ubdKos.kos) do
		if(value.notes == "Unk") then
			VanasKoS:AddKoSPlayer(index, nil);
			VanasKoS:Print(index .. " " .. L["imported"] .. ".");
		else
			VanasKoS:AddKoSPlayer(index, value.notes);
			VanasKoS:Print(index .. " (" .. value.notes .. ") " .. L["imported"] .. ".");
		end
	end
	VanasKoS:Print(L["UBotD data was imported"]);
	VanasKoSGUI:Update();
end

function VanasKoSImporter:FromOpiumPvPStats()
	if(not OpiumData or not OpiumData.playerLinks or not OpiumData.playerLinks[GetRealmName()]) then
		VanasKoS:Print(L["Opium data couldn't be loaded"]);
		return;
	end
	local player = OpiumData.playerLinks[GetRealmName()];
	for k,v in pairs(player) do
		-- 0 = level
		-- 1 = race
		-- 2 = class
		-- 3 = faction
		-- 4 = guild
		-- 5 = guilt title
		-- 6 = lastseen
		-- 7 = losses
		-- 8 = wins
		-- 9 = pvprank
		if(v[7] or v[8]) then
			local lname = k:lower();
			local list = VanasKoS:GetList("PVPSTATS");

			if(not list[lname]) then
				list[lname] = { ['wins'] = 0, ['losses'] = 0};
			end

			if(v[7]) then  -- loss
				list[lname].losses = list[lname].losses + tonumber(v[7]);
			end
			if(v[8]) then -- win
				list[lname].wins = list[lname].wins + tonumber(v[8]);
			end

			VanasKoS:Print(k .. " " .. L["imported"] .. ".");
		end
	end
	VanasKoS:Print(L["Opium data was imported"]);
	VanasKoSGUI:Update();
end

function VanasKoSImporter:FromOpium()
	if(not OpiumData) then
		VanasKoS:Print(L["Opium data couldn't be loaded"]);
		return;
	end
	if(OpiumData.kosPlayer and OpiumData.kosPlayer[GetRealmName()]) then
		local list = OpiumData.kosPlayer[GetRealmName()];

		for k,v in pairs(list) do
			-- 1 = kos, 2 = friendly
			if(v[1] == 1 or v[1] == nil) then
				VanasKoS:AddEntry("PLAYERKOS", k, { ['reason'] = v[0] });
			elseif(v[1] == 2) then
				VanasKoS:AddEntry("NICELIST", k,  { ['reason'] = v[0] });
			end
		end

	end
	if(OpiumData.kosGuild and OpiumData.kosGuild[GetRealmName()]) then
		local list = OpiumData.kosGuild[GetRealmName()];

		for k,v in pairs(list) do
			-- 1 = kos, 2 = friendly (ignored because no friendly guild list)
			if(v[1] == 1 or v[1] == nil) then
				VanasKoS:AddEntry("GUILDKOS", k:gsub("_", " "),  { ['reason'] = v[0] });
			elseif(v[1] == 2) then
				-- ignore
			end
		end
	end
	VanasKoS:Print(L["Opium data was imported"]);
	VanasKoSGUI:Update();
end
