local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Synchronizer", "enUS", true);
if L then
	L["Sharing"] = true;
	L["Sharing - Guild"] = true;
	L["Sharing - Group"] = true;

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

local module = VanasKoSSynchronizer;
local core = VanasKoS;

local function RegisterConfiguration()
	VanasKoSGUI:AddConfigOption("Synchronizer-Common", {
		type = 'group',
		name = L["Sharing"],
		desc = L["Options to share your lists with other people"],
		args = {
			enabled = {
				type = "toggle",
				name = L["Enabled"],
				desc = L["Enables/Disables the sharing module"],
				order = 1,
				set = function(frame, v) VanasKoS:ToggleModuleActive("Synchronizer"); end,
				get = function() return VanasKoSSynchronizer.enabledState end,
			},
			listoptionsheader = {
				type = "header",
				name = L["Accept/Ignore-Lists"],
				desc = L["Lists in which you can put people from whom you want or do not want to receive data"],
				order = 2,
			}
		},
	});
	
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
				set = function(frame, v) VanasKoSSynchronizer.db.profile.GuildSharing = v; SendToGuild(); end,
				get = function() return VanasKoSSynchronizer.db.profile.GuildSharing; end,
			}
		},
	});
	
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
	});
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
			GuildSharing = false,
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
end

function module:OnDisable()
end

function module:GetShareGroupTable()
	local tbl = { };
	for k, v in pairs(module.db.realm.synchronizer.ShareChannels) do
		tbl[k] = k;
	end
	
	return tbl;
end

local function SendToGuild()
end
