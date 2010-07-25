VanasKoSDefaultLists = VanasKoS:NewModule("DefaultLists", "AceEvent-3.0");

local VanasKoSDefaultLists = VanasKoSDefaultLists;
local VanasKoS = VanasKoS;
local VanasKoSGUI = VanasKoSGUI;

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/DefaultLists", false);

-- Global wow strings
local NAME, GUILD, LEVEL_ABBR, CLASS, ZONE = NAME, GUILD, LEVEL_ABBR, CLASS, ZONE

-- sort functions

-- sorts by index
local function SortByIndex(val1, val2)
	return val1 < val2;
end
local function SortByIndexReverse(val1, val2)
	return val1 > val2
end

-- sorts from a-z
local function SortByReason(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].reason or L["_Reason Unknown_"];
	local str2 = list[val2].reason or L["_Reason Unknown_"];
	return (str1:lower() < str2:lower());
end
local function SortByReasonReverse(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].reason or L["_Reason Unknown_"];
	local str2 = list[val2].reason or L["_Reason Unknown_"];
	return (str1:lower() > str2:lower());
end

local function SortByCreateDate(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local cmp1 = list[val1].created or 2^30;
	local cmp2 = list[val2].created or 2^30;
	return (cmp1 > cmp2);
end
local function SortByCreateDateReverse(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local cmp1 = list[val1].created or 2^30;
	local cmp2 = list[val2].created or 2^30;
	return (cmp1 < cmp2);
end

-- sorts from a-z
local function SortByCreator(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].creator or "";
	local str2 = list[val2].creator or "";
	return (str1:lower() < str2:lower());
end
local function SortByCreatorReverse(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].creator or "";
	local str2 = list[val2].creator or "";
	return (str1:lower() > str2:lower());
end

-- sorts from a-z
local function SortByOwner(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].owner or "";
	local str2 = list[val2].owner or "";
	return (str1:lower() < str2:lower());
end
local function SortByOwner(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].owner or "";
	local str2 = list[val2].owner or "";
	return (str1:lower() > str2:lower());
end

-- sorts from lowest to highest level
local function SortByLevel(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list) then
		local lvl1 = list[val1] and (string.gsub(list[val1].level, "+", ".5"));
		local lvl2 = list[val2] and (string.gsub(list[val2].level, "+", ".5"));
		return ((tonumber(lvl1) or 0) < (tonumber(lvl2) or 0));
	end
	return false;
end
local function SortByLevelReverse(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list) then
		local lvl1 = list[val1] and (string.gsub(list[val1].level, "+", ".5"));
		local lvl2 = list[val2] and (string.gsub(list[val2].level, "+", ".5"));
		return ((tonumber(lvl1) or 0) > (tonumber(lvl2) or 0));
	end
	return false;
end

-- sorts from early to later
local function SortByLastSeen(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list) then
		local now = time();
		local cmp1 = list[val1] and list[val1].lastseen and (now - list[val1].lastseen) or 2^30;
		local cmp2 = list[val2] and list[val2].lastseen and (now - list[val2].lastseen) or 2^30;
		return (cmp1 < cmp2);
	end
	return false;
end
local function SortByLastSeenReverse(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list) then
		local now = time();
		local cmp1 = list[val1] and list[val1].lastseen and (now - list[val1].lastseen) or 2^30;
		local cmp2 = list[val2] and list[val2].lastseen and (now - list[val2].lastseen) or 2^30;
		return (cmp1 > cmp2);
	end
	return false;
end

-- sorts from a-z
local function SortByClass(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list) then
		local str1 = list[val1] and list[val1].class or "";
		local str2 = list[val2] and list[val2].class or "";
		return (str1:lower() < str2:lower());
	end
	return false;
end
local function SortByClassReverse(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list) then
		local str1 = list[val1] and list[val1].class or "";
		local str2 = list[val2] and list[val2].class or "";
		return (str1:lower() > str2:lower());
	end
	return false;
end

-- sorts from a-z
local function SortByGuild(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list) then
		local str1 = list[val1] and list[val1].guild or "";
		local str2 = list[val2] and list[val2].guild or "";
		return (str1:lower() < str2:lower());
	end
	return false;
end
local function SortByGuildReverse(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list) then
		local str1 = list[val1] and list[val1].guild or "";
		local str2 = list[val2] and list[val2].guild or "";
		return (str1:lower() > str2:lower());
	end
	return false;
end

-- sorts from a-z
local function SortByZone(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list) then
		local str1 = list[val1] and list[val1].zone or "";
		local str2 = list[val2] and list[val2].zone or "";
		return (str1:lower() < str2:lower());
	end
	return false;
end
local function SortByZoneReverse(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list) then
		local str1 = list[val1] and list[val1].zone or "";
		local str2 = list[val2] and list[val2].zone or "";
		return (str1:lower() > str2:lower());
	end
	return false;
end


function VanasKoSDefaultLists:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("DefaultLists", 
					{
						factionrealm = {
							koslist = {
								players = {
								},
								guilds = {
								}
							},
							hatelist = {
								players = {
								},
							},
							nicelist = {
								players = {
								},
							},
						},
						profile = {
							ShowOnlyMyEntries = false
						}
					});
	
	-- register lists this modules provides at the core
	VanasKoS:RegisterList(1, "PLAYERKOS", L["Player KoS"], self);
	VanasKoS:RegisterList(2, "GUILDKOS", L["Guild KoS"], self);
	VanasKoS:RegisterList(3, "HATELIST", L["Hatelist"], self);
	VanasKoS:RegisterList(4, "NICELIST", L["Nicelist"], self);

	-- register lists this modules provides in the GUI
	VanasKoSGUI:RegisterList("PLAYERKOS", self);
	VanasKoSGUI:RegisterList("GUILDKOS", self);
	VanasKoSGUI:RegisterList("HATELIST", self);
	VanasKoSGUI:RegisterList("NICELIST", self);

	-- register sort options for the lists this module provides
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "byname", L["by name"], L["sort by name"], SortByIndex, SortByIndexReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "bycreatedate", L["by create date"], L["sort by date created"], SortByCreateDate, SortByCreateDateReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "bycreator", L["by creator"], L["sort by creator"], SortByCreator, SortByCreatorReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "byreason", L["by reason"], L["sort by reason"], SortByReason, SortByReasonReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "byowner", L["by owner"], L["sort by owner"], SortByOwner, SortByOwnerReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST"}, "byguild", L["by guild"], L["sort by guild"], SortByGuild, SortByGuildReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST"}, "bylevel", L["by level"], L["sort by level"], SortByLevel, SortByLevelReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST"}, "byclass", L["by class"], L["sort by class"], SortByClass, SortByClassReverse)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST"}, "bylastseen", L["by last seen"], L["sort by last seen"], SortByLastSeen, SortByLastSeenReverse)

	VanasKoSGUI:SetDefaultSortFunction({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, SortByIndex);

	-- first sort function is sorting by name
	VanasKoSGUI:SetSortFunction(SortByIndex);

	-- show the PLAYERKOS list after startup
	VanasKoSGUI:ShowList("PLAYERKOS");

	VanasKoSListFrameCheckBox:SetText(L["Only my entries"]);
	VanasKoSListFrameCheckBox:SetChecked(VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries);
	VanasKoSListFrameCheckBox:SetScript("OnClick", function(frame)
			VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries = not VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries;
			VanasKoSGUI:UpdateShownList();
		end);
end

function VanasKoSDefaultLists:OnEnable()
	if(self.db.realm and (self.db.realm.nicelist or self.db.realm.hatelist or self.db.realm.koslist)) then
		VanasKoS:Print(L["Old list entries detected. You should import old data by going to importer under VanasKoS configuration"]);
	end
end

function VanasKoSDefaultLists:OnDisable()
end

function VanasKoSDefaultLists:ShowList()
	VanasKoSListFrameCheckBox:Show();
end

function VanasKoSDefaultLists:HideList()
	VanasKoSListFrameCheckBox:Hide();
end

function VanasKoSDefaultLists:HoverType()
	local list = VANASKOS.showList;
	if (list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST") then
		return "player";
	elseif (list == "GUILDKOS") then
		return "guild";
	end
end

-- FilterFunction as called by VanasKoSGUI - key is the index from the table entry that gets displayed, value the data associated with the index. searchBoxText the text entered in the searchBox
-- returns true if the entry should be shown, false otherwise
function VanasKoSDefaultLists:FilterFunction(key, value, searchBoxText)
	if(VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries and value.owner ~= nil) then
		return false;
	end
	if(searchBoxText == "") then
		return true;
	end

	if(key:find(searchBoxText) ~= nil) then
		return true;
	end

	if(value.reason and (value.reason:lower():find(searchBoxText) ~= nil)) then
		return true;
	end

	if(value.owner and (value.owner:lower():find(searchBoxText) ~= nil)) then
		return true;
	end

	return false;
end


function VanasKoSDefaultLists:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
	if(key and value and (list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST")) then
		local data = VanasKoS:GetPlayerData(key);
		-- name, guildrank, guild, level, race, class, gender, zone, lastseen
		local owner = "";
		if(value.owner ~= nil and value.owner ~= "") then
			owner = string.Capitalize(value.owner);
		end
		local displayname = string.Capitalize(key);
		if(value.wanted == true) then
			displayname = "|cffff0000" .. displayname .. "|r";
		end
		buttonText1:SetText(displayname);
		if(not self.group or self.group == 1) then
			buttonText2:SetText(value and value.reason or L["_Reason Unknown_"]);
		elseif(self.group == 2) then
			buttonText2:SetText(data and data.guild or "");
			buttonText3:SetText(data and data.level or "");
			buttonText4:SetText(data and data.class or "");
			if (data and data.classEnglish) then
				local classColor = RAID_CLASS_COLORS[data.classEnglish] or NORMAL_FONT_COLOR;
				buttonText4:SetTextColor(classColor.r, classColor.g, classColor.b);
			end
		else
			if(data and data.lastseen) then
				local timespan = SecondsToTime(time() - data.lastseen);
				if(timespan == "") then
					timespan = L["0 Secs"];
				end
				buttonText2:SetText(timespan);
			else
				buttonText2:SetText(format(L["never seen"], timespan));
			end
			if (data and data.zone) then
				buttonText3:SetText(data.zone);
			else
				buttonText3:SetText("");
			end
		end
	elseif(list == "GUILDKOS") then
		local guildname = VanasKoS:GetGuildData(key);
		buttonText1:SetText(guildname or string.Capitalize(key));
		buttonText2:SetText(value and value.reason or L["_Reason Unknown_"]);
		buttonText3:SetText("");
		buttonText4:SetText(value.owner and string.Capitalize(value.owner) or "");
	end

	button:Show();
end

function VanasKoSDefaultLists:SetupColumns(list)
	if(list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST") then
		if(not self.group or self.group == 1) then
			VanasKoSGUI:SetNumColumns(2);
			VanasKoSGUI:SetColumnWidth(1, 83);
			VanasKoSGUI:SetColumnWidth(2, 220);
			VanasKoSGUI:SetColumnName(1, NAME);
			VanasKoSGUI:SetColumnName(2, L["Reason"]);
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse);
			VanasKoSGUI:SetColumnSort(2, SortByReason, SortByReasonReverse);
			VanasKoSGUI:SetColumnType(1, "normal");
			VanasKoSGUI:SetColumnType(2, "highlight");
			VanasKoSGUI:SetToggleButtonText(L["Reason"]);
		elseif(self.group == 2) then
			VanasKoSGUI:SetNumColumns(4);
			VanasKoSGUI:SetColumnWidth(1, 83);
			VanasKoSGUI:SetColumnWidth(2, 100);
			VanasKoSGUI:SetColumnWidth(3, 32);
			VanasKoSGUI:SetColumnWidth(4, 92);
			VanasKoSGUI:SetColumnName(1, NAME);
			VanasKoSGUI:SetColumnName(2, GUILD);
			VanasKoSGUI:SetColumnName(3, LEVEL_ABBR);
			VanasKoSGUI:SetColumnName(4, CLASS);
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse);
			VanasKoSGUI:SetColumnSort(2, SortByGuild, SortByGuildReverse);
			VanasKoSGUI:SetColumnSort(3, SortByLevel, SortByLevelReverse);
			VanasKoSGUI:SetColumnSort(4, SortByClass, SortByClassReverse);
			VanasKoSGUI:SetColumnType(1, "normal");
			VanasKoSGUI:SetColumnType(2, "highlight");
			VanasKoSGUI:SetColumnType(3, "number");
			VanasKoSGUI:SetColumnType(4, "highlight");
			VanasKoSGUI:SetToggleButtonText(L["Player Info"]);
		else
			VanasKoSGUI:SetNumColumns(3);
			VanasKoSGUI:SetColumnWidth(1, 83);
			VanasKoSGUI:SetColumnWidth(2, 110);
			VanasKoSGUI:SetColumnWidth(3, 110);
			VanasKoSGUI:SetColumnName(1, NAME);
			VanasKoSGUI:SetColumnName(2, L["Last Seen"]);
			VanasKoSGUI:SetColumnName(3, ZONE);
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse);
			VanasKoSGUI:SetColumnSort(2, SortByLastSeen, SortByLastSeenReverse);
			VanasKoSGUI:SetColumnSort(3, SortByZone, SortByZoneReverse);
			VanasKoSGUI:SetColumnType(1, "normal");
			VanasKoSGUI:SetColumnType(2, "highlight");
			VanasKoSGUI:SetColumnType(3, "highlight");
			VanasKoSGUI:SetToggleButtonText(L["Last Seen"]);
		end
		VanasKoSGUI:ShowToggleButtons();
	elseif(list == "GUILDKOS") then
		VanasKoSGUI:SetNumColumns(2);
		VanasKoSGUI:SetColumnWidth(1, 105);
		VanasKoSGUI:SetColumnWidth(2, 208);
		VanasKoSGUI:SetColumnName(1, GUILD);
		VanasKoSGUI:SetColumnName(2, L["Reason"]);
		VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse);
		VanasKoSGUI:SetColumnSort(2, SortByReason, SortByReasonReverse);
		VanasKoSGUI:SetColumnType(1, "normal");
		VanasKoSGUI:SetColumnType(2, "highlight");
		VanasKoSGUI:HideToggleButtons();
	end
end

function VanasKoSDefaultLists:ToggleLeftButtonOnClick(button, frame)
	local list = VANASKOS.showList;
	if(list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST") then
		if (not self.group or self.group < 3) then
			self.group = (self.group or 1) + 1;
		else
			self.group = 1
		end
	elseif(list == "GUILDKOS") then
		self.group = 1;
	end
	self:SetupColumns(list);
	VanasKoSGUI:ScrollFrameUpdate()
end

function VanasKoSDefaultLists:ToggleRightButtonOnClick(button, frame)
	local list = VANASKOS.showList;
	if(list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST") then
		if (not self.group or self.group > 1) then
			self.group = (self.group or 4) - 1;
		else
			self.group = 3
		end
	elseif(list == "GUILDKOS") then
		self.group = 1;
	end
	self:SetupColumns(list);
	VanasKoSGUI:ScrollFrameUpdate()
end

function VanasKoSDefaultLists:IsOnList(list, name)
	local listVar = VanasKoS:GetList(list);
	if(listVar and listVar[name]) then
		return listVar[name];
	else
		return nil;
	end
end

-- don't call this directly, call it via VanasKoS:AddEntry - it expects name to be lower case!
function VanasKoSDefaultLists:AddEntry(list, name, data)
	if(list == "PLAYERKOS") then
		self.db.factionrealm.koslist.players[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player") };
	elseif(list == "GUILDKOS") then
		self.db.factionrealm.koslist.guilds[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player") };
	elseif(list == "HATELIST") then
		if(VanasKoS:IsOnList("NICELIST", name)) then
			self:Print(format(L["Entry %s is already on Nicelist"], name));
			return;
		end
		self.db.factionrealm.hatelist.players[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player")  };
	elseif(list == "NICELIST") then
		if(VanasKoS:IsOnList("HATELIST", name)) then
			self:Print(format(L["Entry %s is already on Hatelist"], name));
			return;
		end
		self.db.factionrealm.nicelist.players[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player")  };
	end

	self:SendMessage("VanasKoS_List_Entry_Added", list, name, data);
end

function VanasKoSDefaultLists:RemoveEntry(listname, name)
	local list = VanasKoS:GetList(listname);
	if(list and list[name]) then
		list[name] = nil;
		self:SendMessage("VanasKoS_List_Entry_Removed", listname, name);
	end
end

function VanasKoSDefaultLists:GetList(list)
	if(list == "PLAYERKOS") then
		return self.db.factionrealm.koslist.players;
	elseif(list == "GUILDKOS") then
		return self.db.factionrealm.koslist.guilds;
	elseif(list == "HATELIST") then
		return self.db.factionrealm.hatelist.players;
	elseif(list == "NICELIST") then
		return self.db.factionrealm.nicelist.players;
	else
		return nil;
	end
end

local entry, value;

local function ListButtonOnRightClickMenu()
	local x, y = GetCursorPosition();
	local uiScale = UIParent:GetEffectiveScale();
	local menuItems = {
		{
			text = string.Capitalize(entry),
			isTitle = true,
		},
		{
			text = L["Move to Player KoS"],
			func = function()
						VanasKoS:RemoveEntry(VANASKOS.showList, entry);
						VanasKoS:AddEntry("PLAYERKOS", entry, value);
					end,
		},
		{
			text = L["Move to Hatelist"],
			func = function()
						VanasKoS:RemoveEntry(VANASKOS.showList, entry);
						VanasKoS:AddEntry("HATELIST", entry, value);
					end
		},
		{
			text = L["Move to Nicelist"],
			func = function()
						VanasKoS:RemoveEntry(VANASKOS.showList, entry);
						VanasKoS:AddEntry("NICELIST", entry, value);
					end
		},
		{
			text = L["Remove Entry"],
			func = function()
				VanasKoS:RemoveEntry(VANASKOS.showList, entry);
			end
		}
	};

	if(VANASKOS.showList == "PLAYERKOS"and VanasKoS:ModuleEnabled("DistributedTracker")) then
		tinsert(menuItems, {
			text = L["Wanted"],
			func = function()
					local list = VanasKoS:GetList("PLAYERKOS");
					if (not list[entry].wanted) then
						list[entry].wanted = true;
					else
						list[entry].wanted = nil;
					end
					VanasKoSGUI:Update();
				end,
			checked = function() return value.wanted; end,
		});
	end

	EasyMenu(menuItems, VanasKoSGUI.dropDownFrame, UIParent, x/uiScale, y/uiScale, "MENU");
end

function VanasKoSDefaultLists:ListButtonOnClick(button, frame)
	local id = frame:GetID();
	entry, value = VanasKoSGUI:GetListEntryForID(id);
	if(id == nil or entry == nil) then
		return;
	end
	if(button == "LeftButton") then
		if(IsShiftKeyDown()) then
			local name;

			if(not value) then
				return;
			end

			name = string.Capitalize(entry);

			local str = nil;
			if(value.owner) then
				str = format(L["[%s] %s (%s) - Reason: %s"], value.owner, name, VanasKoSGUI:GetListName(VANASKOS.showList), value.reason);
			else
				str = format(L["%s (%s) - Reason: %s"], name, VanasKoSGUI:GetListName(VANASKOS.showList), value.reason);
			end
			if(DEFAULT_CHAT_FRAME.editBox and str) then
				if(DEFAULT_CHAT_FRAME.editBox:IsVisible()) then
					DEFAULT_CHAT_FRAME.editBox:SetText(DEFAULT_CHAT_FRAME.editBox:GetText() .. str .. " ");
				end
			end
		end
		return;
	end

	ListButtonOnRightClickMenu();
end
