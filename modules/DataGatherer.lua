--[[----------------------------------------------------------------------
      DataGatherer Module - Part of VanasKoS
Handles all external Player Data from Chat and Target Changes/Mouseovers
------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.2"):new("VanasKoSDataGatherer");

VanasKoSDataGatherer = VanasKoS:NewModule("DataGatherer");

local VanasKoSDataGatherer = VanasKoSDataGatherer;
local VanasKoS = VanasKoS;

L:RegisterTranslations("enUS", function() return {
	["Data Gathering"] = true,
	["Combat Log Range"] = true,
	["Adjust Combat Log Ranges"] = true,

	["Death Log Range"] = true,
	["Changes the logging range of the Death Log (in yards)"] = true,
	["Creature Log Range"] = true,
	["Changes the logging range of the Creature Log (in yards)"] = true,
	["Friendly Players Log Range"] = true,
	["Changes the logging range of the Friendly Players Log (in yards)"] = true,
	["Friendly Players Pets Log Range"] = true,
	["Changes the logging range of the Friendly Players Pets Log (in yards)"] = true,
	["Hostile Players Log Range"] = true,
	["Changes the logging range of the Hostile Players Log (in yards)"] = true,
	["Hostile Players Pets Log Range"] = true,
	["Changes the logging range of the Hostile Players Pets Log (in yards)"] = true,
	["Party Log Range"] = true,
	["Changes the logging range of the Party Log (in yards)"] = true,
	["Party Pets Log Range"] = true,
	["Changes the logging range of the Party Pets Log (in yards)"] = true,
} end);

L:RegisterTranslations("frFR", function() return {
	["Data Gathering"] = "Rassemblement de données",
	["Combat Log Range"] = "Distance du Combat Log",
	["Adjust Combat Log Ranges"] = "Ajuster la distance du Combat Log",

	["Death Log Range"] = "Distance Log | Mort",
	["Changes the logging range of the Death Log (in yards)"] = "Change la distance du Log 'Mort' (en yards)",
	["Creature Log Range"] = "Distance Log | Créature",
	["Changes the logging range of the Creature Log (in yards)"] = "Change la distance du Log 'Créature' (en yards)",
	["Friendly Players Log Range"] = "Distance Log | Joueur ami",
	["Changes the logging range of the Friendly Players Log (in yards)"] = "Change la distance du Log 'Joueur ami' (en yards)",
	["Friendly Players Pets Log Range"] = "Distance Log | Familier - joueur ami",
	["Changes the logging range of the Friendly Players Pets Log (in yards)"] = "Change la distance du Log 'Familier - joueur ami' (en yards)",
	["Hostile Players Log Range"] = "Distance Log | Joueur ennemi",
	["Changes the logging range of the Hostile Players Log (in yards)"] = "Change la distance du Log 'Joueur ennemi' (en yards)",
	["Hostile Players Pets Log Range"] = "Distance Log | Familier - Joueur ennemi",
	["Changes the logging range of the Hostile Players Pets Log (in yards)"] = "Change la distance du Log 'Familier - joueur ennemi' (en yards)",
	["Party Log Range"] = "Distance Log | Groupe",
	["Changes the logging range of the Party Log (in yards)"] = "Change la distance du Log 'Groupe' (en yards)",
	["Party Pets Log Range"] = "Distance Log | Familier - groupe",
	["Changes the logging range of the Party Pets Log (in yards)"] = "Change la distance du Log 'Familier - groupe' (en yards)",
} end);

L:RegisterTranslations("koKR", function() return {
	["Data Gathering"] = "데이터 수집",
	["Combat Log Range"] = "전투 로그 범위",
	["Adjust Combat Log Ranges"] = "전투 로그 범위를 조절합니다.",

	["Death Log Range"] = "죽음 로그 범위",
	["Changes the logging range of the Death Log (in yards)"] = "죽음 로그의 로깅 범위를 변경합니다.",
	["Creature Log Range"] = "NPC 로그 범위",
	["Changes the logging range of the Creature Log (in yards)"] = "NPC 로그의 로깅 범위를 변경합니다.",
	["Friendly Players Log Range"] = "우호적 플레이어 로그 범위",
	["Changes the logging range of the Friendly Players Log (in yards)"] = "우호적 플레이어 로그의 로깅 범위를 변경합니다.",
	["Friendly Players Pets Log Range"] = "우호적 플레이어 소환수 로그 범위",
	["Changes the logging range of the Friendly Players Pets Log (in yards)"] = "우호적 플레이어 소환수 로그의 로깅 범위를 변경합니다.",
	["Hostile Players Log Range"] = "적대적 플레이어 로그 범위",
	["Changes the logging range of the Hostile Players Log (in yards)"] = "적대적 플레이어 로그의 로깅 범위를 변경합니다.",
	["Hostile Players Pets Log Range"] = "적대적 플레이어 소환수 로그 범위",
	["Changes the logging range of the Hostile Players Pets Log (in yards)"] = "적대적 플레이어 소환수 로그의 로깅 범위를 변경합니다.",
	["Party Log Range"] = "파티 로그 범위",
	["Changes the logging range of the Party Log (in yards)"] = "파티 로그의 로깅 범위를 변경합니다.",
	["Party Pets Log Range"] = "파티 소환수 로그 범위",
	["Changes the logging range of the Party Pets Log (in yards)"] = "파티 소환수 로그의 로깅 범위를 변경합니다.",
} end);

L:RegisterTranslations("esES", function() return {
	["Data Gathering"] = "Recolección de Datos",
	["Combat Log Range"] = "Rango del Registro de Combate",
	["Adjust Combat Log Ranges"] = "Ajusta los rangos del registro de combate",

	["Death Log Range"] = "Rango del registro de muertes",
	["Changes the logging range of the Death Log (in yards)"] = "Cambia el rango de registro del registro de muertes (en yardas)",
	["Creature Log Range"] = "Rango del registro de criaturas",
	["Changes the logging range of the Creature Log (in yards)"] = "Cambia el rango de registro del registro de criaturas (en yardas)",
	["Friendly Players Log Range"] = "Rango del registro de jugadores amistosos",
	["Changes the logging range of the Friendly Players Log (in yards)"] = "Cambia el rango de registro del registro de jugadores amistosos (en yardas)",
	["Friendly Players Pets Log Range"] = "Rango del registro de mascotas de jugadores amistosos",
	["Changes the logging range of the Friendly Players Pets Log (in yards)"] = "Cambia el rango de registro del registro de mascotas de jugadores amistosos (en yardas)",
	["Hostile Players Log Range"] = "Rango del registro de jugadores hostiles",
	["Changes the logging range of the Hostile Players Log (in yards)"] = "Cambia el rango de registro del registro de jugadores hostiles (en yardas)",
	["Hostile Players Pets Log Range"] = "Rango del registro de mascotas de jugadores hostiles",
	["Changes the logging range of the Hostile Players Pets Log (in yards)"] = "Cambia el rango de registro del registro de mascotas de jugadores hostiles (en yardas)",
	["Party Log Range"] = "Rango del registro de grupo",
	["Changes the logging range of the Party Log (in yards)"] = "Cambia el rango de registro del registro de grupo (en yardas)",
	["Party Pets Log Range"] = "Rango del registro de mascotas del grupo",
	["Changes the logging range of the Party Pets Log (in yards)"] = "Cambia el rango de registro del registro de mascotas del grupo (en yardas)",
} end);

L:RegisterTranslations("ruRU", function() return {
	["Data Gathering"] = "Сбор данных",
	["Combat Log Range"] = "Диапазон лога боя",
	["Adjust Combat Log Ranges"] = "Настройка диапазона лога боя",

	["Death Log Range"] = "Диапазон лога смертей",
	["Changes the logging range of the Death Log (in yards)"] = "Изменение диапазон лога смертей (в метрах)",
	["Creature Log Range"] = "Диапазон лога существ",
	["Changes the logging range of the Creature Log (in yards)"] = "Изменение диапазона лога существ (в метрах)",
	["Friendly Players Log Range"] = "Диапазон лога дружественных игроков",
	["Changes the logging range of the Friendly Players Log (in yards)"] = "Изменяет диапозон лога дружественных игроков (в метрах)",
	["Friendly Players Pets Log Range"] = "Диапазон лога питомцев дружественных игроков",
	["Changes the logging range of the Friendly Players Pets Log (in yards)"] = "Изменяет диапазон лога питомцев дружественных игроков (в метрах)",
	["Hostile Players Log Range"] = "Диапазон лога враждебных игроков",
	["Changes the logging range of the Hostile Players Log (in yards)"] = "Изменяет диапозон лога враждебных игроков (в метрах)",
	["Hostile Players Pets Log Range"] = "Диапазон лога питомцев враждебных игроков",
	["Changes the logging range of the Hostile Players Pets Log (in yards)"] = "Изменяет диапозон лога питомцев враждебных игроков (в метрах)",
	["Party Log Range"] = "Дипазон лога группы",
	["Changes the logging range of the Party Log (in yards)"] = "Изменяет диапазон лога группы (в метрах)",
	["Party Pets Log Range"] = "Настройка диапозона лога питомца в группе",
	["Changes the logging range of the Party Pets Log (in yards)"] = "Изменяет диапазон лога питомцев в группе (в метрах)",
} end);

local continent = -1;
local zoneID = -1;
local zone = nil;
local inBattleground = false;
local zoneContinentZoneID = { };

function VanasKoSDataGatherer:OnInitialize()
	VanasKoS:RegisterDefaults("DataGatherer", "realm", {
		data = {
			players = {
			},
			guilds = {
			},
		},
	});

	self.db = VanasKoS:AcquireDBNamespace("DataGatherer");

	-- import of old data, will be removed in some version in the future
	if(VanasKoS.db.realm.data) then
		self.db.realm.data = VanasKoS.db.realm.data;
		VanasKoS.db.realm.data = nil;
	end

	VanasKoS:RegisterList(nil, "PLAYERDATA", nil, self);
	VanasKoS:RegisterList(nil, "GUILDDATA", nil, self);

--[[ LogRange CVars are not exists anymore as range changing disabled in past 2.4 =(

	VanasKoSGUI:AddConfigOption("DataGatherer", {
		type = 'group',
		name = L["Data Gathering"],
		desc = L["Data Gathering"],
		args = {
			clogrange = {
				type = 'group',
				name = L["Combat Log Range"],
				desc = L["Adjust Combat Log Ranges"],
				args = {
					deathlog = {
						type = 'range',
						name = L["Death Log Range"],
						desc = L["Changes the logging range of the Death Log (in yards)"],
						min = 20,
						max = 150,
						step = 10,
						set = function(val) SetCVar("CombatDeathLogRange", val); end,
						get = function() return GetCVar("CombatDeathLogRange"); end,
					},
					creaturelog = {
						type = 'range',
						name = L["Creature Log Range"],
						desc = L["Changes the logging range of the Creature Log (in yards)"],
						min = 20,
						max = 150,
						step = 10,
						set = function(val) SetCVar("CombatLogRangeCreature", val); end,
						get = function() return GetCVar("CombatLogRangeCreature"); end,
					},
					friendlylog = {
						type = 'range',
						name = L["Friendly Players Log Range"],
						desc = L["Changes the logging range of the Friendly Players Log (in yards)"],
						min = 20,
						max = 150,
						step = 10,
						set = function(val) SetCVar("CombatLogRangeFriendlyPlayers", val); end,
						get = function() return GetCVar("CombatLogRangeFriendlyPlayers"); end,
					},
					friendlypetlog = {
						type = 'range',
						name = L["Friendly Players Pets Log Range"],
						desc = L["Changes the logging range of the Friendly Players Pets Log (in yards)"],
						min = 20,
						max = 150,
						step = 10,
						set = function(val) SetCVar("CombatLogRangeFriendlyPlayersPets", val); end,
						get = function() return GetCVar("CombatLogRangeFriendlyPlayersPets"); end,
					},
					hostilelog = {
						type = 'range',
						name = L["Hostile Players Log Range"],
						desc = L["Changes the logging range of the Hostile Players Log (in yards)"],
						min = 20,
						max = 150,
						step = 10,
						set = function(val) SetCVar("CombatLogRangeHostilePlayers", val); end,
						get = function() return GetCVar("CombatLogRangeHostilePlayers"); end,
					},
					hostilepetlog = {
						type = 'range',
						name = L["Hostile Players Pets Log Range"],
						desc = L["Changes the logging range of the Hostile Players Pets Log (in yards)"],
						min = 20,
						max = 150,
						step = 10,
						set = function(val) SetCVar("CombatLogRangeHostilePlayersPets", val); end,
						get = function() return GetCVar("CombatLogRangeHostilePlayersPets"); end,
					},
					partylog = {
						type = 'range',
						name = L["Party Log Range"],
						desc = L["Changes the logging range of the Party Log (in yards)"],
						min = 20,
						max = 150,
						step = 10,
						set = function(val) SetCVar("CombatLogRangeParty", val); end,
						get = function() return GetCVar("CombatLogRangeParty"); end,
					},
					partypetlog = {
						type = 'range',
						name = L["Party Pets Log Range"],
						desc = L["Changes the logging range of the Party Pets Log (in yards)"],
						min = 20,
						max = 150,
						step = 10,
						set = function(val) SetCVar("CombatLogRangePartyPet", val); end,
						get = function() return GetCVar("CombatLogRangePartyPet"); end,
					},
				},
			},
		},
	});

	]]

end


local COMBATLOG_FILTER_HOSTILE_PLAYER = bit.bor(
				COMBATLOG_OBJECT_REACTION_HOSTILE,
				COMBATLOG_OBJECT_CONTROL_PLAYER,
				COMBATLOG_OBJECT_TYPE_PLAYER
				);

local COMBATLOG_FILTER_FRIENDLY_PLAYER = bit.bor(
				COMBATLOG_OBJECT_REACTION_FRIENDLY,
				COMBATLOG_OBJECT_CONTROL_PLAYER,
				COMBATLOG_OBJECT_TYPE_PLAYER
				);

local myName = UnitName("player");

function VanasKoSDataGatherer:COMBAT_LOG_EVENT_UNFILTERED(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellID, spellName, spellSchool, auraType)
--	self:PrintLiteral(eventType, srcName, srcFlags, dstName, dstFlags);

	-- source or destination is friendly, register as event
	if(srcName ~= nil and srcFlags ~= nil and bit.band(srcFlags, COMBATLOG_FILTER_FRIENDLY_PLAYER) == COMBATLOG_FILTER_FRIENDLY_PLAYER and srcName ~= myName) then
		VanasKoSDataGatherer:SendEvent(srcName, "friendly");
	end

	if(dstName ~= nil and dstFlags ~= nil and bit.band(dstFlags, COMBATLOG_FILTER_FRIENDLY_PLAYER) == COMBATLOG_FILTER_FRIENDLY_PLAYER and dstName ~= myName) then
		VanasKoSDataGatherer:SendEvent(dstName, "friendly");
	end

	-- source or destination are hostile, register as event
	if(srcName ~= nil and srcFlags ~= nil and bit.band(srcFlags, COMBATLOG_FILTER_HOSTILE_PLAYER) == COMBATLOG_FILTER_HOSTILE_PLAYER) then
		VanasKoSDataGatherer:SendEvent(srcName, "enemy");
	end

	if(dstName ~= nil and dstFlags ~= nil and bit.band(dstFlags, COMBATLOG_FILTER_HOSTILE_PLAYER) == COMBATLOG_FILTER_HOSTILE_PLAYER) then
		VanasKoSDataGatherer:SendEvent(dstName, "enemy");
	end

	if(VanasKoSPvPDataGatherer.db.profile.Enabled) then
		if(dstName ~= nil and dstFlags ~= nil and dstName == myName and
			bit.band(srcFlags, COMBATLOG_FILTER_HOSTILE_PLAYER) == COMBATLOG_FILTER_HOSTILE_PLAYER) then
			VanasKoSPvPDataGatherer:DamageDoneFrom(srcName);
		end
--[[
		if(eventType == "UNIT_DIED") then
			-- someone got killed by a hositile player
			if(bit.band(dstFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE) then
				self:PrintLiteral("got killed");
				VanasKoSPvPDataGatherer:Death(dstName, "loss");
			end

			if(bit.band(dstFlags, COMBATLOG_FILTER_HOSTILE_PLAYER) == COMBATLOG_FILTER_HOSTILE_PLAYER) then
				self:PrintLiteral("someone hostile got killed");
				if(bit.band(srcFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE) then
					self:PrintLiteral("it was me");
				end
			end
		end ]]
	end

end

local playerDataList = nil;

function VanasKoSDataGatherer:OnEnable()
	-- Mouseover, Targetchanges
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");

	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");

	-- on zonechange update zone
	self:RegisterEvent("ZONE_CHANGED", "UpdateZone");
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "UpdateZone");
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateZone");

	self:RegisterEvent("VanasKoS_Player_Data_Gathered", "Data_Gathered");
	self:RegisterEvent("VanasKoS_Player_Detected", "Player_Detected");

	zoneContinentZoneID[1] = { GetMapZones(1) };
	zoneContinentZoneID[2] = { GetMapZones(2) };
	zoneContinentZoneID[3] = { GetMapZones(3) };

	self:UpdateZone();

	playerDataList = self.db.realm.data.players;
end

function VanasKoSDataGatherer:OnDisable()
	self:UnregisterAllEvents();
end

-- if a player was detected nearby through chat or mouseover, update lastseen
function VanasKoSDataGatherer:Player_Detected(data)
	-- if the player is on a relevant list, update last seen
	self:UpdateLastSeen(data.name);
end

function VanasKoSDataGatherer:IsOnList(listname, name)
	local listVar = VanasKoS:GetList(listname);
	if(listVar and listVar[name]) then
		return listVar[name];
	else
		return nil;
	end
end


function VanasKoSDataGatherer:GetList(list)
	if(list == "PLAYERDATA") then
		return self.db.realm.data.players;
	elseif(list == "GUILDDATA") then
		return self.db.realm.data.guilds;
	else
		return nil;
	end
end

function VanasKoSDataGatherer:AddEntry(list, name, data)
	return true;
end

function VanasKoSDataGatherer:RemoveEntry(listname, name)
	local list = VanasKoS:GetList(listname);
	if(list and list[name]) then
		list[name] = nil;
		self:TriggerEvent("VanasKoS_List_Entry_Removed", listname, name);
	end
end

function VanasKoSDataGatherer:UpdateLastSeen(name)
	if(playerDataList[name] ~= nil) then
		playerDataList[name].lastseen = time();
	end
end

function VanasKoSDataGatherer:Data_Gathered(list, data)
	-- self:PrintLiteral(list, name, guild, level, race, class, gender);
	assert(data.name ~= nil)
	if(list == nil) then
		return;
	end

	local lname = data.name:lower();

	if(not playerDataList[lname]) then
		playerDataList[lname] = { };
	end
	self:UpdateLastSeen(lname);

	playerDataList[lname].displayname = data.name;
	playerDataList[lname].guild = data['guild'];
	if(data['level'] and data['level'] ~= -1 or
		(data['level'] == -1 and playerDataList[lname].level ~= nil)) then
		playerDataList[lname].level = data['level'];
	end
	playerDataList[lname].race = data['race'];
	playerDataList[lname].class = data['class'];
	playerDataList[lname].gender = data['gender'];
	playerDataList[lname].zone = data['zone'];

	--
	if(data.guild and VanasKoS:BooleanIsOnList("GUILDKOS", data.guild)) then
		local guildData = VanasKoS:GetList("GUILDDATA");
		if(not guildData[data.guild:lower()]) then
			guildData[data.guild:lower()] = { };
		end
		guildData[data.guild:lower()].displayname = data.guild;
	end
end

local tourist = AceLibrary("LibTourist-3.0")

function VanasKoSDataGatherer:GetZoneName(continent, zoneid)
	local zone = zoneContinentZoneID[continent] and zoneContinentZoneID[continent][zoneid] or nil;
	return zone or nil;
end

function VanasKoSDataGatherer:UpdateZone()
	continent = GetCurrentMapContinent();
	zoneID = GetCurrentMapZone();

	if(zoneContinentZoneID[continent] and zoneContinentZoneID[continent][zoneID]) then
		zone = zoneContinentZoneID[continent][zoneID];
	else
		zone = GetZoneText();
	end

	if(zone == nil) then
		return;
	end

	if(tourist:IsBattleground(zone) or tourist:IsInstance(zone) or tourist:IsArena(zone)) then
		inBattleground = true;
	else
		inBattleground = false;
	end

	--self:PrintLiteral("[DEBUG]: BG: ", inBattleground, "Shatt:", self:IsInShattrath());
	self:TriggerEvent("VanasKoS_Zone_Changed", zone, continent, zoneID);
end

function VanasKoSDataGatherer:IsInShattrath()
	if(continent == 3 and zoneID == 6) then
		return true;
	else
		return false;
	end
end

function VanasKoSDataGatherer:IsInBattleground()
	-- TODO: workaround
	self:UpdateZone();
	return inBattleground;
end

local gatheredData = { };
function VanasKoSDataGatherer:Get_Player_Data(unit)
	if(UnitIsPlayer(unit)) then
		gatheredData['name'], gatheredData['realm'] = UnitName(unit);

		if(gatheredData['name'] == nil) then
			return false;
		end
		gatheredData['guild'], gatheredData['guildrank'] = GetGuildInfo(unit);
		gatheredData['level'] = UnitLevel(unit);
		gatheredData['race'] = UnitRace(unit);
		gatheredData['class'], gatheredData['classEnglish'] = UnitClass(unit);
		gatheredData['gender'] = UnitSex(unit);
		gatheredData['zone'] = zone;
		gatheredData['faction'] = nil;

		if(gatheredData['realm'] == nil) then
			gatheredData['list'] = select(2, VanasKoS:IsOnList(nil, gatheredData['name']));

			if(gatheredData['realm'] == nil and (gatheredData['list'] == "PLAYERKOS" or gatheredData['list'] == "GUILDKOS")) then
				gatheredData['faction'] = "kos";
			elseif(UnitExists(unit) and UnitIsEnemy("player", unit)) then
				gatheredData['faction'] = "enemy";
			else
				gatheredData['faction'] = "friendly";
			end

			if(gatheredData['list']) then
				self:TriggerEvent("VanasKoS_Player_Data_Gathered", gatheredData['list'], gatheredData);
			end
		end

		return true;
	end

	return false;
end

function VanasKoSDataGatherer:PLAYER_TARGET_CHANGED()
	if(self:Get_Player_Data("target")) then
		self:TriggerEvent("VanasKoS_Player_Detected", gatheredData);
		self:TriggerEvent("VanasKoS_Player_Target_Changed", gatheredData);
	else
		self:TriggerEvent("VanasKoS_Mob_Target_Changed", nil, nil, nil);
	end
end


-- /script for i=1,10000 do VanasKoSDataGatherer:UPDATE_MOUSEOVER_UNIT() end
-- /script local x = { ['name'] = test; faction = 'enemy'}  for i=1,10000 do x.name = "Moep" .. math.random(1, 100000); VanasKoSDataGatherer:TriggerEvent("VanasKoS_Player_Detected", x); end
function VanasKoSDataGatherer:UPDATE_MOUSEOVER_UNIT()
	if(self:Get_Player_Data("mouseover")) then
		self:TriggerEvent("VanasKoS_Player_Detected", gatheredData);
		--self:TriggerEvent("VanasKoS_Player_MouseOver", gatheredData);
	end
end

function VanasKoSDataGatherer:SendEvent(name, faction)
	-- dumb fix to hide obviously invalid strings gathered in other localizations then enUS
	if(name:find(" ")) then
		return;
	end
	gatheredData['name'] = name;
	gatheredData['guild'] = nil;
	gatheredData['level'] = nil;
	gatheredData['race'] = nil;
	gatheredData['class'] = nil;
	gatheredData['classEnglish'] = nil;
	gatheredData['gender'] = nil;
	gatheredData['zone'] = zone;
	gatheredData['faction'] = faction;
	gatheredData['realm'] = nil;

	if(VanasKoS:BooleanIsOnList("PLAYERKOS", name)) then
		gatheredData['faction'] = "kos";
	end

	self:TriggerEvent("VanasKoS_Player_Detected", gatheredData);
end
