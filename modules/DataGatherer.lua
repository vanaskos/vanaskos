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
local myName = nil;


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
	myName = UnitName("player");
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

function VanasKoSDataGatherer:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellID, spellName, spellSchool, auraType)
--	self:PrintLiteral(eventType, srcName, srcFlags, dstName, dstFlags);
	
	-- source or destination is friendly, register as event
	if(srcName ~= nil and srcFlags ~= nil and bit.band(srcFlags, COMBATLOG_FILTER_FRIENDLY_PLAYER) == COMBATLOG_FILTER_FRIENDLY_PLAYER and srcName ~= myName) then
		VanasKoSDataGatherer:SendDataMessage(srcName, "friendly", spellID);
	end

	if(dstName ~= nil and dstFlags ~= nil and bit.band(dstFlags, COMBATLOG_FILTER_FRIENDLY_PLAYER) == COMBATLOG_FILTER_FRIENDLY_PLAYER and dstName ~= myName) then
		VanasKoSDataGatherer:SendDataMessage(dstName, "friendly", spellID);
	end

	-- source or destination are hostile, register as event
	if(srcName ~= nil and srcFlags ~= nil and bit.band(srcFlags, COMBATLOG_FILTER_HOSTILE_PLAYER) == COMBATLOG_FILTER_HOSTILE_PLAYER) then
		VanasKoSDataGatherer:SendDataMessage(srcName, "enemy", spellID);
	end

	if(dstName ~= nil and dstFlags ~= nil and bit.band(dstFlags, COMBATLOG_FILTER_HOSTILE_PLAYER) == COMBATLOG_FILTER_HOSTILE_PLAYER) then
		VanasKoSDataGatherer:SendDataMessage(dstName, "enemy", spellID);
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
	local count = 0;
	for k, v in pairs(playerDataList) do
		count = count + 1;
	end
	VanasKoS:Print(format("%d entries in datalist", count));
end

function VanasKoSDataGatherer:OnDisable()
	self:UnregisterAllEvents();
	self:UnregisterAllMessages();
end

-- if a player was detected nearby through chat or mouseover, update lastseen
function VanasKoSDataGatherer:Player_Detected(message, data)
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
	local lname = name:lower();
	if(playerDataList[lname] ~= nil) then
		playerDataList[lname].lastseen = time();
	end
end

function VanasKoSDataGatherer:Data_Gathered(message, list, data)
	-- self:PrintLiteral(list, name, guild, level, race, class, gender);
	assert(data.name ~= nil)
	
	if(self:IsInBattleground()) then
		return;
	end
	
	local lname = data.name:lower();

	if(not playerDataList[lname]) then
		playerDataList[lname] = { };
	end

	playerDataList[lname].displayname = data.name;
	playerDataList[lname].guild = data['guild'];
	playerDataList[lname].guildrank = data['guildrank'];
	if((data['level'] and data['level'] ~= -1) or
		(data['level'] == -1 and playerDataList[lname].level == nil)) then
		playerDataList[lname].level = data['level'];
	end
	playerDataList[lname].race = data['race'];
	playerDataList[lname].class = data['class'];
	playerDataList[lname].classEnglish = data['classEnglish'];
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

	if(tourist:IsBattleground(zone) or 
		tourist:IsInstance(zone) or 
		tourist:IsArena(zone) or 
		tourist:IsPvPZone(zone)) then
		inBattleground = true;
	else
		inBattleground = false;
	end

	--self:PrintLiteral("[DEBUG]: BG: ", inBattleground, "Shatt:", self:IsInShattrath());
	self:SendMessage("VanasKoS_Zone_Changed", zone, continent, zoneID);
end

function VanasKoSDataGatherer:IsInSanctuary()
	if( (continent == 3 and zoneID == 6) or -- shattrath
		(continent == 4 and zoneID == 3)) then -- dalaran
		return true;
	else
		return false;
	end
end

function VanasKoSDataGatherer:IsInBattleground()
    local instance, instanceType = IsInInstance()
    if(instance and (instanceType =="pvp" or instanceType == "arena")) then
		inBattleground = true;
        return true;
    end

	-- TODO: workaround
	self:UpdateZone();
	return inBattleground;
end

local gatheredData = { };
function VanasKoSDataGatherer:Get_Player_Data(unit)
	if(UnitIsPlayer(unit) and UnitName(unit) ~= myName) then
		local name, realm = UnitName(unit);

		if(name == nil) then
			return false;
		end
		gatheredData['name'] = name;
		gatheredData['realm'] = realm;
		gatheredData['guild'], gatheredData['guildrank'] = GetGuildInfo(unit);
		gatheredData['level'] = UnitLevel(unit);
		gatheredData['race'] = UnitRace(unit);
		gatheredData['class'], gatheredData['classEnglish'] = UnitClass(unit);
		gatheredData['gender'] = UnitSex(unit);
		gatheredData['zone'] = zone;
		gatheredData['faction'] = nil;

		if(gatheredData['realm'] == nil) then
			gatheredData['list'] = select(2, VanasKoS:IsOnList(nil, gatheredData['name']));

			if(gatheredData['realm'] == nil and 
				(gatheredData['list'] == "PLAYERKOS" or gatheredData['list'] == "GUILDKOS")) then
				gatheredData['faction'] = "kos";
			elseif(UnitExists(unit) and UnitIsEnemy("player", unit)) then
				gatheredData['faction'] = "enemy";
			else
				gatheredData['faction'] = "friendly";
			end

			--if(gatheredData['list']) then
				self:SendMessage("VanasKoS_Player_Data_Gathered", gatheredData['list'], gatheredData);
			--end
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

local LevelGuessLib = LibStub("LibLevelGuess-1.0");

function VanasKoSDataGatherer:SendDataMessage(name, faction, spellId)
	-- dumb fix to hide obviously invalid strings gathered in other localizations then enUS
	if(name == nil or name:lower() == myName:lower()) then
		return;
	end
	
	gatheredData['name'] = name;
	gatheredData['faction'] = faction;
	gatheredData['zone'] = zone;

	local lname = name:lower();

	if(not self:IsInBattleground()) then
		if(spellId ~= nil) then
			local level, classEnglish = LevelGuessLib:GetEstimatedLevelAndClassFromSpellId(spellId);
			if(level ~= nil) then
				if(not playerDataList[lname]) then
					playerDataList[lname] = { };
				end
				if(not playerDataList[lname].level or 
					playerDataList[lname].level == -1) then
					local oldLevel = 0;
					if(playerDataList[lname].level) then
						if(string.find(playerDataList[lname].level, "+")) then
							oldLevel = tonumber(string.match(playerDataList[lname].level, "%d+"));
						end
					end
					if(oldLevel < level) then
						if(level < 80) then
							level = level .. "+";
						end
						playerDataList[lname].level = level;
					end
				end
				gatheredData['level'] = level;
			end
			if(classEnglish ~= nil) then
				if(not playerDataList[lname]) then
					playerDataList[lname] = { };
				end
				if(playerDataList[lname].classEnglish ~= nil) then
					playerDataList[lname].classEnglish = classEnglish;
				end
			end
		end
	end
	-- /script VanasKoSDataGatherer:SendDataMessage("name", "enemy", nil);
	-- /dump VanasKoSDataGatherer.db.realm.data.players['name'];
	if(not self:IsInBattleground() and playerDataList[lname]) then
		gatheredData['level'] =  playerDataList[lname].level;
		gatheredData['guild'] = playerDataList[lname].guild;
		gatheredData['guildrank'] = playerDataList[lname].guildrank;
		
		gatheredData['level'] = playerDataList[lname].level;
		gatheredData['class'] = playerDataList[lname].class;
		gatheredData['classEnglish'] = playerDataList[lname].classEnglish;
		gatheredData['race'] = playerDataList[lname].race;
		gatheredData['gender'] = playerDataList[lname].gender;
		gatheredData['realm'] = nil;
	else
		gatheredData['level'] =  nil;
		gatheredData['classEnglish'] = nil;
		gatheredData['guild'] = nil;
		gatheredData['level'] = nil;
		gatheredData['class'] = nil;
		gatheredData['race'] = nil;
		gatheredData['gender'] = nil;
		gatheredData['realm'] = nil;
	end

	if(not self:IsInBattleground() and VanasKoS:BooleanIsOnList("PLAYERKOS", name)) then
		gatheredData['faction'] = "kos";
	end

	self:SendMessage("VanasKoS_Player_Detected", gatheredData);
end
