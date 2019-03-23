--[[----------------------------------------------------------------------
      Importer Module - Part of VanasKoS
Handles import of other AddOns KoS Data
------------------------------------------------------------------------]]
local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/Importer", false);

VanasKoSImporter = VanasKoS:NewModule("Importer", "AceEvent-3.0");

local hashName = VanasKoS.hashName
local hashGuild = VanasKoS.hashGuild
local splitNameRealm = VanasKoS.splitNameRealm

-- This data was taken for HereBeDragons, glad they did the hard work here
-- I'll just trust their data is correct...
local areaIdToUiMapId = {
    [4]    = 1,
    [9]    = 7,
    [11]   = 10,
    [13]   = 12,
    [14]   = 13,
    [16]   = 14,
    [17]   = 16,
    [19]   = 17,
    [20]   = 18,
    [21]   = 21,
    [22]   = 22,
    [23]   = 23,
    [24]   = 25,
    [26]   = 26,
    [27]   = 28,
    [28]   = 32,
    [29]   = 36,
    [30]   = 38,
    [32]   = 42,
    [34]   = 47,
    [35]   = 48,
    [36]   = 49,
    [37]   = 50,
    [38]   = 51,
    [39]   = 52,
    [40]   = 56,
    [41]   = 58,
    [42]   = 62,
    [43]   = 63,
    [61]   = 64,
    [81]   = 65,
    [101]  = 66,
    [121]  = 69,
    [141]  = 70,
    [161]  = 71,
    [181]  = 76,
    [182]  = 77,
    [201]  = 78,
    [241]  = 80,
    [261]  = 81,
    [281]  = 83,
    [301]  = 84,
    [321]  = 86,
    [341]  = 87,
    [362]  = 88,
    [381]  = 89,
    [382]  = 998,
    [401]  = 91,
    [443]  = 92,
    [461]  = 93,
    [462]  = 94,
    [463]  = 96,
    [464]  = 97,
    [465]  = 100,
    [466]  = 101,
    [467]  = 102,
    [471]  = 103,
    [473]  = 104,
    [475]  = 105,
    [476]  = 106,
    [477]  = 107,
    [478]  = 108,
    [479]  = 109,
    [480]  = 110,
    [481]  = 111,
    [482]  = 112,
    [485]  = 113,
    [486]  = 114,
    [488]  = 115,
    [490]  = 116,
    [491]  = 117,
    [492]  = 118,
    [493]  = 119,
    [495]  = 120,
    [496]  = 121,
    [499]  = 122,
    [501]  = 123,
    [502]  = 124,
    [504]  = 125,
    [510]  = 127,
    [512]  = 128,
    [520]  = 129,
    [521]  = 131,
    [522]  = 132,
    [523]  = 133,
    [524]  = 136,
    [525]  = 138,
    [526]  = 140,
    [527]  = 141,
    [528]  = 143,
    [529]  = 148,
    [530]  = 154,
    [531]  = 155,
    [532]  = 156,
    [533]  = 157,
    [534]  = 160,
    [535]  = 162,
    [536]  = 168,
    [540]  = 169,
    [541]  = 170,
    [542]  = 171,
    [543]  = 172,
    [544]  = 175,
    [545]  = 180,
    [601]  = 183,
    [602]  = 184,
    [603]  = 185,
    [604]  = 186,
    [605]  = 196,
    [606]  = 198,
    [607]  = 199,
    [609]  = 200,
    [610]  = 201,
    [611]  = 202,
    [613]  = 203,
    [614]  = 204,
    [615]  = 205,
    [626]  = 206,
    [640]  = 208,
    [673]  = 210,
    [680]  = 213,
    [684]  = 217,
    [685]  = 218,
    [686]  = 219,
    [687]  = 220,
    [688]  = 221,
    [689]  = 224,
    [690]  = 225,
    [691]  = 226,
    [692]  = 230,
    [696]  = 232,
    [697]  = 233,
    [699]  = 235,
    [700]  = 241,
    [704]  = 242,
    [708]  = 244,
    [709]  = 245,
    [710]  = 246,
    [717]  = 247,
    [718]  = 248,
    [720]  = 249,
    [721]  = 250,
    [722]  = 256,
    [723]  = 258,
    [724]  = 260,
    [725]  = 261,
    [726]  = 262,
    [727]  = 263,
    [728]  = 265,
    [729]  = 266,
    [730]  = 267,
    [731]  = 269,
    [732]  = 272,
    [733]  = 273,
    [734]  = 274,
    [736]  = 275,
    [737]  = 276,
    [747]  = 277,
    [749]  = 279,
    [750]  = 280,
    [751]  = 948,
    [752]  = 282,
    [753]  = 283,
    [754]  = 285,
    [755]  = 287,
    [756]  = 291,
    [757]  = 293,
    [758]  = 294,
    [759]  = 297,
    [760]  = 300,
    [761]  = 301,
    [762]  = 302,
    [763]  = 306,
    [764]  = 310,
    [765]  = 317,
    [766]  = 319,
    [767]  = 322,
    [768]  = 324,
    [769]  = 325,
    [772]  = 327,
    [773]  = 328,
    [775]  = 329,
    [776]  = 330,
    [779]  = 331,
    [780]  = 332,
    [781]  = 333,
    [782]  = 334,
    [789]  = 336,
    [793]  = 337,
    [795]  = 338,
    [796]  = 340,
    [797]  = 347,
    [798]  = 348,
    [799]  = 350,
    [800]  = 368,
    [803]  = 370,
    [806]  = 372,
    [807]  = 376,
    [808]  = 378,
    [809]  = 379,
    [810]  = 388,
    [811]  = 391,
    [813]  = 397,
    [816]  = 398,
    [819]  = 400,
    [820]  = 402,
    [823]  = 408,
    [824]  = 410,
    [851]  = 416,
    [856]  = 417,
    [857]  = 419,
    [858]  = 422,
    [860]  = 423,
    [862]  = 424,
    [864]  = 425,
    [866]  = 427,
    [867]  = 429,
    [871]  = 431,
    [873]  = 433,
    [874]  = 435,
    [875]  = 437,
    [876]  = 439,
    [877]  = 444,
    [878]  = 447,
    [880]  = 448,
    [881]  = 449,
    [882]  = 450,
    [883]  = 451,
    [884]  = 452,
    [885]  = 453,
    [886]  = 456,
    [887]  = 458,
    [888]  = 460,
    [889]  = 461,
    [890]  = 462,
    [891]  = 463,
    [892]  = 465,
    [893]  = 467,
    [894]  = 468,
    [895]  = 469,
    [896]  = 471,
    [897]  = 474,
    [898]  = 476,
    [899]  = 480,
    [900]  = 481,
    [906]  = 483,
    [911]  = 486,
    [912]  = 487,
    [914]  = 489,
    [919]  = 491,
    [920]  = 498,
    [922]  = 499,
    [924]  = 501,
    [925]  = 503,
    [928]  = 505,
    [929]  = 507,
    [930]  = 508,
    [933]  = 517,
    [934]  = 518,
    [935]  = 519,
    [937]  = 521,
    [938]  = 522,
    [939]  = 523,
    [940]  = 524,
    [941]  = 526,
    [945]  = 534,
    [946]  = 535,
    [947]  = 539,
    [948]  = 542,
    [949]  = 543,
    [950]  = 552,
    [951]  = 554,
    [953]  = 557,
    [955]  = 571,
    [962]  = 572,
    [964]  = 573,
    [969]  = 574,
    [970]  = 578,
    [971]  = 580,
    [973]  = 582,
    [976]  = 586,
    [978]  = 588,
    [980]  = 590,
    [983]  = 592,
    [984]  = 593,
    [986]  = 594,
    [987]  = 595,
    [988]  = 596,
    [989]  = 601,
    [993]  = 606,
    [994]  = 611,
    [995]  = 616,
    [1007] = 619,
    [1008] = 621,
    [1009] = 622,
    [1010] = 623,
    [1011] = 624,
    [1014] = 625,
    [1015] = 630,
    [1017] = 635,
    [1018] = 641,
    [1020] = 645,
    [1021] = 647,
    [1022] = 649,
    [1024] = 650,
    [1026] = 662,
    [1027] = 671,
    [1028] = 673,
    [1031] = 676,
    [1032] = 677,
    [1033] = 683,
    [1034] = 694,
    [1035] = 695,
    [1037] = 696,
    [1038] = 697,
    [1039] = 698,
    [1040] = 702,
    [1041] = 704,
    [1042] = 707,
    [1044] = 709,
    [1045] = 710,
    [1046] = 713,
    [1047] = 714,
    [1048] = 715,
    [1049] = 716,
    [1050] = 717,
    [1051] = 718,
    [1052] = 720,
    [1054] = 723,
    [1056] = 725,
    [1057] = 726,
    [1059] = 728,
    [1060] = 729,
    [1065] = 731,
    [1066] = 732,
    [1067] = 733,
    [1068] = 734,
    [1069] = 736,
    [1070] = 737,
    [1071] = 738,
    [1072] = 739,
    [1073] = 740,
    [1075] = 742,
    [1076] = 744,
    [1077] = 747,
    [1078] = 748,
    [1079] = 749,
    [1080] = 750,
    [1081] = 751,
    [1082] = 757,
    [1084] = 758,
    [1085] = 759,
    [1086] = 760,
    [1087] = 762,
    [1088] = 764,
    [1090] = 774,
    [1091] = 775,
    [1092] = 776,
    [1094] = 777,
    [1096] = 790,
    [1097] = 791,
    [1099] = 793,
    [1100] = 794,
    [1102] = 798,
    [1104] = 800,
    [1105] = 804,
    [1114] = 807,
    [1115] = 809,
    [1116] = 823,
    [1126] = 824,
    [1127] = 825,
    [1129] = 826,
    [1130] = 827,
    [1131] = 828,
    [1132] = 829,
    [1135] = 831,
    [1136] = 834,
    [1137] = 835,
    [1139] = 837,
    [1140] = 838,
    [1142] = 839,
    [1143] = 840,
    [1144] = 843,
    [1145] = 844,
    [1146] = 845,
    [1147] = 850,
    [1148] = 857,
    [1149] = 858,
    [1150] = 859,
    [1151] = 860,
    [1152] = 861,
    [1153] = 862,
    [1154] = 863,
    [1155] = 864,
    [1156] = 865,
    [1157] = 867,
    [1158] = 868,
    [1159] = 869,
    [1160] = 871,
    [1161] = 873,
    [1162] = 875,
    [1163] = 876,
    [1164] = 877,
    [1165] = 879,
    [1166] = 881,
    [1170] = 882,
    [1171] = 885,
    [1172] = 888,
    [1173] = 889,
    [1174] = 892,
    [1175] = 895,
    [1176] = 896,
    [1177] = 898,
    [1178] = 903,
    [1183] = 904,
    [1184] = 994,
    [1185] = 906,
    [1186] = 907,
    [1187] = 908,
    [1188] = 910,
    [1190] = 921,
    [1191] = 922,
    [1192] = 923,
    [1193] = 924,
    [1194] = 925,
    [1195] = 926,
    [1196] = 927,
    [1197] = 928,
    [1198] = 929,
    [1199] = 930,
    [1200] = 931,
    [1201] = 932,
    [1202] = 933,
    [1204] = 935,
    [1205] = 936,
    [1210] = 938,
    [1211] = 939,
    [1212] = 940,
    [1213] = 942,
    [1214] = 943,
    [1215] = 971,
    [1216] = 972,
    [1217] = 973,
    [1219] = 976,
    [1220] = 981,
}

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
	local unknownAreas = {}
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
					pvplog.event[eventKey].mapID = areaIdToUiMapId[eventdata.areaID]
					if not pvplog.event[eventKey].mapID and eventdata.areaID then
						unknownAreas[eventdata.areaID] = (unknownAreas[eventdata.areaID] or 0) + 1
						pvplog.event[eventKey].areaID = eventdata.areaID -- Save the old info, maybe the areaID can be found later?
					end
					pvplog.event[eventKey].x = eventdata.posX
					pvplog.event[eventKey].y = eventdata.posY
					if pvplog.event[eventKey].mapID and eventdata.posX and eventdata.posY then
						local cID, wPos = C_Map.GetWorldPosFromMapPos(pvplog.event[eventKey].mapID, CreateVector2D(eventdata.posX, eventdata.posY))
						pvplog.event[eventKey].cID = cID
						if wPos then
							local wx, wy = wPos:GetXY()
							pvplog.event[eventKey].wx = wx
							pvplog.event[eventKey].wy = wy
						end
					end
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
					oldlog.player[playerFullName] = nil
				end
				oldlog.player = nil
			end

			if oldlog and oldlog.area then
				for areaID,eventKeyTable in pairs(oldlog.area) do
					local mapId = areaIdToUiMapId[areaID]
					if mapId then
						pvplog.map[mapId] = eventKeyTable
						count = count + 1
						oldlog.area[areaID] = nil
					else
						unknownAreas[areaID] = (unknownAreas[areaID] or 0) + 1
						invalid = invalid + 1
					end
				end
				oldlog.area = nil
			end
		end
		VanasKoSDB.namespaces.PvPDataGatherer.realm = nil
	end

	for areaID, count in pairs(unknownAreas) do
		VanasKoS:Print(format("Unknown area ID: %d, events: %d", areaID, count))
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
			if (v.data and v.data.players) then
				for fullPlayerName, olddata in pairs(v.data.players) do
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
					playerData[playerKey].mapID = areaIdToUiMapId[olddata.areaID]
					playerData[playerKey].guid = olddata.guid
					count = count + 1
					olddata[fullPlayerName] = nil
				end
				v.data = nil
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
	if(VanasKoSDB.namespaces.PvPStats and VanasKoSDB.namespaces.PvPStats.realm) then
		for realm, realmdata in pairs(VanasKoSDB.namespaces.PvPStats.realm) do
			if(realmdata.pvpstats and realmdata.pvpstats.players) then
				local pvpStats = realmdata.pvpstats.players
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
									if bglosses > 1 then
										event.inBg = true
										bglosses = bglosses - 1
									elseif arenalosses > 1 then
										event.inArena = true
										arenalosses = arenalosses - 1
									elseif combatlosses > 1 then
										event.inCombatZone = true
										combatlosses = combatlosses - 1
									elseif ffalosses > 1 then
										event.inFfa = true
										combatlosses = combatlosses - 1
									end
								end
							end
						end
					end
					count = count + 1
					pvpStats[playerFullName] = nil
				end
			end
		end
		VanasKoSDB.namespaces.PvPStats.realm = nil
	end

	if (count > 0) then
		VanasKoS:Print(format(L["Converted %d PvP stats to %d PvP log events"], count, eventId))
	end
	if (invalid > 0) then
		VanasKoS:Print(format("%d invalid PvP stats skipped", invalid))
	end
end
