--[[----------------------------------------------------------------------
      DistributedTracker Module - Part of VanasKoS
Broadcasts a list on ZONE and GUILD and handles returning position answers
------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.2"):new("VanasKoSDistributedTracker");

VanasKoSTracker = VanasKoS:NewModule("DistributedTracker");

local VanasKoSTracker = VanasKoSTracker;
local VanasKoS = VanasKoS;
local comm = AceLibrary("AceComm-2.0");

L:RegisterTranslations("enUS", function() return {
	["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = true,
	["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = true,
	["Ok"] = true,
	["Cancel"] = true,
	["Distributed Tracking"] = true,
	["Enabled"] = true,
	["Wanted List"] = true,
	["Wanted"] = true,
	["Tracking via Guild"] = true,
	["Tracking via Zone"] = true,
	["%s  %s"] = "%s  |cffff00ff%s|r",
} end);

L:RegisterTranslations("deDE", function() return {
	["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = "Position von Player %s empfangen (%d, %d in %s) von %s - Grund: %s",
	["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = "%%s in %s bei %d, %d (%s) - Cartographer Notiz erstellen?",
	["Ok"] = "Ok",
	["Cancel"] = "Abbrechen",
	["Distributed Tracking"] = "Verteiltes Suchen",
	["Enabled"] = "Aktiviert",
	["Wanted List"] = "Gesucht-Liste",
	["Wanted"] = "Gesucht",
	["Tracking via Guild"] = "Verteilte Suche mit Gilde",
	["Tracking via Zone"] = "Verteilte Suche in Zone",
	["%s  %s"] = "%s  |cffff00ff%s|r",
} end);

L:RegisterTranslations("frFR", function() return {
	["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = "Position du joueur %s (%d, %d \195\128 %s) re\195\167u de %s - Raison: %s",
	["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = "%s in %s at %d, %d (%s) - Cr\195\169er une note avec \"Cartographer\" ?",
	["Ok"] = "Ok",
	["Cancel"] = "Annuler",
	["Distributed Tracking"] = "R\195\169partition des informations KoS",
	["Enabled"] = "Actif",
	["Wanted List"] = "Liste Wanted",
	["Wanted"] = "Wanted",
	["Tracking via Guild"] = "Tracking via la guilde",
	["Tracking via Zone"] = "Tracking la zone",
	["%s  %s"] = "%s  |cffff00ff%s|r",
} end);

L:RegisterTranslations("koKR", function() return {
--	["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = true,
--	["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = true,
	["Ok"] = "확인",
	["Cancel"] = "취소",
	["Distributed Tracking"] = "분산 추적",
	["Enabled"] = "사용",
	["Wanted List"] = "수배 목록",
	["Wanted"] = "수배",
	["Tracking via Guild"] = "길드 내 추적",
	["Tracking via Zone"] = "지역 내 추적",
	["%s  %s"] = "%s  |cffff00ff%s|r",
} end);

L:RegisterTranslations("esES", function() return {
	["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = "Posición del Jugador %s (%d, %d in %s) recibida desde %s - Razón: %s",
	["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = "%s en %s en %d, %d (%s) - ¿Crear Nota de Cartographer?",
	["Ok"] = "Aceptar",
	["Cancel"] = "Cancelar",
	["Distributed Tracking"] = "Rastreo Distribuido",
	["Enabled"] = "Activado",
	["Wanted List"] = "Lista de Se Busca",
	["Wanted"] = "Se Busca",
	["Tracking via Guild"] = "Rastrear vía Hermandad",
	["Tracking via Zone"] = "Rastrear vía Zona",
	["%s  %s"] = "%s  |cffff00ff%s|r",
} end);

L:RegisterTranslations("ruRU", function() return {
	["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"] = "Расположение игрока %s (%d, %d в %s) получено от %s - Причина: %s",
	["%s in %s at %d, %d (%s) - Create Cartographer Note?"] = "%s в %s по %d, %d (%s) - Создать метку в Картографе?",
	["Ok"] = "Ok",
	["Cancel"] = "Отмена",
	["Distributed Tracking"] = "Распределенное слежение",
	["Enabled"] = "Включено",
	["Wanted List"] = "Список розыска",
	["Wanted"] = "Розыск",
	["Tracking via Guild"] = "Следить по гильдии",
	["Tracking via Zone"] = "Следить по локации",
	["%s  %s"] = "%s  |cffff00ff%s|r",
} end);

-- don't change the values!
-- time span for announcing the kos list
local PUBLISH_REPEAT_TIME = 600;
local PUBLISH_GLOBAL_REPEAT_TIME = 1800;

-- time span after a koslist was received, until the kos-list gets purged
local LIST_PURGE_TIME = 610;
-- time until a new location for player A that was sent to B can be sent again
local STOP_REPORTING_DELAY = 800;
-- global custom channel
local GCHANNEL = "VanasKoS";

local watchList = { };
local blockedList = { };
local zoneNames = nil;

function VanasKoSTracker:OnInitialize()
	VanasKoS:RegisterDefaults("DistributedTracker", "profile", {
		Enabled = true,
		WantedListEnabled = true,
		PublishToGuild = true,
		PublishToZone = true,
	});
	VanasKoS:RegisterDefaults("DistributedTracker", "realm", {
		wantedlist = {
			players = {
			},
		},
	});
	self.db = VanasKoS:AcquireDBNamespace("DistributedTracker");

	VanasKoS:ResetDB("DistributedTracker", "realm");

	self:SetCommPrefix("VanasKoSTracker");
	self:SetDefaultCommPriority("BULK");

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
					set = function(v) VanasKoSTracker.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("DistributedTracker", v); end,
					get = function() return VanasKoSTracker.db.profile.Enabled; end,
				},
				wanted = {
					type = 'toggle',
					name = L["Wanted List"],
					desc = L["Wanted List"],
					order = 2,
					set = function(v) VanasKoSTracker.db.profile.WantedListEnabled = v; end,
					get = function() return VanasKoSTracker.db.profile.WantedListEnabled; end,
				},
				publishguild = {
					type = 'toggle',
					name = L["Tracking via Guild"],
					desc = L["Tracking via Guild"],
					order = 3,
					set = function(v) VanasKoSTracker.db.profile.PublishToGuild = v; end,
					get = function() return VanasKoSTracker.db.profile.PublishToGuild; end,
				},
				publishzone = {
					type = 'toggle',
					name = L["Tracking via Zone"],
					desc = L["Tracking via Zone"],
					order = 4,
					set = function(v) VanasKoSTracker.db.profile.PublishToZone = v; end,
					get = function() return VanasKoSTracker.db.profile.PublishToZone; end,
				},
			},
		});
end

function VanasKoSTracker:VersionReceived(player, addon, version)
	if(addon == nil or addon ~= "VanasKoS" or version == nil or version == false) then
		return;
	end
	self:PrintLiteral("addon", player, addon, version);
end

function VanasKoSTracker:OnEnable()
	if(not self.db.profile.Enabled) then
		return;
	end

	if(VANASKOS.DEBUG == 1) then
		--comm:RegisterAddonVersionReceptor(VanasKoSTracker, "VersionReceived");

		self:RegisterComm(self.commPrefix, "WHISPER", "PositionUpdateReceived");
		if(self.db.profile.PublishToZone) then
			self:RegisterComm(self.commPrefix, "ZONE", "ListMessageReceived");
		end
		if(self.db.profile.WantedListEnabled) then
			self:RegisterComm(self.commPrefix, "CUSTOM", GCHANNEL, "GlobalListMessageReceived");
		end
		if(self.db.profile.PublishToGuild and IsInGuild()) then
			self:RegisterComm(self.commPrefix, "GUILD", "ListMessageReceived");
		end
	else
		--comm:RegisterAddonVersionReceptor(VanasKoSTracker, "VersionReceived");
		self:ScheduleEvent(function()
							self:RegisterComm(self.commPrefix, "WHISPER", "PositionUpdateReceived");
							if(self.db.profile.PublishToZone) then
								self:RegisterComm(self.commPrefix, "ZONE", "ListMessageReceived");
							end
							if(self.db.profile.WantedListEnabled) then
								self:RegisterComm(self.commPrefix, "CUSTOM", GCHANNEL, "GlobalListMessageReceived");
							end
							if(self.db.profile.PublishToGuild and IsInGuild()) then
								self:RegisterComm(self.commPrefix, "GUILD", "ListMessageReceived");
							end
						end, PUBLISH_REPEAT_TIME/10);
	end

	if(self.db.profile.WantedListEnabled) then
		VanasKoS:RegisterList(5, "WANTED", L["Wanted"], self);
		VanasKoSGUI:RegisterList("WANTED", self);
		self:ScheduleRepeatingEvent(self.PublishGlobalList, PUBLISH_GLOBAL_REPEAT_TIME, self);
	end

	self:RegisterEvent("VanasKoS_Player_Detected", "Player_Detected");
	self:ScheduleRepeatingEvent(self.PublishList, PUBLISH_REPEAT_TIME, self);
end

function VanasKoSTracker:OnDisable()
	self:UnregisterAllComms();
	self:CancelAllScheduledEvents();

	VanasKoSGUI:UnregisterList("WANTED");
	VanasKoS:UnregisterList("WANTED");
end

function VanasKoSTracker:AddEntry(listname, name, data)
	local list = self:GetList(listname);
	if(list == nil) then
		return false;
	end
	if(not list[name]) then
		list[name] = { ['reason'] = data['reason'], ['reward'] = data['reward'], ['sender'] = data['sender'], ['created'] = time(), ['lastupdated'] = time() };
	else
		list[name]['reason'] = data['reason'];
		list[name]['reward'] = data['reward'];
		list[name]['sender'] = data['sender'];
		list[name]['lastupdated'] = time();
	end
	self:TriggerEvent("VanasKoS_List_Entry_Added", listname, name, data);
end

function VanasKoSTracker:RemoveEntry(listname, name)
	local list = VanasKoS:GetList(listname);
	if(list and list[name]) then
		list[name] = nil;
		self:TriggerEvent("VanasKoS_List_Entry_Removed", listname, name);
	end
end

function VanasKoSTracker:IsOnList(listname, name)
	local list = VanasKoS:GetList(listname);
	if(list and list[name]) then
		return list[name];
	end
end

function VanasKoSTracker:GetList(list)
	if(list == "WANTED") then
		return self.db.realm.wantedlist.players;
	else
		return nil;
	end
end

function VanasKoSTracker:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2)
	if(list ~= "WANTED") then
		return nil;
	end
	if(value.sender) then
		buttonText1:SetText(format(L["%s  %s"], string.Capitalize(key), value.sender));
	else
		buttonText1:SetText(string.Capitalize(key));
	end
	if(value.reason) then
		buttonText2:SetText(value.reason);
	else
		buttonText2:SetText("");
	end
	button:Show();
end

function VanasKoSTracker:ShowList(list)
	if(list == "WANTED") then
		VanasKoSListFrameSyncButton:Disable();
		VanasKoSListFrameChangeButton:Disable();
		VanasKoSListFrameAddButton:Disable();
		VanasKoSListFrameRemoveButton:Disable();
	end
end

function VanasKoSTracker:HideList(list)
	if(list == "WANTED") then
		VanasKoSListFrameSyncButton:Enable();
		VanasKoSListFrameChangeButton:Enable();
		VanasKoSListFrameAddButton:Enable();
		VanasKoSListFrameRemoveButton:Enable();
	end
end

function VanasKoSTracker:GlobalListMessageReceived(prefix, sender, distribution, customchannel, playerlist)
	if(VANASKOS.DEBUG == 1) then
		self:PrintLiteral(prefix, sender, distribution, customchannel, playerlist);
	end
	if(sender == nil or customchannel ~= GCHANNEL or distribution ~= "CUSTOM" or playerlist == nil) then
		return;
	end

	if(type(playerlist) ~= "table") then
		return;
	end

--	self:PrintLiteral("DEBUG DEBUG DEBUG: ", type(playerlist), playerlist);

	for k,v in pairs(playerlist) do
		VanasKoS:AddEntry("WANTED", k, { ['reason'] = v.reason, ['sender'] = sender });
	end
end

function VanasKoSTracker:ListMessageReceived(prefix, sender, distribution, playerlist)
	watchList[sender] = playerlist;

	-- id must be given to prevent execution of ListPurge if new list came
	self:ScheduleEvent("ListPurge" .. sender, self.PurgeListData, LIST_PURGE_TIME, self, sender);
end

function VanasKoSTracker:PurgeListData(name)
	watchList[name] = nil;
end

-- /script VanasKoS:TriggerEvent("VanasKoS_Player_Detected", "arnel", nil, "kos");
function VanasKoSTracker:PositionUpdateReceived(prefix, sender, distribution, playername, posX, posY, continent, zone)
	if(VANASKOS.DEBUG == 1) then
		self:PrintLiteral("received", prefix, sender, distribution, playername, posX, posY, continent, zone);
	end

	if(sender == nil) then
		return;
	end
	if( not (distribution == "WHISPER") or
		not (type(playername) == "string")) then
		self:PrintLiteral("Invalid Message from", sender, "DEBUG", distribution, playername, posX, posY, continent, zone);
		return;
	end

	local data = VanasKoS:IsOnList("PLAYERKOS", playername);

	if(not data or data.reason == nil or data.owner ~= nil or playername == nil) then
		return;
	end

	local zonename = nil;
	if(continent == nil or zone == nil) then
		continent = -1;
		zone = -1;
	else
		zonename = VanasKoSDataGatherer:GetZoneName(continent, zone);
	end

	if(posX == nil) then
		posX = 0.0;
	end
	if(posY == nil) then
		posY = 0.0;
	end
	if(zonename == nil) then
		zonename = UNKNOWN;
	end

	VanasKoS:Print(format(L["Position on Player %s (%d, %d in %s) received from %s - Reason: %s"], playername, posX*100, posY*100, zonename, sender, data.reason));
	if(not Cartographer_Notes) then
		return;
	end

	local dialog = StaticPopup_Show("VANASKOS_TRACKER_ADD_NOTE");
	if(dialog) then
		dialog.kossender = sender;
		dialog.kosname = playername;
		dialog.koszone = VanasKoSDataGatherer:GetZoneName(continent, zone);
		dialog.kosPosX = posX;
		dialog.kosPosY = posY;

		getglobal(dialog:GetName() .. "Text"):SetText(format(L["%s in %s at %d, %d (%s) - Create Cartographer Note?"], playername, zonename, posX*100, posY*100, sender));
	end
end

function VanasKoSTracker:AddToBlockedList(kosTarget, playername)
	if(self:IsOnBlockedList(kosTarget, searchingPlayer)) then
		return;
	end
	local list = blockedList[kosTarget];
	if(list == nil) then
		list = { };
	end
	tinsert(list, playername);
	blockedList[kosTarget] = list;
end

function VanasKoSTracker:Player_Detected(data)
	assert(data.name ~= nil);

	if(data.faction == nil or data.faction == "friendly") then
		return;
	end

	local locatedPlayer = data.name:lower();

	for name, list in pairs(watchList) do
		for index, playername in pairs(list) do
			if(playername:lower() == locatedPlayer:lower()) then
				if(not self:IsOnBlockedList(playername, name)) then
					if(not VanasKoSDataGatherer:IsInShattrath()) then
						-- add to blocked list, add event to remove him
						self:AddToBlockedList(playername, name);
						self:ScheduleEvent(self.RemoveFromBlocked, STOP_REPORTING_DELAY, self, playername, name);

						local result = self:SendPosition(name, playername);
						if(VANASKOS.DEBUG == 1) then
							if(result) then
								VanasKoS:Print("Position of", playername, "sent for", name);
							else
								VanasKoS:Print("Position of", playername, "failed to sent for", name);
							end
						end
					end
				end
			end
		end
	end

	local list = VanasKoS:GetList("WANTED");
	local sender = nil;
	if(list and list[locatedPlayer] and list[locatedPlayer].sender) then
		sender = list[locatedPlayer].sender;
	end

	if(sender) then
		if(not self:IsOnBlockedList(locatedPlayer, sender)) then
			if(not VanasKoSDataGatherer:IsInShattrath()) then
				-- add to blocked list, add event to remove him
				self:AddToBlockedList(locatedPlayer, sender);
				self:ScheduleEvent(self.RemoveFromBlocked, STOP_REPORTING_DELAY, self, locatedPlayer, sender);

				local result = self:SendPosition(sender, locatedPlayer);
				if(VANASKOS.DEBUG == 1) then
					if(result) then
						VanasKoS:Print("Position of ", locatedPlayer, " sent for ", name);
					else
						VanasKoS:Print("Position of ", locatedPlayer, " failed to sent for ", name);
					end
				end
			end
		end
	end
end

function VanasKoSTracker:SendPosition(receiver, locatedPlayer)
	local continent = GetCurrentMapContinent();
	local zone = GetCurrentMapZone();
	local posX, posY = GetPlayerMapPosition("player");

	if(receiver == nil) then
		self:Print("receiver is nil! WTF?!");
		return;
	end

	if(self:IsUserInChannel(receiver, "ZONE") or
		self:IsUserInChannel(receiver, "CUSTOM", GCHANNEL)) then
		self:SendCommMessage("WHISPER", receiver, locatedPlayer, posX, posY, continent, zone);
		return true;
	else
		for i=1, GetNumGuildMembers(1) do
			local name, rank, rankIndex, level, class, zoneGuild, note, officernote, online, status = GetGuildRosterInfo(i);
			if(name ~= nil and name:lower() == receiver:lower() and online) then
				self:SendCommMessage("WHISPER", receiver, locatedPlayer, posX, posY, continent, zone);
				return true;
			end
		end
	end
	return false;
end

function VanasKoSTracker:RemoveFromBlocked(kosTarget, searchingPlayer)
	local list = blockedList[kosTarget];
	for k, v in pairs(list) do
		if(v == searchingPlayer) then
			tremove(list, k);
			blockedList[kosTarget] = list;
			return;
		end
	end
end

function VanasKoSTracker:IsOnBlockedList(kosTarget, searchingPlayer)
	local list = blockedList[kosTarget];
	if(list == nil) then
		return false;
	end

	for k, v in pairs(list) do
		if(v == searchingPlayer) then
			return true;
		end
	end

	return false;
end

function VanasKoSTracker:PrintWatchList()
	if(type(watchList) ~= "table") then
		self:PrintLiteral("watchList", watchList);
		return;
	end
	for playername,list in pairs(watchList) do
		VanasKoS:Print("Player:", playername);
		local msg = "";
		if(type(list) ~= "table") then
			self:PrintLiteral("watchList list", list);
			return;
		end
		for index, kosname in pairs(list) do
			msg = msg .. " " .. kosname;
		end
		VanasKoS:Print(msg);
	end
	VanasKoS:Print("end");
end

function VanasKoSTracker:PrintBlockList()
	for playername,list in pairs(blockedList) do
		VanasKoS:Print("Player:", playername);
		for index, kosname in pairs(list) do
			VanasKoS:Print(" ", kosname);
		end
	end
	VanasKoS:Print("end");
end

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

	VanasKoSTracker:SendCommMessage("CUSTOM", GCHANNEL, newList);
	if(VANASKOS.DEBUG == 1) then
		VanasKoS:Print("[DEBUG]: Global List published - Entries:", entries);
	end
end

function VanasKoSTracker:PublishList()
	local list = { }
	local kosList = VanasKoS:GetList("PLAYERKOS");
	for k,v in pairs(kosList) do
		if(not v.creator or v.creator == "" or v.creator == UnitName("player")) then
			tinsert(list, k);
		end
	end
	if(#list == 0) then
		return;
	end

	if(self.db.profile.PublishToGuild and IsInGuild()) then
		self:SendCommMessage("GUILD", list);
		--comm:QueryAddonVersion("VanasKoS", "GUILD");
	end

	if(self.db.profile.PublishToZone) then
		self:SendCommMessage("ZONE", list);
	end
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
