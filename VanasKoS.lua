--[[----------------------------------------------------------------------
	VanasKoS - Kill on Sight Management
Main Object with database and basic list functionality, handles also Configuration
------------------------------------------------------------------------]]

VanasKoS = LibStub("AceAddon-3.0"):NewAddon("VanasKoS", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0");

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS", false);
local Dialog = LibStub("LibDialog-1.0");
local VanasKoS = VanasKoS;

function VanasKoS:ToggleModuleActive(moduleStr)
	local module = self:GetModule(moduleStr, true);
	if (not module) then
	        return;
	end
	if(module:IsEnabled()) then
		module.db.profile.Enabled = false;
		VanasKoS:DisableModule(moduleStr);
	else
		module.db.profile.Enabled = true;
		VanasKoS:EnableModule(moduleStr);
	end
end

function VanasKoS:ModuleEnabled(moduleStr)
	local module = self:GetModule(moduleStr, true);
	if (not module) then
	        return;
	end
	return module:IsEnabled();
end

--[[----------------------------------------------------------------------
  ACE Functions
------------------------------------------------------------------------]]
function VanasKoS:OnInitialize()
	local versionString = GetAddOnMetadata("VanasKoS", "Version")
	local minusPos = strfind(versionString, "-") - 1;
	VANASKOS.VERSION = strsub(versionString, 0, minusPos);
	self.db = LibStub("AceDB-3.0"):New("VanasKoSDB");
end

function VanasKoS:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateZone");
	self:RegisterEvent("ZONE_CHANGED", "UpdateZone");
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "UpdateZone");
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateZone");
	self:RegisterMessage("VanasKoS_List_Entry_Added", "List_Entry_Added");
	self:RegisterMessage("VanasKoS_List_Entry_Removed", "List_Entry_Removed");
end

function VanasKoS:OnDisable()
	VanasKoS_WarnFrame:Hide();
	self:UnregisterAllMessages();
	self:UnregisterAllEvents();
end

--[[----------------------------------------------------------------------
  Main Functions
------------------------------------------------------------------------]]

local listHandler = { };
VANASKOS.Lists = { };

local function sortLists(val1, val2)
	if (val1[3] == nil) then
		return false;
	end

	if (val2[3] == nil) then
		return true;
	end

	return val1[3] < val2[3];
end

function VanasKoS:RegisterList(position, listNameInternal, listNameHuman, listHandlerObject)
	-- only add the list if the handlerobject supports all required functions
	if(not listHandlerObject) then
		self:Print("Error: No listHandlerObject for ", listNameInternal);
		return false;
	end
	
	if(not listHandlerObject.AddEntry) then
		self:Print("Error: No AddEntry function for ", listNameInternal);
		return false;
	end

	if(not listHandlerObject.RemoveEntry) then
		self:Print("Error: No RemoveEntry function for ", listNameInternal);
		return false;
	end

	if(not listHandlerObject.GetList) then
		self:Print("Error: No GetList function for ", listNameInternal);
		return false;
	end
	
	if(not listHandlerObject.IsOnList) then
		self:Print("Error: No IsOnList function for ", listNameInternal);
		return false;
	end
	
	-- only put it in the VANASKOS.Lists if the listname is human readable => not internal(VANASKOS.Lists is only used for vanaskosgui to choose a list to display)
	if(listNameHuman ~= nil) then
		tinsert(VANASKOS.Lists, { listNameInternal, listNameHuman, position });
		table.sort(VANASKOS.Lists, sortLists);
		self:SendMessage("VanasKoS_List_Added");
	end
	
	-- fix until all list registrations are moved outside of this object (otherwise this object gets called recursive => deadlock)
	if(listHandlerObject == self) then
		return true;
	end
	listHandler[listNameInternal] = listHandlerObject;
	return true;
end

function VanasKoS:UnregisterList(listNameInternal)
	listHandler[listNameInternal] = nil;
	
	for k,v in pairs(VANASKOS.Lists) do
		if(v[1] and v[1] == listNameInternal) then
			tremove(VANASKOS.Lists, k);
		end
	end
	table.sort(VANASKOS.Lists, sortLists);
end

function VanasKoS:GetListNameByShortName(shortname)
	for k,v in pairs(VANASKOS.Lists) do
		if(v and v[1] and v[1] == shortname) then
			return v[2];
		end
	end
end

function VanasKoS:GetList(list, group)
	if(listHandler[list] ~= nil) then
		return listHandler[list]:GetList(list, group);
	end

	return nil;
end

function VanasKoS:GetPlayerData(name)
	local list = self:GetList("PLAYERDATA", 1);
	if(name == nil or not list or list[string.lower(name)] == nil) then
		return nil;
	end
	--      name, guild, level, race, class, gender, lastzone, lastseen
	return list[string.lower(name)];
end

function VanasKoS:GetGuildData(name)
	local list = self:GetList("GUILDDATA", 1);
	if(name == nil or list == nil or list[name:lower()] == nil) then
		return nil;
	end
		--      displayname, guild, level, race, class, gender, lastzone, lastseen
	return list[name:lower()].displayname;
end

function VanasKoS:BooleanIsOnList(list, name, group)
	if(not name) then
		return false;
	end
	
	name = string.trim(name:lower());
	
	local list = VanasKoS:GetList(list, group);
	
	if(list and list[name]) then
		return true;
	end
	
	return false;
end

local ListsToLookInto = { "PLAYERKOS", "NICELIST", "HATELIST", "GUILDKOS" }
function VanasKoS:IsOnList(list, name, group)
	if(not name) then
		return nil;
	end
	
	name = string.trim(name:lower());
	
	if(list ~= nil) then
		if(listHandler[list] ~= nil) then
			return listHandler[list]:IsOnList(list, name);
		end
	else
		for k,v in pairs(ListsToLookInto) do
			local listVar = VanasKoS:GetList(v, group);
			if(listVar and listVar[name]) then
				return listVar[name], v;
			end
		end
	end
		
	return nil;
end

function VanasKoS:AddEntry(list, name, data)
	if (not name) then
		return;
	end

	name = string.trim(name:lower());
	
	if(listHandler[list] ~= nil and listHandler[list].AddEntry ~= nil) then
		listHandler[list]:AddEntry(list, name, data);
	else
		return;
	end
end

function VanasKoS:RemoveEntry(listname, name)
	if(name == nil) then
		return;
	end
	name = name:lower();

	if(listHandler[listname] ~= nil) then
		listHandler[listname]:RemoveEntry(listname, name);
	end
end

--/script VanasKoS:AddEntryFromTarget("PLAYERKOS");
--[[----------------------------------------------------------------------
	functions to manipulate the database
------------------------------------------------------------------------]]
function VanasKoS:AddEntryFromTarget(list)
	local playername;
	local realm;

	VanasKoSGUI:ShowList(list);
	VanasKoSGUI:ScrollFrameUpdate();

	if(UnitIsPlayer("target")) then
		playername, realm = UnitName("target");
		if(list == "GUILDKOS") then
			playername = GetGuildInfo("target");
		end
		if (realm and realm ~= "") then
			playername = playername .. "-" .. realm;
		end
	end

	VanasKoSGUI:AddEntry(playername)
end

function VanasKoS:AddEntryByName(list, playername, reason)
	VanasKoSGUI:ShowList(list);

	if(playername == nil or playername == "") then
		VanasKoSGUI:AddEntry()
	else
		if(reason == nil or reason == "") then
			VanasKoSGUI:AddEntry(playername)
		else
			VanasKoS:AddEntry(list, playername,  { ['reason'] = reason });
		end
	end
end

function VanasKoS:AddKoSPlayer(playername, reason)
	if(reason == nil or reason == "") then
		reason = L["_Reason Unknown_"];
	end
	
	self:AddEntry("PLAYERKOS", playername,  { ['reason'] = reason });
end

function VanasKoS:List_Entry_Added(message, list, name, data)
	-- TODO: make this nicer
	if(list == "PLAYERSYNC" or list == "ACCEPTSYNC" or list == "REJECTSYNC") then
		self:Print(format(L["Entry %s added."], name));
	elseif(list ~= nil and list~= "LASTSEEN") then
		self:Print(format(L["Entry %s (Reason: %s) added."], name, data and data['reason'] or ""));
	end
end

function VanasKoS:List_Entry_Removed(message, list, name)
	self:Print(format(L["Entry \"%s\" removed from list"], name));
end

function VanasKoS:AddKoSGuild(guildname, reason)
	if(reason == nil or reason == "") then
		reason = L["_Reason Unknown_"];
	end

	self:AddEntry("GUILDKOS", guildname,  { ['reason'] = reason });
end


-- removes the Player pname from the KoS-List
function VanasKoS:RemoveKoSPlayer(pname)
	if(pname == nil) then
		return nil;
	end;

	self:RemoveEntry("PLAYERKOS", pname);
end

-- removes the Guild gname from the KoS-List
function VanasKoS:RemoveKoSGuild(gname)
	if(gname == nil) then
		return nil;
	end;
	
	self:RemoveEntry("GUILDKOS", gname);
end

-- resets the database
function VanasKoS:ResetKoSList(silent)
	self.db:ResetDB("factionrealm");
	if(not silent) then
		local _, faction = UnitFactionGroup("player");
		self:Print(format(L["KoS List for Realm \"%s\" - %s now purged."], GetRealmName(), faction));
	end
	self:SendMessage("VanasKoS_KoS_Database_Purged", GetRealmName());
end

function VanasKoS:IsVersionNewer(version)
	local otherVersion = tonumber(string.match(version, "%d+.%d+"));
	local myVersion = tonumber(string.match(VANASKOS.VERSION, "%d+.%d+"));
	
	if(otherVersion == nil or myVersion== nil) then
		return nil;
	end
	
	if(otherVersion > myVersion) then
		return true;
	end
	
	return false;
end

--[[----------------------------------------------------------------------
	Configuration Commands
------------------------------------------------------------------------]]

function VanasKoS:ToggleMenu()
	VanasKoSGUI:Toggle();
end

--[[----------------------------------------------------------------------
	Zone information
------------------------------------------------------------------------]]
local inSanctuary = false;
local inBattleground = false;
local inArena = false;
local inDungeon = false;
local inCombatZone = false;
local inFfaZone = false;
local inCity = false;
local mapAreaID = -1;

local CityAreaIDs = {
    -- Alliance cities
    [301] = true, --Stormwind City
    [341] = true, --Ironforge
    [381] = true, --Darnassus
    [471] = true, --The Exodar
    
    -- Horde cities
    [321] = true, --Orgrimmar
    [382] = true, --Undercity
    [362] = true, --Thunder Bluff
    [480] = true, --Silvermoon City

    -- Neutral city names
    [504] = true, -- Dalaran
    [481] = true, -- Shattrath City
};

function VanasKoS:UpdateZone()
	local gatherTargetEvents, gatherCombatEvents;
	local pvpType, isFFA, faction = GetZonePVPInfo();
	local inInstance, instanceType = IsInInstance();

	mapAreaID = C_Map.GetBestMapForUnit("player");

	inSanctuary = (pvpType == "sanctuary");
	inCombatZone = (pvpType == "combat");
	inArena = ((inInstance and instanceType == "arena") or pvpType == "arena");
	inDungeon = (inInstance and (instanceType == "party" or instanceType == "raid"));
	inBattleground = (inInstance and instanceType == "pvp");
	inFfaZone = isFFA;

	if (CityAreaIDs[mapAreaID]) then
		inCity = true;
	else
		inCity = false;
	end

	self:SendMessage("VanasKoS_Zone_Changed", mapAreaID);
end

function VanasKoS:IsInBattleground()
	return inBattleground;
end

function VanasKoS:IsInSanctuary()
	return inSanctuary;
end

function VanasKoS:IsInArena()
	return inArena;
end

function VanasKoS:IsInDungeon()
	return inDungeon;
end

function VanasKoS:IsInCombatZone()
	return inCombatZone;
end

function VanasKoS:IsInFfaZone()
	return inFfaZone;
end

function VanasKoS:IsInCity()
	return inCity;
end

function VanasKoS:MapID()
	return mapAreaID;
end

