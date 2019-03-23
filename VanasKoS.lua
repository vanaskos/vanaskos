--[[----------------------------------------------------------------------
	VanasKoS - Kill on Sight Management
Main Object with database and basic list functionality, handles also Configuration
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS", false)
VanasKoS = LibStub("AceAddon-3.0"):NewAddon("VanasKoS", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")

-- declare common globals local
local pairs = pairs
local assert = assert
local strfind = strfind
local strsub = strsub
local strmatch = string.match
local tinsert = tinsert
local tremove = tremove
local tsort = table.sort
local format = format
local tonumber = tonumber
local IsInInstance = IsInInstance
local GetZonePVPInfo = GetZonePVPInfo
local GetRealmName = GetRealmName
local GetGuildInfo = GetGuildInfo
local UnitName = UnitName
local UnitFactionGroup = UnitFactionGroup
local UnitIsPlayer = UnitIsPlayer
local VanasKoS = VanasKoS

-- Constants
local CityMapIDs = {
    -- Alliance cities
    [84] = true, --Stormwind City
    [1012] = true, -- Stormwind City
    [1264] = true, -- Stormwind City
    [87] = true, --Ironforge
    [1265] = true, --Ironforge
    [1361] = true, --OldIronforge
    [89] = true, --Darnassus
    [1324] = true, --Darnassus
    [103] = true, --The Exodar
    [775] = true, --The Exodar
    [831] = true, --The Exodar
    [832] = true, --The Exodar
    [1326] = true, --The Exodar
    [1331] = true, --The Exodar
    [393] = true, --Shrine of Seven Stars
    [394] = true, --Shrine of Seven Stars
    [622] = true, -- Stormshield
    [1161] = true, -- Boralus

    -- Horde cities
    [85] = true, --Orgrimmar
    [86] = true, --Orgrimmar
    [88] = true, --Thunder Bluff
    [1323] = true, --Thunder Bluff
    [90] = true, --Undercity
    [998] = true, --Undercity
    [1266] = true, --Undercity
    [110] = true, --Silvermoon City
    [1269] = true, -- Stormwind City
    [391] = true, --Shrine of Two Moons
    [392] = true, --Shrine of Two Moons
    [624] = true, -- Warspear
    [1163] = true, -- Dazar'alor
    [1164] = true, -- Dazar'alor
    [1165] = true, -- Dazar'alor

    -- Neutral city names
    [41] = true, -- Dalaran
    [125] = true, -- Dalaran
    [126] = true, -- Dalaran
    [501] = true, -- Dalaran
    [502] = true, -- Dalaran
    [625] = true, -- Dalaran
    [626] = true, -- Dalaran
    [627] = true, -- Dalaran
    [628] = true, -- Dalaran
    [629] = true, -- Dalaran
    [111] = true, -- Shattrath City
    [594] = true, -- Shattrath City
    [652] = true, -- Thunder Totem
    [750] = true, -- Thunder Totem
}

-- Local Variables
local inSanctuary = false
local inBattleground = false
local inArena = false
local inDungeon = false
local inCombatZone = false
local inFfaZone = false
local inCity = false
local mapID = -1

function VanasKoS.hashName(name, realm)
	assert(name)
	assert(realm)
	if strmatch(name, " ") or strmatch(name, "-") then
		print("ignoring illegal name " .. name)
		return nil
	end

	local key
	if name then
		key = name:trim():lower()
	end

	if realm then
		key = key .. "-" .. realm:trim():lower():gsub(" ", "")
	end

	return key
end

function VanasKoS.hashGuild(guild, realm)
	assert(guild)

	local key
	if guild then
		key = guild:trim():lower()
	end

	key = "<" .. key .. ">"

	return key
end

function VanasKoS.splitNameRealm(fullname)
	if not fullname then
		return nil, nil
	end

	local name, realm
	name = fullname
	realm = nil
	local strSep = fullname:find("-")
	if strSep then
		name = fullname:sub(1, strSep - 1)
		realm = fullname:sub(strSep + 1)
	end

	return name, realm
end

local hashName = VanasKoS.hashName
local hashGuild = VanasKoS.hashGuild

function VanasKoS:ToggleModuleActive(moduleStr)
	local module = self:GetModule(moduleStr, true)
	if (not module) then
	        return
	end
	if(module:IsEnabled()) then
		module.db.profile.Enabled = false
		VanasKoS:DisableModule(moduleStr)
	else
		module.db.profile.Enabled = true
		VanasKoS:EnableModule(moduleStr)
	end
end

function VanasKoS:ModuleEnabled(moduleStr)
	local module = self:GetModule(moduleStr, true)
	if (not module) then
	        return
	end
	return module:IsEnabled()
end

--[[----------------------------------------------------------------------
  ACE Functions
------------------------------------------------------------------------]]
function VanasKoS:OnInitialize()
	local versionString = GetAddOnMetadata("VanasKoS", "Version")
	local minusPos = strfind(versionString, "-") - 1
	VANASKOS.VERSION = strsub(versionString, 0, minusPos)
	self.db = LibStub("AceDB-3.0"):New("VanasKoSDB")
end

function VanasKoS:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateZone")
	self:RegisterEvent("ZONE_CHANGED", "UpdateZone")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "UpdateZone")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateZone")
	self:RegisterMessage("VanasKoS_List_Entry_Added", "List_Entry_Added")
	self:RegisterMessage("VanasKoS_List_Entry_Removed", "List_Entry_Removed")
end

function VanasKoS:OnDisable()
	VanasKoS_WarnFrame:Hide()
	self:UnregisterAllMessages()
	self:UnregisterAllEvents()
end

--[[----------------------------------------------------------------------
  Main Functions
------------------------------------------------------------------------]]

local listHandler = {}

local function sortLists(val1, val2)
	if (val1[3] == nil) then
		return false
	end

	if (val2[3] == nil) then
		return true
	end

	return val1[3] < val2[3]
end

function VanasKoS:RegisterList(position, listNameInternal, listNameHuman, listHandlerObject)
	-- only add the list if the handlerobject supports all required functions
	if(not listHandlerObject) then
		self:Print("Error: No listHandlerObject for ", listNameInternal)
		return false
	end

	if(not listHandlerObject.AddEntry) then
		self:Print("Error: No AddEntry function for ", listNameInternal)
		return false
	end

	if(not listHandlerObject.RemoveEntry) then
		self:Print("Error: No RemoveEntry function for ", listNameInternal)
		return false
	end

	if(not listHandlerObject.GetList) then
		self:Print("Error: No GetList function for ", listNameInternal)
		return false
	end

	if(not listHandlerObject.IsOnList) then
		self:Print("Error: No IsOnList function for ", listNameInternal)
		return false
	end

	-- only put it in the VANASKOS.Lists if the listname is human
	-- readable => not internal(VANASKOS.Lists is only used for
	-- vanaskosgui to choose a list to display)
	--  /script for k,v in pairs(C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player"))) do print(k .. ": " .. v) end
	if(listNameHuman ~= nil) then
		tinsert(VANASKOS.Lists, {
			listNameInternal,
			listNameHuman,
			position
		})
		tsort(VANASKOS.Lists, sortLists)
		self:SendMessage("VanasKoS_List_Added")
	end

	listHandler[listNameInternal] = listHandlerObject
	return true
end

function VanasKoS:UnregisterList(listNameInternal)
	listHandler[listNameInternal] = nil

	for k,v in pairs(VANASKOS.Lists) do
		if(v[1] and v[1] == listNameInternal) then
			tremove(VANASKOS.Lists, k)
		end
	end
	tsort(VANASKOS.Lists, sortLists)
end

function VanasKoS:GetListNameByShortName(shortname)
	for _, v in pairs(VANASKOS.Lists) do
		if(v and v[1] and v[1] == shortname) then
			return v[2]
		end
	end
end

function VanasKoS:GetList(list, group)
	if(listHandler[list] ~= nil) then
		return listHandler[list]:GetList(list, group)
	end

	return nil
end

function VanasKoS:GetPlayerData(key)
	local list = self:GetList("LASTSEEN")
	if not list then
		list = self:GetList("PLAYERDATA")
	end
	if(not list or not key or not list[key]) then
		return nil
	end
	return list[key]
end

function VanasKoS:GetPvpLog(key)
	local list = self:GetList("PVPLOG")
	if(list == nil or key == nil or list[key] == nil) then
		return nil
	end
	return list[key]
end

function VanasKoS:BooleanIsOnList(listName, key, group)
	local list = VanasKoS:GetList(listName, group)

	if(list and key and list[key]) then
		return true
	end

	return false
end

local ListsToLookInto = {"PLAYERKOS", "NICELIST", "HATELIST", "GUILDKOS"}
function VanasKoS:IsOnList(list, key, group)
	if(list and key) then
		if(listHandler[list] ~= nil) then
			return listHandler[list]:IsOnList(list, key, group)
		end
	else
		for _, v in pairs(ListsToLookInto) do
			local listVar = VanasKoS:GetList(v, group)
			if(listVar and listVar[key]) then
				return listVar[key], v
			end
		end
	end

	return nil
end

function VanasKoS:AddEntry(list, key, data)
	if (not key) then
		return
	end

	if(listHandler[list] ~= nil and listHandler[list].AddEntry ~= nil) then
		listHandler[list]:AddEntry(list, key, data)
	else
		return
	end
end

function VanasKoS:RemoveEntry(listname, key)
	if(listHandler[listname] ~= nil) then
		listHandler[listname]:RemoveEntry(listname, key)
	end
end

--/script VanasKoS:AddEntryFromTarget("PLAYERKOS")
--[[----------------------------------------------------------------------
	functions to manipulate the database
------------------------------------------------------------------------]]
function VanasKoS:AddEntryFromTarget(list)
	local name
	local realm

	VanasKoSGUI:ScrollFrameUpdate()

	if(UnitIsPlayer("target")) then
		name, realm = UnitName("target")
		if(list == "GUILDKOS") then
			name = GetGuildInfo("target")
		end
	end

	VanasKoSGUI:AddEntry(list, name, realm)
end

function VanasKoS:AddEntryByName(list, name, realm, reason)
	if name and name ~= "" and (list == "GUILDKOS" or (realm and realm ~= "")) and reason and reason ~= "" then
		local key = hashName(name, realm)
		VanasKoS:AddEntry(list, key, {
			name = name,
			realm = realm,
			reason = reason
		})
	else
		VanasKoSGUI:AddEntry(list, name, realm, reason)
	end
end

function VanasKoS:AddKoSPlayer(name, realm, reason)
	if(reason == nil or reason == "") then
		reason = L["_Reason Unknown_"]
	end
	if(name==nil or name=="" or realm==nil or realm=="") then
		VanasKoSGUI:AddEntry("PLAYERKOS", name, realm, reason)
	else
		local key = hashName(name, realm)
		self:AddEntry("PLAYERKOS", key, {
			name = name,
			realm = realm,
			reason = reason
		})
	end
end

function VanasKoS:List_Entry_Added(message, list, key, data)
	if key then
		if data and data.reason then
			self:Print(format(L["Entry %s (Reason: %s) added."], key, data.reason))
		else
			self:Print(format(L["Entry %s added."], key))
		end
	end
end

function VanasKoS:List_Entry_Removed(message, list, key, data)
	self:Print(format(L["Entry \"%s\" removed from list"], key))
end

function VanasKoS:AddKoSGuild(name, realm, reason)
	if(reason == nil or reason == "") then
		reason = L["_Reason Unknown_"]
	end
	if(name==nil or name=="" or realm==nil or realm=="") then
		VanasKoSGUI:AddEntry("GUILDKOS", name, realm, reason)
	else
		local key = hashGuild(name, realm)
		self:AddEntry("GUILDKOS", key, {
			['name'] = name,
			['realm'] = realm,
			['reason'] = reason
		})
	end
end


-- removes the Player pname from the KoS-List
function VanasKoS:RemoveKoSPlayer(pname, realm)
	local key = hashName(pname, realm)
	self:RemoveEntry("PLAYERKOS", key)
end

-- removes the Guild gname from the KoS-List
function VanasKoS:RemoveKoSGuild(gname, realm)
	local key = hashGuild(gname, realm)
	self:RemoveEntry("GUILDKOS", key)
end

-- resets the database
function VanasKoS:ResetKoSList(silent)
	self.db:ResetDB("factionrealm")
	if(not silent) then
		local _, faction = UnitFactionGroup("player")
		self:Print(format(L["KoS List for Realm \"%s\" - %s now purged."], GetRealmName(), faction))
	end
	self:SendMessage("VanasKoS_KoS_Database_Purged", GetRealmName())
end

function VanasKoS:IsVersionNewer(version)
	local otherVersion = tonumber(strmatch(version, "%d+.%d+"))
	local myVersion = tonumber(strmatch(VANASKOS.VERSION, "%d+.%d+"))

	if(otherVersion == nil or myVersion== nil) then
		return nil
	end

	if(otherVersion > myVersion) then
		return true
	end

	return false
end

--[[----------------------------------------------------------------------
	Configuration Commands
------------------------------------------------------------------------]]

function VanasKoS:ToggleMenu()
	VanasKoSGUI:Toggle()
end

function VanasKoS:UpdateZone()
	local pvpType, isFFA, _ = GetZonePVPInfo()
	local inInstance, instanceType = IsInInstance()

	mapID = C_Map.GetBestMapForUnit("player")

	inSanctuary = (pvpType == "sanctuary")
	inCombatZone = (pvpType == "combat")
	inArena = ((inInstance and instanceType == "arena") or pvpType == "arena")
	inDungeon = (inInstance and (instanceType == "party" or instanceType == "raid"))
	inBattleground = (inInstance and instanceType == "pvp")
	inFfaZone = isFFA

	if (CityMapIDs[mapID]) then
		inCity = true
	else
		inCity = false
	end

	self:SendMessage("VanasKoS_Zone_Changed", mapID)
end

function VanasKoS:IsInBattleground()
	return inBattleground
end

function VanasKoS:IsInSanctuary()
	return inSanctuary
end

function VanasKoS:IsInArena()
	return inArena
end

function VanasKoS:IsInDungeon()
	return inDungeon
end

function VanasKoS:IsInCombatZone()
	return inCombatZone
end

function VanasKoS:IsInFfaZone()
	return inFfaZone
end

function VanasKoS:IsInCity()
	return inCity
end

function VanasKoS:MapID()
	return mapID
end
