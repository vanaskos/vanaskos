--[[----------------------------------------------------------------------
      DistributedTracker Module - Part of VanasKoS
Broadcasts a list to GUILD and handles returning position answers
------------------------------------------------------------------------]]


VanasKoSTracker = VanasKoS:NewModule("DistributedTracker", "AceComm-3.0", "AceEvent-3.0", "AceTimer-3.0");

local VanasKoSTracker = VanasKoSTracker;
local VanasKoS = VanasKoS;
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable();
local BZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable();

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_DistributedTracker", "enUS", true);
if L then
	L["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = true;
	L["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = true;
	L["Ok"] = true;
	L["Cancel"] = true;
	L["Distributed Tracking"] = true;
	L["Enabled"] = true;
	L["Wanted List"] = true;
	L["Wanted"] = true;
	L["Tracking via Guild"] = true;
	L["Tracking via Zone"] = true;
	L["Wanted by %s players"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_DistributedTracker", "deDE", false);
if L then
	L["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = "Position von Player %s empfangen (%d, %d in %s) von %s - Grund: %s";
	L["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = "%%s in %s bei %d, %d (%s) - Cartographer Notiz erstellen?";
	L["Ok"] = "Ok";
	L["Cancel"] = "Abbrechen";
	L["Distributed Tracking"] = "Verteiltes Suchen";
	L["Enabled"] = "Aktiviert";
	L["Wanted List"] = "Gesucht-Liste";
	L["Wanted"] = "Gesucht";
	L["Tracking via Guild"] = "Verteilte Suche mit Gilde";
	L["Tracking via Zone"] = "Verteilte Suche in Zone";
--	L["Wanted by %s players"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_DistributedTracker", "frFR", false);
if L then
	L["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = "Position du joueur %s (%d, %d \195\128 %s) re\195\167u de %s - Raison: %s";
	L["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = "%s in %s at %d, %d (%s) - Cr\195\169er une note avec \"Cartographer\" ?";
	L["Ok"] = "Ok";
	L["Cancel"] = "Annuler";
	L["Distributed Tracking"] = "R\195\169partition des informations KoS";
	L["Enabled"] = "Actif";
	L["Wanted List"] = "Liste Wanted";
	L["Wanted"] = "Wanted";
	L["Tracking via Guild"] = "Tracking via la guilde";
	L["Tracking via Zone"] = "Tracking la zone";
--	L["Wanted by %s players"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_DistributedTracker", "koKR", false);
if L then
--	L["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = true;
--	L["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = true;
	L["Ok"] = "확인";
	L["Cancel"] = "취소";
	L["Distributed Tracking"] = "분산 추적";
	L["Enabled"] = "사용";
	L["Wanted List"] = "수배 목록";
	L["Wanted"] = "수배";
	L["Tracking via Guild"] = "길드 내 추적";
	L["Tracking via Zone"] = "지역 내 추적";
--	L["Wanted by %s players"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_DistributedTracker", "esES", false);
if L then
	L["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = "Posición del Jugador %s (%d, %d in %s) recibida desde %s - Razón: %s";
	L["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = "%s en %s en %d, %d (%s) - ¿Crear Nota de Cartographer?";
	L["Ok"] = "Aceptar";
	L["Cancel"] = "Cancelar";
	L["Distributed Tracking"] = "Rastreo Distribuido";
	L["Enabled"] = "Activado";
	L["Wanted List"] = "Lista de Se Busca";
	L["Wanted"] = "Se Busca";
	L["Tracking via Guild"] = "Rastrear vía Hermandad";
	L["Tracking via Zone"] = "Rastrear vía Zona";
--	L["Wanted by %s players"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_DistributedTracker", "ruRU", false);
if L then
	L["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = "Расположение игрока %s (%d, %d в %s) получено от %s - Причина: %s";
	L["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = "%s в %s по %d, %d (%s) - Создать метку в Картографе?";
	L["Ok"] = "Ok";
	L["Cancel"] = "Отмена";
	L["Distributed Tracking"] = "Распределенное слежение";
	L["Enabled"] = "Включено";
	L["Wanted List"] = "Список розыска";
	L["Wanted"] = "Розыск";
	L["Tracking via Guild"] = "Следить по гильдии";
	L["Tracking via Zone"] = "Следить по локации";
--	L["Wanted by %s players"] = true;
end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_DistributedTracker", false);
local AceSerializer = LibStub("AceSerializer-3.0");


-- time span for announcing the kos list
local PUBLISH_REPEAT_TIME = 600;
--local PUBLISH_GLOBAL_REPEAT_TIME = 1800;
local POSITION_UPDATE = "pu";
local WANTED_LIST = "wl";

-- time span after a koslist was received, until the kos-list gets purged
local LIST_PURGE_TIME = 610;
-- global custom channel
--local GCHANNEL = "VanasKoS";

local watchList = { };
local wantedList = { };
local zoneNames = nil;

function VanasKoSTracker:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("DistributedTracker", 
			{
				profile = {
					Enabled = true,
--					PublishToGlobal = true,
					PublishToGuild = true,
--					PublishToZone = true,
				},
			}
	);
	
	
	VanasKoSGUI:AddConfigOption("DistributedTracking", {
			type = 'group',
			name = L["Distributed Tracking"],
			desc = L["Distributed Tracking"],
			args = {
				enabled = {
					type = 'toggle',
					name = L["Enabled"],
					desc = L["Enabled"],
					order = 1,
					set = function(frame, v) VanasKoS:ToggleModuleActive("DistributedTracker"); end,
					get = function() return VanasKoS:ModuleEnabled("DistributedTracker"); end,
				},
				--[[
				publishglobal = {
					type = 'toggle',
					name = L["Global Tracking"],
					desc = L["Global Tracking"],
					order = 2,
					set = function(v) VanasKoSTracker.db.profile.publishToGlobal = v; end,
					get = function() return VanasKoSTracker.db.profile.publishToGlobal; end,
				},
				]]
				publishguild = {
					type = 'toggle',
					name = L["Tracking via Guild"],
					desc = L["Tracking via Guild"],
					order = 3,
					set = function(v) VanasKoSTracker.db.profile.PublishToGuild = v; end,
					get = function() return VanasKoSTracker.db.profile.PublishToGuild; end,
				},
				--[[
				publishzone = {
					type = 'toggle',
					name = L["Tracking via Zone"],
					desc = L["Tracking via Zone"],
					order = 4,
					set = function(v) VanasKoSTracker.db.profile.PublishToZone = v; end,
					get = function() return VanasKoSTracker.db.profile.PublishToZone; end,
				},
				]]
			},
		});
end

-- TODO: Merge with communication from synchronizer
function VanasKoSTracker:OnEnable()
	if(not self.db.profile.Enabled) then
		return;
	end

	self:RegisterComm("VanasKoS");

	VanasKoS:RegisterList(5, "WANTED", L["Wanted"], self);
	VanasKoSGUI:RegisterList("WANTED", self);

	--[[
	if(self.db.profile.publishToGlobal) then
		self:ScheduleRepeatingTimer(self.PublishGlobalList, PUBLISH_GLOBAL_REPEAT_TIME, self);
	end
	]]

	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected");
	self:ScheduleRepeatingTimer("PublishList", PUBLISH_REPEAT_TIME);
	self:ScheduleRepeatingTimer("PurgeList", 60);
end

function VanasKoSTracker:OnDisable()
	self:UnregisterAllComm();
	self:UnregisterAllMessages();
	self:CancelAllTimers();

	VanasKoSGUI:UnregisterList("WANTED");
	VanasKoS:UnregisterList("WANTED");
end

local function GetSerializedPositionString(locatedPlayer, posX, posY, zone)
	local data = {
		["version"] = 1,
		["player"] = locatedPlayer,
		["posX"] = posX,
		["posY"] = posY,
		["zone"] = zone,
	};
	return AceSerializer:Serialize(VANASKOS.VERSION, 1, POSITION_UPDATE, data);
end

local function GetSerializedWantedString(list)
	local data = {
		["version"] = 1,
		["list"] = list,
	};
	return AceSerializer:Serialize(VANASKOS.VERSION, 1, WANTED_LIST, data);
end

local function DeserializeString(serializedString)
	local result, vanasKoSVersion, protocolVersion, command, data = AceSerializer:Deserialize(serializedString);
	if(protocolVersion ~= 1) then
		return false, format("Unknown protocol version '%s'", protocolVersion or "nil");
	end
	if(type(command) ~= "string") then
		return false, format("Invalid command format (%s)", type(command));
	end
	if(type(data) ~= "table") then
		return false, format("Invalid command format (%s)", type(command));
	end

	if(command == POSITION_UPDATE) then
		if(data.version == nil or data.version ~= 1) then
			return false, format("Unknown position update version '%s'", data.version or "nil");
		end
		if(data.player == nil or type(data.player) ~= "string") then
			return false, format("Invalid player format (%s)", type(data.player));
		end
		if(data.posX == nil or type(data.posX) ~= "string") then
			return false, format("Invalid posX format (%s)", type(data.posX));
		end
		if(data.posY == nil or type(data.posY) ~= "string") then
			return false, format("Invalid posY format (%s)", type(data.posY));
		end
		if(data.zone == nil or type(data.zone) ~= "string") then
			return false, format("Invalid zone format (%s)", type(data.zone));
		end
	elseif(command == WANTED_LIST) then
		if(data.version == nil or data.version ~= 1) then
			return false, format("Unknown wanted list version '%s'", data.version or "nil");
		end
		if(data.list == nil or type(data.list) ~= "table") then
			return false, format("Invalid list (%s)", type(data.list));
		end
	else
		return false, format("Unknown command '%s'", command);
	end

	return true, vanasKoSVersion, protocolVersion, command, data;
end

function VanasKoSTracker:OnCommReceived(prefix, text, distribution, sender)
	local result, vanasKoSVersion, protocolVersion, command, data = DeserializeString(text);
	if(not result) then
		if(VANASKOS.DEBUG == 1) then
			VanasKoS:Print(format("Tracker: Invalid comm from %s: %s", sender, vanasKoSVersion));
		end
		return;
	end

	if(VANASKOS.DEBUG == 1) then
		VanasKoS:Print(format("Tracker: CommReceived from %s ver:%s pv:%s cmd:%s", sender, vanasKoSVersion, protocolVersion, command));
	end

	-- Ignore messages from self
	if(not sender or sender == UnitName("player")) then
		return
	end

	if(VanasKoS:IsVersionNewer(vanasKoSVersion)) then
		if(not VANASKOS.NewVersionNotice) then
			VanasKoS:Print("A newer version of VanasKoS is available. Please upgrade!");
			VANASKOS.NewVersionNotice = true;
		end
	end
	
	if(command == POSITION_UPDATE) then
		self:PositionUpdateReceived(distribution, sender, data.player, data.posX, data.posY, data.zone);
	elseif(command == WANTED_LIST) then
		self:ListMessageReceived(distribution, sender, data.list);
	end
end

function VanasKoSTracker:AddEntry(list, name, data)
end

function VanasKoSTracker:RemoveEntry(listname, name)
	
end

function VanasKoSTracker:IsOnList(listname, name)
	local list = VanasKoS:GetList(listname);
	if(list and list[name]) then
		return list[name];
	end
end

function VanasKoSTracker:GetList(list)
	if(list == "WANTED") then
		return wantedList;
	else
		return nil;
	end
end

function VanasKoSTracker:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2)
	if(list ~= "WANTED") then
		return nil;
	end
	buttonText1:SetText(string.Capitalize(key));
	buttonText2:SetText(format(L["Wanted by %s players"], value.count));
	button:Show();
end

function VanasKoSTracker:ShowList(list)
	if(list == "WANTED") then
--		VanasKoSListFrameSyncButton:Disable();
		VanasKoSListFrameChangeButton:Disable();
		VanasKoSListFrameAddButton:Disable();
		VanasKoSListFrameRemoveButton:Disable();
	end
end

function VanasKoSTracker:HideList(list)
	if(list == "WANTED") then
--		VanasKoSListFrameSyncButton:Enable();
		VanasKoSListFrameChangeButton:Enable();
		VanasKoSListFrameAddButton:Enable();
		VanasKoSListFrameRemoveButton:Enable();
	end
end

function VanasKoSTracker:ListMessageReceived(distribution, sender, playerlist)
	if (VANASKOS.DEBUG == 1) then
		VanasKoS:Print("Receiving wanted list from %s", sender);
	end

	for player, data in pairs(playerlist) do
		local wantedName = player:lower();
		if (not wantedList[wantedName]) then
			wantedList[wantedName] = {
				["wantedby"] = {},
				["count"] = 0,
			};
		end
		wantedList[wantedName].wantedby[sender] = true;
		wantedList[wantedName].count = wantedList[wantedName].count + 1;
		wantedList[wantedName].addtime = time();
		watchList[sender] = time();
		if (VANASKOS.DEBUG == 1) then
			VanasKoS:Print(format("  %s WANTED by %d players", wantedName, wantedList[wantedName].count));
		end
	end
end

function VanasKoSTracker:PurgeList()
	for watcher, senttime in pairs(watchList) do
		if(time() - senttime > LIST_PURGE_TIME) then
			wipe(watchList[watcher]);
			watchList[watcher] = nil;
			for player, data in pairs(wantedList) do
				if(data.wantedby[watcher]) then
					data.count = data.count - 1;
					data.wantedby[watcher] = nil;
				end
				if(data.count == 0) then
					wipe(wantedList[player]);
					wantedList[player] = nil;
				end
			end
		end
	end
end

function VanasKoSTracker:PositionUpdateReceived(distribution, sender, playername, posX, posY, zone)
	if(VANASKOS.DEBUG == 1) then
		self:PrintLiteral("received", sender, distribution, playername, posX, posY, zone);
	end

	if(sender == nil) then
		return;
	end
	if( not (distribution == "WHISPER") or
		not (type(playername) == "string")) then
		self:PrintLiteral("Invalid Message from", sender, "DEBUG", distribution, playername, posX, posY, zone);
		return;
	end

	local data = VanasKoS:IsOnList("PLAYERKOS", playername);

	if(not data or data.reason == nil or data.owner ~= nil or playername == nil) then
		return;
	end

	if(posX == nil) then
		posX = 0.0;
	end
	if(posY == nil) then
		posY = 0.0;
	end
	if(zone == nil) then
		zonename = UNKNOWN;
	else
		assert(BZ[zone]);
		zonename = BZ[zone];
	end

	VanasKoS:Print(format(L["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"], playername, posX*100, posY*100, zonename, sender, data.reason));
	if(not Cartographer_Notes) then
		return;
	end

	local dialog = StaticPopup_Show("VANASKOS_TRACKER_ADD_NOTE");
	if(dialog) then
		dialog.kossender = sender;
		dialog.kosname = playername;
		dialog.koszone = zonename;
		dialog.kosPosX = posX;
		dialog.kosPosY = posY;

		getglobal(dialog:GetName() .. "Text"):SetText(format(L["%s in %s at %d, %d (%s) - Create Cartographer Note?"], playername, zonename, posX*100, posY*100, sender));
	end
end

function VanasKoSTracker:Player_Detected(message, data)
	assert(data.name ~= nil);

	if(data.faction == nil or data.faction == "friendly") then
		return;
	end

	local locatedPlayer = data.name:lower();

	if(wantedList[locatedPlayer] and not VanasKoSDataGatherer:IsInSanctuary()) then
		for watcher, data in pairs(wantedList[locatedPlayer].wantedby) do
			local result = self:SendPosition(name, playername);
			if(VANASKOS.DEBUG == 1) then
				if(result) then
					VanasKoS:Print("Position of", playername, "sent for", name);
				else
					VanasKoS:Print("Position of", playername, "failed to sent for", name);
				end
			end
			wipe(wantedList[locatedPlayer].wantedby[watcher]);
			wantedList[locatedPlayer].wantedby[watcher] = nil;
		end
	end
end

function VanasKoSTracker:SendPosition(receiver, locatedPlayer)
	local zonename = GetRealZoneText();
	local posX, posY = GetPlayerMapPosition("player");

	if(receiver == nil) then
		self:Print("receiver is nil! WTF?!");
		return;
	end

	local zone = nil;
	if (zonename) then
		assert(BZR[zonename]);
		zone = BZR[zonename];
	end

	--[[
	if(self:IsUserInChannel(receiver, "ZONE") or
		self:IsUserInChannel(receiver, "CUSTOM", GCHANNEL)) then
		self:SendCommMessage("VanasKoS", GetSerializedPositionString(locatedPlayer, posX, posY, zone) "WHISPER", receiver);
		return true;
	else
	]]
		for i=1, GetNumGuildMembers(1) do
			local name, rank, rankIndex, level, class, zoneGuild, note, officernote, online, status = GetGuildRosterInfo(i);
			if(name ~= nil and name:lower() == receiver:lower() and online) then
				self:SendCommMessage("VanasKoS", GetSerializedPositionString(locatedPlayer, posX, posY, zone) "WHISPER", receiver, "BULK");
				return true;
			end
		end
	--[[
	end
	]]
	return false;
end


--[[
function VanasKoSTracker:PublishGlobalList()
	local list = VanasKoS:GetList("PLAYERKOS");
	if(list == nil) then
		return;
	end

	local newList = { };
	local entries = 0;

	for k,v in pairs(list) do
		if(v.wanted) then
			newList[k] = { ['reason'] = v.reason };
			entries = entries + 1;
		end
	end

	if(entries == 0) then
		return;
	end

	VanasKoSTracker:SendCommMessage("VanasKoS", GetSerializedWantedString(newList), "CUSTOM", GCHANNEL);
	
	if(VANASKOS.DEBUG == 1) then
		VanasKoS:Print("[DEBUG]: Global List published - Entries:", entries);
	end
end
]]


-- /script VanasKoSTracker:PublishList()
function VanasKoSTracker:PublishList()
	local list = { };
	local count = 0;
	local kosList = VanasKoS:GetList("PLAYERKOS");
	for k,v in pairs(kosList) do
		if(v.wanted) then
			list[k] = v;
			count = count + 1;
		end
	end
	if(count == 0) then
		return;
	end

	if(self.db.profile.PublishToGuild and IsInGuild()) then
		if(VANASKOS.DEBUG == 1) then
			VanasKoS:Print("Publish wanted list to guild");
		end
		self:SendCommMessage("VanasKoS", GetSerializedWantedString(list), "GUILD");
	end

	--[[
	if(self.db.profile.PublishToZone) then
		self:SendCommMessage(self.commPrefix, GetSerializedWantedString(list), "ZONE");
	end
	]]
end

StaticPopupDialogs["VANASKOS_TRACKER_ADD_NOTE"] = {
	text = "TEMPLATE",
	button1 = L["Ok"],
	button2 = L["Cancel"],
	OnAccept = function()
		if(Cartographer_Notes ~= nil) then
			local dialog = this:GetParent();
			Cartographer_Notes:SetNote(dialog.koszone, dialog.kosPosX, dialog.kosPosY, dialog.kosname, "VanasKoS-" .. dialog.kossender)
			if(Cartographer_Waypoints ~= nil) then
				Cartographer_Waypoints:SetNoteAsWaypoint(dialog.koszone, Cartographer_Notes.getID(dialog.kosPosX, dialog.kosPosY));
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
