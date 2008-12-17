local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Synchronizer", "enUS", true);
if L then
	L["Sharing"] = true;
	L["Sharing - Guild"] = true;
	L["Sharing - Group"] = true;
	L["Lists to share with guild"] = true;
	L["Select the lists you want to share with your guild."] = true;
	L["Options to share your lists with other people"] = true;
	L["Options to share lists with groups"] = true;
	
	L["Enabled"] = true;
	L["Enables/Disables the sharing module"] = true;
	L["Guild Sharing"] = true;
	L["Guild Sharing Options"] = true;
	L["Enables/Disables sharing lists with the guild"] = true;
	L["Lists in which you can put people from whom you want or do not want to receive data"] = true;
	L["Accept/Ignore-Lists"] = true;
	L["Share Groups"] = true;
	L["Groups with whom I share"] = true;

	L["Add Share Group"] = true;
	L["Adds a Share Group to the list"] = true;
	L["Remove Share Group"] = true;
	L["Removes the selected Share Group from the list"] = true;
end


VanasKoSSynchronizer = VanasKoS:NewModule("Synchronizer", "AceComm-3.0", "AceTimer-3.0");

 L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_Synchronizer", false);

 local SEND_TO_GUILD_INTERVAL = 3600;
 
local module = VanasKoSSynchronizer;
local core = VanasKoS;

local configOptions = nil;

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
	VanasKoSGUI:AddConfigOption("Synchronizer", configOptions);
	
	local DL = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_DefaultLists", false);
	
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
								VanasKoSSynchronizer:StartGuildSync(); 
							else 
								VanasKoSSynchronizer:StopGuildSync(); 
							end
						end,
				get = function() return VanasKoSSynchronizer.db.profile.GuildSharingEnabled; end,
			},
			liststoshare = {
				type = "multiselect",
				name = L["Lists to share with guild"],
				desc = L["Select the lists you want to share with your guild."],
				order = 2,
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

function module:OnInitialize()
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
end

function module:OnEnable()
	if(not self.db.profile.Enabled) then
		self:Disable();
		return;
	end
	
	self:RegisterCommunicationChannels();
	if(self.db.profile.GuildSharingEnabled) then
		self:ScheduleTimer("StartGuildSync", 30);
	end
end

function module:OnDisable()
	self:UnregisterAllComm();
end

function module:GetShareGroupTable()
	local tbl = { };
	for k, v in pairs(self.db.realm.synchronizer.ShareChannels) do
		tbl[k] = k;
	end
	
	return tbl;
end

local AceSerializer = LibStub("AceSerializer-3.0");

local function GetSerializedString(command, list)
	-- VanasKoS Version, Protocol Version
	return AceSerializer:Serialize(VANASKOS.VERSION, 1, command, VanasKoSSynchronizer.db.realm.synchronizer.mainchar, list);
end

local function DeserializeString(serializedString)
	local result, vanasKoSVersion, protocolVersion, command, mainchar, list = AceSerializer:Deserialize(serializedString);
	if(protocolVersion ~= 1) then
		return false, "Unknown protocol version";
	end
	if(type(listName) ~= "string") then
		return false, "Invalid listName";
	end
	if(type(list) == "table") then
		return false, "Invalid list";
	end
	
	return true, vanasKoSVersion, protocolVersion, command, mainchar, list;
end

local listsToShare = {"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"};

function module:SendListsToGuild()
	for index, listName in pairs(listsToShare) do
		if(self.db.profile.GuildShareLists[listName]) then
			--[[  TODO:REEnable for releases
			if(not IsInGuild()) then
				return;
			end]]
			local shareList = self:GetListToShare(listName);
			-- sl = setlist
			self:SendCommMessage("VanasKoS", GetSerializedString("sl", shareList), "WHISPER", "Vanae", "BULK");
		end
	end
end

local sendList = { };
function module:GetListToShare(listName)
	local list = VanasKoS:GetList(listName);
	wipe(sendList);
	for k, v in pairs(list) do
		sendList[k] = {
			['reason'] = v.reason;
			['creator'] = v.creator;
		};
	end
end

local guildSyncTimer = nil;

function module:StartGuildSync()
	self:SendListsToGuild();
	guildSyncTimer = self:ScheduleRepeatingTimer("SendListsToGuild", SEND_TO_GUILD_INTERVAL);
end

function module:StopGuildSync()
	self:CancelTimer(guildSyncTimer);
	guildSyncTimer = nil;
end

function module:RegisterCommunicationChannels()
	self:RegisterComm("VanasKoS");
end

local moppelkotze = false;

function module:OnCommReceived(prefix, text, distribution, sender)
	local result, vanasKoSVersion, protocolVersion, command, mainchar, list = DeserializeString(text);
	if(not result) then
		-- TODO: Log
		return;
	end
	if(VanasKoS:IsVersionNewer(vanasKoSVersion)) then
		if(not moppelkotze) then
			VanasKoS:Print("A newer version of VanasKoS is available. Please upgrade!");
			moppelkotze = true;
		end
	end
	
	if(command == "sl") then
		self:ProcessList(distribution, sender, mainchar, list);
	end
end

function module:ProcessList(distribution, sender, mainchar, receivedList)
	local synctime = time();
	for listname, list in pairs(receivedList) do
		local destList = VanasKoS:GetList(listname);
		if(destList ~= nil) then
			-- create and update all entries on the list
			for k,v in pairs(list) do
				local name = k:lower();
				if(destList[name] and
					(destList[name].owner == nil or
					destList[name].owner == "")) then
					-- i already created the kos entry, don't touch it
				else
					if(v.owner == nil or v.owner == "") then
						v.owner = sender:lower();
					end
					if(v.creator == nil or v.creator == "") then
						v.creator = sender:lower();
					end

					if(destList[name]) then
						destList[name].reason = v.reason;
						destList[name].sender = sender:lower();
						destList[name].creator = v.creator:lower();
						destList[name].owner = mainchar;
						destList[name].lastupdated = synctime;
					else
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

			-- delete old from that owner  that werent just synced
			for k,v in pairs(destList) do
				if(v.owner ~= nil and
					v.owner:lower() == owner:lower() and
					(not v.lastupdated or
						(v.lastupdated and v.lastupdated ~= synctime))) then
					destList[k] = nil
				end
			end
		end
	end
end
