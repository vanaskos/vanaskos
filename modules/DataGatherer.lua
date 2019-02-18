--[[----------------------------------------------------------------------
      DataGatherer Module - Part of VanasKoS
Handles all external Player Data from Chat and Target Changes/Mouseovers
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/DataGatherer", false)
local LevelGuess = LibStub("LibLevelGuess-1.0")
VanasKoSDataGatherer = VanasKoS:NewModule("DataGatherer", "AceEvent-3.0", "AceTimer-3.0")

-- Declare some common global functions local
local assert = assert
local select = select
local pairs = pairs
local type = type
local tonumber = tonumber
local band = bit.band
local bor = bit.bor
local time = time
local wipe = wipe
local strfind = string.find
local UnitIsPlayer = UnitIsPlayer
local UnitIsEnemy = UnitIsEnemy
local UnitExists = UnitExists
local UnitName = UnitName
local UnitRace = UnitRace
local UnitClass = UnitClass
local UnitSex = UnitSex
local UnitGUID = UnitGUID
local UnitLevel = UnitLevel
local GetPlayerInfoByGUID = GetPlayerInfoByGUID
local GetGuildInfo = GetGuildInfo
local GetRealmName = GetRealmName
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local splitNameRealm = VanasKoS.splitNameRealm
local hashName = VanasKoS.hashName
local hashGuild = VanasKoS.hashGuild

-- Local Variables
local myName = nil
local myRealm = nil
local playerDataList = nil
local targetEventsEnabled = false
local combatEventsEnabled = false
local gatherEventEnabled = false
local gatheredData = {}

function VanasKoSDataGatherer:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("DataGatherer", {
		global = {
			data = {
				players = {
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
	})

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
					get = function()
						return VanasKoSDataGatherer.db.profile.UseCombatLog
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.UseCombatLog = v
						VanasKoSDataGatherer:EnableCombatEvents(v)
					end,
				},
				playerdatastore = {
					type = "toggle",
					order = 2,
					name = L["Permanent Player-Data-Storage"],
					desc = L["Toggles if the data about players (level, class, etc) should be saved permanently."],
					get = function()
						return VanasKoSDataGatherer.db.profile.StorePlayerDataPermanently
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.StorePlayerDataPermanently = v
					end,
				},
				gatherincities = {
					type = "toggle",
					order = 3,
					name = L["Save data gathered in cities"],
					desc = L["Toggles if data from players gathered in cities should be saved."],
					get = function()
						return VanasKoSDataGatherer.db.profile.GatherInCities
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.GatherInCities = v
						VanasKoSDataGatherer:ZoneChanged()
					end,
				},
				enableinsanctuary = {
					type = "toggle",
					order = 4,
					name = L["Enable in Sanctuaries"],
					desc = L["Toggles detection of players in sanctuaries"],
					get = function()
						return VanasKoSDataGatherer.db.profile.EnableInSanctuary
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.EnableInSanctuary = v
						VanasKoSDataGatherer:ZoneChanged()
					end,
				},
				enableincity = {
					type = "toggle",
					order = 5,
					name = L["Enable in Cities"],
					desc = L["Toggles detection of players in cities"],
					get = function()
						return VanasKoSDataGatherer.db.profile.EnableInCity
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.EnableInCity = v
						VanasKoSDataGatherer:ZoneChanged()
					end,
				},
				enableinbg = {
					type = "toggle",
					order = 6,
					name = L["Enable in Battleground"],
					desc = L["Toggles detection of players in battlegrounds"],
					get = function()
						return VanasKoSDataGatherer.db.profile.EnableInBattleground
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.EnableInBattleground = v
						VanasKoSDataGatherer:ZoneChanged()
					end,
				},
				enableincombatzone = {
					type = "toggle",
					order = 7,
					name = L["Enable in combat zone"],
					desc = L["Toggles detection of players in combat zones (Wintergrasp, Tol Barad)"],
				get = function()
					return VanasKoSDataGatherer.db.profile.EnableInCombatZone
				end,
				set = function(frame, v)
					VanasKoSDataGatherer.db.profile.EnableInCombatZone = v
					VanasKoSDataGatherer:ZoneChanged()
				end,
				},
				enableinarena = {
					type = "toggle",
					order = 8,
					name = L["Enable in arena"],
					desc = L["Toggles detection of players in arenas"],
					get = function()
						return VanasKoSDataGatherer.db.profile.EnableInArena
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.EnableInArena = v
						VanasKoSDataGatherer:ZoneChanged()
					end,
				}
			},
		},
	})

	VanasKoS:RegisterList(nil, "PLAYERDATA", nil, self)
	VanasKoS:RegisterList(nil, "GUILDDATA", nil, self)
	myName = UnitName("player")
	myRealm = GetRealmName()
end

local COMBATLOG_FILTER_PLAYER = bor(COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PLAYER)
local COMBATLOG_FILTER_HOSTILE_PLAYER = bor(COMBATLOG_OBJECT_REACTION_HOSTILE, COMBATLOG_FILTER_PLAYER)
local COMBATLOG_FILTER_NEUTRAL_PLAYER = bor(COMBATLOG_OBJECT_REACTION_NEUTRAL, COMBATLOG_FILTER_PLAYER)
local COMBATLOG_FILTER_FRIENDLY_PLAYER = bor(COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_FILTER_PLAYER)

local COMBATLOG_POWERTYPE_HEALTH = -2

local function isFriendlyOrEnemy(flags)
	if(flags and band(flags, COMBATLOG_FILTER_FRIENDLY_PLAYER) == COMBATLOG_FILTER_FRIENDLY_PLAYER) then
		return "friendly"
	end
	if(flags and band(flags, COMBATLOG_FILTER_NEUTRAL_PLAYER) == COMBATLOG_FILTER_NEUTRAL_PLAYER) then
		return "neutral"
	end
	if(flags and band(flags, COMBATLOG_FILTER_HOSTILE_PLAYER) == COMBATLOG_FILTER_HOSTILE_PLAYER) then
		return "enemy"
	end
	return nil
end

local function isPlayer(flags)
	if(flags and band(flags, COMBATLOG_FILTER_PLAYER) == COMBATLOG_FILTER_PLAYER) then
		return true
	end
	return nil
end

function VanasKoSDataGatherer:COMBAT_LOG_EVENT_UNFILTERED(...)
	local offset = 1
	local spellID = nil
	local amount = nil
	local powerType = nil
	local eventType, _, srcGUID, srcNameRealm, srcFlags, _, dstGUID, dstNameRealm, dstFlags, _ = select(2, CombatLogGetCurrentEventInfo())
	local srcName, srcRealm = splitNameRealm(srcNameRealm)
	if srcName and srcRealm == nil then
		srcRealm = myRealm
	end
	local dstName, dstRealm = splitNameRealm(dstNameRealm)
	if dstName and dstRealm == nil then
		dstRealm = myRealm
	end

	if(strfind(eventType, "SPELL_") or strfind(eventType, "RANGE_")) then
		spellID, _, _ = select(offset, ...)
		offset = offset + 3
	end
	if(strfind(eventType, "_DAMAGE")) then
--		amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(offset, ...)
		amount = select(offset, ...)
		offset = offset + 9
	elseif(strfind(eventType, "_LEECH") or strfind(eventType, "DRAIN")) then
--		amount, powerType, extraAmount = select(offset, ...)
		amount, powerType = select(offset, ...)
		offset = offset + 3
	end

	--self:PrintLiteral(eventType, srcNameRealm, srcFlags, dstNameRealm, dstFlags)
	--if(dstNameRealm and srcNameRealm and dstNameRealm ~= srcNameRealm) then
	--	ChatFrame2:AddMessage(eventType .. " " .. (srcNameRealm or "nil") .. " -> " .. (dstNameRealm or "nil") .. "  -  " .. (spellName or "nil"))
	--end
	if(strfind(eventType, "SPELL_AURA_")) then
		-- in case a auro is removed or applied it may be that the auro was gained from someone else and spellID is therefore from the class who casted the aura
		--(and because we don't know where that player is, ignore him)
		if(srcNameRealm ~= dstNameRealm) then
			spellID = nil
		end

		-- in case auras are applied or fade, use only the player who gains the aura / from whom fades the aura
		--[[
			SPELL_AURA_APPLIED:
				lockenkopf gains Raktic's trueshot aura
				dst<-			src

			SPELL_AURA_REMOVED:
				name's *aura* fades from name
				src			dst <-

		]]

		local fOrE = isFriendlyOrEnemy(dstFlags)
		if(dstNameRealm and fOrE and dstNameRealm ~= myName) then
			VanasKoSDataGatherer:SendDataMessage(dstName, dstRealm, dstGUID, fOrE, spellID)
			return
		end
	end

	-- try source and destination  if source or destination is friendly, register as event
	if(srcNameRealm ~= nil and srcNameRealm ~= myName) then
		local fOrE = isFriendlyOrEnemy(srcFlags)
		if(fOrE) then
			VanasKoSDataGatherer:SendDataMessage(srcName, srcRealm, srcGUID, fOrE, spellID)
		end
	end

	if(dstNameRealm ~= nil and dstNameRealm ~= myName) then
		local fOrE = isFriendlyOrEnemy(dstFlags)
		if(fOrE) then
			VanasKoSDataGatherer:SendDataMessage(dstName, dstRealm, dstGUID, fOrE, spellID)
		end
	end

	if((dstNameRealm == myName and isFriendlyOrEnemy(srcFlags) == "enemy") or
		(srcNameRealm == myName and isFriendlyOrEnemy(dstFlags) == "enemy")) then
		if(strfind(eventType, "_DAMAGE")) then
			self:SendMessage("VanasKoS_PvPDamage", srcName, srcRealm, dstName, dstRealm, amount)
		elseif ((strfind(eventType, "_DRAIN") or (strfind(eventType, "_LEECH"))) and powerType == COMBATLOG_POWERTYPE_HEALTH) then
			self:SendMessage("VanasKoS_PvPDamage", srcName, srcRealm, dstName, dstRealm, amount)
		end
	end

	if(eventType == "UNIT_DIED" and isPlayer(dstFlags)) then
		self:SendMessage("VanasKoS_PvPDeath", dstName, dstRealm)
	end
end

function VanasKoSDataGatherer:OnEnable()
	-- on areachange update area
	self:RegisterMessage("VanasKoS_Zone_Changed", "ZoneChanged")
	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected")

	self:ZoneChanged()

	playerDataList = self.db.global.data.players
	local count = 0
	for _ in pairs(playerDataList) do
		count = count + 1
	end

	if(not self.db.profile.StorePlayerDataPermanently) then
		self:ScheduleTimer("CleanupPlayerDataDatabase", 10)
	end
	--VanasKoS:Print(format("%d entries in datalist", count))
end

function VanasKoSDataGatherer:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
end

function VanasKoSDataGatherer:CleanupPlayerDataDatabase()
	local pkos = VanasKoS:GetList("PLAYERKOS") or {}
	local hl = VanasKoS:GetList("HATELIST") or {}
	local nl = VanasKoS:GetList("NICELIST") or {}
	local ps = VanasKoS:GetList("PVPSTATS", 1) or {}
	local pl = VanasKoS:GetList("PVPLOG") or {}

	for k, _ in pairs(playerDataList) do
		if(not (pkos[k] or hl[k] or nl[k] or ps[k] or pl[k])) then -- entry isn't in any of these lists.
			wipe(playerDataList[k])
			playerDataList[k] = nil
		end
	end
end

function VanasKoSDataGatherer:PurgeData()
	self.db.global.data.players = {}
	playerDataList = {}
end

-- if a player was detected nearby through chat or mouseover, update lastseen
function VanasKoSDataGatherer:Player_Detected(message, data)
	assert(data.name)
	assert(data.realm)
	-- if the player is on a relevant list, update last seen
	self:UpdateLastSeen(data.name, data.realm)
end

function VanasKoSDataGatherer:IsOnList(listname, key)
	local listVar = VanasKoS:GetList(listname)
	if(listVar and listVar[key]) then
		return listVar[key]
	else
		return nil
	end
end


function VanasKoSDataGatherer:GetList(list)
	if(list == "PLAYERDATA") then
		return self.db.global.data.players
	else
		return nil
	end
end

function VanasKoSDataGatherer:AddEntry(list, key, data)
	return true
end

function VanasKoSDataGatherer:RemoveEntry(listname, key)
	local list = VanasKoS:GetList(listname)
	if(list and list[key]) then
		list[key] = nil
		self:SendMessage("VanasKoS_List_Entry_Removed", listname, key)
	end
end

function VanasKoSDataGatherer:UpdateLastSeen(name, realm)
	local key = hashName(name, realm)
	if(playerDataList[key] ~= nil) then
		if (time() - (playerDataList[key].lastseen or 0) > 300) then
			playerDataList[key].seen = (playerDataList[key].seen or 0) + 1
		end
		playerDataList[key].lastseen = time()
	end
end

function VanasKoSDataGatherer:Data_Gathered(message, list, data)
	-- self:PrintLiteral(list, name, guild, level, race, class, gender)
	assert(data.name)
	assert(data.realm)
	local key = hashName(data.name, data.realm)

	if(not playerDataList[key]) then
		playerDataList[key] = {}
	end

	if (data.guild) then
		playerDataList[key].guild = data.guild
	end

	if (data.guildrank) then
		playerDataList[key].guildrank = data.guildrank
	end

	playerDataList[key].name = data.name
	playerDataList[key].realm = data.realm
	playerDataList[key].level = data.level
	playerDataList[key].race = data.race
	playerDataList[key].class = data.class
	playerDataList[key].classEnglish = data.classEnglish
	playerDataList[key].gender = data.gender
	playerDataList[key].mapID = data.mapID
	playerDataList[key].guid = data.guid
end

function VanasKoSDataGatherer:EnableTargetEvents(enable)
	if (enable and (not targetEventsEnabled)) then
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		targetEventsEnabled = true
	elseif ((not enable) and targetEventsEnabled) then
		self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		self:UnregisterEvent("PLAYER_TARGET_CHANGED")
		targetEventsEnabled = false
	end
end

function VanasKoSDataGatherer:EnableCombatEvents(enable)
	if(enable and (not combatEventsEnabled)) then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		combatEventsEnabled = true
	elseif ((not enable) and combatEventsEnabled) then
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		combatEventsEnabled = false
	end
end

function VanasKoSDataGatherer:EnableDataGathering(enable)
	if(enable and (not gatherEventEnabled)) then
		-- print("enable data gathering")
		self:RegisterMessage("VanasKoS_Player_Data_Gathered", "Data_Gathered")
		gatherEventEnabled = true
	elseif ((not enable) and combatEventsEnabled) then
		-- print("disable data gathering")
		self:UnregisterMessage("VanasKoS_Player_Data_Gathered")
		gatherEventEnabled = false
	end
end


function VanasKoSDataGatherer:ZoneChanged()
	if (VanasKoS:IsInSanctuary()) then
		self:EnableTargetEvents(self.db.profile.EnableInSanctuary)
		self:EnableCombatEvents(self.db.profile.EnableInSanctuary and self.db.profile.UseCombatLog)
	elseif (VanasKoS:IsInCity()) then
		self:EnableTargetEvents(self.db.profile.EnableInCity)
		self:EnableCombatEvents(self.db.profile.EnableInCity and self.db.profile.UseCombatLog)
	elseif (VanasKoS:IsInBattleground()) then
		self:EnableTargetEvents(self.db.profile.EnableInBattleground)
		self:EnableCombatEvents(self.db.profile.EnableInBattleground and self.db.profile.UseCombatLog)
	elseif (VanasKoS:IsInCombatZone()) then
		self:EnableTargetEvents(self.db.profile.EnableInCombatZone)
		self:EnableCombatEvents(self.db.profile.EnableInCombatZone and self.db.profile.UseCombatLog)
	elseif (VanasKoS:IsInArena()) then
		self:EnableTargetEvents(self.db.profile.EnableInArena)
		self:EnableCombatEvents(self.db.profile.EnableInArena and self.db.profile.UseCombatLog)
	elseif (VanasKoS:IsInDungeon()) then
		self:EnableTargetEvents(false)
		self:EnableCombatEvents(false)
	else
		self:EnableTargetEvents(true)
		self:EnableCombatEvents(self.db.profile.UseCombatLog)
	end

	if (VanasKoS:IsInCity()) then
		self:EnableDataGathering(self.db.profile.GatherInCities)
	else
		self:EnableDataGathering(true)
	end
end

function VanasKoSDataGatherer:Get_Player_Data(unit)
	if(UnitIsPlayer(unit) and UnitName(unit) ~= myName) then
		local name, realm = UnitName(unit)
		assert(name)
		if not realm then
			--print(name .. " ( " .. unit .. ") has no realm, assuming local")
			realm = myRealm
		end
		wipe(gatheredData)
		gatheredData.name = name
		gatheredData.realm = realm
		gatheredData.pvp = UnitIsPVP(unit)
		gatheredData.guild, gatheredData.guildrank = GetGuildInfo(unit)
		gatheredData.race = UnitRace(unit)
		gatheredData.class, gatheredData.classEnglish = UnitClass(unit)
		gatheredData.gender = UnitSex(unit)
		gatheredData.mapID = VanasKoS:MapID()
		gatheredData.faction = nil
		gatheredData.guid = UnitGUID(unit)

		local lvl = UnitLevel(unit)
		local key = hashName(name, realm)
		local guildKey = gatheredData.guild and hashGuild(gatheredData.guild, gatheredData.realm) or nil
		if(lvl == -1) then
			lvl = (UnitLevel("player") or 1) + 10
			local oldLevel = (playerDataList[key] and playerDataList[key].level) or -1
			local oldLevelNum = oldLevel
			if (type(oldLevel) == "string") then
				oldLevelNum = tonumber(select(3, strfind(oldLevel, "(%d+)[+]"))) or -1
			end
			if(oldLevelNum > lvl) then
				lvl = oldLevel
			elseif(lvl < 110) then
				lvl = lvl .. "+"
			end
		end
		gatheredData.level = lvl

		gatheredData.list = select(2, VanasKoS:IsOnList(nil, key)) or (guildKey and select(2, VanasKoS:IsOnList(nil, guildKey)))

		if((gatheredData.list == "PLAYERKOS" or gatheredData.list == "GUILDKOS")) then
			gatheredData.faction = "kos"
		elseif((gatheredData.list == "NICELIST" or gatheredData.list == "NICELIST")) then
			gatheredData.faction = "nice"
		elseif((gatheredData.list == "HATELIST" or gatheredData.list == "HATELIST")) then
			gatheredData.faction = "hate"
		elseif(UnitExists(unit) and UnitIsEnemy("player", unit)) then
			gatheredData.faction = "enemy"
		else
			gatheredData.faction = "friendly"
		end

		self:SendMessage("VanasKoS_Player_Data_Gathered", gatheredData.list, gatheredData)

		return true
	end

	return false
end

function VanasKoSDataGatherer:PLAYER_TARGET_CHANGED()
	if(self:Get_Player_Data("target")) then
		self:SendMessage("VanasKoS_Player_Detected", gatheredData)
		self:SendMessage("VanasKoS_Player_Target_Changed", gatheredData)
	else
		self:SendMessage("VanasKoS_Mob_Target_Changed", nil, nil, nil)
	end
end


-- /script for i=1,10000 do VanasKoSDataGatherer:UPDATE_MOUSEOVER_UNIT() end
-- /script local x = {name = test, faction = 'enemy'}; for i=1,10000 do x.name = "Moep" .. math.random(1, 100000); VanasKoSDataGatherer:SendMessage("VanasKoS_Player_Detected", x); end
function VanasKoSDataGatherer:UPDATE_MOUSEOVER_UNIT()
	if(self:Get_Player_Data("mouseover")) then
		self:SendMessage("VanasKoS_Player_Detected", gatheredData)
	end
end

function VanasKoSDataGatherer:SendDataMessage(name, realm, guid, faction, spellId)
	local mapID = VanasKoS:MapID()
	local class, classEnglish, race, raceEnglish, gender = GetPlayerInfoByGUID(guid)
	wipe(gatheredData)
	gatheredData.name = name
	gatheredData.realm = realm
	gatheredData.faction = faction
	gatheredData.mapID = mapID
	gatheredData.class = class
	gatheredData.classEnglish = classEnglish
	gatheredData.race = race
	gatheredData.raceEnglish = raceEnglish
	gatheredData.gender = gender
	gatheredData.guid = guid

	local level = -1
	if(spellId and tonumber(spellId)) then
		level = LevelGuess:GetEstimatedLevelAndClassFromSpellId(spellId) or -1
	end
	local key = hashName(gatheredData.name, gatheredData.realm)
	local oldLevel = (playerDataList[key] and playerDataList[key].level) or -1
	local oldLevelNum = oldLevel
	if (type(oldLevel) == "string") then
		oldLevelNum = tonumber(select(3, strfind(oldLevel, "(%d+)[+]"))) or -1
	end
	-- print("gathered", name, oldLevel, level)
	if(oldLevelNum > level) then
		level = oldLevel
	elseif (level < 1) then
		level = nil
	elseif (level < 110) then
		level = level .. "+"
	end
	gatheredData.guild = playerDataList[key] and playerDataList[key].guild
	local guildkey = gatheredData.guild and hashGuild(gatheredData.guild, gatheredData.realm) or nil
	gatheredData.level = level
	-- print("spellid", spellId, "level", gatheredData.level, "english", classEnglish)

	-- /script VanasKoSDataGatherer:SendDataMessage("name", "realm", "enemy", nil)
	-- /dump VanasKoSDataGatherer.db.realm.data.players['name']
	if(VanasKoS:BooleanIsOnList("PLAYERKOS", key)) then
		gatheredData.faction = "kos"
	elseif(guildKey and VanasKoS:BooleanIsOnList("GUILDKOS", guildKey)) then
		gatheredData.faction = "kos"
	elseif(VanasKoS:BooleanIsOnList("HATELIST", key)) then
		gatheredData.faction = "hate"
	elseif(VanasKoS:BooleanIsOnList("NICELIST", key)) then
		gatheredData.faction = "nice"
	end

	if(gatheredData.faction == "kos") then
		gatheredData.list = "PLAYERKOS"
	else
		gatheredData.list = nil
	end

	self:SendMessage("VanasKoS_Player_Data_Gathered", gatheredData.list, gatheredData)
	self:SendMessage("VanasKoS_Player_Detected", gatheredData)
end
