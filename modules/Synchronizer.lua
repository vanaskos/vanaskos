local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Synchronizer", "enUS", true, VANASKOS.DEBUG)
if L then
-- auto generated from wowace translation app
--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, namespace="VanasKoS/Synchronizer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Synchronizer", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS/Synchronizer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Synchronizer", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS/Synchronizer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Synchronizer", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS/Synchronizer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Synchronizer", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS/Synchronizer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Synchronizer", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS/Synchronizer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Synchronizer", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS/Synchronizer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Synchronizer", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS/Synchronizer")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/Synchronizer", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS/Synchronizer")@
end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/Synchronizer", false);

VanasKoSSynchronizer = VanasKoS:NewModule("Synchronizer", "AceComm-3.0", "AceTimer-3.0");

local VanasKoSSynchronizer = VanasKoSSynchronizer;
local core = VanasKoS;

local configOptions = nil;
local startupTimer = nil;
local SHARE_LIST = "sl";


local function RegisterConfiguration()
	configOptions = {
		type = 'group',
		name = L["Sharing"],
		desc = L["Options to share your lists with other people"],
		childGroups = "tab",
		args = {
			enabled = {
				type = "toggle",
				name = L["Enabled"],
				desc = L["Enables/Disables the sharing module"],
				order = 1,
				set = function(frame, v) VanasKoS:ToggleModuleActive("Synchronizer"); end,
				get = function() return VanasKoSSynchronizer.enabledState end,
			},
			--[[listoptionsheader = {
				type = "header",
				name = L["Accept/Ignore-Lists"],
				desc = L["Lists in which you can put people from whom you want or do not want to receive data"],
				order = 2,
			},
			acceptgroup = {
				type = "group",
				name = "Accept",
				childGroups = "tab",
				order = 3;
				args = { 
					playerkos  = {
						type = "group",
						name = "Player KoS",
						desc = "Players from whom to accept/ignore Player KoS entries",
						order = 3,
						args = { },
					},
					guildkos  = {
						type = "group",
						name = "Guild KoS",
						desc = "Players from whom to accept/ignore Guild KoS entries",
						order = 4,
						args = { },
					},
					hatelist  = {
						type = "group",
						name = "Hatelist",
						desc = "Players from whom to accept/ignore Hatelist entries",
						order = 5,
						args = { },
					},
					nicelist  = {
						type = "group",
						name = "Nicelist",
						desc = "Players from whom to accept/ignore Nicelist entries",
						order = 6,
						args = { },
					},
				}
			},
			ignoregroup = {
				type = "group",
				name = "Ignore",
				childGroups = "tab",
				order = 4;
				args = { 
					playerkos  = {
						type = "group",
						name = "Player KoS",
						desc = "Players from whom to accept/ignore Player KoS entries",
						order = 3,
						args = { },
					},
					guildkos  = {
						type = "group",
						name = "Guild KoS",
						desc = "Players from whom to accept/ignore Guild KoS entries",
						order = 4,
						args = { },
					},
					hatelist  = {
						type = "group",
						name = "Hatelist",
						desc = "Players from whom to accept/ignore Hatelist entries",
						order = 5,
						args = { },
					},
					nicelist  = {
						type = "group",
						name = "Nicelist",
						desc = "Players from whom to accept/ignore Nicelist entries",
						order = 6,
						args = { },
					},
				}
			},]]
		},
	};
	VanasKoSGUI:AddConfigOption("VanasKoS-Synchronizer", configOptions);
	
	local DL = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/DefaultLists", false);
	
	VanasKoSGUI:AddConfigOption("Synchronizer-Guild", {
		type = "group",
		name = L["Sharing - Guild"],
		desc = L["Guild Sharing Options"],
		args = {
			enabled = {
				type = "toggle",
				name = L["Guild Sharing"],
				desc = L["Enables/Disables sharing lists with the guild"],
				order = 1,
				set = function(frame, v) 
							VanasKoSSynchronizer.db.profile.GuildSharingEnabled = v; 
							if(v) then 
								VanasKoSSynchronizer:StartGuildSync(true); 
							else 
								VanasKoSSynchronizer:StopGuildSync(); 
							end
						end,
				get = function() return VanasKoSSynchronizer.db.profile.GuildSharingEnabled; end,
			},
			interval = {
				type = 'range',
				name = L["Interval"],
				desc = L["Sets the number of minutes between sending lists"],
				order = 2,
				get = function() return VanasKoSSynchronizer.db.profile.GuildSharingInterval end;
				set = function(frame, v)
						if(v >= 10) then
							VanasKoSSynchronizer.db.profile.GuildSharingInterval = v;
							VanasKoSSynchronizer:StopGuildSync();
							VanasKoSSynchronizer:StartGuildSync(false); 
						end
					end,
				min = 10,
				max = 120,
				step = 1,
				isPercent = false,
			},
			liststoshare = {
				type = "multiselect",
				name = L["Lists to share with guild"],
				desc = L["Select the lists you want to share with your guild."],
				order = 3,
				get = function(frame, key) 
						return VanasKoSSynchronizer.db.profile.GuildShareLists[key];
					end,
				set = function(frame, key, value) VanasKoSSynchronizer.db.profile.GuildShareLists[key] = value end,
				
				values = {
						["PLAYERKOS"] = DL["Player KoS"],
						["GUILDKOS"] = DL["Guild KoS"],
						["HATELIST"] = DL["Hatelist"],
						["NICELIST"] = DL["Nicelist"],
					},
			}
		},
	});
	--[[
	VanasKoSGUI:AddConfigOption("Synchronizer-Group", {
		type = "group",
		name = L["Sharing - Group"],
		desc = L["Options to share lists with groups"],
		args = {
			lists = {
				type = "select",
				name = L["Share Groups"],
				desc = L["Groups with whom I share"],
				order = 1,
				set = function(frame, v) end,
				get = function() end,
				values = function() return VanasKoSSynchronizer:GetShareGroupTable(); end,
			},
			optionsheader = {
				type = "header",
				name = "",
			},
			addgroup = {
				type = "execute",
				name = L["Add Share Group"],
				desc = L["Adds a Share Group to the list"],
				func = function(frame) end,
			},
			removeroup = {
				type = "execute",
				name = L["Remove Share Group"],
				desc = L["Removes the selected Share Group from the list"],
				func = function(frame) end,
			},
		},
	});]]
end

function VanasKoSSynchronizer:OnInitialize()
	self.db = core.db:RegisterNamespace("Synchronizer", {
		realm = {
			synchronizer = {
				mainchar = nil,
				otherchars = {
				},
				ShareChannels = {
				},
			},
		},
		profile = {
			Enabled = true,
			GuildSharingEnabled = false,
			GuildSharingInterval = 60,
			GuildShareLists = {
				['PLAYERKOS'] = true,
				['GUILDKOS'] = true,
				['HATELIST'] = true,
				['NICELIST'] = true,
			},
		},
	});
	
	local charName = UnitName("player");
	if(self.db.realm.synchronizer.mainchar == nil) then
		self.db.realm.synchronizer.mainchar = charName;
	end
	if(self.db.realm.synchronizer.mainchar ~= charName) then
		self.db.realm.synchronizer.otherchars[charName] = true;
	end
	
	RegisterConfiguration();
	
	self:SetEnabledState(self.db.profile.Enabled);
end

function VanasKoSSynchronizer:OnEnable()
	self:RegisterCommunicationChannels();
	if(self.db.profile.GuildSharingEnabled) then
		startupTimer = self:ScheduleTimer("StartGuildSync", 30, true);
	end
end

function VanasKoSSynchronizer:OnDisable()
	self:UnregisterAllComm();
end

function VanasKoSSynchronizer:GetShareGroupTable()
	local tbl = { };
	for k, v in pairs(self.db.realm.synchronizer.ShareChannels) do
		tbl[k] = k;
	end

	return tbl;
end

local AceSerializer = LibStub("AceSerializer-3.0");

local function GetSerializedString(command, listName, list)
	local data = {
		["owner"] = VanasKoSSynchronizer.db.realm.synchronizer.mainchar,
		["listName"] = listName,
		["list"] = list,
		["version"] = 1,
	};
	return AceSerializer:Serialize(VANASKOS.VERSION, 1, command, data);
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

	if(command == SHARE_LIST) then
		if(data.version == nil or data.version ~= 1) then
			return false, format("Unknown synchronizer version '%s'", data.version or "nil");
		end
		if(data.owner == nil or type(data.owner) ~= "string") then
			return false, format("Invalid owner (%s)", type(data.owner));
		end
		if(data.listName == nil or type(data.listName) ~= "string") then
			return false, format("Invalid listName (%s)", type(data.listName));
		end
		if(data.list == nil or type(data.list) ~= "table") then
			return false, format("Invalid list (%s)", type(data.list));
		end
	else
		return false, format("Unknown command '%s'", command);
	end

	return true, vanasKoSVersion, protocolVersion, command, data;
end

local listsToShare = {"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"};

-- /script VanasKoSSynchronizer:SendListsToGuild()
function VanasKoSSynchronizer:SendListsToGuild()
	if (startupTimer ~= nil) then
		startupTimer = nil;
	end

	if(not IsInGuild()) then
		return;
	end
	VanasKoS:Print(L["Sending lists to guild"]);

	for index, listName in pairs(listsToShare) do
		if(self.db.profile.GuildShareLists[listName]) then
			local shareList = self:GetListToShare(listName);
			self:SendCommMessage("VanasKoS", GetSerializedString(SHARE_LIST, listName, shareList), "GUILD", nil, "BULK");
		end
	end
end

local sendList = { };
function VanasKoSSynchronizer:GetListToShare(listName)
	local list = VanasKoS:GetList(listName);
	wipe(sendList);
	for k, v in pairs(list) do
		if (not v.owner or v.owner == "") then
			sendList[k] = {
				['reason'] = v.reason;
				['creator'] = v.creator;
			}
		end;
	end

	return sendList;
end

local guildSyncTimer = nil;

function VanasKoSSynchronizer:StartGuildSync(sendNow)
	if(sendNow == true) then
		self:SendListsToGuild();
	end
	guildSyncTimer = self:ScheduleRepeatingTimer("SendListsToGuild", self.db.profile.GuildSharingInterval * 60);
end

function VanasKoSSynchronizer:StopGuildSync()
	if (startupTimer ~= nil) then
		self:CancelTimer(startupTimer);
		startupTimer = nil;
	end

	if (guildSyncTimer ~= nil) then
		self:CancelTimer(guildSyncTimer);
		guildSyncTimer = nil;
	end
end

function VanasKoSSynchronizer:RegisterCommunicationChannels()
	self:RegisterComm("VanasKoS");
end

function VanasKoSSynchronizer:OnCommReceived(prefix, text, distribution, sender)
	local result, vanasKoSVersion, protocolVersion, command, data = DeserializeString(text);
	if(not result) then
		-- TODO: Log
		if(VANASKOS.DEBUG == 1) then
			VanasKoS:Print(format("Sync: Invalid comm from %s: %s", sender, vanasKoSVersion));
		end
		return;
	end

	if(VANASKOS.DEBUG == 1) then
		VanasKoS:Print(format("Sync: CommReceived from %s ver:%s pv:%s cmd:%s", sender, vanasKoSVersion, protocolVersion, command));
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
	
	if(command == SHARE_LIST) then
		self:ProcessList(distribution, sender, data.owner, data.listName, data.list);
	end
end

function VanasKoSSynchronizer:ProcessList(distribution, sender, owner, listName, receivedList)
	local synctime = time();
	if(VANASKOS.DEBUG == 1) then
		VanasKoS:Print(format("Processing list %s from %s (%s)", listName, sender, owner));
	end
	local destList = VanasKoS:GetList(listName);
	if(destList == nil) then
		if(VANASKOS.DEBUG == 1) then
			VanasKoS:Print(format("Invalid list (%s)", listName));
		end
		return;
	end

	-- create and update all entries on the list
	for k,v in pairs(receivedList) do
		local name = k:lower();
		if(VANASKOS.DEBUG == 1) then
			VanasKoS:Print("    Received " .. name)
		end
		if(destList[name] ~= nil and
			(destList[name].owner == nil or destList[name].owner == "")) then
			-- I already created the kos entry, don't touch it
			if(VANASKOS.DEBUG == 1) then
				VanasKoS:Print("      " .. name .. " already on list")
			end
		else
			if(VANASKOS.DEBUG == 1) then
				VanasKoS:Print("      not on my list")
			end
			if(v.owner == nil or v.owner == "") then
				v.owner = sender:lower();
			end
			if(v.creator == nil or v.creator == "") then
				v.creator = sender:lower();
			end

			if(destList[name]) then
				if(VANASKOS.DEBUG == 1) then
					VanasKoS:Print("      	Updating");
				end
				destList[name].reason = v.reason;
				destList[name].sender = sender:lower();
				destList[name].creator = v.creator:lower();
				destList[name].owner = owner:lower();
				destList[name].lastupdated = synctime;
			else
				if(VANASKOS.DEBUG == 1) then
					VanasKoS:Print("      	Adding");
				end
				destList[name] = { ["reason"] = v.reason,
						["sender"] = sender:lower(),
						["creator"] = v.creator:lower(),
						["owner"] = owner:lower(),
						["lastupdated"] = synctime };
			end
			if(destList[name].created == nil) then
				destList[name].created = synctime;
			end
		end
	end

	-- delete old entries from this owner that werent just synced
	for k,v in pairs(destList) do
		if(v.owner and v.owner:lower() == owner:lower() and
			(not v.lastupdated or (v.lastupdated and v.lastupdated ~= synctime))) then
			if(VANASKOS.DEBUG == 1) then
				VanasKoS:Print("    Removing old entry")
			end
			destList[k] = nil
		end
	end

	VanasKoSGUI:Update();
end
