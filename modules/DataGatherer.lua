--[[----------------------------------------------------------------------
      DataGatherer Module - Part of VanasKoS
Handles all external Player Data from Chat and Target Changes/Mouseovers
------------------------------------------------------------------------]]

VanasKoSDataGatherer = VanasKoS:NewModule("DataGatherer", "AceEvent-3.0", "AceTimer-3.0");

local VanasKoSDataGatherer = VanasKoSDataGatherer;
local VanasKoS = VanasKoS;

local inBattleground = false;
local myName = nil;

local combatLogEventRegistered = true;
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable();

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
			},
			profile = {
				UseCombatLog = true,
				StorePlayerDataPermanently = false,
				GatherInCities = false,
				EnableInSanctuary = false,
			},
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

local COMBATLOG_FILTER_PLAYER = bit.bor(COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PLAYER);
local COMBATLOG_FILTER_HOSTILE_PLAYER = bit.bor(COMBATLOG_OBJECT_REACTION_HOSTILE, COMBATLOG_FILTER_PLAYER);
local COMBATLOG_FILTER_FRIENDLY_PLAYER = bit.bor(COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_FILTER_PLAYER);

local COMBATLOG_POWERTYPE_HEALTH = -2;

local function isFriendlyOrEnemy(flags)
	if(flags and bit.band(flags, COMBATLOG_FILTER_FRIENDLY_PLAYER) == COMBATLOG_FILTER_FRIENDLY_PLAYER) then
		return "friendly";
	end
	if(flags and bit.band(flags, COMBATLOG_FILTER_HOSTILE_PLAYER) == COMBATLOG_FILTER_HOSTILE_PLAYER) then
		return "enemy";
	end
	return nil;
end

local function isPlayer(flags)
	if(flags and bit.band(flags, COMBATLOG_FILTER_PLAYER) == COMBATLOG_FILTER_PLAYER) then
		return true;
	end
	return nil;
end

function VanasKoSDataGatherer:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local offset = 1;
	local spellID = nil;
	local spellName = nil;
	local spellSchool = nil;
	local amount = nil;
	local powerType = nil;

	if(string.find(eventType, "SPELL_") or string.find(eventType, "RANGE_")) then
		spellID, spellName, spellSchool = select(offset, ...);
		offset = offset + 3;
	end
	if(string.find(eventType, "_DAMAGE")) then
--		amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(offset, ...);
		amount = select(offset, ...);
		offset = offset + 9;
	elseif(string.find(eventType, "_LEECH") or string.find(eventType, "DRAIN")) then
--		amount, powerType, extraAmount = select(offset, ...);
		amount, powerType = select(offset, ...);
		offset = offset + 3;
	end

--	self:PrintLiteral(eventType, srcName, srcFlags, dstName, dstFlags);
	--[[if(dstName and srcName and dstName ~= srcName) then
		ChatFrame2:AddMessage(eventType .. " " .. (srcName or "nil") .. " -> " .. (dstName or "nil") .. "  -  " .. (spellName or "nil"));
	end]]
	if(string.find(eventType, "SPELL_AURA_")) then
		-- in case a auro is removed or applied it may be that the auro was gained from someone else and spellID is therefore from the class who casted the aura 
		--(and because we don't know where that player is, ignore him)
		if(srcName ~= dstName) then
			spellID = nil;
		end		
		
		-- in case auras are applied or fade, use only the player who gains the aura / from whom fades the aura
		--[[ 
			SPELL_AURA_APPLIED:
				lockenkopf gains Raktic's trueshot aura
				dst<-			src
			
			SPELL_AURA_REMOVED:
				name's *aura* fades from name
				src				   dst <-
			
		]]
		
		local fOrE = isFriendlyOrEnemy(dstFlags);
		if(dstName and fOrE) then
			VanasKoSDataGatherer:SendDataMessage(dstName, fOrE, spellID);
			return;
		end
	end
	
	
	-- try source and destinationation - if 
	-- source or destination is friendly, register as event
	if(srcName ~= nil and srcName ~= myName) then
		local fOrE = isFriendlyOrEnemy(srcFlags);
		if(fOrE) then
			VanasKoSDataGatherer:SendDataMessage(srcName, fOrE, spellID);
		end
	end

	if(dstName ~= nil and dstName ~= myName) then
		local fOrE = isFriendlyOrEnemy(dstFlags);
		if(fOrE) then
			VanasKoSDataGatherer:SendDataMessage(dstName, fOrE, spellID);
		end
	end

	if((dstName == myName and isFriendlyOrEnemy(srcFlags) == "enemy") or 
		(srcName == myName and isFriendlyOrEnemy(dstFlags) == "enemy")) then
		if(string.find(eventType, "_DAMAGE")) then
			self:SendMessage("VanasKoS_PvPDamage", srcName, dstName, amount);
		elseif ((string.find(eventType, "_DRAIN") or (string.find(eventType, "_LEECH"))) and powerType == COMBATLOG_POWERTYPE_HEALTH) then
			self:SendMessage("VanasKoS_PvPDamage", srcName, dstName, amount);
		end
	end

	if(eventType == "UNIT_DIED" and isPlayer(dstFlags)) then
		self:SendMessage("VanasKoS_PvPDeath", dstName);
	end
end

local playerDataList = nil;

function VanasKoSDataGatherer:OnEnable()
	-- on zonechange update zone
	self:RegisterEvent("ZONE_CHANGED", "UpdateZone");
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "UpdateZone");
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateZone");

	self:RegisterMessage("VanasKoS_Player_Data_Gathered", "Data_Gathered");
	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected");

	self:UpdateZone();

	playerDataList = self.db.realm.data.players;
	local count = 0;
	for k, v in pairs(playerDataList) do
		count = count + 1;
	end

	if(not self.db.profile.StorePlayerDataPermanently) then
		self:ScheduleTimer("CleanupPlayerDataDatabase", 10);
	end
	--VanasKoS:Print(format("%d entries in datalist", count));
end

function VanasKoSDataGatherer:OnDisable()
	self:UnregisterAllEvents();
	self:UnregisterAllMessages();
end

function VanasKoSDataGatherer:CleanupPlayerDataDatabase()
	local pkos = VanasKoS:GetList("PLAYERKOS");
	local hl = VanasKoS:GetList("HATELIST");
	local nl = VanasKoS:GetList("NICELIST");
	
	for k, v in pairs(playerDataList) do
		if(not (pkos[k] or hl[k] or nl[k])) then -- entry isn't in any of these lists.
			wipe(playerDataList[k]);
			playerDataList[k] = nil;
		end
	end
end

function VanasKoSDataGatherer:PurgeData()
	self.db.realm.data.players = { };
	playerDataList = { };
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
	
	if(self:IsInSanctuary() and not self.db.profile.GatherInCities) then
		return;
	end
	
	local lname = data.name:lower();

	if(not playerDataList[lname]) then
		playerDataList[lname] = { };
	end

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

local tourist = LibStub("LibTourist-3.0");
local eventsEnabled = false;

function VanasKoSDataGatherer:EnableEvents()
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	if(self.db.profile.UseCombatLog) then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	end
	eventsEnabled = true;
end

function VanasKoSDataGatherer:DisableEvents()
	self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");
	self:UnregisterEvent("PLAYER_TARGET_CHANGED");
	if (self.db.profile.UseCombatLog) then
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	end
	eventsEnabled = false;
end

function VanasKoSDataGatherer:UpdateZone()
	local zone = GetRealZoneText();
	local gatherEvents;

	if (self:IsInBattleground()) then
		gatherEvents = false;
	elseif (self:IsInSanctuary()) then
		gatherEvents = self.db.profile.EnableInSanctuary;
	else
		gatherEvents = true;
	end

	if (eventsEnabled and not gatherEvents) then
		self:DisableEvents();
	elseif (not eventsEnabled and gatherEvents) then
		self:EnableEvents();
	end
	
	self:SendMessage("VanasKoS_Zone_Changed", zone);
end

function VanasKoSDataGatherer:IsInSanctuary()
	local zone = GetRealZoneText();

	if(zone == BZ["Shattrath City"] or zone == BZ["Dalaran"]) then
		return true;
	else
		return false;
	end
end

function VanasKoSDataGatherer:IsInBattleground()
	local zone = GetRealZoneText();

	if(tourist:IsBattleground(zone) or
		tourist:IsInstance(zone) or
		tourist:IsArena(zone) or
		zone == BZ["Wintergrasp"]) then
		return true;
	else
		return false
	end
end

local gatheredData = { };
function VanasKoSDataGatherer:Get_Player_Data(unit)
	local zone = GetRealZoneText();

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

			self:SendMessage("VanasKoS_Player_Data_Gathered", gatheredData['list'], gatheredData);
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
	end
end

local LevelGuessLib = LibStub("LibLevelGuess-1.0");

function VanasKoSDataGatherer:SendDataMessage(name, faction, spellId)
	local zone = GetRealZoneText();
	-- dumb fix to hide obviously invalid strings gathered in other localizations then enUS
	if(name == nil or name:lower() == myName:lower()) then
		return;
	end
	
	gatheredData['name'] = name;
	gatheredData['faction'] = faction;
	gatheredData['zone'] = zone;

	local lname = name:lower();

	if(spellId ~= nil and tonumber(spellId)) then
		local level, classEnglish = LevelGuessLib:GetEstimatedLevelAndClassFromSpellId(spellId);
		--print("spellid", spellId, "level", level, "english", classEnglish);
		if(level ~= nil and classEnglish ~= nil) then
			if(not playerDataList[lname]) then
				playerDataList[lname] = { };
			end

			local oldLevel = 0;
			if(playerDataList[lname].level ~= nil) then -- update old level (was lower)
				if(string.find(playerDataList[lname].level, "+") ~= nil) then
					oldLevel = tonumber(string.match(playerDataList[lname].level, "%d+"));
				end
			end
			if(not playerDataList[lname].level or 
				playerDataList[lname].level == -1) then
				if(oldLevel < level) then
					if(level < 80) then
						level = level .. "+";
					end

					playerDataList[lname].level = level;
				end
			end
			
			if(playerDataList[lname].classEnglish and playerDataList[lname].classEnglish ~= classEnglish) then
				--print("VanasKoS DEBUG: Wrong data gathered: " .. spellId .. " " .. lname .. playerDataList[lname].classEnglish .. " ~= " .. classEnglish .. "  " .. spellName);
			end
			playerDataList[lname].classEnglish = classEnglish;
		end
	end
	-- /script VanasKoSDataGatherer:SendDataMessage("name", "enemy", nil);
	-- /dump VanasKoSDataGatherer.db.realm.data.players['name'];
	if(not self:IsInBattleground() and playerDataList[lname]) then
		gatheredData['level'] =  playerDataList[lname].level;
		gatheredData['guild'] = playerDataList[lname].guild;
		gatheredData['guildrank'] = playerDataList[lname].guildrank;
		gatheredData['class'] = playerDataList[lname].class;
		gatheredData['classEnglish'] = playerDataList[lname].classEnglish;
		gatheredData['race'] = playerDataList[lname].race;
		gatheredData['gender'] = playerDataList[lname].gender;
		gatheredData['realm'] = nil;
	else
		gatheredData['level'] =  nil;
		gatheredData['guild'] = nil;
		gatheredData['guildrank'] = nil;
		gatheredData['class'] = nil;
		gatheredData['classEnglish'] = nil;
		gatheredData['race'] = nil;
		gatheredData['gender'] = nil;
		gatheredData['realm'] = nil;
	end

	if(not self:IsInBattleground() and VanasKoS:BooleanIsOnList("PLAYERKOS", name)) then
		gatheredData['faction'] = "kos";
	end

	self:SendMessage("VanasKoS_Player_Detected", gatheredData);
end
