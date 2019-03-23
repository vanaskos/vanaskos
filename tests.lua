-- /script VanasKoSAddOldTestData()
-- For testing importer
function VanasKoSAddOldTestData()
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
	if not VanasKoSDB.namespaces.PvPStats then
		VanasKoSDB.namespaces.PvPStats = {}
	end
	if not VanasKoSDB.namespaces.PvPStats.realm then
		VanasKoSDB.namespaces.PvPStats.realm = {}
	end
	if not VanasKoSDB.namespaces.PvPStats.realm["Test Realm 1"] then
		VanasKoSDB.namespaces.PvPStats.realm["Test Realm 1"] = {}
	end
	if not VanasKoSDB.namespaces.PvPStats.realm["Test Realm 1"].pvpstats then
		VanasKoSDB.namespaces.PvPStats.realm["Test Realm 1"].pvpstats = {}
	end
	if not VanasKoSDB.namespaces.PvPStats.realm["Test Realm 1"].pvpstats.players then
		VanasKoSDB.namespaces.PvPStats.realm["Test Realm 1"].pvpstats.players = {}
	end
	if not VanasKoSDB.namespaces.PvPStats.realm["Test Realm 2"] then
		VanasKoSDB.namespaces.PvPStats.realm["Test Realm 2"] = {}
	end
	if not VanasKoSDB.namespaces.PvPStats.realm["Test Realm 2"].pvpstats then
		VanasKoSDB.namespaces.PvPStats.realm["Test Realm 2"].pvpstats = {}
	end
	if not VanasKoSDB.namespaces.PvPStats.realm["Test Realm 2"].pvpstats.players then
		VanasKoSDB.namespaces.PvPStats.realm["Test Realm 2"].pvpstats.players = {}
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
	if not VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 1"].data then
		VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 1"].data = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 1"].data.players then
		VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 1"].data.players = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"] then
		VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"] = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"].data then
		VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"].data = {}
	end
	if not VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"].data.players then
		VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"].data.players = {}
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
	local pvpstats = VanasKoSDB.namespaces.PvPStats.realm["Test Realm 1"].pvpstats.players
	local pvpstats = VanasKoSDB.namespaces.PvPStats.realm["Test Realm 2"].pvpstats.players
	local playerdata1 = VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 1"].data.players
	local playerdata2 = VanasKoSDB.namespaces.DataGatherer.realm["Test Realm 2"].data.players
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
			local playerKey = name .. "-" .. realm
			local eventKey = playerKey.."-"..math.floor(math.random()*10000000)
			local areaID=math.floor(math.random()*1220)
			pvplog1.event[eventKey] = {
				enemyname=playerKey,
				time=time(),
				myname="bob",
				mylevel=15,
				enemylevel=16,
				areaID=areaID,
				type="win",
				posX=math.random(),
				posY=math.random()
			}
			if not pvplog1.player[playerKey] then
				pvplog1.player[playerKey] = {}
			end
			tinsert(pvplog1.player[playerKey], eventKey)
			if not pvplog1.area[areaID] then
				pvplog1.area[areaID] = {}
			end
			tinsert(pvplog1.area[areaID], eventKey)
			local eventKey = playerKey.."-"..math.floor(math.random()*10000000)
			local areaID=math.floor(math.random()*1220)
			pvplog2.event[eventKey] = {
				enemyname=playerKey,
				time=time(),
				myname="bob",
				mylevel=15,
				enemylevel=16,
				areaID=areaID,
				type="win",
				posX=math.random(),
				posY=math.random()
			}
			if not pvplog2.player[playerKey] then
				pvplog2.player[playerKey] = {}
			end
			tinsert(pvplog2.player[playerKey], eventKey)
			if not pvplog2.area[areaID] then
				pvplog2.area[areaID] = {}
			end
			tinsert(pvplog2.area[areaID], eventKey)

			if not playerdata1[playerKey] then
				playerdata1[playerKey] = {}
			end
			playerdata1[playerKey] = {
				level = math.floor(math.random()*120),
				race = "Human",
				class = "Mage",
				classEnglish = "Mage",
				gender = "Female",
				areaID = areaID,
				guid = "Player-"..math.floor(math.random()*100000)
			}
			playerdata2[playerKey] = {
				level = math.floor(math.random()*120),
				race = "Human",
				class = "Mage",
				classEnglish = "Mage",
				gender = "Female",
				areaID = areaID,
				guid = "Player-"..math.floor(math.random()*100000)
			}
		end
	end
	for i=1,50 do
		local name = "test" .. i
		local playerKey = name
		local eventKey = playerKey.."-"..math.floor(math.random()*10000000)
		local areaID=math.floor(math.random()*1220)
		pvplog1.event[eventKey] = {
			enemyname=playerKey,
			time=time(),
			myname="bob",
			mylevel=15,
			enemylevel=16,
			areaID=areaID,
			type="win",
			posX=math.random(),
			posY=math.random()
		}
		if not pvplog1.player[playerKey] then
			pvplog1.player[playerKey] = {}
		end
		tinsert(pvplog1.player[playerKey], eventKey)
		if not pvplog2.area[areaID] then
			pvplog2.area[areaID] = {}
		end
		tinsert(pvplog2.area[areaID], eventKey)
		local eventKey = playerKey.."-"..math.floor(math.random()*10000000)
		local areaID=math.floor(math.random()*1220)
		pvplog2.event[eventKey] = {
			enemyname=playerKey,
			time=time(),
			myname="bob",
			mylevel=15,
			enemylevel=16,
			areaID=areaID,
			type="win",
			posX=math.random(),
			posY=math.random()
		}
		if not pvplog2.player[playerKey] then
			pvplog2.player[playerKey] = {}
		end
		tinsert(pvplog2.player[playerKey], eventKey)
		if not pvplog2.area[areaID] then
			pvplog2.area[areaID] = {}
		end
		tinsert(pvplog2.area[areaID], eventKey)
		playerdata1[playerKey] = {
			level = math.floor(math.random()*120),
			race = "Human",
			class = "Mage",
			classEnglish = "Mage",
			gender = "Female",
			mapID = areaID,
			guid = "Player-"..math.floor(math.random()*100000)
		}
		playerdata2[playerKey] = {
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
		pvpstats["name" .. i .. "-arealm"] = {
			wins = math.random() * 10 + 1,
			losses = math.random() * 10 + 1,
			ffawins = math.random() * 10 + 1,
			combatwins = math.random() * 10 + 1,
			arenawins = math.random() * 10 + 1,
			bgwins = math.random() * 10 + 1,
			ffalosses = math.random() * 10 + 1,
			combatlosses = math.random() * 10 + 1,
			arenalosses = math.random() * 10 + 1,
			bglosses = math.random() * 10 + 1
		}
		pvpstats["realmlessguy" .. i] = {
			wins = math.random() * 10 + 1,
			losses = math.random() * 10 + 1,
			ffawins = math.random() * 10 + 1,
			combatwins = math.random() * 10 + 1,
			arenawins = math.random() * 10 + 1,
			bgwins = math.random() * 10 + 1,
			ffalosses = math.random() * 10 + 1,
			combatlosses = math.random() * 10 + 1,
			arenalosses = math.random() * 10 + 1,
			bglosses = math.random() * 10 + 1
		}
	end
end

-- /script VanasKoSPvPDataGatherer:AddTestData(100)
-- For testing data gathering
function VanasKoSAddPvPTestData(cnt)
	for i=1,cnt do
		local name = "test" .. i
		local realm = "some random realm"
		local key = hashName(name, realm)
		VanasKoS:SendMessage("VanasKoS_Player_Detected", {
			name=name,
			realm=realm,
			guild="Evil is us",
			guildRank="Recruit",
			faction = "Alliance",
			mapID = C_Map.GetBestMapForUnit("player"),
			class = "Tank",
			classEnglish = "Warrior",
			race = "Gerbil",
			raceEnglish = "Gnome",
			gender = FEMALE,
			guid = "Player-XXXXXXXX",
		})
		local special = math.random()
		VanasKoS:AddEntry("PVPLOG", key, {
			name=name,
			realm=realm,
			time=time(),
			myname="bob",
			myrealm="the good one",
			mylevel=15,
			enemylevel=16,
			mapID=C_Map.GetBestMapForUnit("player"),
			type=math.random() > 0.5 and "win" or "loss",
			x=math.random(),
			y=math.random(),
			inBg = special < 0.2,
			inArena = special >= 0.2 and special < 0.4,
			inCombatZone = special >=0.4 and special < 0.6,
			inFfa = special >= 0.6 and special < 0.8
		})
	end
end
