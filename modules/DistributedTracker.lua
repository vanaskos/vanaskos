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
	local continent = VanasKoS:MapContinent();
	local zone = VanasKoS:MapZone();
	local area = VanasKoS:MapID();
	
	if(area == nil or area == -1) then
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


local changeZoneTimer = nil;

function VanasKoSTracker:Zone_Changed(areaID)
	if(changeZoneTimer ~= nil) then
		self:CancelTimer(changeZoneTimer);
	end
	changeZoneTimer = self:ScheduleTimer("ChangeZone", JOIN_DELAY);
end

function VanasKoSTracker:ChangeZone()
	changeZoneTimer = nil;
	if(Nx) then
		return;
	end
	
	local channelName = GetCurrentCrbZoneChannelName();
	
	if(leaveCrbChannels(channelName)) then
		return;
	end
	if(channelName) then
		JoinChannelByName(channelName);
	end
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

	-- Don't break AFK
	if(count == 0 or IsChatAFK()) then
		return;
	end

	local mapAndZone = VanasKoS:MapContinent() * 1000 + VanasKoS:MapZone();
	local areaID = VanasKoS:MapID();
	if(areaID < 0) then
		return;
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

local function checkForKoS(name, areaID, posX, posY)
	local koslist = VanasKoS:GetList("PLAYERKOS");
	if(koslist and koslist[name:lower()]) then
		VanasKoS:Print(format(L["Map Position update on Player %s (%d, %d in %s) received - Reason: %s"], name, posX, posY, GetMapNameByID(areaID), koslist[name:lower()].reason));
		VanasKoSEventMap:TrackPlayer(name, areaID, posX/100, posY/100);
	end
end

local targetInfo = { };

function VanasKoSTracker:ChannelMessage()
	if(arg9 == nil) then
		return;
	end;
	
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

	local areaID = VanasKoS:MapID();
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
			checkForKoS(targetInfo.name, areaID, posX, posY);
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
			checkForKoS(name, areaID, posX, posY);
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
	if(channelName) then
		JoinChannelByName(channelName);
	end
end
