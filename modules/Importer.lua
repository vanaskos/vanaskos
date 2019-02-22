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
	if(VanasKoSDB.namespaces.PvPDataGatherer.realm) then
		for realm,v in pairs(VanasKoSDB.namespaces.PvPDataGatherer.realm) do
			local oldlog = v.pvpstats and v.pvpstats.pvplog;
			if oldlog and oldlog.event then
				for eventKey,eventdata in pairs(oldlog.event) do
					if not pvplog.event[eventKey] then
						pvplog.event[eventKey] = {}
					end
					pvplog.event[eventKey].name, pvplog.event[eventKey].realm = splitNameRealm(eventdata.enemyname)
					if not pvplog.event[eventKey].realm then
						pvplog.event[eventKey].realm = realm
					end
					pvplog.event[eventKey].enemylevel = eventdata.enemylevel
					pvplog.event[eventKey].myname = eventdata.myname
					pvplog.event[eventKey].myrealm = realm
					pvplog.event[eventKey].mylevel = eventdata.mylevel
					pvplog.event[eventKey].time = eventdata.time
					pvplog.event[eventKey].type = eventdata.type
					-- pvplog.event[eventKey].mapID = convert(eventdata.areaID)
					-- pvplog.event[eventKey].x = data.posX,
					-- pvplog.event[eventKey].y = data.posY
					count = count + 1
					oldlog[eventKey] = nil
				end
				oldlog.event = nil
			end
			if oldlog and oldlog.player then
				for playerFullName,eventKeyTable in pairs(oldlog.player) do
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
	if (VanasKoSDB.namespaces.DataGatherer.realm) then
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
	if(VanasKoSDB.namespaces.DefaultLists.factionrealm) then
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

	count = 0
	invalid = 0
	local eventId = 1
	if(VanasKoSDB.namespaces.PvPStats and VanasKoSDB.namespaces.PvPStats.global and VanasKoSDB.namespaces.PvPStats.global.pvpstats and VanasKoSDB.namespaces.PvPStats.global.pvpstats.players) then
		local pvpStats = VanasKoSDB.namespaces.PvPStats.global.pvpstats.players
		for playerFullName, statData in pairs(pvpStats) do
			local playerName, playerRealm = splitNameRealm(playerFullName)
			if not playerRealm then
				playerRealm = L["unknown"]
			end
			local playerKey = hashName(playerName, playerRealm)
			if not pvplog.players[playerKey] then
				pvplog.players[playerKey] = {}
			end
			local wins = 0
			local losses = 0
			local ffawins = 0
			local combatwins = 0
			local arenawins = 0
			local bgwins = 0
			local ffalosses = 0
			local combatlosses = 0
			local arenalosses = 0
			local bglosses = 0

			print("Converting PvP stats for " .. playerKey)
			for i, eventKey in pairs(pvplog.players[playerKey]) do
				local event = pvplog.event[eventKey]
				if event and event.type == "win" then
					wins = wins + 1
					if event.inBg then
						bgwins = bgwins + 1
					end
					if event.inArena then
						arenawins = arenawins + 1
					end
					if event.inCombatZone then
						combatwins = combatwins + 1
					end
					if event.inFfa then
						ffawins = ffawins + 1
					end
				elseif event and event.type == "loss" then
					losses = losses + 1
					if event.inBg then
						bglosses = bglosses + 1
					end
					if event.inArena then
						arenalosses = arenalosses + 1
					end
					if event.inCombatZone then
						combatlosses = combatlosses + 1
					end
					if event.inFfa then
						ffalosses = ffalosses + 1
					end
				end
			end

			wins = statData.wins - wins
			ffawins = statData.ffawins - ffawins
			combatwins = statData.combatwins - combatwins
			arenawins = statData.arenawins - arenawins
			bgwins = statData.bgwins - bgwins
			losses = statData.losses - losses
			ffalosses = statData.ffalosses - ffalosses
			combatlosses = statData.combatlosses - combatlosses
			arenalosses = statData.arenalosses - arenalosses
			bglosses = statData.bglosses - bglosses

			if wins > 0 then
				for i=1,wins do
					local eventKey = "pvpstatimport-" .. eventId
					eventId = eventId + 1
					print("Adding PvP win event " .. eventKey)
					pvplog.event[eventKey] = {
						name = playerName,
						realm = playerRealm,
						type = "win"
					}
					if bgwins > 1 then
						pvplog.event[eventKey].inBg = true
						bgwins = bgwins - 1
					elseif arenawins > 1 then
						pvplog.event[eventKey].inArena = true
						arenawins = arenawins - 1
					elseif combatwins > 1 then
						pvplog.event[eventKey].inCombatZone = true
						combatwins = combatwins - 1
					elseif ffawins > 1 then
						pvplog.event[eventKey].inFfa = true
						combatwins = combatwins - 1
					end
					tinsert(pvplog.players[playerKey], eventKey)
				end
			end
			if losses > 0 then
				for i=1,losses do
					local eventKey = "pvpstatimport-" .. eventId
					eventId = eventId + 1
					print("Adding PvP loss evnt " .. eventKey)
					pvplog.event[eventKey] = {
						name = playerName,
						realm = playerRealm,
						type = "loss"
					}
					if bglosses > 1 then
						pvplog.event[eventKey].inBg = true
						bglosses = bglosses - 1
					elseif arenalosses > 1 then
						pvplog.event[eventKey].inArena = true
						arenalosses = arenalosses - 1
					elseif combatlosses > 1 then
						pvplog.event[eventKey].inCombatZone = true
						combatlosses = combatlosses - 1
					elseif ffalosses > 1 then
						pvplog.event[eventKey].inFfa = true
						combatlosses = combatlosses - 1
					end
					tinsert(pvplog.players[playerKey], eventKey)
				end
			end

			-- Add flags to already existing wins if the counts don't add up
			if ffawins + combatwins + arenawins + bgwins + ffalosses + combatlosses + arenalosses + bglosses > 0 then
				for i, eventKey in pairs(pvplog.players[playerKey]) do
					local event = pvplog.event[eventKey]
					if event and not (event.mapId or event.inBg or event.inArena or event.inCombatZone or event.inFfa) then
						if event.type == "win" then
							if bgwins > 1 then
								event.inBg = true
								bgwins = bgwins - 1
							elseif arenawins > 1 then
								event.inArena = true
								arenawins = arenawins - 1
							elseif combatwins > 1 then
								event.inCombatZone = true
								combatwins = combatwins - 1
							elseif ffawins > 1 then
								event.inFfa = true
								combatwins = combatwins - 1
							end
						elseif event.type == "loss" then
							if bglossess > 1 then
								event.inBg = true
								bglossess = bglossess - 1
							elseif arenalossess > 1 then
								event.inArena = true
								arenalossess = arenalossess - 1
							elseif combatlossess > 1 then
								event.inCombatZone = true
								combatlossess = combatlossess - 1
							elseif ffalosses > 1 then
								event.inFfa = true
								combatlossess = combatlossess - 1
							end
						end
					end
				end
			end
			count = count + 1
			pvpStats[playerFullName] = nil
		end
		VanasKoSDB.namespaces.PvPStats.global = nil
	end

	if (count > 0) then
		VanasKoS:Print(format(L["Converted %d PvP stats to %d PvP log events"], count, eventId))
	end
	if (invalid > 0) then
		VanasKoS:Print(format("%d invalid PvP stats skipped", invalid))
	end
end
