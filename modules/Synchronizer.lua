--[[----------------------------------------------------------------------
	Synchronizer Module - Part of VanasKoS
Handles list sychronization through chat (whisper, guild, party)
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/Synchronizer", false)
local Dialog = LibStub("LibDialog-1.0")
local VanasKoS = LibStub("AceAddon-3.0"):GetAddon("VanasKoS")
local VanasKoSGUI = VanasKoS:GetModule("GUI")
local VanasKoSSynchronizer = VanasKoS:NewModule("Synchronizer", "AceComm-3.0", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceSerializer-3.0")

-- Global wow strings
local NAME, GUILD, ERR_CHAT_PLAYER_NOT_FOUND_S = NAME, GUILD, ERR_CHAT_PLAYER_NOT_FOUND_S
local ACCEPT, CANCEL = ACCEPT, CANCEL

-- declare common globals local
local type = type
local pairs = pairs
local ipairs = ipairs
local next = next
local time = time
local SecondsToTime = SecondsToTime
local format = format
local wipe = wipe
local tinsert = tinsert
local tremove = tremove
local strmatch = strmatch
local strsplit = strsplit
local UnitName = UnitName
local IsInGuild = IsInGuild

-- constants
local POLICY_ACCEPT = 1
local POLICY_REJECT = 2
local POLICY_ACCEPT_ALL = 3
local POLICY_REJECT_ALL = 4
local SHARE_LIST = "sl"
local REQUEST_LIST = "rl"
local DENY_REQUEST = "dr"

-- Local Variables
local startupGuildTimer = nil
local startupRequestTimer = nil

-- sorts by index
local function SortByIndex(val1, val2)
	return val1 < val2
end
local function SortByIndexReverse(val1, val2)
	return val1 > val2
end

-- sort current lastseen
local function SortByLastSync(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	if(list ~= nil) then
		local cmp1 = 2^30
		local cmp2 = 2^30
		if(list[val1] ~= nil and list[val1].lastsync ~= nil) then
			cmp1 = time() - list[val1].lastsync
		end
		if(list[val2] ~= nil and list[val2].lastsync ~= nil) then
			cmp2 = time() - list[val2].lastsync
		end
		return (cmp1 < cmp2)
	end
	return false
end
local function SortByLastSyncReverse(val1, val2)
	local list = VanasKoSGUI:GetCurrentList()
	if(list ~= nil) then
		local cmp1 = 2^30
		local cmp2 = 2^30
		if(list[val1] ~= nil and list[val1].lastsync ~= nil) then
			cmp1 = time() - list[val1].lastsync
		end
		if(list[val2] ~= nil and list[val2].lastsync ~= nil) then
			cmp2 = time() - list[val2].lastsync
		end
		return (cmp1 > cmp2)
	end
	return false
end

local function RegisterConfiguration()
	VanasKoSGUI:AddModuleToggle("Synchronizer", L["Sharing"])
	VanasKoSGUI:AddConfigOption("Synchronizer", {
		type = 'group',
		name = L["Sharing"],
		desc = L["Options to share your lists with other people"],
		childGroups = "tab",
		args = {
			guild = {
				type = "group",
				name = GUILD,
				desc = L["Guild Sharing Options"],
				order = 1,
				args = {
					enabled = {
						type = "toggle",
						name = L["Enable"],
						desc = L["Enables/Disables sharing lists with the guild"],
						order = 1,
						set = function(frame, v)
							VanasKoSSynchronizer.db.profile.GuildSharingEnabled = v
							if (VanasKoSSynchronizer.db.profile.Enabled) then
								if(v) then
									VanasKoSSynchronizer:StartGuildSync(true)
								else
									VanasKoSSynchronizer:StopGuildSync()
								end
							end
						end,
						get = function()
							return VanasKoSSynchronizer.db.profile.GuildSharingEnabled
						end,
					},
					interval = {
						type = 'range',
						name = L["Interval"],
						desc = L["Sets the number of minutes between sending lists"],
						order = 2,
						get = function()
							return VanasKoSSynchronizer.db.profile.GuildSharingInterval
						end,
						set = function(frame, v)
							if(v >= 10) then
								VanasKoSSynchronizer.db.profile.GuildSharingInterval = v
								if (VanasKoSSynchronizer.db.profile.Enabled) then
									VanasKoSSynchronizer:StopGuildSync()
									VanasKoSSynchronizer:StartGuildSync(false)
								end
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
							return VanasKoSSynchronizer.db.profile.GuildShareLists[key]
						end,
						set = function(frame, key, value) VanasKoSSynchronizer.db.profile.GuildShareLists[key] = value end,
						values = {
							["PLAYERKOS"] = L["Player KoS"],
							["GUILDKOS"] = L["Guild KoS"],
							["HATELIST"] = L["Hatelist"],
							["NICELIST"] = L["Nicelist"],
						},
					},
				},
			},
			sharing = {
				type = "group",
				name = L["Automatic"],
				args =
				{
					enabled = {
						type = "toggle",
						name = L["Enable"],
						desc = L["Enables/Disables automatic list retrieval requests"],
						order = 1,
						set = function(frame, v)
							VanasKoSSynchronizer.db.profile.AutoSharingEnabled = v
							if (VanasKoSSynchronizer.db.profile.Enabled) then
								if(v) then
									VanasKoS:RegisterList(7, "PLAYERSYNC", L["Sharing"], VanasKoSSynchronizer)
									VanasKoSGUI:RegisterList("PLAYERSYNC", VanasKoSSynchronizer)
									VanasKoSSynchronizer:StartRequestSync(true)
								else
									VanasKoSGUI:UnregisterList("PLAYERSYNC")
									VanasKoS:UnregisterList("PLAYERSYNC")
									VanasKoSSynchronizer:StopRequestSync()
								end
							end
						end,
						get = function()
							return VanasKoSSynchronizer.db.profile.AutoSharingEnabled
						end,
					},
					policy = {
						type = "select",
						name = L["Request Policy"],
						desc = L["Default policy for sharing lists with others"],
						style = "radio",
						order = 2,
						values = {
							[POLICY_ACCEPT] = L["Accept"],
							[POLICY_REJECT] = L["Reject"],
							[POLICY_ACCEPT_ALL] = L["Accept all"],
							[POLICY_REJECT_ALL] = L["Reject all"],
						},
						set = function(frame, v)
							if(VanasKoSSynchronizer.db.profile.SharePolicy == v) then
								return
							end
							VanasKoSSynchronizer.db.profile.SharePolicy = v
							if (VanasKoSSynchronizer.db.profile.Enabled) then
								if(v == POLICY_REJECT) then
									VanasKoSGUI:UnregisterList("REJECTSYNC")
									VanasKoS:UnregisterList("REJECTSYNC")
									VanasKoS:RegisterList(8, "ACCEPTSYNC", L["Share Whitelist"], VanasKoSSynchronizer)
									VanasKoSGUI:RegisterList("ACCEPTSYNC", VanasKoSSynchronizer)
								elseif(v == POLICY_ACCEPT) then
									VanasKoSGUI:UnregisterList("ACCEPTSYNC")
									VanasKoS:UnregisterList("ACCEPTSYNC")
									VanasKoS:RegisterList(8, "REJECTSYNC", L["Share Blacklist"], VanasKoSSynchronizer)
									VanasKoSGUI:RegisterList("REJECTSYNC", VanasKoSSynchronizer)
								else
									VanasKoSGUI:UnregisterList("REJECTSYNC")
									VanasKoS:UnregisterList("REJECTSYNC")
									VanasKoSGUI:UnregisterList("ACCEPTSYNC")
									VanasKoS:UnregisterList("ACCEPTSYNC")
								end
							end
						end,
						get = function()
							return VanasKoSSynchronizer.db.profile.SharePolicy
						end,
					},
					liststoshare = {
						type = "multiselect",
						name = L["Lists to request from share group"],
						desc = L["Select the lists you want to receive from your share group."],
						order = 3,
						get = function(frame, key)
							return VanasKoSSynchronizer.db.profile.AutoShareLists[key]
						end,
						set = function(frame, key, value)
							VanasKoSSynchronizer.db.profile.AutoShareLists[key] = value
						end,
						values = {
							["PLAYERKOS"] = L["Player KoS"],
							["GUILDKOS"] = L["Guild KoS"],
							["HATELIST"] = L["Hatelist"],
							["NICELIST"] = L["Nicelist"],
						},
					},
				},

			}
		},
	})
end

function VanasKoSSynchronizer:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("Synchronizer", {
		factionrealm = {
			synchronizer = {
				mainchar = nil,
				otherchars = {
				},
				share = {
				},
				accept = {
				},
				reject = {
				},
				--[[
				ShareChannels = {
				},
				]]
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
			AutoSharingEnabled = false,
			AutoShareLists = {
				['PLAYERKOS'] = true,
				['GUILDKOS'] = true,
				['HATELIST'] = true,
				['NICELIST'] = true,
			},
			SharePolicy = POLICY_ACCEPT_ALL,
		},
	})

	local charName = UnitName("player")
	if(self.db.factionrealm.synchronizer.mainchar == nil) then
		self.db.factionrealm.synchronizer.mainchar = charName
	end
	if(self.db.factionrealm.synchronizer.mainchar ~= charName) then
		self.db.factionrealm.synchronizer.otherchars[charName] = true
	end

	RegisterConfiguration()

	Dialog:Register("VanasKoSQuestionAdd", {
		show_while_dead = true,
		is_exclusive = true,
		on_show = function(self, data)
			self.text:SetText(data.prompt)
		end,
		on_hide = function(self, data)
			VanasKoSSynchronizer:ClearQueuedPlayerList(data.sender, data.listName)
		end,
		buttons = {
			{
				text = ACCEPT,
				on_click = function(self, data)
					VanasKoSSynchronizer:ProcessQueuedPlayerList(data.sender, data.listName)
				end,
			},
			{
				text = CANCEL,
				on_click = function(self)
					Dialog:Dismiss("VanasKoSQuestionAdd")
				end,
			},
		},
	})

	self:SetEnabledState(self.db.profile.Enabled)
end

function VanasKoSSynchronizer:OnEnable()
	self:RegisterCommunicationChannels()
	if(self.db.profile.GuildSharingEnabled) then
		startupGuildTimer = self:ScheduleTimer("StartGuildSync", 30, true)
	end
	if(self.db.profile.AutoSharingEnabled) then
		startupRequestTimer = self:ScheduleTimer("StartRequestSync", 90, true)
	end
	local hookSecure = true
	self:RawHook("ChatFrame_MessageEventHandler", hookSecure)

	if(self.db.profile.AutoSharingEnabled) then
		VanasKoS:RegisterList(7, "PLAYERSYNC", L["Sharing"], self)
		VanasKoSGUI:RegisterList("PLAYERSYNC", self)
	end

	if(self.db.profile.SharePolicy == POLICY_REJECT) then
		VanasKoS:RegisterList(8, "ACCEPTSYNC", L["Share Whitelist"], self)
		VanasKoSGUI:RegisterList("ACCEPTSYNC", self)
	elseif(self.db.profile.SharePolicy == POLICY_ACCEPT) then
		VanasKoS:RegisterList(8, "REJECTSYNC", L["Share Blacklist"], self)
		VanasKoSGUI:RegisterList("REJECTSYNC", self)
	end
end

function VanasKoSSynchronizer:OnDisable()
	self:Unhook("ChatFrame_MessageEventHandler")
	self:UnregisterAllComm()

	VanasKoS:UnregisterList("PLAYERSYNC")
	VanasKoS:UnregisterList("ACCEPTSYNC")
	VanasKoS:UnregisterList("REJECTSYNC")
	VanasKoSGUI:UnregisterList("PLAYERSYNC")
	VanasKoSGUI:UnregisterList("ACCEPTSYNC")
	VanasKoSGUI:UnregisterList("REJECTSYNC")
end

local function GetSerializedString(command, listName, list)
	if (command == SHARE_LIST) then
		local data = {
			["owner"] = VanasKoSSynchronizer.db.factionrealm.synchronizer.mainchar,
			["listName"] = listName,
			["list"] = list,
			["version"] = 1,
		}
		return VanasKoSSynchronizer:Serialize(VANASKOS.VERSION, 1, command, data)
	elseif (command == REQUEST_LIST) then
		local data = {
			["listName"] = listName,
			["version"] = 1,
		}
		return VanasKoSSynchronizer:Serialize(VANASKOS.VERSION, 1, command, data)
	elseif (command == DENY_REQUEST) then
		local data = {
			["listName"] = listName,
			["version"] = 1,
		}
		return VanasKoSSynchronizer:Serialize(VANASKOS.VERSION, 1, command, data)
	end
end

local function DeserializeString(serializedString)
	local _, vanasKoSVersion, protocolVersion, command, data = VanasKoSSynchronizer:Deserialize(serializedString)
	if(protocolVersion ~= 1) then
		return false, format("Unknown protocol version '%s'", protocolVersion or "nil")
	end
	if(type(command) ~= "string") then
		return false, format("Invalid command format (%s)", type(command))
	end
	if(type(data) ~= "table") then
		return false, format("Invalid command format (%s)", type(command))
	end

	if(command == SHARE_LIST) then
		if(data.version == nil or data.version ~= 1) then
			return false, format("Unknown synchronizer version '%s'", data.version or "nil")
		end
		if(data.owner == nil or type(data.owner) ~= "string") then
			return false, format("Invalid owner (%s)", type(data.owner))
		end
		if(data.listName == nil or type(data.listName) ~= "string") then
			return false, format("Invalid listName (%s)", type(data.listName))
		end
		if(data.list == nil or type(data.list) ~= "table") then
			return false, format("Invalid list (%s)", type(data.list))
		end
	elseif (command == REQUEST_LIST) then
		if(data.version == nil or data.version ~= 1) then
			return false, format("Unknown synchronizer version '%s'", data.version or "nil")
		end
		if(data.listName == nil or type(data.listName) ~= "string") then
			return false, format("Invalid listName (%s)", type(data.listName))
		end
	elseif (command == DENY_REQUEST) then
		if(data.version == nil or data.version ~= 1) then
			return false, format("Unknown synchronizer version '%s'", data.version or "nil")
		end
		if(data.listName == nil or type(data.listName) ~= "string") then
			return false, format("Invalid listName (%s)", type(data.listName))
		end
	else
		return false, format("Unknown command '%s'", command)
	end

	return true, vanasKoSVersion, protocolVersion, command, data
end

local listsToShare = {"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}

-- /script VanasKoSSynchronizer:SendListsToGuild()
function VanasKoSSynchronizer:SendListsToGuild()
	if (startupGuildTimer ~= nil) then
		startupGuildTimer = nil
	end

	if(not IsInGuild()) then
		return
	end
	VanasKoS:Print(L["Sending lists to guild"])

	for _, listName in pairs(listsToShare) do
		if(self.db.profile.GuildShareLists[listName]) then
			local shareList = self:GetListToShare(listName)
			if (next(shareList) ~= nil) then
				self:SendCommMessage("VanasKoS", GetSerializedString(SHARE_LIST, listName, shareList), "GUILD", nil, "BULK")
			end
		end
	end
end

local requestSharePlayer = nil
function VanasKoSSynchronizer:RequestNextLists()
	requestSharePlayer = next(self.db.factionrealm.synchronizer.share, requestSharePlayer)
	if (requestSharePlayer == nil) then
		return
	end
	for _, listName in ipairs(listsToShare) do
		if(self.db.profile.AutoShareLists[listName]) then
			self:RequestPlayerList(requestSharePlayer, listName)
		end
	end
end


function VanasKoSSynchronizer:SendListToParty(listName)
	local shareList = self:GetListToShare(listName)
	if (next(shareList) ~= nil) then
		self:SendCommMessage("VanasKoS", GetSerializedString(SHARE_LIST, listName, shareList), "PARTY", nil, "BULK")
	end
end

local LastWhispered = nil
-- /script VanasKoSSynchronizer:SendListToPlayer("Bairik", "PLAYERKOS") VanasKoSSynchronizer:SendListToPlayer("Bairik", "GUILDKOS");
function VanasKoSSynchronizer:SendListToPlayer(player, listName)
	local shareList = self:GetListToShare(listName)
	if (next(shareList) ~= nil) then
		LastWhispered = player
		self:SendCommMessage("VanasKoS", GetSerializedString(SHARE_LIST, listName, shareList), "WHISPER", player, "BULK")
	end
end

local requestedLists = {
	["PLAYERKOS"] = {},
	["GUILDKOS"] = {},
	["HATELIST"] = {},
	["NICELIST"] = {},
}
function VanasKoSSynchronizer:RequestPlayerList(player, listName)
	if (requestedLists[listName] == nil) then
		return
	end
	if(VANASKOS.DEBUG == 1) then
		VanasKoS:Print(format("RequestPlayerList(%s, %s)", player, listName))
	end
	requestedLists[listName][player:lower()] = true
	LastWhispered = player
	self:SendCommMessage("VanasKoS", GetSerializedString(REQUEST_LIST, listName), "WHISPER", player, "BULK")
end

function VanasKoSSynchronizer:DenyRequest(player, listName)
	LastWhispered = player
	self:SendCommMessage("VanasKoS", GetSerializedString(DENY_REQUEST, listName), "WHISPER", player, "BULK")
end

local sendList = {}
function VanasKoSSynchronizer:GetListToShare(listName, key)
	local list = VanasKoS:GetList(listName)
	if (not list) then
		return
	end

	wipe(sendList)
	if (not key) then
		for k, v in pairs(list) do
			if (not v.owner or v.owner == "") then
				sendList[k] = {
					name = v.name,
					reason = v.reason,
					creator = v.creator
				}
			end
		end
	else
		if (list[key]) then
			sendList[key] = {
				name = list[key].name,
				reason = list[key].reason,
				creator = list[key].creator
			}
		end
	end

	return sendList
end

local guildSyncTimer = nil

function VanasKoSSynchronizer:StartGuildSync(sendNow)
	if (startupGuildTimer ~= nil) then
		startupGuildTimer = nil
	end
	if(sendNow == true) then
		self:SendListsToGuild()
	end
	guildSyncTimer = self:ScheduleRepeatingTimer("SendListsToGuild", self.db.profile.GuildSharingInterval * 60)
end

function VanasKoSSynchronizer:StopGuildSync()
	if (startupGuildTimer ~= nil) then
		self:CancelTimer(startupGuildTimer)
		startupGuildTimer = nil
	end

	if (guildSyncTimer ~= nil) then
		self:CancelTimer(guildSyncTimer)
		guildSyncTimer = nil
	end
end

local requestSyncTimer = nil
function VanasKoSSynchronizer:StartRequestSync()
	if (startupRequestTimer ~= nil) then
		startupRequestTimer = nil
	end
	requestSyncTimer = self:ScheduleRepeatingTimer("RequestNextLists", 90)
end

function VanasKoSSynchronizer:StopRequestSync()
	if (startupRequestTimer ~= nil) then
		self:CancelTimer(startupRequestTimer)
		startupRequestTimer = nil
	end

	if (requestSyncTimer ~= nil) then
		self:CancelTimer(requestSyncTimer)
		requestSyncTimer = nil
	end
end

function VanasKoSSynchronizer:RegisterCommunicationChannels()
	self:RegisterComm("VanasKoS")
end

local sharedLists = {}
local sharedListQueue = {}
function VanasKoSSynchronizer:OnCommReceived(prefix, text, distribution, sender)
	local result, vanasKoSVersion, protocolVersion, command, data = DeserializeString(text)
	if(not result) then
		-- TODO: Log
		if(VANASKOS.DEBUG == 1) then
			VanasKoS:Print(format("Sync: Invalid comm from %s: %s", sender, vanasKoSVersion))
		end
		return
	end

	if(VANASKOS.DEBUG == 1) then
		VanasKoS:Print(format("Sync: CommReceived from %s ver:%s pv:%s cmd:%s",
			sender, vanasKoSVersion, protocolVersion, command))
	end

	-- Ignore messages from self
	if(not sender or sender == UnitName("player")) then
		return
	end

	if(VanasKoS:IsVersionNewer(vanasKoSVersion)) then
		if(not VANASKOS.NewVersionNotice) then
			VanasKoS:Print("A newer version of VanasKoS is available. Please upgrade!")
			VANASKOS.NewVersionNotice = true
		end
	end

	local senderKey = sender
	if(command == SHARE_LIST) then
		if (distribution == "GUILD") then
			self:ProcessList(sender, data.owner, data.listName, data.list)
		elseif (distribution == "WHISPER") then
			if (requestedLists[data.listName] == nil) then
				if(VANASKOS.DEBUG == 1) then
					VanasKoS:Print(format("Invalid list data received from %s", sender))
				end
				return
			end
			if (requestedLists[data.listName][senderKey]) then
				if(VANASKOS.DEBUG == 1) then
					VanasKoS:Print(format("Processing requested results from %s", sender))
				end
				self:ProcessList(sender, data.owner, data.listName, data.list)
				requestedLists[data.listName][senderKey] = nil
				self.db.factionrealm.synchronizer.share[senderKey].lastsync = time()
			else
				if(VANASKOS.DEBUG == 1) then
					VanasKoS:Print(format("Unsolicited %s list from %s", data.listName, sender))
				end
				if (sharedLists[sender] == nil) then
					sharedLists[senderKey] = {list = {}}
				end
				sharedLists[senderKey].ownerName = data.ownerName
				sharedLists[senderKey].list[data.listName] = data.list
				local count = 0
				for _ in pairs(data.list) do
					count = count + 1
				end
				if(not Dialog:ActiveDialog("VanasKoSQuestionAdd")) then
					Dialog:Spawn("VanasKoSQuestionAdd", {
						prompt = format(L["Accept %d entries for list %s from %s?"], count, VanasKoSGUI:GetListName(data.listName), sender),
						sender = sender,
						listName = data.listName,
					})
				else
					tinsert(sharedListQueue, {
						sender = sender,
						count = count,
						listName = data.listName
					})
				end
			end
		elseif (distribution == "PARTY") then
				if(VANASKOS.DEBUG == 1) then
					VanasKoS:Print(format("Unsolicited %s list from %s in party", data.listName, sender))
				end
			if (sharedLists[senderKey] == nil) then
				sharedLists[senderKey] = {list = {}}
			end
			sharedLists[senderKey].ownerName = data.owner
			sharedLists[senderKey].list[data.listName] = data.list
			local count = 0
			for _ in pairs(data.list) do
				count = count + 1
			end
			if(not Dialog:ActiveDialog("VanasKoSQuestionAdd")) then
				Dialog:Spawn("VanasKoSQuestionAdd", {
					prompt = format(L["Accept %d entries for list %s from %s?"],
						count, VanasKoSGUI:GetListName(data.listName), sender),
					sender = sender,
					listName = data.listName,
				})
			else
				tinsert(sharedListQueue, {
					sender = sender,
					count = count,
					listName = data.listName
				})
			end
		end
	elseif(command == REQUEST_LIST) then
		if (self.db.profile.SharePolicy == POLICY_ACCEPT_ALL
			or (self.db.profile.SharePolicy == POLICY_ACCEPT and not self.db.factionrealm.synchronizer.reject[sender])
			or (self.db.profile.SharePolicy == POLICY_REJECT and self.db.factionrealm.synchronizer.accept[sender])) then
			if(VANASKOS.DEBUG == 1) then
				VanasKoS:Print(format("Granting request from %s for %s", sender, data.listName))
			end
			self:SendListToPlayer(sender, data.listName)
		else
			if(VANASKOS.DEBUG == 1) then
				VanasKoS:Print(format("Denying request from %s for %s", sender, data.listName))
			end
			self:DenyRequest(sender, data.listName)
		end
	elseif(command == DENY_REQUEST) then
		requestedLists[data.listName][sender] = nil
		if(VANASKOS.DEBUG == 1) then
			VanasKoS:Print("List request denied")
		end
	end
end

function VanasKoSSynchronizer:ProcessList(senderName, ownerName, listName, receivedList)
	local synctime = time()
	if(VANASKOS.DEBUG == 1) then
		VanasKoS:Print(format("Processing list %s from %s (%s)", listName, senderName, ownerName))
	end
	local destList = VanasKoS:GetList(listName)
	if(destList == nil) then
		if(VANASKOS.DEBUG == 1) then
			VanasKoS:Print(format("Invalid list (%s)", listName))
		end
		return
	end

	-- create and update all entries on the list
	for k,v in pairs(receivedList) do
		if(VANASKOS.DEBUG == 1) then
			VanasKoS:Print("    Received " .. v.name)
		end
		if(destList[k] ~= nil and
			(destList[k].ownerName == nil or destList[k].ownerName == "")) then
			-- I already created the kos entry, don't touch it
			if(VANASKOS.DEBUG == 1) then
				VanasKoS:Print("      " .. v.name .. " already on list")
			end
		else
			if(VANASKOS.DEBUG == 1) then
				VanasKoS:Print("      not on my list")
			end
			if(v.ownerName == nil or v.ownerName == "") then
				v.ownerName = senderName
			end
			if(v.creator == nil or v.creator == "") then
				v.creatorname = senderName
			end

			if(destList[k]) then
				if(VANASKOS.DEBUG == 1) then
					VanasKoS:Print("      	Updating")
				end
				destList[k].name = v.name
				destList[k].reason = v.reason
				destList[k].senderName = senderName
				destList[k].creatorname = v.creatorname
				destList[k].ownerName = ownerName
				destList[k].lastupdated = synctime
			else
				if(VANASKOS.DEBUG == 1) then
					VanasKoS:Print("      	Adding")
				end
				destList[k] = {
					name = v.name,
					reason = v.reason,
					senderName = senderName,
					creatorname = v.creatorname,
					ownerName = ownerName,
					lastupdated = synctime
				}
			end
			if(destList[k].created == nil) then
				destList[k].created = synctime
			end
		end
	end

	-- delete old entries from this owner that werent just synced
	for k, v in pairs(destList) do
		if(v.ownerName == ownerName and v.lastupdated ~= synctime) then
			if(VANASKOS.DEBUG == 1) then
				VanasKoS:Print("    Removing old entry")
			end
			destList[k] = nil
		end
	end

	VanasKoSGUI:Update()
end

function VanasKoSSynchronizer:ProcessQueuedPlayerList(senderName, listName)
	local senderKey = senderName
	if (sharedLists[senderKey] == nil) then
		return
	end

	if (sharedLists[senderKey].list[listName] == nil) then
		return
	end

	local ownerName = sharedLists[senderKey].ownerName
	self:ProcessList(senderName, senderKey, ownerName, listName, sharedLists[senderKey].list[listName])
end

function VanasKoSSynchronizer:ClearQueuedPlayerList(senderName, listName)
	local senderKey = senderName
	if (sharedLists[senderKey] == nil) then
		return
	end

	sharedLists[senderKey].list[listName] = nil
	if (next(sharedLists[senderKey].list) == nil) then
		sharedLists[senderKey] = nil
	end

	if(#sharedListQueue > 0) then
		local senderName = sharedListQueue[1].senderName
		local listName = sharedListQueue[1].listName
		local count = sharedListQueue[1].count
		tremove(sharedListQueue, 1)
		Dialog:Spawn("VanasKoSQuestionAdd", {
			prompt = format(L["Accept %d entries for list %s from %s?"],
				count, VanasKoSGUI:GetListName(listName), senderName),
			senderName = senderName,
			listName = listName,
		})
	end
end

function VanasKoSSynchronizer:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
	if(key and value and list == "PLAYERSYNC") then
		local displayname = value.name
		buttonText1:SetText(displayname)
		if(not value.lastsync) then
			buttonText2:SetText(L["never synced"])
		else
			local timespan = SecondsToTime(time() - value.lastsync)
			if(timespan == "") then
				buttonText2:SetText(L["0 Secs ago"])
			else
				buttonText2:SetText(format(L["%s ago"], timespan))
			end
		end
	elseif (key and (list == "ACCEPTSYNC" or list == "REJECTSYNC")) then
		local displayname = value.name
		buttonText1:SetText(displayname)
	end
	button:Show()
end

function VanasKoSSynchronizer:SetupColumns(list)
	if(list == "PLAYERSYNC") then
		VanasKoSGUI:SetNumColumns(2)
		VanasKoSGUI:SetColumnWidth(1, 103)
		VanasKoSGUI:SetColumnName(1, NAME)
		VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse)
		VanasKoSGUI:SetColumnType(1, "normal")
		VanasKoSGUI:SetColumnWidth(2, 200)
		VanasKoSGUI:SetColumnName(2, L["Last Sync"])
		VanasKoSGUI:SetColumnSort(2, SortByLastSync, SortByLastSyncReverse)
		VanasKoSGUI:SetColumnType(2, "normal")
		VanasKoSGUI:HideToggleButtons()
	elseif(list == "ACCEPTSYNC" or list == "REJECTSYNC") then
		VanasKoSGUI:SetNumColumns(1)
		VanasKoSGUI:SetColumnWidth(1, 303)
		VanasKoSGUI:SetColumnName(1, NAME)
		VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse)
		VanasKoSGUI:SetColumnType(1, "normal")
		VanasKoSGUI:HideToggleButtons()
	end
end

function VanasKoSSynchronizer:ShowList(list)
	if (list == "PLAYERSYNC" or list == "ACCEPTSYNC" or list == "REJECTSYNC") then
		VanasKoSGUI.listFrame.changeButton:Disable()
		VanasKoSGUI.listFrame.addButton:Enable()
		VanasKoSGUI.listFrame.removeButton:Enable()
	end
end

function VanasKoSSynchronizer:HideList(list)
	if (list == "PLAYERSYNC" or list == "ACCEPTSYNC" or list == "REJECTSYNC") then
		VanasKoSGUI.listFrame.changeButton:Enable()
	end
end

function VanasKoSSynchronizer:IsOnList(list, key)
	local listVar = VanasKoS:GetList(list)
	if(listVar and listVar[key]) then
		return listVar[key]
	end
	return nil
end

function VanasKoSSynchronizer:GetList(list)
	if (list == "PLAYERSYNC") then
		return self.db.factionrealm.synchronizer.share
	elseif (list == "ACCEPTSYNC") then
		return self.db.factionrealm.synchronizer.accept
	elseif (list == "REJECTSYNC") then
		return self.db.factionrealm.synchronizer.reject
	end
	return nil
end

function VanasKoSSynchronizer:AddEntry(list, key, data)
	if (list == "PLAYERSYNC") then
		if (self.db.factionrealm.synchronizer.share[key] == nil) then
			self.db.factionrealm.synchronizer.share[key] = {}
		end
	elseif (list == "ACCEPTSYNC") then
		self.db.factionrealm.synchronizer.accept[key] = true
	elseif (list == "REJECTSYNC") then
		self.db.factionrealm.synchronizer.reject[key] = true
	end
	self:SendMessage("VanasKoS_List_Entry_Added", list, key, data)
end

function VanasKoSSynchronizer:RemoveEntry(listname, key)
	local list = VanasKoS:GetList(listname)
	if (list and list[key]) then
		list[key] = nil
		self:SendMessage("VanasKoS_List_Entry_Removed", listname, key)
	end
end

-- hide offline player spam
function VanasKoSSynchronizer:ChatFrame_MessageEventHandler(frame, event, msg, ...)
	if(LastWhispered and event == "CHAT_MSG_SYSTEM") then
		local match = strmatch(msg, format(ERR_CHAT_PLAYER_NOT_FOUND_S, LastWhispered))

		if (not match) then
			self.hooks.ChatFrame_MessageEventHandler(frame, event, msg, ...)
		end
	else
		self.hooks.ChatFrame_MessageEventHandler(frame, event, msg, ...)
	end
end
