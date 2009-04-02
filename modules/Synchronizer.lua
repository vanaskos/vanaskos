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

	L["Interval"] = true;
	L["Sets the number of minutes between sending lists"] = true;
	L["Sending lists to guild"] = true;
end


VanasKoSSynchronizer = VanasKoS:NewModule("Synchronizer", "AceComm-3.0", "AceTimer-3.0");

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_Synchronizer", false);

local module = VanasKoSSynchronizer;
local core = VanasKoS;

local configOptions = nil;
local startupTimer = nil;

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

function module:OnEnable()
	self:RegisterCommunicationChannels();
	if(self.db.profile.GuildSharingEnabled) then
	startupTimer = self:ScheduleTimer("StartGuildSync", 30, true);
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

local function GetSerializedString(command, listName, list)
-- VanasKoS Version, Protocol Version
return AceSerializer:Serialize(VANASKOS.VERSION, 1, command, VanasKoSSynchronizer.db.realm.synchronizer.mainchar, listName, list);
end

local function DeserializeString(serializedString)
local result, vanasKoSVersion, protocolVersion, command, mainchar, listName, list = AceSerializer:Deserialize(serializedString);
if(protocolVersion ~= 1) then
	return false, format("Unknown protocol version '%s'", protocolVersion);
end
if(type(listName) ~= "string") then
	return false, "Invalid listName (%s)", type(listName);
end
if(type(list) ~= "table") then
	return false, format("Invalid list (%s)", type(list));
end

return true, vanasKoSVersion, protocolVersion, command, mainchar, listName, list;
end

local listsToShare = {"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"};

-- /script VanasKoSSynchronizer:SendListsToGuild()
function module:SendListsToGuild()
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
			-- sl = setlist
			self:SendCommMessage("VanasKoS", GetSerializedString("sl", listName, shareList), "GUILD", nil, "BULK");
		end
	end
end

local sendList = { };
function module:GetListToShare(listName)
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

function module:StartGuildSync(sendNow)
	if(sendNow == true) then
		self:SendListsToGuild();
	end
	guildSyncTimer = self:ScheduleRepeatingTimer("SendListsToGuild", self.db.profile.GuildSharingInterval * 60);
end

function module:StopGuildSync()
	if (startupTimer ~= nil) then
		self:CancelTimer(startupTimer);
		startupTimer = nil;
	end

	if (guildSyncTimer ~= nil) then
		self:CancelTimer(guildSyncTimer);
		guildSyncTimer = nil;
	end
end

function module:RegisterCommunicationChannels()
	self:RegisterComm("VanasKoS");
end

local moppelkotze = false;

function module:OnCommReceived(prefix, text, distribution, sender)
	local result, vanasKoSVersion, protocolVersion, command, mainchar, listName, list = DeserializeString(text);
	if(not result) then
		-- TODO: Log
--		VanasKoS:Print(format("Invalid comm from %s: %s", sender, vanasKoSVersion));
		return;
	end

	-- Ignore messages from self
	if(not sender or sender == UnitName("player")) then
		return
	end

--	VanasKoS:Print(format("CommReceived from %s ver:%s pv:%s cmd:%s mc:%s", sender, vanasKoSVersion, protocolVersion, command, mainchar));
	if(VanasKoS:IsVersionNewer(vanasKoSVersion)) then
		if(not moppelkotze) then
			VanasKoS:Print("A newer version of VanasKoS is available. Please upgrade!");
			moppelkotze = true;
		end
	end
	
	if(command == "sl") then
		self:ProcessList(distribution, sender, mainchar, listName, list);
	end
end

function module:ProcessList(distribution, sender, mainchar, listName, receivedList)
	local synctime = time();
--	VanasKoS:Print(format("Processing list %s from %s (%s)", listName, sender, mainchar));
	local destList = VanasKoS:GetList(listName);
	if(destList == nil) then
--		VanasKoS:Print(format("Invalid list (%s)", listName));
		return;
	end

	-- create and update all entries on the list
	for k,v in pairs(receivedList) do
		local name = k:lower();
--		VanasKoS:Print("    Received " .. name)
		if(destList[name] ~= nil and
			(destList[name].owner == nil or destList[name].owner == "")) then
			-- I already created the kos entry, don't touch it
--			VanasKoS:Print("      " .. name .. " already on list")
		else
--			VanasKoS:Print("      not on my list")
			if(v.owner == nil or v.owner == "") then
				v.owner = sender:lower();
			end
			if(v.creator == nil or v.creator == "") then
				v.creator = sender:lower();
			end

			if(destList[name]) then
--				VanasKoS:Print("      	Updating")
				destList[name].reason = v.reason;
				destList[name].sender = sender:lower();
				destList[name].creator = v.creator:lower();
				destList[name].owner = mainchar:lower();
				destList[name].lastupdated = synctime;
			else
--				VanasKoS:Print("      	Adding")
				destList[name] = { ["reason"] = v.reason,
						["sender"] = sender:lower(),
						["creator"] = v.creator:lower(),
						["owner"] = mainchar:lower(),
						["lastupdated"] = synctime };
			end
			if(destList[name].created == nil) then
				destList[name].created = synctime;
			end
		end
	end

	-- delete old entries from this owner that werent just synced
	for k,v in pairs(destList) do
		if(v.owner and v.owner:lower() == mainchar:lower() and
			(not v.lastupdated or (v.lastupdated and v.lastupdated ~= synctime))) then
--			VanasKoS:Print("    Removing old entry")
			destList[k] = nil
		end
	end
end
