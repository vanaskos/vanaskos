--[[----------------------------------------------------------------------
      Importer Module - Part of VanasKoS
Handles import of other AddOns KoS Data
------------------------------------------------------------------------]]
local L = AceLibrary("AceLocale-2.2"):new("VanasKoSImporter");

VanasKoSImporter = VanasKoS:NewModule("Importer");

L:RegisterTranslations("enUS", function() return {
	["UBotD data couldn't be loaded"] = true,
	["UBotD data was imported"] = true,
	["imported"] = true,
	["Old VanasKoS data couldn't be loaded"] = true,
	["Old VanasKoS Players-data couldn't be loaded"] = true,
	["Old Vanas KoS Data successfully imported"] = true,
	["Opium data couldn't be loaded"] = true,
	["Opium data was imported"] = true,
} end);

L:RegisterTranslations("deDE", function() return {
	["UBotD data couldn't be loaded"] = "UBotD Daten konnten nicht geladen werden",
	["UBotD data was imported"] = "UBotD Daten wurden importiert",
	["imported"] = "importiert",
	["Old VanasKoS data couldn't be loaded"] = "Alte VanasKoS Daten konnten nicht geladen werden",
	["Old VanasKoS Players-data couldn't be loaded"] = "Alte VanaskoS Spieler-Daten konnten nicht geladen werden",
	["Old Vanas KoS Data successfully imported"] = "Alte VanasKoS Daten wurden erfolgreich importiert",
	["Opium data couldn't be loaded"] = "Opium Daten konnten nicht geladen werden",
	["Opium data was imported"] = "Opium Daten wurden importiert",
} end);

L:RegisterTranslations("frFR", function() return {
	["UBotD data couldn't be loaded"] = "Des donn\195\169es d'UBotD n'ont pas pu \195\170tre charg\195\169es",
	["UBotD data was imported"] = "Des donn\195\169es d'UBotD ont \195\169t\195\169 import\195\169es",
	["imported"] = "import\195\169",
	["Old VanasKoS data couldn't be loaded"] = "De vieilles donn\195\169es de VanasKoS n'ont pas pu \195\170tre charg\195\169es",
	["Old VanasKoS Players-data couldn't be loaded"] = "De vieilles donn\195\169es de joueurs de VanasKoS n'ont pas pu \195\170tre charg\195\169es",
	["Old Vanas KoS Data successfully imported"] = "Vieilles donn\195\169es de Vanas KoS import\195\169es avec succ\195\168s",
	["Opium data couldn't be loaded"] = "Des donn\195\169es d'Opium n'ont pas pu \195\170tre charg\195\169es",
	["Opium data was imported"] = "Des donn\195\169es d'Opium ont \195\169t\195\169 import\195\169es",
} end);

L:RegisterTranslations("koKR", function() return {
	["UBotD data couldn't be loaded"] = "UBotD 데이터를 불러올 수 없습니다.",
	["UBotD data was imported"] = "UBotD 데이터를 로드하였습니다.",
	["imported"] = "로드됨",
	["Old VanasKoS data couldn't be loaded"] = "이전 버전 데이터를 불러올 수 없습니다.",
	["Old VanasKoS Players-data couldn't be loaded"] = "이전 버전의 플레이어 데이터를 불러올 수 없습니다.",
	["Old Vanas KoS Data successfully imported"] = "이전 버전의 데이터를 성공적으로 로드하였습니다.",
	["Opium data couldn't be loaded"] = "Opium 데이터를 불러올 수 없습니다.",
	["Opium data was imported"] = "Opium 데이터를 로드하였습니다.",
} end);

L:RegisterTranslations("esES", function() return {
	["UBotD data couldn't be loaded"] = "Los datos de UBotD no han podido ser cargados",
	["UBotD data was imported"] = "Los datos de UBotD han sido importados",
	["imported"] = "importados",
	["Old VanasKoS data couldn't be loaded"] = "Los datos del viejo VanasKoS no han podido ser cargados",
	["Old VanasKoS Players-data couldn't be loaded"] = "Los datos de Jugadores del viejo VanasKoS no han podido ser cargados",
	["Old Vanas KoS Data successfully imported"] = "Los datos del viejo VanasKoS han sido importados",
	["Opium data couldn't be loaded"] = "Los datos de Opium no han podido ser cargados",
	["Opium data was imported"] = "Los datos de Opium han sido importados",
} end);

L:RegisterTranslations("ruRU", function() return {
	["UBotD data couldn't be loaded"] = "Не удалось загрузить данные UBotD",
	["UBotD data was imported"] = "Данные UBotD импортированы",
	["imported"] = "импортировано",
	["Old VanasKoS data couldn't be loaded"] = "Не удалось загрузить данные старого VanasKoS",
	["Old VanasKoS Players-data couldn't be loaded"] = "Не удалось загрузить данные игроков из старого VanasKoS",
	["Old Vanas KoS Data successfully imported"] = "Данные из старого VanasKoS успешно загружены",
	["Opium data couldn't be loaded"] = "Не удалось загрузить данные Opium",
	["Opium data was imported"] = "Данные Opium импортированы",
} end);

function VanasKoSImporter:OnInitialize()
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

function VanasKoSImporter:FromOldVanasKoS()
	if(not VanasKoSDB) then
		VanasKoS:Print(L["Old VanasKoS data couldn't be loaded"]);
		return nil;
	end
	if(not VanasKoSDB.koslist) then
		VanasKoS:Print(L["Old VanasKoS data couldn't be loaded"]);
		return nil;
	end
	if(not VanasKoSDB.koslist[GetRealmName()]) then
		VanasKoS:Print(L["Old VanasKoS data couldn't be loaded"]);
		return nil;
	end

	local playersdb = VanasKoSDB.koslist[GetRealmName()].players;
	local guildsdb = VanasKoSDB.koslist[GetRealmName()].guilds;
	if(playersdb ~= nil) then
		for index, value in pairs(playersdb) do
			VanasKoS:AddKoSPlayer(index, value.reason);
		end

		VanasKoSDB.koslist[GetRealmName()].players = nil;
	end
	if(guildsdb ~= nil) then
		for index, value in pairs(guildsdb) do
			VanasKoS:AddKoSGuild(index, value.reason);
		end

		VanasKoSDB.koslist[GetRealmName()].guilds = nil;
	end

	VanasKoS:Print(L["Old Vanas KoS Data successfully imported"]);
end