--[[----------------------------------------------------------------------
      DataGatherer Module - Part of VanasKoS
Handles all external Player Data from Chat and Target Changes/Mouseovers
------------------------------------------------------------------------]]

VanasKoSDataGatherer = VanasKoS:NewModule("DataGatherer", "AceEvent-3.0", "AceTimer-3.0");

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/DataGatherer", false);

local VanasKoSDataGatherer = VanasKoSDataGatherer;
local VanasKoS = VanasKoS;

local myName = nil;

local combatLogEventRegistered = true;

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
				EnableInCity = true,
				EnableInBattleground = false,
				EnableInCombatZone = false,
				EnableInArena = false,
			},
		});

	VanasKoSGUI:AddMainMenuConfigOptions({
		data_gatherer_group = {
			name = L["Data Gathering"],
			type = "group",
			args = {
				combatlog = {
					type = "toggle",
					order = 1,
					name = L["Use Combat Log"],
					desc = L["Toggles if the combatlog should be used to detect nearby player"],
					get = function() return VanasKoSDataGatherer.db.profile.UseCombatLog; end,
					set = function(frame, v) VanasKoSDataGatherer.db.profile.UseCombatLog = v; VanasKoSDataGatherer:EnableCombatEvents(v); end,
				},
				playerdatastore = {
					type = "toggle",
					order = 2,
					name = L["Permanent Player-Data-Storage"],
					desc = L["Toggles if the data about players (level, class, etc) should be saved permanently."],
					get = function() return VanasKoSDataGatherer.db.profile.StorePlayerDataPermanently; end,
					set = function(frame, v) VanasKoSDataGatherer.db.profile.StorePlayerDataPermanently = v; end,
				},
				gatherincities = {
					type = "toggle",
					order = 3,
					name = L["Save data gathered in cities"],
					desc = L["Toggles if data from players gathered in cities should be saved."],
					get = function() return VanasKoSDataGatherer.db.profile.GatherInCities; end,
					set = function(frame, v) VanasKoSDataGatherer.db.profile.GatherInCities = v; VanasKoSDataGatherer:ZoneChanged(); end,
				},
				enableinsanctuary = {
					type = "toggle",
					order = 4,
					name = L["Enable in Sanctuaries"],
					desc = L["Toggles detection of players in sanctuaries"],
					get = function() return VanasKoSDataGatherer.db.profile.EnableInSanctuary; end,
					set = function(frame, v) VanasKoSDataGatherer.db.profile.EnableInSanctuary = v; VanasKoSDataGatherer:ZoneChanged(); end,
				},
				enableincity = {
					type = "toggle",
					order = 5,
					name = L["Enable in Cities"],
					desc = L["Toggles detection of players in cities"],
					get = function() return VanasKoSDataGatherer.db.profile.EnableInCity; end,
					set = function(frame, v) VanasKoSDataGatherer.db.profile.EnableInCity = v; VanasKoSDataGatherer:ZoneChanged(); end,
				},
				enableinbg = {
				    type = "toggle",
				    order = 6,
				    name = L["Enable in Battleground"],
				    desc = L["Toggles detection of players in battlegrounds"],
				    get = function() return VanasKoSDataGatherer.db.profile.EnableInBattleground; end,
				    set = function(frame, v) VanasKoSDataGatherer.db.profile.EnableInBattleground = v; VanasKoSDataGatherer:ZoneChanged(); end,
				},
				enableincombatzone = {
				    type = "toggle",
				    order = 7,
				    name = L["Enable in combat zone"],
				    desc = L["Toggles detection of players in combat zones (Wintergrasp, Tol Barad)"],
				    get = function() return VanasKoSDataGatherer.db.profile.EnableInCombatZone; end,
				    set = function(frame, v) VanasKoSDataGatherer.db.profile.EnableInCombatZone = v; VanasKoSDataGatherer:ZoneChanged(); end,
				},
				enableinarena = {
				    type = "toggle",
				    order = 8,
				    name = L["Enable in arena"],
				    desc = L["Toggles detection of players in arenas"],
				    get = function() return VanasKoSDataGatherer.db.profile.EnableInArena; end,
				    set = function(frame, v) VanasKoSDataGatherer.db.profile.EnableInArena = v; VanasKoSDataGatherer:ZoneChanged(); end,
				}
			},
		},
	});
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

function VanasKoSDataGatherer:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)
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
			VanasKoSDataGatherer:SendDataMessage(dstName, dstGUID, fOrE, spellID);
			return;
		end
	end
	
	
	-- try source and destinatio  if source or destination is friendly, register as event
	if(srcName ~= nil and srcName ~= myName) then
		local fOrE = isFriendlyOrEnemy(srcFlags);
		if(fOrE) then
			VanasKoSDataGatherer:SendDataMessage(srcName, srcGUID, fOrE, spellID);
		end
	end

	if(dstName ~= nil and dstName ~= myName) then
		local fOrE = isFriendlyOrEnemy(dstFlags);
		if(fOrE) then
			VanasKoSDataGatherer:SendDataMessage(dstName, dstGUID, fOrE, spellID);
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
	self:RegisterMessage("VanasKoS_Zone_Changed", "ZoneChanged");
	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected");

	self:ZoneChanged();

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
	local pkos = VanasKoS:GetList("PLAYERKOS") or {};
	local hl = VanasKoS:GetList("HATELIST") or {};
	local nl = VanasKoS:GetList("NICELIST") or {};
	local ps = VanasKoS:GetList("PVPSTATS", 1) or {};
	
	for k, v in pairs(playerDataList) do
		if(not (pkos[k] or hl[k] or nl[k] or ps[k])) then -- entry isn't in any of these lists.
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
		if (time() - (playerDataList[lname].lastseen or 0) > 300) then
			playerDataList[lname].seen = (playerDataList[lname].seen or 0) + 1;
		end
		playerDataList[lname].lastseen = time();
	end
end

function VanasKoSDataGatherer:Data_Gathered(message, list, data)
	-- self:PrintLiteral(list, name, guild, level, race, class, gender);
	assert(data.name ~= nil)
	
	local lname = data.name:lower();

	if(not playerDataList[lname]) then
		playerDataList[lname] = { };
	end

	if (data.guild) then
		playerDataList[lname].guild = data.guild;
	end

	if (data.guildrank) then
		playerDataList[lname].guildrank = data.guildrank;
	end

	playerDataList[lname].level = data.level;
	playerDataList[lname].race = data.race;
	playerDataList[lname].class = data.class;
	playerDataList[lname].classEnglish = data.classEnglish;
	playerDataList[lname].gender = data.gender;
	playerDataList[lname].zone = data.zone;

	--
	if(data.guild and VanasKoS:BooleanIsOnList("GUILDKOS", data.guild)) then
		local guildData = VanasKoS:GetList("GUILDDATA");
		if(not guildData[data.guild:lower()]) then
			guildData[data.guild:lower()] = { };
		end
		guildData[data.guild:lower()].displayname = data.guild;
	end
end

local targetEventsEnabled = false;
function VanasKoSDataGatherer:EnableTargetEvents(enable)
	if (enable and (not targetEventsEnabled)) then
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
		self:RegisterEvent("PLAYER_TARGET_CHANGED");
		targetEventsEnabled = true;
	elseif ((not enable) and targetEventsEnabled) then
		self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");
		self:UnregisterEvent("PLAYER_TARGET_CHANGED");
		targetEventsEnabled = false;
	end
end

local combatEventsEnabled = false;
function VanasKoSDataGatherer:EnableCombatEvents(enable)
	if(enable and (not combatEventsEnabled)) then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		combatEventsEnabled = true;
	elseif ((not enable) and combatEventsEnabled) then
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		combatEventsEnabled = false;
	end
end

local gatherEventEnabled = false;
function VanasKoSDataGatherer:EnableDataGathering(enable)
	if(enable and (not gatherEventEnabled)) then
		-- print("enable data gathering");
		self:RegisterMessage("VanasKoS_Player_Data_Gathered", "Data_Gathered");
		gatherEventEnabled = true;
	elseif ((not enable) and combatEventsEnabled) then
		-- print("disable data gathering");
		self:UnregisterMessage("VanasKoS_Player_Data_Gathered");
		gatherEventEnabled = false;
	end
end


function VanasKoSDataGatherer:ZoneChanged()
	if (VanasKoS:IsInSanctuary()) then
		self:EnableTargetEvents(self.db.profile.EnableInSanctuary);
		self:EnableCombatEvents(self.db.profile.EnableInSanctuary and self.db.profile.UseCombatLog);
	elseif (VanasKoS:IsInCity()) then
		self:EnableTargetEvents(self.db.profile.EnableInCity);
		self:EnableCombatEvents(self.db.profile.EnableInCity and self.db.profile.UseCombatLog);
	elseif (VanasKoS:IsInBattleground()) then
		self:EnableTargetEvents(self.db.profile.EnableInBattleground);
		self:EnableCombatEvents(self.db.profile.EnableInBattleground and self.db.profile.UseCombatLog);
	elseif (VanasKoS:IsInCombatZone()) then
		self:EnableTargetEvents(self.db.profile.EnableInCombatZone);
		self:EnableCombatEvents(self.db.profile.EnableInCombatZone and self.db.profile.UseCombatLog);
	elseif (VanasKoS:IsInArena()) then
		self:EnableTargetEvents(self.db.profile.EnableInArena);
		self:EnableCombatEvents(self.db.profile.EnableInArena and self.db.profile.UseCombatLog);
	elseif (VanasKoS:IsInDungeon()) then
		self:EnableTargetEvents(false);
		self:EnableCombatEvents(false);
	else
		self:EnableTargetEvents(true);
		self:EnableCombatEvents(self.db.profile.UseCombatLog);
	end

	if (VanasKoS:IsInCity()) then
		self:EnableDataGathering(self.db.profile.GatherInCities);
	else
		self:EnableDataGathering(true);
	end
end

local gatheredData = { };
function VanasKoSDataGatherer:Get_Player_Data(unit)
	if(UnitIsPlayer(unit) and UnitName(unit) ~= myName) then
		local name, realm = UnitName(unit);

		if(name == nil) then
			return false;
		end
		if(realm and realm ~= "") then
			name = name .. "-" .. realm;
		end
		wipe(gatheredData);
		gatheredData.name = name;
		gatheredData.guild, gatheredData.guildrank = GetGuildInfo(unit);
		gatheredData.race = UnitRace(unit);
		gatheredData.class, gatheredData.classEnglish = UnitClass(unit);
		gatheredData.gender = UnitSex(unit);
		gatheredData.zone = GetRealZoneText();
		gatheredData.faction = nil;

		if(gatheredData.guild and realm and realm ~= "") then
			gatheredData.guild = gatheredData.guild .. "-" .. realm;
		end

		local lvl = UnitLevel(unit);
		local lname = name:lower();
		if(lvl == -1) then
			lvl = (UnitLevel("player") or 1) + 10;
			local oldLevel = (playerDataList[lname] and playerDataList[lname].level) or -1;
			local oldLevelNum = oldLevel;
			if (type(oldLevel) == "string") then
				oldLevelNum = tonumber(select(3, strfind(oldLevel, "(%d+)[+]"))) or -1;
			end
			if(oldLevelNum > lvl) then
				lvl = oldLevel;
			elseif(lvl < 85) then
				lvl = lvl .. "+";
			end
		end
		gatheredData.level = lvl;

		gatheredData.list = select(2, VanasKoS:IsOnList(nil, gatheredData.name));

		if((gatheredData.list == "PLAYERKOS" or gatheredData.list == "GUILDKOS")) then
			gatheredData.faction = "kos";
		elseif(UnitExists(unit) and UnitIsEnemy("player", unit)) then
			gatheredData.faction = "enemy";
		else
			gatheredData.faction = "friendly";
		end

		self:SendMessage("VanasKoS_Player_Data_Gathered", gatheredData.list, gatheredData);

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

function VanasKoSDataGatherer:SendDataMessage(name, guid, faction, spellId)
	local zone = GetRealZoneText();
	-- dumb fix to hide obviously invalid strings gathered in other localizations then enUS
	if(not name or name:lower() == myName:lower()) then
		return;
	end
	
	local class, classEnglish, race, raceEnglish, gender = GetPlayerInfoByGUID(guid)
	wipe(gatheredData);
	gatheredData.name = name;
	gatheredData.faction = faction;
	gatheredData.zone = zone;
	gatheredData.class = class;
	gatheredData.classEnglish = classEnglish;
	gatheredData.race = race;
	gatheredData.raceEnglish = raceEnglish;
	gatheredData.gender = gender;

	local level = -1;
	if(spellId and tonumber(spellId)) then
		level = LevelGuessLib:GetEstimatedLevelAndClassFromSpellId(spellId) or -1;
	end
	local lname = name:lower();
	local oldLevel = (playerDataList[lname] and playerDataList[lname].level) or -1;
	local oldLevelNum = oldLevel;
	if (type(oldLevel) == "string") then
		oldLevelNum = tonumber(select(3, strfind(oldLevel, "(%d+)[+]"))) or -1;
	end
	-- print("gathered", name, oldLevel, level);
	if(oldLevelNum > level) then
		level = oldLevel;
	elseif (level < 1) then
		level = nil;
	elseif (level < 85) then
		level = level .. "+";
	end
	gatheredData.level = level;
	-- print("spellid", spellId, "level", gatheredData.level, "english", classEnglish);

	-- /script VanasKoSDataGatherer:SendDataMessage("name", "enemy", nil);
	-- /dump VanasKoSDataGatherer.db.realm.data.players['name'];
	if(VanasKoS:BooleanIsOnList("PLAYERKOS", name)) then
		gatheredData.faction = "kos";
	end

	if(gatheredData.faction == "kos") then
		gatheredData.list = "PLAYERKOS";
	else
		gatheredData.list = nil;
	end

	self:SendMessage("VanasKoS_Player_Data_Gathered", gatheredData.list, gatheredData);
	self:SendMessage("VanasKoS_Player_Detected", gatheredData);
end
