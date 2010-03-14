--[[----------------------------------------------------------------------
      LastSeenList Module - Part of VanasKoS
Keeps track of recently seen players
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/LastSeenList", false);

VanasKoSLastSeenList = VanasKoS:NewModule("LastSeenList", "AceEvent-3.0");

local VanasKoSLastSeenList = VanasKoSLastSeenList;
local VanasKoS = VanasKoS;

local lastseenlist = { };

-- sorts by index
local function SortByIndex(val1, val2)
	return val1 < val2;
end
local function SortByIndexReverse(val1, val2)
	return val1 > val2
end

-- sort current lastseen
local function SortByLastSeen(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	if(list ~= nil) then
		local cmp1 = 2^30;
		local cmp2 = 2^30;
		if(list[val1] ~= nil and list[val1].lastseen ~= nil) then
			cmp1 = time() - list[val1].lastseen;
		end
		if(list[val2] ~= nil and list[val2].lastseen ~= nil) then
			cmp2 = time() - list[val2].lastseen;
		end
		return (cmp1 < cmp2);
	end
	return false;
end
local function SortByLastSeenReverse(val1, val2)
	local list = VanasKoSGUI:GetCurrentList();
	if(list ~= nil) then
		local cmp1 = 2^30;
		local cmp2 = 2^30;
		if(list[val1] ~= nil and list[val1].lastseen ~= nil) then
			cmp1 = time() - list[val1].lastseen;
		end
		if(list[val2] ~= nil and list[val2].lastseen ~= nil) then
			cmp2 = time() - list[val2].lastseen;
		end
		return (cmp1 > cmp2);
	end
	return false;
end

function VanasKoSLastSeenList:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("LastSeenList", {
		profile = {
			Enabled = true,
		}
	});

	VanasKoSGUI:RegisterSortOption({"LASTSEEN"}, "byname", L["by name"], L["sort by name"], SortByIndex, SortByIndexReverse)
	VanasKoSGUI:RegisterSortOption({"LASTSEEN"}, "bylastseen", L["by last seen"], L["sort by last seen"], SortByLastSeen, SortByLastSeenReverse)
	VanasKoSGUI:SetDefaultSortFunction({"LASTSEEN"}, SortByLastSeen);

	VanasKoSGUI:AddModuleToggle("LastSeenList", L["Last Seen List"]);
end

function VanasKoSLastSeenList:OnEnable()
	if(not self.db.profile.Enabled) then
		self:SetEnabledState(false);
		return;
	end
	if(VanasKoSDataGatherer) then
		if(VanasKoSDataGatherer.db.profile.StorePlayerDataPermanently == true) then
			lastseenlist = VanasKoSDataGatherer.db.realm.data.players or { };
		else
			-- Copy player data into the volatile lastseenlist
			for name, data in pairs(VanasKoSDataGatherer.db.realm.data.players) do
				lastseenlist[name] = { };
				for k, v in pairs(data) do
					lastseenlist[name][k] = v; 
				end
			end
		end
	end

	VanasKoS:RegisterList(5, "LASTSEEN", L["Last seen"], self);
	VanasKoSGUI:RegisterList("LASTSEEN", self);

	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected");
end

function VanasKoSLastSeenList:OnDisable()
	VanasKoSGUI:UnregisterList("LASTSEEN");
	VanasKoS:UnregisterList("LASTSEEN");
	self:UnregisterAllEvents();
	self:UnregisterAllMessages();
end

function VanasKoSLastSeenList:AddEntry(list, name, data)
end

function VanasKoSLastSeenList:RemoveEntry(listname, name)
	if(listname == "LASTSEEN") then
		for k, v in pairs(lastseenlist) do
			lastseenlist[k] = nil;
		end
	end
end

function VanasKoSLastSeenList:GetList(listname)
	return lastseenlist;
end

local PURPLE = "|cffff00ff";
local RED = "|cffff0000";
local GREEN = "|cff00ff00";
local WHITE = "|cffffffff";
local ORANGE = "|cffff7f00";

function VanasKoSLastSeenList:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
	if(list == "LASTSEEN") then
		key = string.Capitalize(key);
		local listname = select(2, VanasKoS:IsOnList(nil, key));
		if(listname == "PLAYERKOS") then
			buttonText1:SetText(format("%s%s|r", PURPLE, key));
		elseif(listname == "HATELIST") then
			buttonText1:SetText(format("%s%s|r", RED, key));
		elseif(listname == "NICELIST") then
			buttonText1:SetText(format("%s%s|r", GREEN, key));
		elseif(value.faction == "friendly") then
			buttonText1:SetText(format("%s%s|r", WHITE, key));
		elseif(value.faction == "enemy") then
			buttonText1:SetText(format("%s%s|r", ORANGE, key));
		else
			buttonText1:SetText(format("%s%s|r", "", key));
		end

		if(not value.lastseen) then
			buttonText2:SetText(L["never seen"]);
		else
			local timespan = SecondsToTime(time() - value.lastseen);
			if(timespan == "") then
				buttonText2:SetText(L["0 Secs ago"]);
			else
				buttonText2:SetText(format(L["%s ago"], timespan));
			end
		end
		button:Show();
	end
end

function VanasKoSLastSeenList:SetupColumns(list)
	if(list == "LASTSEEN") then
		if(not self.group or self.group == 1) then
			VanasKoSGUI:SetNumColumns(2);
			VanasKoSGUI:SetColumnWidth(1, 103);
			VanasKoSGUI:SetColumnWidth(2, 200);
			VanasKoSGUI:SetColumnName(1, L["Name"]);
			VanasKoSGUI:SetColumnName(2, L["Last seen"]);
			VanasKoSGUI:SetColumnSort(1, SortByIndex, SortByIndexReverse);
			VanasKoSGUI:SetColumnSort(2, SortByLastSeen, SortByLastSeenReverse);
			VanasKoSGUI:SetColumnType(1, "normal");
			VanasKoSGUI:SetColumnType(2, "highlight");
			VanasKoSGUI:HideToggleButtons();
		end
	end
end

function VanasKoSLastSeenList:ToggleLeftButtonOnClick(button, frame)
	local list = VANASKOS.showList;
	if(list == "LASTSEEN") then
		self.group = 1
	end
	self:SetupColumns(list)
	VanasKoSGUI:Update();
end

function VanasKoSLastSeenList:ToggleRightButtonOnClick(button, frame)
	local list = VANASKOS.showList;
	if(list == "LASTSEEN") then
		self.group = 1
	end
	self:SetupColumns(list)
	VanasKoSGUI:Update();
end

function VanasKoSLastSeenList:IsOnList(listname, name)
	if(listname == "LASTSEEN") then
		if(lastseenlist[name]) then
			return lastseenlist[name];
		end
	end
	return nil;
end

function VanasKoSLastSeenList:Player_Detected(message, data)
	assert(data.name ~= nil);

	if(not VanasKoSDataGatherer or VanasKoSDataGatherer.db.profile.StorePlayerDataPermanently ~= true) then
		local name = data.name:lower();
		if(not lastseenlist[name]) then
			lastseenlist[name] = { };
		end

		for k, v in pairs(data) do
			lastseenlist[name][k] = v;
		end
		lastseenlist[name].lastseen = time();
	end

	-- update the frame
	self:SendMessage("VanasKoS_List_Entry_Added", "LASTSEEN", nil, nil);
end

function VanasKoSLastSeenList:ShowList(list)
	if(list == "LASTSEEN") then
		--VanasKoSListFrameSyncButton:Disable();
		VanasKoSListFrameChangeButton:Disable();
		VanasKoSListFrameAddButton:Disable();
		VanasKoSListFrameRemoveButton:Disable();
	end
end

function VanasKoSLastSeenList:HideList(list)
	if(list == "LASTSEEN") then
		--VanasKoSListFrameSyncButton:Enable();
		VanasKoSListFrameChangeButton:Enable();
		VanasKoSListFrameAddButton:Enable();
		VanasKoSListFrameRemoveButton:Enable();
	end
end

local lastseenOptions = { };
local entry, value;

local function ListButtonOnRightClickMenu()
	local x, y = GetCursorPosition();
	local uiScale = UIParent:GetEffectiveScale();
	wipe(lastseenOptions);
	lastseenOptions = {
		{
			text = string.Capitalize(entry),
			isTitle = true,
			order = 1,
		},
		{
			text = L["Add to Player KoS"],
			func = function() VanasKoS:AddEntry("PLAYERKOS", entry, { ['reason'] = date() }); end,
			order = 2,
		},
		{
			text = L["Add to Hatelist"],
			func = function() VanasKoS:AddEntry("HATELIST", entry, { ['reason'] = date() }); end,
			order = 3,
		},
		{
			text = L["Add to Nicelist"],
			func = function() VanasKoS:AddEntry("NICELIST", entry, { ['reason'] = date() }); end,
			order = 4,
		},
	};
	EasyMenu(lastseenOptions, VanasKoSGUI.dropDownFrame, UIParent, x/uiScale, y/uiScale, "MENU");
end

function VanasKoSLastSeenList:ListButtonOnClick(button, frame)
	local id = frame:GetID();
	entry, value = VanasKoSGUI:GetListEntryForID(id);

	if(id == nil or entry == nil) then
		return;
	end

	if(button == "RightButton") then
		ListButtonOnRightClickMenu();
	end
end

function VanasKoSLastSeenList:ListButtonOnEnter(button, frame)
	VanasKoSDefaultLists:SetSelectedPlayerData(VanasKoSGUI:GetListEntryForID(frame:GetID()));
	
	VanasKoSDefaultLists:ShowTooltip();
end

function VanasKoSLastSeenList:ListButtonOnLeave(button, frame)
	VanasKoSDefaultLists:HideTooltip();
end
