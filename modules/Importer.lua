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
	local invalid = 0;

	if not VanasKoSDB.namespaces then
		return
	end

	if not VanasKoSDB.namespaces.PvPDataGatherer then
		VanasKoSDB.namespaces.PvPDataGatherer = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.global then
		VanasKoSDB.namespaces.PvPDataGatherer.global = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.global.pvplog then
		VanasKoSDB.namespaces.PvPDataGatherer.global.pvplog = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.global.pvplog.event then
		VanasKoSDB.namespaces.PvPDataGatherer.global.pvplog.event = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.global.pvplog.map then
		VanasKoSDB.namespaces.PvPDataGatherer.global.pvplog.map = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.global.pvplog.players then
		VanasKoSDB.namespaces.PvPDataGatherer.global.pvplog.players = {}
	end
	local pvplog = VanasKoSDB.namespaces.PvPDataGatherer.global.pvplog

	count = 0
	invalid = 0
	if(VanasKoSDB and VanasKoSDB.namespaces and VanasKoSDB.namespaces.PvPDataGatherer and VanasKoSDB.namespaces.PvPDataGatherer.realm) then
		for realm,v in pairs(VanasKoSDB.namespaces.PvPDataGatherer.realm) do
			local oldlog = v.pvpstats and v.pvpstats.pvplog;
			if oldlog and oldlog.event then
				for eventkey,eventdata in pairs(oldlog.event) do
					if not pvplog.event[eventkey] then
						pvplog.event[eventkey] = {}
					end
					pvplog.event[eventkey].name, pvplog.event[eventkey].realm = splitNameRealm(eventdata.enemyname)
					if not pvplog.event[eventkey].realm then
						pvplog.event[eventkey].realm = realm
					end
					pvplog.event[eventkey].enemylevel = eventdata.enemylevel
					pvplog.event[eventkey].myname = eventdata.myname
					pvplog.event[eventkey].myrealm = realm
					pvplog.event[eventkey].mylevel = eventdata.mylevel
					pvplog.event[eventkey].time = eventdata.time
					pvplog.event[eventkey].type = eventdata.type
					-- pvplog.event[eventkey].mapID = convert(eventdata.areaID)
					-- pvplog.event[eventKey].x = data.posX,
					-- pvplog.event[eventKey].y = data.posY
					count = count + 1
					oldlog[eventkey] = nil
				end
				oldlog.event = nil
			end
			if oldlog and oldlog.player then
				for playerFullName,eventkeyTable in pairs(oldlog.player) do
					local playerName, playerRealm = splitNameRealm(playerFullName)
					if not playerRealm then
						playerRealm = realm
					end
					local playerKey = hashName(playerName, playerRealm)
					pvplog.players[playerKey] = eventKeyTable
					count = count + 1
					oldlog[playerFullName] = nil
				end
				oldlog.player = nil
			end

			if oldlog and oldlog.area then
				-- convert areas
				oldlog.area = nil
			end
		end
		VanasKoSDB.namespaces.PvPDataGatherer.realm = nil
	end
	if (count > 0) then
		VanasKoS:Print(format(L["Imported %d PVP events"], count))
	end
	if (invalid > 0) then
		VanasKoS:Print(format("%d invalid entries skipped", invalid))
	end

	if not VanasKoSDB.namespaces.DataGatherer then
		VanasKoSDB.namespaces.DataGatherer = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.global then
		VanasKoSDB.namespaces.DataGatherer.global = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.global.data then
		VanasKoSDB.namespaces.DataGatherer.global.data = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.global.data.players then
		VanasKoSDB.namespaces.DataGatherer.global.data.players = {}
	end
	local playerData = VanasKoSDB.namespaces.DataGatherer.global.data.players

	count = 0;
	invalid = 0
	if(VanasKoSDB and VanasKoSDB.namespaces and VanasKoSDB.namespaces.DataGatherer and VanasKoSDB.namespaces.DataGatherer.realm) then
		for realm,v in pairs(VanasKoSDB.namespaces.DataGatherer.realm) do
			if (v.players) then
				for fullPlayerName, olddata in pairs(v.players) do
					local playerName, playerRealm = splitNameRealm(fullPlayerName)
					if not playerRealm then
						playerRealm = realm
					end
					local playerKey = hashName(playerName, playerRealm)
					if not playerData[playerKey] then
						playerData[playerKey] = {}
					end
					playerData[playerKey].name = playerName
					playerData[playerKey].realm = playerRealm
					playerData[playerKey].level = olddata.level
					playerData[playerKey].race = olddata.race
					playerData[playerKey].class = olddata.class
					playerData[playerKey].classEnglish = olddata.classEnglish
					playerData[playerKey].gender = olddata.gender
					playerData[playerKey].mapID = olddata.mapID
					playerData[playerKey].guid = olddata.guid
					count = count + 1
					olddata[fullPlayerName] = nil
				end
				v.players = nil
			end
		end
		VanasKoSDB.namespaces.DataGatherer.realm = nil
	end
	if (count > 0) then
		VanasKoS:Print(format(L["Imported %d player data"], count));
	end
	if (invalid > 0) then
		VanasKoS:Print(format("%d invalid entries skipped", invalid))
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

	count = 0;
	invalid = 0
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
							if playerKey then
								if not VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey] then
									VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey] = {}
								end
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].name = playerName
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].realm = playerRealm
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].created = olddata.created
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].creator = olddata.creator
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].creatorrealm = realm
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].owner = olddata.owner
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].ownerrealm = realm
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].players[playerKey].reason = olddata.reason
								count = count + 1
							else
								invalid = invalid + 1
							end
							listdata[fullPlayerName] = nil
						end
						listdata.players = nil
					end
					if listdata.guilds then
						for fullGuildName, olddata in pairs(listdata.guilds) do
							local guild, guildRealm = splitNameRealm(fullGuildName)
							local guildKey = hashGuild(guild, guildRealm)
							if guildKey then
								if not VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey] then
									VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey] = {}
								end
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].name = guild
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].created = olddata.created
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].creator = olddata.creator
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].creatorrealm = realm
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].owner = olddata.owner
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].ownerrealm = realm
								VanasKoSDB.namespaces.DefaultLists.faction[faction][listname].guilds[guildKey].reason = olddata.reason
							else
								invalid = invalid + 1
							end
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
		VanasKoS:Print(format(L["Imported %d list entries"], count))
	end
	if (invalid > 0) then
		VanasKoS:Print(format("%d invalid entries skipped", invalid))
	end

	if VanasKoSDB.namespaces.Synchronizer and VanasKoSDB.namespaces.Synchronizer.factionrealm then
		-- Just erase the old data
		VanasKoSDB.namespaces.Synchronizer.factionrealm = nil
	end
end

-- /script VanasKoSImporter:AddTestData()
function VanasKoSImporter:AddTestData()
	if not VanasKoSDB then
		VanasKoSDB = {}
	end
	if not VanasKoSDB.namespaces then
		VanasKoSDB.namespaces = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer then
		VanasKoSDB.namespaces.PvPDataGatherer = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm then
		VanasKoSDB.namespaces.PvPDataGatherer.realm = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"] then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"] = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"] then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"] = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"].pvpstats then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"].pvpstats = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"].pvpstats.pvplog then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"].pvpstats.pvplog = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"].pvpstats.pvplog.event then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"].pvpstats.pvplog.event = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"].pvpstats.pvplog.area then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"].pvpstats.pvplog.area = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"].pvpstats.pvplog.player then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"].pvpstats.pvplog.player = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"].pvpstats then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"].pvpstats = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"].pvpstats.pvplog then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"].pvpstats.pvplog = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"].pvpstats.pvplog.event then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"].pvpstats.pvplog.event = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"].pvpstats.pvplog.area then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"].pvpstats.pvplog.area = {}
	end
	if not VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"].pvpstats.pvplog.player then
		VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"].pvpstats.pvplog.player = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer then
		VanasKoSDB.namespaces.DataGatherer = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.realm then
		VanasKoSDB.namespaces.DataGatherer.realm = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 1"] then
		VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 1"] = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 1"].players then
		VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 1"].players = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"] then
		VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"] = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"].players then
		VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"].players = {}
	end
	if not VanasKoSDB.namespaces.DefaultLists then
		VanasKoSDB.namespaces.DefaultLists = {}
	end
	if not VanasKoSDB.namespaces.DefaultLists.factionrealm then
		VanasKoSDB.namespaces.DefaultLists.factionrealm = {}
	end
	for _, factionrealm in pairs({"Alliance - Test Realm 1", "Horde - Test Realm 1", "Alliance - Test Realm 2", "Horde - Test Realm 2"}) do
		if not VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm] then
			VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm] = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].nicelist then
			VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].nicelist = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].nicelist.players then
			VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].nicelist.players = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].hatelist then
			VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].hatelist = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].hatelist.players then
			VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].hatelist.players = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].koslist then
			VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].koslist = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].koslist.players then
			VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].koslist.players = {}
		end
		if not VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].koslist.guilds then
			VanasKoSDB.namespaces.DefaultLists.factionrealm[factionrealm].koslist.guilds = {}
		end
	end
	local pvplog1 = VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 1"].pvpstats.pvplog
	local pvplog2 = VanasKoSDB.namespaces.PvPDataGatherer.realm["Test Realm 2"].pvpstats.pvplog
	local playerdata1 = VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 1"].players
	local playerdata2 = VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"].players
	local nicelist1 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Alliance - Test Realm 1"].nicelist.players
	local nicelist2 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Horde - Test Realm 1"].nicelist.players
	local nicelist3 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Alliance - Test Realm 2"].nicelist.players
	local nicelist4 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Horde - Test Realm 2"].nicelist.players
	local hatelist1 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Alliance - Test Realm 1"].hatelist.players
	local hatelist2 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Horde - Test Realm 1"].hatelist.players
	local hatelist3 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Alliance - Test Realm 2"].hatelist.players
	local hatelist4 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Horde - Test Realm 2"].hatelist.players
	local kos1 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Alliance - Test Realm 1"].koslist.players
	local kos2 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Horde - Test Realm 1"].koslist.players
	local kos3 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Alliance - Test Realm 2"].koslist.players
	local kos4 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Horde - Test Realm 2"].koslist.players
	local gkos1 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Alliance - Test Realm 1"].koslist.guilds
	local gkos2 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Horde - Test Realm 1"].koslist.guilds
	local gkos3 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Alliance - Test Realm 2"].koslist.guilds
	local gkos4 = VanasKoSDB.namespaces.DefaultLists.factionrealm["Horde - Test Realm 2"].koslist.guilds

	for i=1,100 do
		for j=1,10 do
			local name = "test" .. i
			local realm = "some random realm"
			local playerkey = name .. "-" .. realm
			local eventkey = playerkey.."-"..math.floor(math.random()*10000000)
			local areaID=math.floor(math.random()*100)
			pvplog1.event[eventkey] = {
				enemyname=playerkey,
				time=time(),
				myname="bob",
				mylevel=15,
				enemylevel=16,
				areaID=areaID,
				type="win",
				posX=math.random(),
				posY=math.random()
			}
			if not pvplog1.player[playerkey] then
				pvplog1.player[playerkey] = {}
			end
			tinsert(pvplog1.player[playerkey], eventkey)
			if not pvplog1.area[areaID] then
				pvplog1.area[areaID] = {}
			end
			tinsert(pvplog1.area[areaID], eventkey)
			local eventkey = playerkey.."-"..math.floor(math.random()*10000000)
			local areaID=math.floor(math.random()*100)
			pvplog2.event[eventkey] = {
				enemyname=playerkey,
				time=time(),
				myname="bob",
				mylevel=15,
				enemylevel=16,
				areaID=areaID,
				type="win",
				posX=math.random(),
				posY=math.random()
			}
			if not pvplog2.player[playerkey] then
				pvplog2.player[playerkey] = {}
			end
			tinsert(pvplog2.player[playerkey], eventkey)
			if not pvplog2.area[areaID] then
				pvplog2.area[areaID] = {}
			end
			tinsert(pvplog2.area[areaID], eventkey)

			if not playerdata1[playerkey] then
				playerdata1[playerkey] = {}
			end
			playerdata1[playerkey] = {
				level = math.floor(math.random()*120),
				race = "Human",
				class = "Mage",
				classEnglish = "Mage",
				gender = "Female",
				mapID = areaID,
				guid = "Player-"..math.floor(math.random()*100000)
			}
			playerdata2[playerkey] = {
				level = math.floor(math.random()*120),
				race = "Human",
				class = "Mage",
				classEnglish = "Mage",
				gender = "Female",
				mapID = areaID,
				guid = "Player-"..math.floor(math.random()*100000)
			}
		end
	end
	for i=1,50 do
		local name = "test" .. i
		local playerkey = name
		local eventkey = playerkey.."-"..math.floor(math.random()*10000000)
		local areaID=math.floor(math.random()*100)
		pvplog1.event[eventkey] = {
			enemyname=playerkey,
			time=time(),
			myname="bob",
			mylevel=15,
			enemylevel=16,
			areaID=areaID,
			type="win",
			posX=math.random(),
			posY=math.random()
		}
		if not pvplog1.player[playerkey] then
			pvplog1.player[playerkey] = {}
		end
		tinsert(pvplog1.player[playerkey], eventkey)
		if not pvplog2.area[areaID] then
			pvplog2.area[areaID] = {}
		end
		tinsert(pvplog2.area[areaID], eventkey)
		local eventkey = playerkey.."-"..math.floor(math.random()*10000000)
		local areaID=math.floor(math.random()*100)
		pvplog2.event[eventkey] = {
			enemyname=playerkey,
			time=time(),
			myname="bob",
			mylevel=15,
			enemylevel=16,
			areaID=areaID,
			type="win",
			posX=math.random(),
			posY=math.random()
		}
		if not pvplog2.player[playerkey] then
			pvplog2.player[playerkey] = {}
		end
		tinsert(pvplog2.player[playerkey], eventkey)
		if not pvplog2.area[areaID] then
			pvplog2.area[areaID] = {}
		end
		tinsert(pvplog2.area[areaID], eventkey)
		playerdata1[playerkey] = {
			level = math.floor(math.random()*120),
			race = "Human",
			class = "Mage",
			classEnglish = "Mage",
			gender = "Female",
			mapID = areaID,
			guid = "Player-"..math.floor(math.random()*100000)
		}
		playerdata2[playerkey] = {
			level = math.floor(math.random()*120),
			race = "Human",
			class = "Mage",
			classEnglish = "Mage",
			gender = "Female",
			mapID = areaID,
			guid = "Player-"..math.floor(math.random()*100000)
		}
	end

	for i=1,10 do
		local testdata = {
			creator="bob",
			owner="sally",
			reason="test reason "..i
		}
		nicelist1["nice1test" .. i] = testdata
		nicelist2["nice2test" .. i] = testdata
		nicelist3["nice3test" .. i] = testdata
		nicelist4["nice4test" .. i] = testdata
		nicelist1["nice1test" .. i .. "-Realm W"] = testdata
		nicelist2["nice2test" .. i .. "-Realm X"] = testdata
		nicelist3["nice3test" .. i .. "-Realm Y"] = testdata
		nicelist4["nice4test" .. i .. "-Realm Z"] = testdata
		hatelist1["hate1test" .. i] = testdata
		hatelist2["hate2test" .. i] = testdata
		hatelist3["hate3test" .. i] = testdata
		hatelist4["hate4test" .. i] = testdata
		hatelist1["hate1test" .. i .. "-Realm W"] = testdata
		hatelist2["hate2test" .. i .. "-Realm X"] = testdata
		hatelist3["hate3test" .. i .. "-Realm Y"] = testdata
		hatelist4["hate4test" .. i .. "-Realm Z"] = testdata
		kos1["kos1test" .. i] = testdata
		kos2["kos2test" .. i] = testdata
		kos3["kos3test" .. i] = testdata
		kos4["kos4test" .. i] = testdata
		kos1["kos1test" .. i .. "-Realm W"] = testdata
		kos2["kos2test" .. i .. "-Realm X"] = testdata
		kos3["kos3test" .. i .. "-Realm Y"] = testdata
		kos4["kos4test" .. i .. "-Realm Z"] = testdata
		gkos1["gkos1test" .. i] = testdata
		gkos2["gkos2test" .. i] = testdata
		gkos3["gkos3test" .. i] = testdata
		gkos4["gkos4test" .. i] = testdata
		gkos1["gkos1test" .. i .. "-Realm W"] = testdata
		gkos2["gkos2test" .. i .. "-Realm X"] = testdata
		gkos3["gkos3test" .. i .. "-Realm Y"] = testdata
		gkos4["gkos4test" .. i .. "-Realm Z"] = testdata
	end
end
