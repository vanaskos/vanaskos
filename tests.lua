-- /script VanasKoSPvPDataGatherer:AddTestData(100)
-- For testing data gathering
function VanasKoSAddPvPTestData(cnt)
	for i=1,cnt do
		local name = "test" .. i
		VanasKoS:SendMessage("VanasKoS_Player_Detected", {
			name=name,
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
		VanasKoS:AddEntry("PVPLOG", name, {
			name=name,
			time=time(),
			myname="bob",
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
