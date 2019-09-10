--[[----------------------------------------------------------------------
      DataGatherer Module - Part of VanasKoS
Handles all external Player Data from Chat and Target Changes/Mouseovers
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/DataGatherer", false)
local LevelGuess = LibStub("LibLevelGuess-1.0")
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")
local VanasKoSGUI = VanasKoS:GetModule("GUI")
local VanasKoSDataGatherer = VanasKoS:NewModule("DataGatherer", "AceEvent-3.0", "AceTimer-3.0")

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
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo

-- Local Variables
local myName = nil
local playerDataList = {}
local targetEventsEnabled = false
local combatEventsEnabled = false
local gatherEventEnabled = false
local gatheredData = {}

function VanasKoSDataGatherer:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("DataGatherer", {
		realm = {
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
				combatlog_header = {
					order = 1,
					type = "header",
					name = L["Combat Log Monitoring"],
				},
				combatlog = {
					type = "toggle",
					order = 2,
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
				enableinsanctuary = {
					type = "toggle",
					order = 3,
					name = L["Enable in Sanctuaries"],
					desc = L["Toggles detection of players in sanctuaries"],
					get = function()
						return VanasKoSDataGatherer.db.profile.EnableInSanctuary
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.EnableInSanctuary = v
						VanasKoSDataGatherer:Update()
					end,
				},
				enableincity = {
					type = "toggle",
					order = 4,
					name = L["Enable in Cities"],
					desc = L["Toggles detection of players in cities"],
					get = function()
						return VanasKoSDataGatherer.db.profile.EnableInCity
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.EnableInCity = v
						VanasKoSDataGatherer:Update()
					end,
				},
				enableinbg = {
					type = "toggle",
					order = 5,
					name = L["Enable in Battleground"],
					desc = L["Toggles detection of players in battlegrounds"],
					get = function()
						return VanasKoSDataGatherer.db.profile.EnableInBattleground
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.EnableInBattleground = v
						VanasKoSDataGatherer:Update()
					end,
				},
				enableincombatzone = {
					type = "toggle",
					order = 6,
					name = L["Enable in combat zone"],
					desc = L["Toggles detection of players in combat zones (Wintergrasp, Tol Barad)"],
					get = function()
						return VanasKoSDataGatherer.db.profile.EnableInCombatZone
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.EnableInCombatZone = v
						VanasKoSDataGatherer:Update()
					end,
				},
				enableinarena = {
					type = "toggle",
					order = 7,
					name = L["Enable in arena"],
					desc = L["Toggles detection of players in arenas"],
					get = function()
						return VanasKoSDataGatherer.db.profile.EnableInArena
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.EnableInArena = v
						VanasKoSDataGatherer:Update()
					end,
				},
				datastorage_header = {
					order = 10,
					type = "header",
					name = L["Player-Data Storage"],
				},
				playerdatastore = {
					type = "toggle",
					order = 11,
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
					order = 12,
					name = L["Save data gathered in cities"],
					desc = L["Toggles if data from players gathered in cities should be saved."],
					get = function()
						return VanasKoSDataGatherer.db.profile.GatherInCities
					end,
					set = function(frame, v)
						VanasKoSDataGatherer.db.profile.GatherInCities = v
						VanasKoSDataGatherer:Update()
					end,
				},
			},
		},
	})

	VanasKoS:RegisterList(nil, "PLAYERDATA", nil, self)
	VanasKoS:RegisterList(nil, "GUILDDATA", nil, self)
	myName = UnitName("player")
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

function VanasKoSDataGatherer:CombatEvent(timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)
	local offset = 1
	local spellID = nil
	local amount = nil
	local powerType = nil
	local _ = nil

	if(strfind(eventType, "SPELL_") or strfind(eventType, "RANGE_")) then
		spellID, _, _ = select(offset, ...)
		offset = offset + 3
	end
	if(strfind(eventType, "_DAMAGE")) then
		amount = select(offset, ...)
		--print("_DAMAGE Amount is " .. amount)
		offset = offset + 9
	elseif(strfind(eventType, "_LEECH") or strfind(eventType, "DRAIN")) then
		amount, powerType = select(offset, ...)
		--print("_LEECH Amount is " .. amount)
		offset = offset + 3
	end

	--self:PrintLiteral(eventType, srcName, srcFlags, dstName, dstFlags)
	--if(dstName and srcName and dstName ~= srcName) then
	--	ChatFrame2:AddMessage(eventType .. " " .. (srcName or "nil") .. " -> " .. (dstName or "nil") .. "  -  " .. (spellName or "nil"))
	--end
	if(strfind(eventType, "SPELL_AURA_")) then
		-- in case a auro is removed or applied it may be that the auro was gained from someone else and spellID is therefore from the class who casted the aura
		--(and because we don't know where that player is, ignore him)
		if(srcName ~= dstName) then
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
		if(dstName and fOrE and dstName ~= myName) then
			VanasKoSDataGatherer:SendDataMessage(dstName, dstGUID, fOrE, spellID)
			return
		end
	end

	-- try source and destination  if source or destination is friendly, register as event
	if(srcName ~= nil and srcName ~= myName) then
		local fOrE = isFriendlyOrEnemy(srcFlags)
		if(fOrE) then
			VanasKoSDataGatherer:SendDataMessage(srcName, srcGUID, fOrE, spellID)
		end
	end

	if(dstName ~= nil and dstName ~= myName) then
		local fOrE = isFriendlyOrEnemy(dstFlags)
		if(fOrE) then
			VanasKoSDataGatherer:SendDataMessage(dstName, dstGUID, fOrE, spellID)
		end
	end

	if((dstName == myName and isFriendlyOrEnemy(srcFlags) == "enemy") or
		(srcName == myName and isFriendlyOrEnemy(dstFlags) == "enemy")) then
		if(strfind(eventType, "_DAMAGE")) then
			self:SendMessage("VanasKoS_PvPDamage", srcName, dstName, amount)
		elseif ((strfind(eventType, "_DRAIN") or (strfind(eventType, "_LEECH"))) and powerType == COMBATLOG_POWERTYPE_HEALTH) then
			self:SendMessage("VanasKoS_PvPDamage", srcName, dstName, amount)
		end
	end

	if(eventType == "UNIT_DIED" and isPlayer(dstFlags)) then
		self:SendMessage("VanasKoS_PvPDeath", dstName)
	end
end

function VanasKoSDataGatherer:COMBAT_LOG_EVENT_UNFILTERED()
	self:CombatEvent(CombatLogGetCurrentEventInfo())
end

function VanasKoSDataGatherer:OnEnable()
	-- on areachange update area
	self:RegisterMessage("VanasKoS_Zone_Changed", "Update")
	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected")

	self:Update()

	playerDataList = self.db.realm.data.players
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
	gatherEventEnabled = false
	combatEventsEnabled = false
	targetEventsEnabled = false
end

function VanasKoSDataGatherer:CleanupPlayerDataDatabase()
	local pkos = VanasKoS:GetList("PLAYERKOS") or {}
	local hl = VanasKoS:GetList("HATELIST") or {}
	local nl = VanasKoS:GetList("NICELIST") or {}
	local pl = VanasKoS:GetList("PVPLOG", 2) or {}

	for k, _ in pairs(playerDataList) do
		if(not (pkos[k] or hl[k] or nl[k] or pl[k])) then -- entry isn't in any of these lists.
			wipe(playerDataList[k])
			playerDataList[k] = nil
		end
	end
end

function VanasKoSDataGatherer:PurgeData()
	self.db.realm.data.players = {}
	playerDataList = {}
end

-- if a player was detected nearby through chat or mouseover, update lastseen
function VanasKoSDataGatherer:Player_Detected(message, data)
	assert(data.name)
	-- if the player is on a relevant list, update last seen
	self:UpdateLastSeen(data.name)
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
		return self.db.realm.data.players
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

function VanasKoSDataGatherer:UpdateLastSeen(name)
	if playerDataList and playerDataList[name] then
		if (time() - (playerDataList[name].lastseen or 0) > 300) then
			playerDataList[name].seen = (playerDataList[name].seen or 0) + 1
		end
		playerDataList[name].lastseen = time()
	end
end

function VanasKoSDataGatherer:Data_Gathered(message, list, data)
	-- self:PrintLiteral(list, name, guild, level, race, class, gender)
	assert(data.name)
	local key = data.name

	if not playerDataList[key] then
		playerDataList[key] = {}
	end

	if (data.guild) then
		playerDataList[key].guild = data.guild
	end

	if (data.guildrank) then
		playerDataList[key].guildrank = data.guildrank
	end

	playerDataList[key].name = data.name
	playerDataList[key].level = data.level
	playerDataList[key].race = data.race
	playerDataList[key].class = data.class
	playerDataList[key].classEnglish = data.classEnglish
	playerDataList[key].gender = data.gender
	playerDataList[key].mapID = data.mapID
	playerDataList[key].guid = data.guid
	playerDataList[key].faction = data.faction
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


function VanasKoSDataGatherer:Update()
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
		local name = UnitName(unit)
		assert(name)
		wipe(gatheredData)
		gatheredData.name = name
		gatheredData.pvp = UnitIsPVP(unit)
		gatheredData.guild, gatheredData.guildrank = GetGuildInfo(unit)
		gatheredData.race = UnitRace(unit)
		gatheredData.class, gatheredData.classEnglish = UnitClass(unit)
		gatheredData.gender = UnitSex(unit)
		gatheredData.mapID = VanasKoS:MapID()
		gatheredData.faction = nil
		gatheredData.guid = UnitGUID(unit)

		local lvl = UnitLevel(unit)
		local key = name
		local guildKey = gatheredData.guild
		if(lvl == -1) then
			lvl = (UnitLevel("player") or 1) + 10
			local oldLevel = (playerDataList[key] and playerDataList[key].level) or -1
			local oldLevelNum = oldLevel
			if (type(oldLevel) == "string") then
				oldLevelNum = tonumber(select(3, strfind(oldLevel, "(%d+)[+]"))) or -1
			end
			if(oldLevelNum > lvl) then
				lvl = oldLevel
			elseif(lvl < 120) then
				lvl = lvl .. "+"
			end
		end
		gatheredData.level = lvl

		gatheredData.list = select(2, VanasKoS:IsOnList(nil, key)) or (guildKey and select(2, VanasKoS:IsOnList(nil, guildKey)))

		if(UnitExists(unit) and UnitIsEnemy("player", unit)) then
			gatheredData.faction = "enemy"
		else
			gatheredData.faction = "friendly"
		end

		assert(gatheredData.faction, "faction must be present")
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

function VanasKoSDataGatherer:SendDataMessage(name, guid, faction, spellId)
	local mapID = VanasKoS:MapID()
	local class, classEnglish, race, raceEnglish, gender = GetPlayerInfoByGUID(guid)
	wipe(gatheredData)
	gatheredData.name = name
	gatheredData.faction = faction
	gatheredData.mapID = mapID
	gatheredData.class = class
	gatheredData.classEnglish = classEnglish
	gatheredData.race = race
	gatheredData.raceEnglish = raceEnglish
	gatheredData.gender = gender
	gatheredData.guid = guid

	local level = -1
	if(LevelGuess and spellId and tonumber(spellId)) then
		level = LevelGuess:GetEstimatedLevelAndClassFromSpellId(spellId) or -1
	end
	local key = gatheredData.name
	local oldLevel = (playerDataList and playerDataList[key] and playerDataList[key].level) or -1
	local oldLevelNum = oldLevel
	if (type(oldLevel) == "string") then
		oldLevelNum = tonumber(select(3, strfind(oldLevel, "(%d+)[+]"))) or -1
	end
	-- print("gathered", name, oldLevel, level)
	if(oldLevelNum > level) then
		level = oldLevel
	elseif (level < 1) then
		level = nil
	elseif (level < 120) then
		level = level .. "+"
	end
	gatheredData.guild = playerDataList and playerDataList[key] and playerDataList[key].guild
	local guildKey = gatheredData.guild
	gatheredData.list = select(2, VanasKoS:IsOnList(nil, key)) or (guildKey and select(2, VanasKoS:IsOnList(nil, guildKey)))
	gatheredData.level = level
	-- print("spellid", spellId, "level", gatheredData.level, "english", classEnglish)

	-- /script VanasKoSDataGatherer:SendDataMessage("name", "enemy", nil)
	-- /dump VanasKoSDataGatherer.db.realm.data.players['name']

	self:SendMessage("VanasKoS_Player_Data_Gathered", gatheredData.list, gatheredData)
	self:SendMessage("VanasKoS_Player_Detected", gatheredData)
end
