--[[----------------------------------------------------------------------
      LastSeenList Module - Part of VanasKoS
Keeps track of recently seen players
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "enUS", true)
if L then
	L["0 Secs ago"] = true
	L["Add to Hatelist"] = true
	L["Add to Nicelist"] = true
	L["Add to Player KoS"] = true
	L["by last seen"] = true
	L["Last seen"] = true
	L["Last Seen List"] = true
	L["never seen"] = true
	L["%s ago"] = true
	L["sort by last seen"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS/LastSeenList")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS/LastSeenList")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS/LastSeenList")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS/LastSeenList")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS/LastSeenList")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS/LastSeenList")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS/LastSeenList")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/LastSeenList", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS/LastSeenList")@
end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/LastSeenList", false);

VanasKoSLastSeenList = VanasKoS:NewModule("LastSeenList", "AceEvent-3.0");

local VanasKoSLastSeenList = VanasKoSLastSeenList;
local VanasKoS = VanasKoS;

local lastseenlist = { };

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

		if(cmp1 < cmp2) then
			return true;
		else
			return false;
		end
	end
end

function VanasKoSLastSeenList:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("LastSeenList", {
		profile = {
			Enabled = true,
		}
	});

	VanasKoSGUI:RegisterSortOption({"LASTSEEN"}, "bylastseen", L["by last seen"], L["sort by last seen"], SortByLastSeen)
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

function VanasKoSLastSeenList:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2)
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
