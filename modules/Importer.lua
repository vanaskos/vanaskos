--[[----------------------------------------------------------------------
      Importer Module - Part of VanasKoS
Handles import of other AddOns KoS Data
------------------------------------------------------------------------]]

local function RegisterTranslations(locale, translationfunction)
	local defaultLocale = false;
	if(locale == "enUS") then
		defaultLocale = true;
	end
	
	local liblocale = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Importer", locale, defaultLocale);
	if liblocale then
		for k, v in pairs(translationfunction()) do
			liblocale[k] = v;
		end
	end
end

VanasKoSImporter = VanasKoS:NewModule("Importer");

RegisterTranslations("enUS", function() return {
	["UBotD data couldn't be loaded"] = true,
	["UBotD data was imported"] = true,
	["imported"] = true,
	["Opium data couldn't be loaded"] = true,
	["Opium data was imported"] = true,
	["Imports KoS Data from other KoS tools"] = true,
	["Imports KoS Data from Ultimate Book of the Dead"] = true,
	["Imports KoS Data from Opium"] = true,
	["Imports PvP Stats Data from Opium"] = true,
} end);

RegisterTranslations("deDE", function() return {
	["UBotD data couldn't be loaded"] = "UBotD Daten konnten nicht geladen werden",
	["UBotD data was imported"] = "UBotD Daten wurden importiert",
	["imported"] = "importiert",
	["Opium data couldn't be loaded"] = "Opium Daten konnten nicht geladen werden",
	["Opium data was imported"] = "Opium Daten wurden importiert",
	["Imports KoS Data from other KoS tools"] = "Importieren von Daten aus anderen KoS-AddOns",
	["Imports KoS Data from Ultimate Book of the Dead"] = "Importieren von Daten aus dem Ultimate Book of the Dead",
	["Imports KoS Data from Opium"] = "Importieren von Daten aus Opium",
	["Imports PvP Stats Data from Opium"] = "Importieren von Opiums PvP Statistiken",
} end);

RegisterTranslations("frFR", function() return {
	["UBotD data couldn't be loaded"] = "Des donn\195\169es d'UBotD n'ont pas pu \195\170tre charg\195\169es",
	["UBotD data was imported"] = "Des donn\195\169es d'UBotD ont \195\169t\195\169 import\195\169es",
	["imported"] = "import\195\169",
	["Opium data couldn't be loaded"] = "Des donn\195\169es d'Opium n'ont pas pu \195\170tre charg\195\169es",
	["Opium data was imported"] = "Des donn\195\169es d'Opium ont \195\169t\195\169 import\195\169es",
	["Imports KoS Data from other KoS tools"] = "Importe les donn\195\169es KoS d'autres outils KoS",
	["Imports KoS Data from Ultimate Book of the Dead"] = "Importe les donn\195\169es de \"Ultimate Book of the Dead\"",
	["Imports KoS Data from Opium"] = "Importe les donn\195\169es de \"Opium\"",
--	["Imports PvP Stats Data from Opium"] = true,
} end);

RegisterTranslations("koKR", function() return {
	["UBotD data couldn't be loaded"] = "UBotD 데이터를 불러올 수 없습니다.",
	["UBotD data was imported"] = "UBotD 데이터를 로드하였습니다.",
	["imported"] = "로드됨",
	["Opium data couldn't be loaded"] = "Opium 데이터를 불러올 수 없습니다.",
	["Opium data was imported"] = "Opium 데이터를 로드하였습니다.",
	["Imports KoS Data from other KoS tools"] = "다른 KoS 툴에서 KoS 데이터를 불러옵니다.",
	["Imports KoS Data from Ultimate Book of the Dead"] = "Ultimate Book of the Dead에서 KoS 데이터를 불러옵니다.",
	["Imports KoS Data from Opium"] = "Opium의 KoS 데이터를 불러옵니다.",
	["Imports PvP Stats Data from Opium"] = "Opium에서 PvP 상태 데이터를 불러옵니다.",
} end);

RegisterTranslations("esES", function() return {
	["UBotD data couldn't be loaded"] = "Los datos de UBotD no han podido ser cargados",
	["UBotD data was imported"] = "Los datos de UBotD han sido importados",
	["imported"] = "importados",
	["Opium data couldn't be loaded"] = "Los datos de Opium no han podido ser cargados",
	["Opium data was imported"] = "Los datos de Opium han sido importados",
	["Imports KoS Data from other KoS tools"] = "Importa datos de KoS de otras herramientas de KoS",
	["Imports KoS Data from Ultimate Book of the Dead"] = "Importa datos de KoS de Ultimate Book of the Dead",
	["Imports KoS Data from Opium"] = "Importa datos de KoS de Opium",
--	["Imports PvP Stats Data from Opium"] = true,
} end);

RegisterTranslations("ruRU", function() return {
	["UBotD data couldn't be loaded"] = "Не удалось загрузить данные UBotD",
	["UBotD data was imported"] = "Данные UBotD импортированы",
	["imported"] = "импортировано",
	["Opium data couldn't be loaded"] = "Не удалось загрузить данные Opium",
	["Opium data was imported"] = "Данные Opium импортированы",
	["Imports KoS Data from other KoS tools"] = "Импортирует данные KoS из других KoS инструментов",
	["Imports KoS Data from Ultimate Book of the Dead"] = "Импортирует данные KoS из Ultimate Book of the Dead",
	["Imports KoS Data from Opium"] = "Импортирует данные KoS из Opium",
	["Imports PvP Stats Data from Opium"] = "Импортирует ПвП статистику из Opium",
} end);

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_Importer", false);

function VanasKoSImporter:OnInitialize()
	VanasKoSGUI:AddConfigOption("Importer", {
		type = "group",
		name = L["Imports KoS Data from other KoS tools"],
		desc = L["Imports KoS Data from other KoS tools"],
		args = {
			ubotd = {
				type = "execute",
				name = L["Imports KoS Data from Ultimate Book of the Dead"],
				desc = L["Imports KoS Data from Ultimate Book of the Dead"],
				func = function() VanasKoSImporter:FromUBotD(); end
			},
			opium = {
				type = "execute",
				name = L["Imports KoS Data from Opium"],
				desc = L["Imports KoS Data from Opium"],
				func = function() VanasKoSImporter:FromOpium(); end
			},
			opiumpvpstats = {
				type = "execute",
				name = L["Imports PvP Stats Data from Opium"],
				desc = L["Imports PvP Stats Data from Opium"],
				func = function() VanasKoSImporter:FromOpiumPvPStats(); end
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

			self:TriggerEvent("VanasKoS_Player_Data_Gathered", "PLAYERKOS", name, data);
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
end