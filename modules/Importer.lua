--[[----------------------------------------------------------------------
      Importer Module - Part of VanasKoS
Handles import of other AddOns KoS Data
------------------------------------------------------------------------]]
local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/Importer", false);

local LCM = LOCALIZED_CLASS_NAMES_MALE;
local BR = LibStub("LibBabble-Race-3.0"):GetLookupTable()

VanasKoSImporter = VanasKoS:NewModule("Importer", "AceEvent-3.0");
local zoneContinentZoneID = {};

function VanasKoSImporter:OnInitialize()
	VanasKoSGUI:AddConfigOption("Importer", {
		type = "group",
		name = L["Import Data"],
		desc = L["Imports KoS Data from other KoS tools"],
		args = {
			vanaskos_header = {
				order = 1,
				type = "header",
				name = L["Old VanasKoS"],
			},
			oldvanaskos = {
				order = 2,
				type = "execute",
				name = L["Old VanasKoS"],
				desc = L["Imports Data from old VanasKoS"],
				func = function() VanasKoSImporter:FromOldVanasKoS(); end
			},
			ubotd_header = {
				order = 3,
				type = "header",
				name = L["Ultimate Book of the Dead"],
			},
			ubotd = {
				order = 4,
				type = "execute",
				name = L["UBotD KoS"],
				desc = L["Imports KoS Data from Ultimate Book of the Dead"],
				func = function() VanasKoSImporter:FromUBotD(); end
			},
			opium_header = {
				order = 5,
				type = "header",
				name = L["Opium KoS"],
			},
			opium = {
				order = 6,
				type = "execute",
				name = L["Opium KoS"],
				desc = L["Imports KoS Data from Opium"],
				func = function() VanasKoSImporter:FromOpium(); end
			},
			opiumpvpstats = {
				order = 7,
				type = "execute",
				name = L["Opium PvP Stats"],
				desc = L["Imports PvP Stats Data from Opium"],
				func = function() VanasKoSImporter:FromOpiumPvPStats(); end
			},
			skmap_header = {
				order = 8,
				type = "header",
				name = L["Shim's Kill Map"],
			},
			skmap = {
				order = 9,
				type = "execute",
				name = L["SKMap KoS"],
				desc = L["Imports KoS Data from Shim's Kill Map"],
				func = function() VanasKoSImporter:FromSKMap(); end
			},
			skmappvpstats = {
				order = 10,
				type = "execute",
				name = L["SKMap PvP Stats"],
				desc = L["Imports PvP Stats Data from Shim's Kill Map"],
				func = function() VanasKoSImporter:FromSKMapPvPStats(); end
			},
		},
	});
end

function VanasKoSImporter:OnEnable()
	continents = {GetMapContinents()};
	for i, name in ipairs(continents) do
		zoneContinentZoneID[i] = {GetMapZones(i)};
		zoneContinentZoneID[i][0] = name;
	end

	self:ConvertFromOldVanasKoSList();
end

function VanasKoSImporter:OnDisable()
end

local function importOldList(src, dest) 
	for k,v in pairs(src) do
		if(not dest[k]) then
			dest[k] = src[k];
			VanasKoS:Print("import " .. k);
		end
	end
end

local function importVanasDefaultListsPerRealm(realmDB)
	for k,v in pairs(realmDB) do
		local allyRealm = "Alliance - " .. string.gsub(string.gsub(k, " [-] Alliance", ""), " [-] Horde", "");
		local hordeRealm = "Horde - " .. string.gsub(string.gsub(k, " [-] Alliance", ""), " [-] Horde", "");

		if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm]) then
			VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm] = {};
		end
		if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm]) then
			VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm] = {};
		end

		if(v.koslist) then
			if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].koslist) then
				VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].koslist = {};
			end
			if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].koslist) then
				VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].koslist = {};
			end

			if (v.koslist.players) then
				if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].koslist.players) then
					VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].koslist.players = {};
				end
				if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].koslist.players) then
					VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].koslist.players = {};
				end
				importOldList(v.koslist.players, VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].koslist.players);
				importOldList(v.koslist.players, VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].koslist.players);
				v.koslist.players = nil;
			end
			if(v.koslist.guilds) then
				if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].koslist.guilds) then
					VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].koslist.guilds = {};
				end
				if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].koslist.guilds) then
					VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].koslist.guilds = {};
				end
				importOldList(v.koslist.guilds, VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].koslist.guilds);
				importOldList(v.koslist.guilds, VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].koslist.guilds);
				v.koslist.guilds = nil;
			end
			v.koslist = nil;
		end

		if(v.hatelist and v.hatelist.players) then
			if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].hatelist) then
				VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].hatelist = {};
			end
			if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].hatelist.players) then
				VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].hatelist.players = {};
			end
			if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].hatelist) then
				VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].hatelist = {};
			end
			if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].hatelist.players) then
				VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].hatelist.players = {};
			end
			importOldList(v.hatelist.players, VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].hatelist.players);
			importOldList(v.hatelist.players, VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].hatelist.players);
			v.hatelist = nil;
		end

		if(v.nicelist and v.nicelist.players) then
			if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].nicelist) then
				VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].nicelist = {};
			end
			if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].nicelist.players) then
				VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].nicelist.players = {};
			end
			if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].nicelist) then
				VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].nicelist = {};
			end
			if(not VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].nicelist.players) then
				VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].nicelist.players = {};
			end
			importOldList(v.nicelist.players, VanasKoSDB.namespaces.DefaultLists.factionrealm[allyRealm].nicelist.players);
			importOldList(v.nicelist.players, VanasKoSDB.namespaces.DefaultLists.factionrealm[hordeRealm].nicelist.players);
			v.nicelist = nil;
		end
	end
end

function importVanasPvPStats(src)
	if(not VanasKoSDB.namespaces.PvPStats) then
		VanasKoSDB.namespaces.PvPStats = {};
	end
	if(not VanasKoSDB.namespaces.PvPStats.realm) then
		VanasKoSDB.namespaces.PvPStats.realm = {};
	end

	for k,v in pairs(src) do
		local realm = string.gsub(string.gsub(k, " [-] Alliance", ""), " [-] Horde", "");
		if(not VanasKoSDB.namespaces.PvPStats.realm[realm]) then
			VanasKoSDB.namespaces.PvPStats.realm[realm] = {};
		end
		if(not VanasKoSDB.namespaces.PvPStats.realm[realm].pvpstats) then
			VanasKoSDB.namespaces.PvPStats.realm[realm].pvpstats = {};
		end
		local pvpstats = VanasKoSDB.namespaces.PvPStats.realm[realm].pvpstats;
		if(not pvpstats.players) then
			pvpstats.players = {};
		end
		if (v.pvpstats and v.pvpstats.players) then
			for name, stat in pairs(v.pvpstats.players) do
				if(not pvpstats.players[name]) then
					pvpstats.players[name] = {};
				end
				if(not pvpstats.players[name].wins) then
					pvpstats.players[name].wins = 0;
				end
				if(not pvpstats.players[name].losses) then
					pvpstats.players[name].losses = 0;
				end
				pvpstats.players[name].wins = pvpstats.players[name].wins + (stat.wins or 0);
				pvpstats.players[name].losses = pvpstats.players[name].losses + (stat.losses or 0);
			end
			v.pvpstats.players = nil;
		end
	end
end

function VanasKoSImporter:FromOldVanasKoS()
	if(not VanasKoSDB and not VanasKoSDB.namespaces) then
		return
	end

	if(VanasKoSDB.namespaces.DefaultLists) then
		if(not VanasKoSDB.namespaces.DefaultLists.factionrealm) then
			VanasKoSDB.namespaces.DefaultLists.factionrealm = {};
		end

		if(VanasKoSDB.namespaces.DefaultLists.realms) then
			importVanasDefaultListsPerRealm(VanasKoSDB.namespaces.DefaultLists.realms);
			VanasKoSDB.namespaces.DefaultLists.realms = nil;
		end
		if(VanasKoSDB.namespaces.DefaultLists.realm) then
			importVanasDefaultListsPerRealm(VanasKoSDB.namespaces.DefaultLists.realm);
			VanasKoSDB.namespaces.DefaultLists.realm = nil;
		end
	end

	if(VanasKoSDB.namespaces.PvPDataGatherer) then
		if(VanasKoSDB.namespaces.PvPDataGatherer.realm) then
			importVanasPvPStats(VanasKoSDB.namespaces.PvPDataGatherer.realm);
		end
		if(VanasKoSDB.namespaces.PvPDataGatherer.realms) then
			importVanasPvPStats(VanasKoSDB.namespaces.PvPDataGatherer.realms);
			VanasKoSDB.namespaces.PvPDataGatherer.realms = nil;
		end
	end

	if(VanasKoSDB.namespaces.DataGatherer and VanasKoSDB.namespaces.DataGatherer.realms) then
		for k,v in pairs (VanasKoSDB.namespaces.DataGatherer.realms) do
			local realm = string.gsub(string.gsub(k, " [-] Alliance", ""), " [-] Horde", "");
			if(not VanasKoSDB.namespaces.DataGatherer.realm) then
				VanasKoSDB.namespaces.DataGatherer.realm = {};
			end
			if(not VanasKoSDB.namespaces.DataGatherer.realm[realm]) then
				VanasKoSDB.namespaces.DataGatherer.realm[realm] = {};
			end
			if(not VanasKoSDB.namespaces.DataGatherer.realm[realm].data) then
				VanasKoSDB.namespaces.DataGatherer.realm[realm].data = {};
			end
			if(not VanasKoSDB.namespaces.DataGatherer.realm[realm].data.players) then
				VanasKoSDB.namespaces.DataGatherer.realm[realm].data.players = {};
			end
			local datalist = VanasKoSDB.namespaces.DataGatherer.realm[realm].data.players;

			if(v.data) then
				for player, data in pairs(datalist) do
					if(not datalist[player]) then
						datalist[player] = data
					end
				end
			end
			v.players = nil;
		end
		VanasKoSDB.namespaces.DataGatherer.realms = nil;
	end
end

function VanasKoSImporter:ConvertFromOldVanasKoSList()
	if(VanasKoSDB and VanasKoSDB.namespaces and VanasKoSDB.namespaces.DefaultLists and VanasKoSDB.namespaces.DefaultLists.factionrealm) then
		for k, v in pairs(VanasKoSDB.namespaces.DefaultLists.factionrealm) do
			local realm = string.gsub(string.gsub(k, "Alliance [-] ", ""), "Horde [-] ", "");

			local koslist  = v.koslist and v.koslist.players or {};
			local gkoslist = v.koslist and v.koslist.guilds or {};
			local hatelist = v.hatelist and v.hatelist.players or {};
			local nicelist = v.nicelist and v.nicelist.players or {};
			if (not VanasKoSDB.namespaces.DataGatherer) then
				VanasKoSDB.namespaces.DataGatherer = {};
			end
			if (not VanasKoSDB.namespaces.DataGatherer.realm) then
				VanasKoSDB.namespaces.DataGatherer.realm = {};
			end
			if (not VanasKoSDB.namespaces.DataGatherer.realm[realm]) then
				VanasKoSDB.namespaces.DataGatherer.realm[realm] = {};
			end
			if (not VanasKoSDB.namespaces.DataGatherer.realm[realm].data) then
				VanasKoSDB.namespaces.DataGatherer.realm[realm].data = {};
			end
			if (not VanasKoSDB.namespaces.DataGatherer.realm[realm].data.players) then
				VanasKoSDB.namespaces.DataGatherer.realm[realm].data.players = {};
			end
			local datalist = VanasKoSDB.namespaces.DataGatherer.realm[realm].data.players;

			-- split old koslist data to koslist and playerdata
			for n,data in pairs(koslist) do
				if(koslist[n].lastseen ~= nil and koslist[n].lastseen ~= -1) then
					local name = koslist[n].displayname;
					if(name == nil or name == "") then
						name = n;
					end
					local level = koslist[n].level;
					local class = koslist[n].class;
					local race = koslist[n].race;
					local lastseen = koslist[n].lastseen;
					if(lastseen == -1) then
						lastseen = nil;
					end

					local data = {
						['name'] = name,
						['guild'] = nil,
						['level'] = level,
						['race'] = race,
						['class'] = class,
						['gender'] = 0,
						['zone'] = nil,
					};

					local lname = data.name:lower();
					if(not dataList[lname]) then
						dataList[lname] = data;
					end
					dataList[lname].lastseen = lastseen;
				end
				-- delete old entries
				koslist[n].displayname = nil;
				koslist[n].level = nil;
				koslist[n].class = nil;
				koslist[n].race = nil;
				koslist[n].lastseen = nil;
			end

			-- convert old foreign entries to the new format
			local lists = {koslist, gkoslist, hatelist, nicelist};
			for index, list in pairs(lists) do
				for n,data in pairs(list) do
					if(data.owner == nil) then
						if(data.creator ~= nil and data.sender ~= nil) then
							list[n].owner = data.sender:lower();
						end
					end
				end
			end
		end
	end

	if(VanasKoSDB and VanasKoSDB.namespaces and VanasKoSDB.namespaces.PvPDataGatherer and VanasKoSDB.namespaces.PvPDataGatherer.realm) then
		for k, v in pairs(VanasKoSDB.namespaces.PvPDataGatherer.realm) do
			if (not VanasKoSDB.namespaces.DataGatherer) then
				VanasKoSDB.namespaces.DataGatherer = {};
			end
			if (not VanasKoSDB.namespaces.DataGatherer.realm) then
				VanasKoSDB.namespaces.DataGatherer.realm = {};
			end
			if (not VanasKoSDB.namespaces.DataGatherer.realm[k]) then
				VanasKoSDB.namespaces.DataGatherer.realm[k] = {};
			end
			if (not VanasKoSDB.namespaces.DataGatherer.realm[k].data) then
				VanasKoSDB.namespaces.DataGatherer.realm[k].data = {};
			end
			if (not VanasKoSDB.namespaces.DataGatherer.realm[k].data.players) then
				VanasKoSDB.namespaces.DataGatherer.realm[k].data.players = {};
			end
			local datalist = VanasKoSDB.namespaces.DataGatherer.realm[k].data.players;
			local pvplog = v.pvpstats and v.pvpstats.pvplog;
			--convert continent/id zone information to zone only and
			-- upgrade to new format
			if (pvplog and not (pvplog.player and pvplog.zone and pvplog.event)) then
				local playerlog = {};
				local zonelog = {};
				local eventlog = {};
				for player, event in pairs(v) do
					for timestamp, data in pairs(event) do
						local zone = data.zone or "UNKNOWN";
						if (data.zoneid and data.continent) then
							if (not zoneContinentZoneID[data.continent] or not zoneContinentZoneID[data.continent][data.zoneid]) then
								VanasKoS:Print("pvplog: Invalid continent:" .. data.continent .. " zoneid:" .. data.zoneid);
							else
								zone = zoneContinentZoneID[data.continent][data.zoneid];
							end
						end
						tinsert(eventlog, {['enemyname'] = player,
									['time'] = timestamp,
									['myname'] = data['myname'],
									['mylevel'] = data['mylevel'],
									['enemylevel'] = data['enemylevel'],
									['type'] = data['type'],
									['zone']  = zone,
									['posX'] = data['posX'],
									['posY'] = data['posY'],
								});

						if (not zonelog[zone]) then
							zonelog[zone] = {};
						end
						tinsert(zonelog[zone], #eventlog);

						if (not playerlog[player]) then
							playerlog[player] = {};
						end
						tinsert(playerlog[player], #eventlog);
					end
				end
				wipe(pvplog);

				pvplog.event = eventlog;
				pvplog.player = playerlog;
				pvplog.zone = zonelog;
			end

			--convert continent/id zone information to zone only
			for player, data in pairs(datalist) do
				if (data.zoneid and data.continent) then
					if (not zoneContinentZoneID[data.continent] or not zoneContinentZoneID[data.continent][data.zoneid]) then
						VanasKoS:Print("playerdata: Invalid continent:" .. data.continent .. " zoneid:" .. data.zoneid);
						pvplog[player][timestamp].zone = "UNKNOWN";
					else
						pvplog[player][timestamp].zone = zoneContinentZoneID[data.continent][data.zoneid];
					end
					datalist[player].zoneid = nil;
					datalist[player].continent = nil;
				end
			end
		end
	end
end

--[[----------------------------------------------------------------------
	Import Functions
------------------------------------------------------------------------]]

local SKMZoneTranslate = {
	["KA_01"] = "Ashenvale",
	["KA_02"] = "Azshara",
	["KA_03"] = "Azuremyst Isle",
	["KA_04"] = "Bloodmyst Isle",
	["KA_05"] = "Darkshore",
	["KA_06"] = "Darnassus",
	["KA_07"] = "Desolace",
	["KA_08"] = "Durotar",
	["KA_09"] = "Dustwallow Marsh",
	["KA_10"] = "Felwood",
	["KA_11"] = "Feralas",
	["KA_12"] = "Moonglade",
	["KA_13"] = "Mulgore",
	["KA_14"] = "Orgrimmar",
	["KA_15"] = "Silithus",
	["KA_16"] = "Stonetalon Mountains",
	["KA_17"] = "Tanaris",
	["KA_18"] = "Teldrassil",
	["KA_19"] = "The Barrens",
	["KA_20"] = "The Exodar",
	["KA_21"] = "Thousand Needles",
	["KA_22"] = "Thunder Bluff",
	["KA_23"] = "Un'Goro Crater",
	["KA_24"] = "Winterspring",
	["EK_01"] = "Alterac Mountains",
	["EK_02"] = "Arathi Highlands",
	["EK_03"] = "Badlands",
	["EK_04"] = "Blasted Lands",
	["EK_05"] = "Burning Steppes",
	["EK_06"] = "Deadwind Pass",
	["EK_07"] = "Dun Morogh",
	["EK_08"] = "Duskwood",
	["EK_09"] = "Eastern Plaguelands",
	["EK_10"] = "Elwynn Forest",
	["EK_11"] = "Eversong Woods",
	["EK_12"] = "Ghostlands",
	["EK_13"] = "Hillsbrad Foothills",
	["EK_14"] = "Ironforge",
	["EK_15"] = "Loch Modan",
	["EK_16"] = "Redridge Mountains",
	["EK_17"] = "Searing Gorge",
	["EK_18"] = "Silvermoon City",
	["EK_19"] = "Silverpine Forest",
	["EK_20"] = "Stormwind City",
	["EK_21"] = "Stranglethorn Vale",
	["EK_22"] = "Swamp of Sorrows",
	["EK_23"] = "The Hinterlands",
	["EK_24"] = "Tirisfal Glades",
	["EK_25"] = "Undercity",
	["EK_26"] = "Western Plaguelands",
	["EK_27"] = "Westfall",
	["EK_28"] = "Wetlands",
	["OL_01"] = "Blade's Edge Mountains",
	["OL_02"] = "Hellfire Peninsula",
	["OL_03"] = "Nagrand",
	["OL_04"] = "Netherstorm",
	["OL_05"] = "Shadowmoon Valley",
	["OL_06"] = "Shattrath City",
	["OL_07"] = "Terokkar Forest",
	["OL_08"] = "Zangarmarsh",

	-- These are not defined in current skmap
	--["EK_29"] = "Isle of Quel'Danas",
	--["NR_01"] = "Borean Tundra",
	--["NR_02"] = "Crystalsong Forest",
	--["NR_03"] = "Dalaran",
	--["NR_04"] = "Dragonblight",
	--["NR_05"] = "Grizzly Hills",
	--["NR_06"] = "Howling Fjord",
	--["NR_07"] = "Icecrown",
	--["NR_08"] = "Sholazar Basin",
	--["NR_09"] = "The Storm Peaks",
	--["NR_10"] = "Wintergrasp",
	--["NR_11"] = "Zul'Drak",
};

local SKMRaceTranslate = {BR["Dwarf"], BR["Gnome"], BR["Human"], BR["Night Elf"], BR["Orc"], BR["Tauren"], BR["Troll"], BR["Undead"], BR["Draenei"], BR["Blood Elf"]};
local SKMClassTranslate = {"DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARRIOR", "WARLOCK"};

local function SKMGetZoneName(ZoI)
	if (ZoI ~= nil) then
		return SKMZoneTranslate[ZoI];
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
	if (not (posX and posY and zone and name and sktype and sktime)) then
		return 0;
	end

	VanasKoS:AddEntry("PVPLOG", name:lower(), { ['time'] = sktime,
					['myname'] = myname,
					['type'] = sktype,
					['zone']  = zone,
					['posX'] = posX,
					['posY'] = posY });
	return 1;
end

-- returns imported
local function importSKMapEnemyStats(player, enemy)
	local etable = assert(SKM_Data[GetRealmName()][player].EnemyHistory[enemy]);
	local pvpstats = VanasKoS:GetList("PVPSTATS", 1);
	local wins = tonumber(etable["PK"] or etable["playerKill"]) or 0;
	local bgwins = tonumber(etable["PbK"] or etable["playerBGKill"]) or 0;
	local losses = tonumber(etable["EKP"] or etable["enemyKillPlayer"]) or 0;
	local bglosses = tonumber(etable["EKb"] or etable["enemyKillBG"]) or 0;
	local name = etable["Na"] or etable["name"] or enemy;
	local lname = name:lower();

	if (wins + losses + bgwins + bglosses > 0) then
		if (not pvpstats[lname]) then
			pvpstats[lname] = {
				['wins'] = wins + bgwins,
				['losses'] = losses + bglosses,
				['bgwins'] = bgwins,
				['bglosses'] = bglosses,
			};
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
		local classEnglish = SKMClassTranslate[etable["Cl"] or etable["class"]];
		local class = LCM[classEnglish]
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
