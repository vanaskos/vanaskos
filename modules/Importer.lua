--[[----------------------------------------------------------------------
      Importer Module - Part of VanasKoS
Handles import of other AddOns KoS Data
------------------------------------------------------------------------]]
local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/Importer", false);

VanasKoSImporter = VanasKoS:NewModule("Importer", "AceEvent-3.0");

local hashName = VanasKoS.hashName
local hashGuild = VanasKoS.hashGuild
local splitNameRealm = VanasKoS.splitNameRealm

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
				desc = L["Imports Data from old VanasKoS (backup WTF first)"],
				func = function()
					VanasKoSImporter:FromOldVanasKoS()
				end
			},
		},
	});
end

function VanasKoSImporter:OnEnable()
end

function VanasKoSImporter:OnDisable()
end

local function splitFactionRealm(factionrealm)
	if not factionrealm then
		return nil, nil
	end

	local faction, realm
	local strSep = factionrealm:find(" - ")
	if strSep then
		faction = factionrealm:sub(1, strSep - 1)
		realm = factionrealm:sub(strSep + 3)
	end

	return faction, realm
end

function VanasKoSImporter:FromOldVanasKoS()
	local count = 0;

	if not VanasKoSDB.namespaces then
		return
	end

	if not VanasKoSDB.namespaces.PvPDataGatherer then
		VanasKoSDB.namespaces.PvPDataGatherer = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.global then
		VanasKoSDB.namespaces.PvPDataGatherer.global = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.global.pvpstats then
		VanasKoSDB.namespaces.PvPDataGatherer.global.pvpstats = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.global.pvpstats.pvplog then
		VanasKoSDB.namespaces.PvPDataGatherer.global.pvpstats.pvplog = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.global.pvpstats.pvplog.event then
		VanasKoSDB.namespaces.PvPDataGatherer.global.pvpstats.pvplog.event = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.global.pvpstats.pvplog.map then
		VanasKoSDB.namespaces.PvPDataGatherer.global.pvpstats.pvplog.map = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.global.pvpstats.pvplog.players then
		VanasKoSDB.namespaces.PvPDataGatherer.global.pvpstats.pvplog.players = {}
	end
	pvplog = VanasKoSDB.namespaces.PvPDataGatherer.global.pvpstats.pvplog

	count = 0
	if(VanasKoSDB and VanasKoSDB.namespaces and VanasKoSDB.namespaces.PvPDataGatherer and VanasKoSDB.namespaces.PvPDataGatherer.realm) then
		for realm,v in pairs(VanasKoSDB.namespaces.PvPDataGatherer.realm) do
			local oldlog = v.pvpstats and v.pvpstats.pvplog;
			if oldlog and oldlog.event then
				for eventkey,eventdata in pairs(oldlog.event) do
					pvplog[eventkey].name, pvplog[eventkey].realm = splitNameRealm(eventdata.enemyname)
					if not pvplog[eventkey].realm then
						pvplog[eventkey].realm = realm
					end
					pvplog[eventkey].enemylevel = eventdata.enemylevel
					pvplog[eventkey].myname = eventdata.name
					pvplog[eventkey].myrealm = realm
					pvplog[eventkey].mylevel = eventdata.mylevel
					pvplog[eventkey].time = eventdata.time
					pvplog[eventkey].type = eventdata.type
					-- pvplog[eventkey].mapID = convert(eventdata.areaID)
					-- pvplog[eventKey].x = data.posX,
					-- pvplog[eventKey].y = data.posY
					print("Imported " .. eventkey)
					oldlog[eventkey] = nil
				end
				oldlog.event = nil
			end
			if oldlog and oldlog.players then
				for playerFullName,eventkeyTable in pairs(oldlog.players) do
					local playerName, playerRealm = splitNameRealm(playerFullName)
					if not playerRealm then
						playerRealm = realm
					end
					local playerKey = hashName(playerName, playerRealm)
					pvplog[playerKey] = eventKeyTable
					print("Imported " .. playerKey)
					oldlog[playerFullName] = nil
				end
				oldlog.players = nil
			end

			if oldlog and oldlog.area then
				-- convert areas
				oldlog.area = nil
			end
		end
		VanasKoSDB.namespaces.PvPDataGatherer.realm = nil
	end
	if (count > 0) then
		VanasKoS:Print(format(L["Imported %d PvP events"], count));
	end

	if not VanasKoSDB.namespaces.DataGatherer then
		VanasKoSDB.namespaces.DataGatherer = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.global then
		VanasKoSDB.namespaces.DataGatherer.global = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.global.pvpstats then
		VanasKoSDB.namespaces.DataGatherer.global.pvpstats = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.global.players then
		VanasKoSDB.namespaces.DataGatherer.global.players = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.global.guilds then
		VanasKoSDB.namespaces.DataGatherer.global.guilds = {}
	end
	playerdata = VanasKoSDB.namespaces.DataGatherer.global.players
	guilddata = VanasKoSDB.namespaces.DataGatherer.global.guilds

	count = 0;
	if(VanasKoSDB and VanasKoSDB.namespaces and VanasKoSDB.namespaces.DataGatherer and VanasKoSDB.namespaces.DataGatherer.realm) then
		for realm,v in pairs(VanasKoSDB.namespaces.DataGatherer.realm) do
			if (v.players) then
				for fullPlayerName, olddata in pairs(v.players) do
					local playerName, playerRealm = splitNameRealm(fullPlayerName)
					if not playerRealm then
						playerRealm = realm
					end
					local playerKey = hashName(playerName, playerRealm)
					playerData[playerKey].name = playerName
					playerData[playerKey].realm = playerRealm
					playerData[playerKey].level = olddata.level
					playerData[playerKey].race = olddata.race
					playerData[playerKey].class = olddata.class
					playerData[playerKey].classEnglish = olddata.classEnglish
					playerData[playerKey].gender = olddata.gender
					playerData[playerKey].mapID = olddata.mapID
					playerData[playerKey].guid = olddata.guid
					oldData[fullPlayerName] = nil
				end
				v.players = nil
			end
		end
		VanasKoSDB.namespaces.DataGatherer.realm = nil
	end
	if (count > 0) then
		VanasKoS:Print(format(L["Imported %d player data"], count));
	end

	if not VanasKoSDB.namespaces.DefaultLists then
		VanasKoSDB.namespaces.DefaultLists = {}
	end
	if not VanasKoSDB.namespaces.DefaultLists.faction then
		VanasKoSDB.namespaces.DefaultLists.faction = {}
	end
	if not VanasKoSDB.namespaces.DefaultLists.faction.Alliance then
		VanasKoSDB.namespaces.DefaultLists.faction.Alliance = {}
	end
	if not VanasKoSDB.namespaces.DefaultLists.faction.Horde then
		VanasKoSDB.namespaces.DefaultLists.faction.Horde = {}
	end

	for _, faction in pairs({"Alliance", "Horde"}) do
		if not VanasKoSDB.namespaces.DefaultLists.faction[faction].nicelist then
			VanasKoSDB.namespaces.DefaultLists.faction[faction].nicelist = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.faction[faction].nicelist.players then
			VanasKoSDB.namespaces.DefaultLists.faction[faction].nicelist.players = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.faction[faction].hatelist then
			VanasKoSDB.namespaces.DefaultLists.faction[faction].hatelist = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.faction[faction].hatelist.players then
			VanasKoSDB.namespaces.DefaultLists.faction[faction].hatelist.players = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.faction[faction].koslist then
			VanasKoSDB.namespaces.DefaultLists.faction[faction].koslist = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.faction[faction].koslist.players then
			VanasKoSDB.namespaces.DefaultLists.faction[faction].koslist.players = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.faction[faction].koslist.guilds then
			VanasKoSDB.namespaces.DefaultLists.faction[faction].koslist.guilds = {}
		end
	end

	alliancelists = VanasKoSDB.namespaces.DefaultLists.faction.Alliance
	hordelists = VanasKoSDB.namespaces.DefaultLists.faction.Horde

	count = 0;
	if(VanasKoSDB and VanasKoSDB.namespaces and VanasKoSDB.namespaces.DefaultLists and VanasKoSDB.namespaces.DefaultLists.factionrealm) then
		for factionrealm, list in pairs(VanasKoSDB.namespaces.DefaultLists.factionrealm) do
			local faction, realm = splitFactionRealm(factionrealm)
			if list then
				for listname, listdata in pairs(list) do
					if listdata.players then
						for fullPlayerName, olddata in pairs(listdata.players) do
							local playerName, playerRealm = splitNameRealm(fullPlayerName)
							if not playerRealm then
								playerRealm = realm
							end
							local playerKey = hashName(playerName, playerRealm)
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].name = playerName
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].realm = playerRealm
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].created = olddata.created
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].creator = olddata.creator
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].creatorrealm = realm
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].owner = olddata.owner
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].ownerrealm = realm
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].reason = olddata.reason
							listdata[fullPlayerName] = nil
						end
						listdata.players = nil
					end
					if listdata.guilds then
						for fullGuildName, olddata in pairs(listdata.guilds) do
							local guild, guildRealm = splitNameRealm(fullGuildName)
							local guildKey = hashGuild(guild, guildRealm)
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].name = guild
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].created = olddata.created
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].creator = olddata.creator
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].creatorrealm = realm
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].owner = olddata.owner
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].ownerrealm = realm
							VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].reason = olddata.reason
							listdata[fullGuildName] = nil
						end
						listdata.guilds = nil
					end
				end
			end
		end
		VanasKoSDB.namespaces.DefaultLists.factionrealm = nil
	end
	if (count > 0) then
		VanasKoS:Print(format(L["Imported %d list entries"], count));
	end

	if VanasKoSDB.namespaces.Synchronizer and VanasKoSDB.namespaces.Synchronizer.factionrealm then
		-- Just erase the old data
		VanasKoSDB.namespaces.Synchronizer.factionrealm = nil
	end
end
