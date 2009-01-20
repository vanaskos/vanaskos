--[[----------------------------------------------------------------------
      LastSeenList Module - Part of VanasKoS
Keeps track of recently seen players
------------------------------------------------------------------------]]


local function RegisterTranslations(locale, translationfunction)
	local defaultLocale = false;
	if(locale == "enUS") then
		defaultLocale = true;
	end
	
	local liblocale = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_LastSeenList", locale, defaultLocale);
	if liblocale then
		for k, v in pairs(translationfunction()) do
			liblocale[k] = v;
		end
	end
end

VanasKoSLastSeenList = VanasKoS:NewModule("LastSeenList", "AceEvent-3.0");

local VanasKoSLastSeenList = VanasKoSLastSeenList;
local VanasKoS = VanasKoS;

local lastseenlist = { };

RegisterTranslations("enUS", function() return {
	["Last seen"] = true,
	["by last seen"] = true,
	["sort by last seen"] = true,
	["0 Secs ago"] = true,
	["%s ago"] = true,
	["never seen"] = true,

	["Add to Player KoS"]  = true,
	["Add to Hatelist"]  = true,
	["Add to Nicelist"]  = true,

	["Last Seen List"] = true,
	["Enabled"] = true,
} end);

RegisterTranslations("deDE", function() return {
	["Last seen"] = "Zuletzt gesehen",
	["by last seen"] = "nach zuletzt gesehen",
	["sort by last seen"] = "sortieren nach wann zuletzt gesehen",
	["0 Secs ago"] = "Vor 0 Sekunden",
	["%s ago"] = "Vor %s",
	["never seen"] = "noch nicht gesehen",

	["Add to Player KoS"]  = "Zur KoS Liste hinzufügen",
	["Add to Hatelist"]  = "Zur Hassliste hinzufügen",
	["Add to Nicelist"]  = "Zur Nette-Leute-Liste hinzufügen",

	["Last Seen List"] = "Zuletzt gesehen Liste",
	["Enabled"] = "Aktiviert",
} end);

RegisterTranslations("frFR", function() return {
} end);

RegisterTranslations("koKR", function() return {
	["Last seen"] = "마지막 발견",
	["by last seen"] = "마지막 발견에 의해",
	["sort by last seen"] = "마지막 발견에 의한 정렬",
	["0 Secs ago"] = "0초 이전",
	["%s ago"] = "%s 이전",

	["Add to Player KoS"]  = "플레이어 KoS에 추가",
	["Add to Hatelist"]  = "악인명부에 추가",
	["Add to Nicelist"]  = "호인명부에 추가",
} end);

RegisterTranslations("esES", function() return {
} end);

RegisterTranslations("ruRU", function() return {
	["Last seen"] = "Последние встречи",
	["by last seen"] = "по последней встрече",
	["sort by last seen"] = "сортировать по последней встрече",
	["0 Secs ago"] = "0 сек. назад",
	["%s ago"] = "%s назад",

	["Add to Player KoS"]  = "Добавить к KoS-игрокам",
	["Add to Hatelist"]  = "Добавить к списку ненавистных",
	["Add to Nicelist"]  = "Добавить к списку хороших",

	["Last Seen List"] = "Последние встречи",
	["Enabled"] = "Включено",
} end);

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_LastSeenList", false);

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

	VanasKoSGUI:AddConfigOption("LastSeenList", {
			type = 'group',
			name = L["Last Seen List"],
			desc = L["Last Seen List"],
			args = {
				enabled = {
					type = 'toggle',
					name = L["Enabled"],
					desc = L["Enabled"],
					order = 1,
					set = function(v) VanasKoSLastSeenList.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("LastSeenList"); end,
					get = function() return VanasKoSLastSeenList.db.profile.Enabled end,
				}
			}
		});
end

function VanasKoSLastSeenList:OnEnable()
	if(not self.db.profile.Enabled) then
		self:SetEnabledState(false);
		return;
	end
	if(VanasKoSDataGatherer) then
		if(VanasKoSDataGatherer.db.profile.StorePlayerDataPermanently == true) then
			VanasKoS:Print("using");
			lastseenlist = VanasKoSDataGatherer.db.realm.data.players or { };
		else
			VanasKoS:Print("copying");
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
