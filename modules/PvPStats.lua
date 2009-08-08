--[[----------------------------------------------------------------------
      PvPStats Module - Part of VanasKoS
Displays Stats about PvP in a window
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "enUS", true)
if L then
	L["All Characters (Realm)"] = true
	L["All Time"] = true
	L["Last 24 hours"] = true
	L["Last Month"] = true
	L["Last Week"] = true
	L["Losses: |cffff0000%d|r (%.1f%%)"] = true
	L["PvP Stats"] = true
	L["Wins: |cff00ff00%d|r (%.1f%%)"] = true
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "frFR")
if L then
-- auto generated from wowace translation app
--@localization(locale="frFR", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "deDE")
if L then
-- auto generated from wowace translation app
--@localization(locale="deDE", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "koKR")
if L then
-- auto generated from wowace translation app
--@localization(locale="koKR", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "esMX")
if L then
-- auto generated from wowace translation app
--@localization(locale="esMX", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "ruRU")
if L then
-- auto generated from wowace translation app
--@localization(locale="ruRU", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "zhCN")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhCN", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "esES")
if L then
-- auto generated from wowace translation app
--@localization(locale="esES", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS/PvPStats", "zhTW")
if L then
-- auto generated from wowace translation app
--@localization(locale="zhTW", format="lua_additive_table", namespace="VanasKoS/PvPStats")@
end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PvPStats", false);

VanasKoSPvPStats = VanasKoS:NewModule("PvPStats");

local VanasKoSPvPStats = VanasKoSPvPStats;

local GraphLib = LibStub("LibGraph-2.0");
local frame = nil;

function VanasKoSPvPStats:OnInitialize()
end

local timeSpanStart = nil;
local timeSpanEnd = nil;
local selectedCharacter = nil;

function VanasKoSPvPStats:SetTimeSpan(timeSpanText)
	if(timeSpanText == "ALLTIME") then
		timeSpanStart = nil;
		timeSpanEnd = nil;
	end
	if(timeSpanText == "LAST24HOURS") then
		timeSpanStart = time() - 24*3600; -- 24hours a 3600 seconds
		timeSpanEnd = time();
	end
	if(timeSpanText == "LASTWEEK") then
		timeSpanStart = time() - 7*24*3600; -- 7 days a 24hours a 3600 seconds
		timeSpanEnd = time();
	end
	if(timeSpanText == "LASTMONTH") then
		timeSpanStart = time() - 31*24*3600; -- 31 days a 24hours a 3600 seconds
		timeSpanEnd = time();
	end

	self:UpdateStatsPie();
end

function VanasKoSPvPStats:SetCharacter(charname)
	if(charname == "ALLCHARS") then
		selectedCharacter = nil;
	else
		selectedCharacter = charname;
	end
	self:UpdateStatsPie();
end

function VanasKoSPvPStats:OnEnable()
	if(not self.frame) then
		frame = CreateFrame("Frame", "VanasKoSPvPStatsFrame", UIParent);

		frame:SetWidth(500);
		frame:SetHeight(400);
		frame:SetMovable(true);
		frame:SetToplevel(true);
		frame:EnableMouse(true);
		frame:SetPoint("TOPLEFT", VanasKoSListFrame, "TOPRIGHT", -33, -10);
		frame:SetBackdrop({
				bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
				edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
				insets = { left = 11, right = 12, top = 12, bottom = 11 }
			});

		local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton");
		closeButton:SetPoint("TOPRIGHT", frame, -3, -3);
		closeButton:SetScript("OnClick", function()
			VanasKoSPvPStats:ToggleAllPvPStats();
		end);

		local characterDropdown = CreateFrame("Frame", "VanasKoSPvPStatsCharacterDropDown", frame, "UIDropDownMenuTemplate");
		characterDropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -12);
		UIDropDownMenu_SetWidth(characterDropdown, 150);

		local CharacterChoices = {
			[0] = { L["All Characters (Realm)"], "ALLCHARS" },
		}

		local pvplog = VanasKoS:GetList("PVPLOG") or {};

		local twinks = { };
		for idx, event in ipairs(pvplog.event or {}) do
			if(event.myname) then
				twinks[event.myname] = true;
			end
		end
		for k,v in pairs(twinks) do
			tinsert(CharacterChoices, { k, k });
		end

		UIDropDownMenu_Initialize(characterDropdown,
			function()
				for k,v in pairs(CharacterChoices) do
					local button = UIDropDownMenu_CreateInfo();
					button.text = v[1];
					button.value = v[2];
					button.func = function()
						VanasKoSPvPStats:SetCharacter(this.value);
						UIDropDownMenu_SetSelectedValue(VanasKoSPvPStatsCharacterDropDown, this.value);
					end
					UIDropDownMenu_AddButton(button);
				end

			end
		);
		UIDropDownMenu_SetSelectedValue(characterDropdown, "ALLCHARS");

		local timespanDropdown = CreateFrame("Frame", "VanasKoSPvPStatsTimeSpanDropDown", frame, "UIDropDownMenuTemplate");
		timespanDropdown:SetPoint("LEFT", characterDropdown, "RIGHT", -30, 0);

		local TimeSpanChoices = {
			[0] = { L["All Time"], "ALLTIME" };
			[1] = { L["Last 24 hours"], "LAST24HOURS" };
			[2] = { L["Last Week"], "LASTWEEK" };
			[3] = { L["Last Month"], "LASTMONTH" };
		};

		UIDropDownMenu_Initialize(timespanDropdown,
			function()
				for k,v in VanasKoSGUI:pairsByKeys(TimeSpanChoices, nil) do
					local button = UIDropDownMenu_CreateInfo();
					button.text = v[1];
					button.value = v[2];
					button.func = function()
						VanasKoSPvPStats:SetTimeSpan(this.value);
						UIDropDownMenu_SetSelectedValue(VanasKoSPvPStatsTimeSpanDropDown, this.value);
					end
					UIDropDownMenu_AddButton(button);
				end

			end
		);
		UIDropDownMenu_SetSelectedValue(VanasKoSPvPStatsTimeSpanDropDown, "ALLTIME");

		self.frame = frame;
		frame:Hide();
	end

	local showOptions = VanasKoSGUI:GetShowButtonOptions();
	showOptions[#showOptions+1] = {
		text = L["PvP Stats"],
		func = function() VanasKoSPvPStats:ToggleAllPvPStats(); end,
	};
end

function VanasKoSPvPStats:OnDisable()
	local showOptions = VanasKoSGUI:GetShowButtonOptions();
	for k,v in pairs(showOptions) do
		if v.text == L["PvP Stats"] then
			showOptions[k] = nil;
		end
	end
	showOptions.args["pvpstats"] = nil;
end

local function round(number, dp)
	local temp = 10^(dp or 0);
	return math.floor(number * temp + 0.5) / temp;
end

function VanasKoSPvPStats:UpdateStatsPie()
	local pvplog = VanasKoS:GetList("PVPLOG");
	local wins = 0;
	local losses = 0;

	for idx,event in ipairs(pvplog.event) do
		if( (timeSpanStart == nil or event.time >= timeSpanStart) and
			(timeSpanEnd == nil or event.time <= timeSpanEnd)) then

			if(not selectedCharacter or event.myname == selectedCharacter) then
				if(event ~= nil) then
					if(event.type == 'win') then
						wins = wins + 1;
					elseif(event.type == 'loss') then
						losses = losses + 1;
					end
				end
			end
		end
	end

	self:SetWinLossStatsPie(wins, losses);
end

local statPie = nil;
local RED = { 1.0, 0.0, 0.0 };
local GREEN = { 0.0, 1.0, 0.0 };
local text1 = nil;
local text2 = nil;

function VanasKoSPvPStats:SetWinLossStatsPie(wins, losses)
	if(statPie == nil) then
		statPie = GraphLib:CreateGraphPieChart("VanasKoS_PvP_StatPie", VanasKoSPvPStatsCharacterDropDown, "TOPLEFT", "BOTTOMLEFT", 15, 0, 100, 100);

		text1 = statPie:CreateFontString(nil, "ARTWORK");
		text1:SetFontObject("GameFontNormal");
		text1:SetPoint("TOPLEFT", statPie, "TOPRIGHT", 0, 0);
		text1:SetText("|cff00ff00Wins:" .. wins .. "|r");

		text2 = statPie: CreateFontString(nil, "ARTWORK");
		text2:SetFontObject("GameFontNormal");
		text2:SetPoint("TOPLEFT", text1, "BOTTOMLEFT", 0, 0);
		text2:SetText("|cffff0000Wins:" .. losses .. "|r");
	else
		statPie:ResetPie();
	end

	local losspercent = 0.0;
	local winpercent  = 0.0;

	if(wins+losses > 0) then
		local losspercent = losses / (wins + losses);
		if(losspercent == 1) then
			statPie:CompletePie(RED);
		elseif(losspercent == 0) then
			statPie:CompletePie(GREEN);
		else
			statPie:AddPie(losspercent * 100, RED);
		end
		winpercent = (1.0-losspercent)
	end

	text1:SetText(format(L["Wins: |cff00ff00%d|r (%.1f%%)"], wins, winpercent*100));
	text2:SetText(format(L["Losses: |cffff0000%d|r (%.1f%%)"], losses, losspercent*100));

	if(losspercent ~= 0 and losspercent ~= 1) then
		statPie:CompletePie(GREEN);
	end
end

function VanasKoSPvPStats:ToggleAllPvPStats()
	if(self.frame:IsVisible()) then
		self.frame:Hide();
	else
		self:UpdateStatsPie();
		self.frame:Show();
	end
end
