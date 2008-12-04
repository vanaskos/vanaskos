--[[----------------------------------------------------------------------
      DataGatherer Module - Part of VanasKoS
Handles all external Player Data from Chat and Target Changes/Mouseovers
------------------------------------------------------------------------]]

VanasKoSDataGatherer = VanasKoS:NewModule("DataGatherer", "AceEvent-3.0");

local VanasKoSDataGatherer = VanasKoSDataGatherer;
local VanasKoS = VanasKoS;

local continent = -1;
local zoneID = -1;
local zone = nil;
local inBattleground = false;
local zoneContinentZoneID = { };

function VanasKoSDataGatherer:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("DataGatherer", 
		{
			realm = {
				data = {
					players = {
					},
					guilds = {
					},
				},
			}
		});

	-- import of old data, will be removed in some version in the future
--[[	if(VanasKoS.db.realm.data) then
		self.db.realm.data = VanasKoS.db.realm.data;
		VanasKoS.db.realm.data = nil;
	end ]]

	VanasKoS:RegisterList(nil, "PLAYERDATA", nil, self);
	VanasKoS:RegisterList(nil, "GUILDDATA", nil, self);
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

function VanasKoSDataGatherer:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellID, spellName, spellSchool, auraType)
--	self:PrintLiteral(eventType, srcName, srcFlags, dstName, dstFlags);

	-- source or destination is friendly, register as event
	if(srcName ~= nil and srcFlags ~= nil and bit.band(srcFlags, COMBATLOG_FILTER_FRIENDLY_PLAYER) == COMBATLOG_FILTER_FRIENDLY_PLAYER and srcName ~= myName) then
		VanasKoSDataGatherer:SendDataMessage(srcName, "friendly");
	end

	if(dstName ~= nil and dstFlags ~= nil and bit.band(dstFlags, COMBATLOG_FILTER_FRIENDLY_PLAYER) == COMBATLOG_FILTER_FRIENDLY_PLAYER and dstName ~= myName) then
		VanasKoSDataGatherer:SendDataMessage(dstName, "friendly");
	end

	-- source or destination are hostile, register as event
	if(srcName ~= nil and srcFlags ~= nil and bit.band(srcFlags, COMBATLOG_FILTER_HOSTILE_PLAYER) == COMBATLOG_FILTER_HOSTILE_PLAYER) then
		VanasKoSDataGatherer:SendDataMessage(srcName, "enemy");
	end

	if(dstName ~= nil and dstFlags ~= nil and bit.band(dstFlags, COMBATLOG_FILTER_HOSTILE_PLAYER) == COMBATLOG_FILTER_HOSTILE_PLAYER) then
		VanasKoSDataGatherer:SendDataMessage(dstName, "enemy");
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

	self:RegisterMessage("VanasKoS_Player_Data_Gathered", "Data_Gathered");
	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected");

	zoneContinentZoneID[1] = { GetMapZones(1); };
	zoneContinentZoneID[2] = { GetMapZones(2); };
	zoneContinentZoneID[3] = { GetMapZones(3); };
	zoneContinentZoneID[4] = { GetMapZones(4); };

	self:UpdateZone();

	playerDataList = self.db.realm.data.players;
end

function VanasKoSDataGatherer:OnDisable()
	self:UnregisterAllEvents();
	self:UnregisterAllMessages();
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
		self:SendMessage("VanasKoS_List_Entry_Removed", listname, name);
	end
end

function VanasKoSDataGatherer:UpdateLastSeen(name)
	if(playerDataList[name] ~= nil) then
		playerDataList[name].lastseen = time();
	end
end

function VanasKoSDataGatherer:Data_Gathered(message, list, data)
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

local tourist = LibStub("LibTourist-3.0")

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
	self:SendMessage("VanasKoS_Zone_Changed", zone, continent, zoneID);
end

function VanasKoSDataGatherer:IsInSanctuary()
	if( (continent == 3 and zoneID == 6) or
		(continent == 4 and zoneID == 3)) then
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
				self:SendMessage("VanasKoS_Player_Data_Gathered", gatheredData['list'], gatheredData);
			end
		end

		return true;
	end

	return false;
end

function VanasKoSDataGatherer:PLAYER_TARGET_CHANGED()
	if(self:Get_Player_Data("target")) then
		self:SendMessage("VanasKoS_Player_Detected", gatheredData);
		self:SendMessage("VanasKoS_Player_Target_Changed", gatheredData);
	else
		self:SendMessage("VanasKoS_Mob_Target_Changed", nil, nil, nil);
	end
end


-- /script for i=1,10000 do VanasKoSDataGatherer:UPDATE_MOUSEOVER_UNIT() end
-- /script local x = { ['name'] = test; faction = 'enemy'}  for i=1,10000 do x.name = "Moep" .. math.random(1, 100000); VanasKoSDataGatherer:SendMessage("VanasKoS_Player_Detected", x); end
function VanasKoSDataGatherer:UPDATE_MOUSEOVER_UNIT()
	if(self:Get_Player_Data("mouseover")) then
		self:SendMessage("VanasKoS_Player_Detected", gatheredData);
		--self:SendMessage("VanasKoS_Player_MouseOver", gatheredData);
	end
end

function VanasKoSDataGatherer:SendDataMessage(name, faction)
	-- dumb fix to hide obviously invalid strings gathered in other localizations then enUS
	assert(name ~= nil);
	
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

	self:SendMessage("VanasKoS_Player_Detected", gatheredData);
end
