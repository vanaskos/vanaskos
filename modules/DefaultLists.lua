VanasKoSDefaultLists = VanasKoS:NewModule("DefaultLists", "AceEvent-3.0");

local VanasKoSDefaultLists = VanasKoSDefaultLists;
local VanasKoS = VanasKoS;
local VanasKoSGUI = VanasKoSGUI;

local tooltip = nil;

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_DefaultLists", false);

-- sort functions

-- sorts by index
local SortByName = nil;

-- sorts from highest to lowest level
local function SortByLevel(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list ~= nil) then
		local cmp1 = 0;
		local cmp2 = 0;
		if(list[val1] ~= nil and list[val1].level ~= nil) then
			cmp1 = list[val1].level;
		end
		if(list[val2] ~= nil and list[val2].level ~= nil) then
			cmp2 = list[val2].level;
		end
		if(cmp1 > cmp2) then
			return true;
		else
			return false;
		end
	end
end

-- sorts from early to later
local function SortByLastSeen(val1, val2)
	local list = VanasKoS:GetList("PLAYERDATA");
	if(list ~= nil) then
		local cmp1 = 2^30;
		local cmp2 = 2^30;
		if(list[val1] ~= nil and list[val1].lastseen ~= nil) then
			cmp1 = time() - list[val1].lastseen;
		end
		if(list[val2] ~= nil and list[val2].lastseen ~= nil) then
			cmp2 = time() - list[val2].lastseen;
		end

		if(cmp1 < cmp2) then
			return true;
		else
			return false;
		end
	end
end

-- sorts from a-Z
local function SortByReason(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].reason;
	local str2 = list[val2].reason;
	if(str1 == nil or str1 == "") then
		str1 = L["_Reason Unknown_"];
	end
	if(str2 == nil or str2 == "") then
		str2 = L["_Reason Unknown_"];
	end
	if(str1:lower() < str2:lower()) then
		return true;
	else
		return false;
	end
end

-- sorts from a-Z
local function SortByCreateDate(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	if(list ~= nil) then
		local cmp1 = 2^30;
		local cmp2 = 2^30;
		if(list[val1] ~= nil and list[val1].created ~= nil) then
			cmp1 = list[val1].created;
		end
		if(list[val2] ~= nil and list[val2].created ~= nil) then
			cmp2 = list[val2].created;
		end

		if(cmp1 > cmp2) then
			return true;
		else
			return false;
		end
	end
end

-- sorts from a-Z
local function SortByCreator(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].creator;
	local str2 = list[val2].creator;
	if(str1 == nil or str1 == "") then
		str1 = "";
	end
	if(str2 == nil or str2 == "") then
		str2 = "";
	end
	if(str1:lower() < str2:lower()) then
		return true;
	else
		return false;
	end
end

-- sorts from a-Z
local function SortByOwner(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	local str1 = list[val1].owner;
	local str2 = list[val2].owner;
	if(str1 == nil or str1 == "") then
		str1 = "";
	end
	if(str2 == nil or str2 == "") then
		str2 = "";
	end
	if(str1:lower() < str2:lower()) then
		return true;
	else
		return false;
	end
end


function VanasKoSDefaultLists:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("DefaultLists", 
					{
						realm = {
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

	-- import of old data, will be removed in some version in the future
--[[	if(VanasKoS.db.realm.koslist) then
		self.db.realm.koslist = VanasKoS.db.realm.koslist;
		VanasKoS.db.realm.koslist = nil;
	end
	if(VanasKoS.db.realm.hatelist) then
		self.db.realm.hatelist = VanasKoS.db.realm.hatelist;
		VanasKoS.db.realm.hatelist = nil;
	end
	if(VanasKoS.db.realm.nicelist) then
		self.db.realm.nicelist = VanasKoS.db.realm.nicelist;
		VanasKoS.db.realm.nicelist = nil;
	end ]]

	if(VanasKoSDB.namespaces.DefaultLists.realms) then
		for k,v in pairs(VanasKoSDB.namespaces.DefaultLists.realms) do
			if(string.find(k, GetRealmName()) ~= nil) then
				if(v.koslist) then
					self.db.realm.koslist = v.koslist;
					v.koslist = nil;
				end
				if(v.hatelist) then
					self.db.realm.hatelist = v.hatelist;
					v.hatelist = nil;
				end
				if(v.nicelist) then
					self.db.realm.nicelist = v.nicelist;
					v.nicelist = nil;
				end
			end
		end
	end
	
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
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST", "LASTSEEN"}, "byname", L["by name"], L["sort by name"], SortByName)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST" }, "bylevel", L["by level"], L["sort by level"], SortByLevel)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "byreason", L["by reason"], L["sort by reason"], SortByReason)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "HATELIST", "NICELIST"}, "bylastseen", L["by last seen"], L["sort by last seen"], SortByLastSeen)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "bycreatedate", L["by create date"], L["sort by date created"], SortByCreateDate)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "bycreator", L["by creator"], L["sort by creator"], SortByCreator)
	VanasKoSGUI:RegisterSortOption({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, "byowner", L["by owner"], L["sort by owner"], SortByOwner)

	VanasKoSGUI:SetDefaultSortFunction({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}, SortByName);

	-- first sort function is sorting by name
	VanasKoSGUI:SetSortFunction(SortByName);

	-- show the PLAYERKOS list after startup
	VanasKoSGUI:ShowList("PLAYERKOS");

	local showOptions = VanasKoSGUI:GetShowButtonOptions();
	showOptions[#showOptions+1] = {
		
		text = L["Show only my entries"],
		func = function(frame) VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries = not VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries; VanasKoSGUI:UpdateShownList(); end,
		checked = function() return VanasKoSDefaultLists.db.profile.ShowOnlyMyEntries; end,
	};

	self.tooltipFrame = CreateFrame("GameTooltip", "VanasKoSDefaultListsTooltip", UIParent, "GameTooltipTemplate");
	tooltip = self.tooltipFrame;
	
	tooltip:Hide();
end

function VanasKoSDefaultLists:OnEnable()
end

function VanasKoSDefaultLists:OnDisable()
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



function VanasKoSDefaultLists:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2)
	if(list == "PLAYERKOS" or list == "HATELIST" or list == "NICELIST") then
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
		if(data and data.level and data.race and data.class) then
			buttonText1:SetText(format(L["%s  Level %s %s %s %s"], displayname, data.level, data.race, data.class, owner));
		else
			buttonText1:SetText(format(L["%s  %s"], displayname, owner));
		end
		if(data and data.lastseen) then
			local timespan = SecondsToTime(time() - data.lastseen);
			if(timespan == "") then
				timespan = L["0 Secs"];
			end

			if(value.reason) then
				buttonText2:SetText(format(L["%s (last seen: %s ago)"], string.Capitalize(value.reason), timespan));
			else
				buttonText2:SetText(format(L["%s (last seen: %s ago)"], L["_Reason Unknown_"], timespan));
			end
		else
			if(value.reason) then
				buttonText2:SetText(format(L["%s (never seen)"], string.Capitalize(value.reason)));
			else
				buttonText2:SetText(format(L["%s (never seen)"], L["_Reason Unknown_"]));
			end
		end
	elseif(VANASKOS.showList == "GUILDKOS") then
		local guildname = VanasKoS:GetGuildData(key);
		if(guildname ~= nil and guildname ~= "") then
			if(value.owner ~= nil and value.owner ~= "") then
				local owner = string.Capitalize(value.owner);
				buttonText1:SetText(format(L["%s  %s"], guildname, owner));
			else
				buttonText1:SetText(format(L["%s  %s"], guildname, ""));
			end
		else
			buttonText1:SetText(string.Capitalize(key));
		end
		if(value.reason) then
			buttonText2:SetText(string.Capitalize(value.reason));
		else
			buttonText2:SetText(L["_Reason Unknown_"]);
		end
	end

	button:Show();
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
		self.db.realm.koslist.players[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player") };
	elseif(list == "GUILDKOS") then
		self.db.realm.koslist.guilds[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player") };
	elseif(list == "HATELIST") then
		if(VanasKoS:IsOnList("NICELIST", name)) then
			self:Print(format(L["Entry %s is already on Nicelist"], name));
			return;
		end
		self.db.realm.hatelist.players[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player")  };
	elseif(list == "NICELIST") then
		if(VanasKoS:IsOnList("HATELIST", name)) then
			self:Print(format(L["Entry %s is already on Hatelist"], name));
			return;
		end
		self.db.realm.nicelist.players[name] = { ["reason"] = data['reason'], ["created"] = time(), ['creator'] = UnitName("player")  };
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
		return self.db.realm.koslist.players;
	elseif(list == "GUILDKOS") then
		return self.db.realm.koslist.guilds;
	elseif(list == "HATELIST") then
		return self.db.realm.hatelist.players;
	elseif(list == "NICELIST") then
		return self.db.realm.nicelist.players;
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

local selectedPlayer, selectedPlayerData = nil;

function VanasKoSDefaultLists:UpdateMouseOverFrame()
	if(not selectedPlayer) then
		tooltip:AddLine("----");
		return;
	end
	
	-- name
	local pdatalist = VanasKoS:GetList("PLAYERDATA")[selectedPlayer];
	tooltip:AddLine(string.Capitalize(selectedPlayer));
	
	-- guild, level, race, class, zone, lastseen
	if(pdatalist) then
		if(pdatalist['guild']) then
			local text = "<|cffffffff" .. pdatalist['guild'] .. "|r>";
			if(pdatalist['guildrank']) then
				text = text .. " (" .. pdatalist['guildrank'] .. ")";
			end
			tooltip:AddLine(text);
		end
		if(pdatalist['level'] and pdatalist['race'] and pdatalist['class']) then
			tooltip:AddLine(format(L['Level %s %s %s'], pdatalist['level'], pdatalist['race'], pdatalist['class']));
		end
		if(pdatalist['zone'] and pdatalist['lastseen']) then
			tooltip:AddLine(format(L['Last seen at %s in %s'], date("%x", pdatalist['lastseen']), pdatalist['zone']));
		end
	end

	-- infos about creator, sender, owner, last updated
	if(selectedPlayerData) then
		if(selectedPlayerData['owner']) then
			tooltip:AddLine(format(L['Owner: %s'], selectedPlayerData['owner']));
		end

		if(selectedPlayerData['creator']) then
			tooltip:AddLine(format(L['Creator: %s'], selectedPlayerData['creator']));
		end

		if(selectedPlayerData['created']) then
			tooltip:AddLine(format(L['Created: %s'], date("%x", selectedPlayerData['created'])));
		end

		if(selectedPlayerData['sender']) then
			tooltip:AddLine(format(L['Received from: %s'], selectedPlayerData['sender']));
		end

		if(selectedPlayerData['lastupdated']) then
			tooltip:AddLine(format(L['Last updated: %s'], date("%x", selectedPlayerData['lastupdated'])));
		end
	end

	local pvplog = VanasKoS:GetList("PVPLOG");
	if(pvplog) then
		pvplog = pvplog[selectedPlayer];
		if(pvplog) then
			tooltip:AddLine("|cffffffff" .. L["PvP Encounter:"] .. "|r");
			local i = 0;
			for k,v in VanasKoSGUI:pairsByKeys(pvplog, nil, nil) do -- sorted from old to new
				if(v.type and v.zone and v.myname) then
					if(v.type == 'win') then
						tooltip:AddLine(format(L["%s: Win in %s (%s)"], date("%c", k), v.zone, v.myname));
					else
						tooltip:AddLine(format(L["%s: Loss in %s (%s)"], date("%c", k), v.zone, v.myname));
					end
				end
				i = i + 1;
				if(i > 10) then
					return;
				end
			end
		end
	end
end

function VanasKoSDefaultLists:ShowTooltip()
	tooltip:ClearLines();
	tooltip:SetOwner(VanasKoSListFrame, "ANCHOR_CURSOR");
	tooltip:SetPoint("TOPLEFT", VanasKoSListFrame, "TOPRIGHT", -33, -30);
	tooltip:SetPoint("BOTTOMLEFT", VanasKoSListFrame, "TOPRIGHT", -33, -390);
	
	self:UpdateMouseOverFrame();
	tooltip:Show();
end

function VanasKoSDefaultLists:HideTooltip()
	tooltip:Hide();
end

function VanasKoSDefaultLists:ListButtonOnEnter(button, frame)
	self:SetSelectedPlayerData(VanasKoSGUI:GetListEntryForID(frame:GetID()));
	
	self:ShowTooltip();
end

function VanasKoSDefaultLists:ListButtonOnLeave(button, frame)
	self:HideTooltip();
end

function VanasKoSDefaultLists:SetSelectedPlayerData(selPlayer, selPlayerData)
	selectedPlayer = selPlayer;
	selectedPlayerData = selPlayerData;
end
