--[[----------------------------------------------------------------------
      DistributedTracker Module - Part of VanasKoS
Broadcasts a list to GUILD and handles returning position answers
------------------------------------------------------------------------]]


VanasKoSTracker = VanasKoS:NewModule("DistributedTracker", "AceComm-3.0", "AceEvent-3.0", "AceTimer-3.0");

local VanasKoSTracker = VanasKoSTracker;
local VanasKoS = VanasKoS;

local JOIN_DELAY = 20;

-- Global wow strings
local OKAY, CANCEL = OKAY, CANCEL

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/DistributedTracker", false);
local AceSerializer = LibStub("AceSerializer-3.0");

local tempNameList = { };

function VanasKoSTracker:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("DistributedTracker", 
		{
			profile = {
				Enabled = true,
			},
		}
	);
	
	VanasKoSGUI:AddModuleToggle("DistributedTracker", L["Distributed Tracking"]);
end

function VanasKoSTracker:OnEnable()
	if(not self.db.profile.Enabled) then
		return;
	end

	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected");
	self:RegisterMessage("VanasKoS_Zone_Changed", "Zone_Changed");
	self:ScheduleTimer("StartCrbTracking", JOIN_DELAY);
end

function VanasKoSTracker:OnDisable()
	self:UnregisterAllMessages();
	self:CancelAllTimers();
end

function VanasKoSTracker:Player_Detected(message, data)
	assert(data and data.name ~= nil);

	tempNameList[data.name] = time();
end

-- crb stuff

local function GetCurrentCrbZoneName() 
	local continent = GetCurrentMapContinent();
	local zone = GetCurrentMapZone();
	
	if(continent == nil or zone == nil or continent == 0 or continent > 4) then
		return nil;
	end
	
	local channelNumber = continent * 1000 + zone;
	return channelNumber;
end

local function GetCurrentCrbZoneChannelName() 
	local channelNr = GetCurrentCrbZoneName();
	if(channelNr == nil) then
		return nil;
	end
	
	local name = "CrbZ" .. channelNr .. "I" .. 1;
	return name;
end

local function leaveCrbChannels(exceptChannel)
	local channels = { GetChannelList(); }
	local alreadyInChannel = false;
	
	if(channels ~= nil) then
		for i=1, #channels do
			local nr, name = GetChannelName(channels[i]);
			if(name ~= nil) then
				if(name ~= exceptChannel and string.match(name, "^Crb")) then
					LeaveChannelByName(name);
				end
				
				if(name == exceptChannel) then
					alreadyInChannel = true;
				end
			end
			
			i = i + 1;
		end
	end
	
	return alreadyInChannel;
end


local changeZoneTimer;

function VanasKoSTracker:Zone_Changed(zone)
	self:CancelTimer(changeZoneTimer);
	changeZonetimer = self:ScheduleTimer("ChangeZone", JOIN_DELAY);
end

function VanasKoSTracker:ChangeZone()
	if(Nx) then
		return;
	end
	
	local channelName = GetCurrentCrbZoneChannelName();
	
	if(leaveCrbChannels(channelName)) then
		return;
	end
	
	JoinChannelByName(channelName);
end

function VanasKoSTracker:SendSeenPeople()
	local count = 0;
	local playerStr = "";
	for k, v in pairs(tempNameList) do
		local toAdd = format("%2x%s!", 0, k);
		if((#playerStr + #toAdd) > 200) then
			break;
		end
		playerStr = playerStr .. toAdd;
		tempNameList[k] = nil;
		count = count + 1;
	end
	
	if(count == 0) then
		return;
	end

	-- Hopefully they are looking at the correct zone on the map, we could
	-- call SetMapToCurrentZone(), but it would make people angry if called
	-- it often
	local mapAndZone = GetCurrentMapContinent() * 1000 + GetCurrentMapZone();
	if(mapAndZone <= 0 or mapAndZone >= 5000) then
		return; -- todo: implement
	end
	
	local posX, posY = GetPlayerMapPosition("player");
	if(posX == 0 or posY == 0) then
		return;
	end

	local myHealthPerc = ((not UnitIsDeadOrGhost("player") and UnitHealth("player")) or 0)/UnitHealthMax("player")*20;
	if(myHealthPerc > 0) then
		myHealthPerc = max(myHealthPerc, 1);
	end
	myHealthPerc = floor(myHealthPerc + 0.5);
	
	local str = format("p%4x%3x%3x%c%c%s", mapAndZone, min(posX, .999)*0xfff, min(posY, .999)*0xfff, myHealthPerc + 48, 4+35, playerStr);
	-- VanasKoS:Print(str);
	--[[arg2 = "Vana";
	arg1 = str;
	arg9 = GetCurrentCrbZoneChannelName();
	self:ChannelMessage();]]
	local number = GetChannelName(GetCurrentCrbZoneChannelName());
	if(number == nil or number == 0) then
		return;
	end
	
	SendChatMessage(str, "CHANNEL", nil, number);
end

local function checkForKoS(name, continent, zone, posX, posY)
	local koslist = VanasKoS:GetList("PLAYERKOS");
	if(koslist and koslist[name:lower()]) then
		local zones = { GetMapZones(continent) };
		VanasKoS:Print(format(L["Map Position update on Player %s (%d, %d in %s) received - Reason: %s"], name, posX, posY, zones[zone], koslist[name:lower()].reason));
		VanasKoSEventMap:TrackPlayer(name, continent, zone, posX/100, posY/100);
	end
end

local targetInfo = { };

function VanasKoSTracker:ChannelMessage()
	if(strsub(arg9, 1, 3) ~= "Crb") then
		return;
	end
	
	local sender = arg2;
	
	if(sender == UnitName("player")) then
		return;
	end
	
	local msg = arg1;
	if(strfind(msg,"\1")) then
		msg = gsub(msg,"\1", "|")
	end

	local id = strbyte(msg, 0);
	if(id ~= tonumber('p')) then
		return;
	end
	
	if(#msg < 11) then
		return;
	end
	
	local continentAndZone = tonumber(strsub(msg, 2, 5), 16);
	if(continentAndZone == nil) then
		return;
	end
	local continent = floor(continentAndZone / 1000);
	local zone = continentAndZone % 1000;
	
	if(continentAndZone ~= GetCurrentCrbZoneName()) then
		return;
	end

	local posX = (tonumber(strsub(msg, 6, 8), 16) * 100) / 0xfff;
	local posY = (tonumber(strsub(msg, 9, 11), 16) * 100) / 0xfff;
	local healthPerc =(((strbyte(msg, 12) or 48) - 48) * 100) / 20;
	local flags = (strbyte(msg, 13) or 35) - 35;
	
	--VanasKoS:Print(format("%s %d %f %f %d %d", sender, continentAndZone, posX, posY, healthPerc, flags));
	
	--[[ flags: 
			1 = player is in combat, 
			16 = unknown
			
			32 = player has a target (affects message),  targetString ~= ""
			8 = quest stuff, queststuff ~= ""
			4 = contains recently seen players, punklist ~= ""
			
			targetString = type, level, class, health, length of name, name
				everything 1 char in hex - except for name
			
			quest stuff = 9 bytes (if included)
			
			punklist = [level, name, !]+
				level = 1 byte hex
			
			message (offset 14 to end):
				"targetString, queststuff, punklist"
			]]
	local str = strsub(msg, 14, #msg);
	
	local offset = 14;
	
	if(bit.band(flags, 16) > 0) then
			VanasKoS:Print("16  abort");
		return;
	elseif(bit.band(flags, 32) > 0) then -- player has a target
		targetInfo.type = strbyte(msg, offset) - 35;
		offset = offset + 1;
		targetInfo.level = strbyte(msg, offset) - 35;
		offset = offset + 1;
		targetInfo.class = strbyte(msg, offset) - 35;
		offset = offset + 1;
		targetInfo.health = strbyte(msg, offset) - 35;
		offset = offset + 1;
		local len = strbyte(msg, offset) - 35;
		offset = offset + 1;
		targetInfo.name = strsub(msg, offset, offset+len-1);
		offset = 19 + len;
		
		if(targetInfo.type == 2) then-- 1 = friendly, 2 = player, 3=enemy, 4= elite, 5 = other
			checkForKoS(targetInfo.name, continent, zone, posX, posY);
		end
	else
		targetInfo.name = nil;
	end
	
	local count = 0;
	if(bit.band(flags, 8) > 0) then -- quest stuff
		local queststuff = strsub(msg, offset);
		if #queststuff < 7 then
			VanasKoS:Print("queststuff abort");
			return;
		else 
			count = strbyte(queststuff, 7) - 35;
			if(#msg>=7+count*2) then
				offset = offset + 7 + 2*count;
			else
				return;
			end
		end
	end
	
	--VanasKoS:Print(format("%d %d, posX: %f posY: %f %d target: %s | %s", flags, count, posX, posY, healthPerc, targetInfo.name or "", strsub(msg, offset)));
	if(bit.band(flags, 4) > 0) then -- contains recently seen players
		offset = offset + 1;
		--VanasKoS:Print(strsub(msg, offset));
		local punksWithLevel = { strsplit("!", strsub(msg, offset)) };
		for n,v in ipairs(punksWithLevel) do
			local level = tonumber(strsub(v, 1, 2), 16);
			if(level == nil) then
				break;
			end
			
			local name = strsub(v, 3);
			if(level >= 255) then
				name = strsub(v, 9);
				level = 0;
			end
			
			--VanasKoS:Print(format("name: %s", name));
			checkForKoS(name, continent, zone, posX, posY);
		end
	end
	--VanasKoS:Print("---");
	
end

function VanasKoSTracker:StopCrbTracking() 
	self:UnregisterEvent("CHAT_MSG_CHANNEL");

	if(Nx) then
		return; -- todo 
	end

	leaveCrbChannels(nil);
end

function VanasKoSTracker:StartCrbTracking()
	self:ScheduleRepeatingTimer("SendSeenPeople", 10);
	self:RegisterEvent("CHAT_MSG_CHANNEL", "ChannelMessage");
	
	if(Nx) then
		return; -- todo 
	end
	
	local channelName = GetCurrentCrbZoneChannelName();
	
	if(leaveCrbChannels(channelName)) then
		return;
	end
	
	JoinChannelByName(channelName);
end


-- Taken straight from Cartographer3_Notes, I don't know why this had no interface
-- already.
local zoneList = nil;
local possibleMatches = {};
local function Cartographer3_Zone(zoneName)
	local texture;
	if not zoneList then
		zoneList = {}
		for texture, zoneData in pairs(Cartographer3.Data.ZONE_DATA) do
			zoneList[zoneData.localizedName:lower():gsub("[%L]", "")] = texture;
		end
	end

	local lowerZone = zoneName:lower():gsub("[%L]", "");
	for name, texture in pairs(zoneList) do
		if name:match(lowerZone) then
			possibleMatches[#possibleMatches+1] = texture;
		end
	end
	if #possibleMatches > 1 then
		local names = {};
		for i, texture in ipairs(possibleMatches) do
			names[#names+1] = Cartographer3.Data.ZONE_DATA[texture].localizedName;
		end
		table.sort(names);

		VanasKoS:Print(L["Found multiple matches for zone '%s': %s"]:format(zoneName, table.concat(names, ", ")));
		for i = 1, #possibleMatches do
			possibleMatches[i] = nil;
		end

		return nil;
	end

	texture = possibleMatches[1];
	possibleMatches[1] = nil;

	if not texture then
		VanasKoS:Print(L["No match was found for zone '%s'"]:format(zoneName));
		return nil;
	end

	return texture;
end

StaticPopupDialogs["VANASKOS_TRACKER_ADD_NOTE"] = {
	text = "TEMPLATE",
	button1 = OKAY,
	button2 = CANCEL,
	OnAccept = function()
		local dialog = this:GetParent();
		if(Cartographer_Notes ~= nil) then
			Cartographer_Notes:SetNote(dialog.koszone, dialog.kosPosX, dialog.kosPosY, dialog.kosname, "VanasKoS-" .. dialog.kossender);
			if(Cartographer_Waypoints ~= nil) then
				Cartographer_Waypoints:SetNoteAsWaypoint(dialog.koszone, Cartographer_Notes.getID(dialog.kosPosX, dialog.kosPosY));
			end
		end

		if(Cartographer3 ~= nil) then
			local Cart3Zone = Cartographer3_Zone(dialog.koszone);
			if(Cartographer3_Notes ~= nil) then
				Cartographer3_Notes.AddNote(Cart3Zone, dialog.kosPosX, dialog.kosPosY, "Skull", dialog.kosname, "VanasKoS-" .. dialog.kossender);
			end

			if(Cartographer3_Waypoints ~= nil) then
				Cartographer3_Waypoints.SetWaypoint(Cart3Zone, dialog.kosPosX, dialog.kosPosY, dialog.kosname, "POI")
			end
		end
	end,
	OnShow = function(playername)
	end,
	OnHide = function()
		if(ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
	end,
	timeout = 0,
	exclusive = 0,
	whileDead = 1,
	hideOnEscape = 1
}
