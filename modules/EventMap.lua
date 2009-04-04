--[[----------------------------------------------------------------------
      EventMap Module - Part of VanasKoS
Displays PvP Events on World Map
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "enUS", true);
if L then
	L["Enabled"] = true;
	L["PvP Event Map"] = true;
	L["%s - %s killed by %s"] = "|cffff0000%s: %s killed by %s|r";
	L["%s - %s killed %s"] = "|cff00ff00%s: %s killed %s|r";
	L["PvP Encounter"] = true;
	L["Performance"] = true;
	L["Events Processed"] = true;
	L["Number of events to process at a time"] = true;
	L["Process Delay"] = true;
	L["Delay between processing the next set of events"] = true;
	L["Draw Alts"] = true;
	L["Draws PvP events on map for all characters"] = true;
	L["Dynamic Zoom"] = true;
	L["Redraws points based on Cartographer3 zoom level"] = true;
	L["Show Icons"] = true;
	L["Toggle showing individual icons or simple dots"] = true;
	L["Tooltips"] = true;
	L["Show tooltips when hovering over PvP event icons"] = true;
	L["Dots"] = true;
	L["Size"] = true;
	L["Size of dots"] = true;
	L["Loss"] = true;
	L["Sets the loss color and opacity"] = true;
	L["Win"] = true
	L["Sets the win color and opacity"] = true;
	L["Reset"] = true;
	L["Reset dots to default"] = true;
end

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "deDE", false);
if L then
	L["Enabled"] = "Aktiviert";
	--L["PvP Event Map"] = true;
	--L["%s - %s killed by %s"] = "|cffff0000%s: %s killed by %s|r";
	--L["%s - %s killed %s"] = "|cff00ff00%s: %s killed %s|r";
	--L["PvP Encounter"] = true;
	--L["Performance"] = true;
	--L["Events Processed"] = true;
	--L["Number of events to process at a time"] = true;
	--L["Process Delay"] = true;
	--L["Delay between processing the next set of events"] = true;
	--L["Draw Alts"] = true;
	--L["Draws PvP events on map for all characters"] = true;
	--L["Dynamic Zoom"] = true;
	--L["Redraws points based on Cartographer3 zoom level"] = true;
	--L["Show Icons"] = true;
	--L["Toggle showing individual icons or simple dots"] = true;
	--L["Tooltips"] = true;
	--L["Show tooltips when hovering over PvP event icons"] = true;
	--L["Dots"] = true;
	--L["Size"] = true;
	--L["Size of dots"] = true;
	--L["Loss"] = true;
	--L["Sets the loss color and opacity"] = true;
	--L["Win"] = true
	--L["Sets the win color and opacity"] = true;
	--L["Reset"] = true;
	--L["Reset dots to default"] = true;
end

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "frFR", false);
if L then
	L["Enabled"] = "actif";
	--L["PvP Event Map"] = true;
	--L["%s - %s killed by %s"] = "|cffff0000%s: %s killed by %s|r";
	--L["%s - %s killed %s"] = "|cff00ff00%s: %s killed %s|r";
	--L["PvP Encounter"] = true;
	--L["Performance"] = true;
	--L["Events Processed"] = true;
	--L["Number of events to process at a time"] = true;
	--L["Process Delay"] = true;
	--L["Delay between processing the next set of events"] = true;
	--L["Draw Alts"] = true;
	--L["Draws PvP events on map for all characters"] = true;
	--L["Dynamic Zoom"] = true;
	--L["Redraws points based on Cartographer3 zoom level"] = true;
	--L["Show Icons"] = true;
	--L["Toggle showing individual icons or simple dots"] = true;
	--L["Tooltips"] = true;
	--L["Show tooltips when hovering over PvP event icons"] = true;
	--L["Dots"] = true;
	--L["Size"] = true;
	--L["Size of dots"] = true;
	--L["Loss"] = true;
	--L["Sets the loss color and opacity"] = true;
	--L["Win"] = true
	--L["Sets the win color and opacity"] = true;
	--L["Reset"] = true;
	--L["Reset dots to default"] = true;
end

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "koKR", false);
if L then
	L["Enabled"] = "사용";
	--L["PvP Event Map"] = true;
	--L["%s - %s killed by %s"] = "|cffff0000%s: %s killed by %s|r";
	--L["%s - %s killed %s"] = "|cff00ff00%s: %s killed %s|r";
	--L["PvP Encounter"] = true;
	--L["Performance"] = true;
	--L["Events Processed"] = true;
	--L["Number of events to process at a time"] = true;
	--L["Process Delay"] = true;
	--L["Delay between processing the next set of events"] = true;
	--L["Draw Alts"] = true;
	--L["Draws PvP events on map for all characters"] = true;
	--L["Dynamic Zoom"] = true;
	--L["Redraws points based on Cartographer3 zoom level"] = true;
	--L["Show Icons"] = true;
	--L["Toggle showing individual icons or simple dots"] = true;
	--L["Tooltips"] = true;
	--L["Show tooltips when hovering over PvP event icons"] = true;
	--L["Dots"] = true;
	--L["Size"] = true;
	--L["Size of dots"] = true;
	--L["Loss"] = true;
	--L["Sets the loss color and opacity"] = true;
	--L["Win"] = true
	--L["Sets the win color and opacity"] = true;
	--L["Reset"] = true;
	--L["Reset dots to default"] = true;
end

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "esES", false);
if L then
	L["Enabled"] = "Activado";
	--L["PvP Event Map"] = true;
	--L["%s - %s killed by %s"] = "|cffff0000%s: %s killed by %s|r";
	--L["%s - %s killed %s"] = "|cff00ff00%s: %s killed %s|r";
	--L["PvP Encounter"] = true;
	--L["Performance"] = true;
	--L["Events Processed"] = true;
	--L["Number of events to process at a time"] = true;
	--L["Process Delay"] = true;
	--L["Delay between processing the next set of events"] = true;
	--L["Draw Alts"] = true;
	--L["Draws PvP events on map for all characters"] = true;
	--L["Dynamic Zoom"] = true;
	--L["Redraws points based on Cartographer3 zoom level"] = true;
	--L["Show Icons"] = true;
	--L["Toggle showing individual icons or simple dots"] = true;
	--L["Tooltips"] = true;
	--L["Show tooltips when hovering over PvP event icons"] = true;
	--L["Dots"] = true;
	--L["Size"] = true;
	--L["Size of dots"] = true;
	--L["Loss"] = true;
	--L["Sets the loss color and opacity"] = true;
	--L["Win"] = true
	--L["Sets the win color and opacity"] = true;
	--L["Dots"] = true;
	--L["Size"] = true;
	--L["Size of dots"] = true;
	--L["Loss"] = true;
	--L["Sets the loss color and opacity"] = true;
	--L["Win"] = true
	--L["Sets the win color and opacity"] = true;
	--L["Reset"] = true;
	--L["Reset dots to default"] = true;
end

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "ruRU", false);
if L then
	L["Enabled"] = "Включено";
	--L["PvP Event Map"] = true;
	--L["%s - %s killed by %s"] = "|cffff0000%s: %s killed by %s|r";
	--L["%s - %s killed %s"] = "|cff00ff00%s: %s killed %s|r";
	--L["PvP Encounter"] = true;
	--L["Performance"] = true;
	--L["Events Processed"] = true;
	--L["Number of events to process at a time"] = true;
	--L["Process Delay"] = true;
	--L["Delay between processing the next set of events"] = true;
	--L["Draw Alts"] = true;
	--L["Draws PvP events on map for all characters"] = true;
	--L["Dynamic Zoom"] = true;
	--L["Redraws points based on Cartographer3 zoom level"] = true;
	--L["Show Icons"] = true;
	--L["Toggle showing individual icons or simple dots"] = true;
	--L["Tooltips"] = true;
	--L["Show tooltips when hovering over PvP event icons"] = true;
	--L["Dots"] = true;
	--L["Size"] = true;
	--L["Size of dots"] = true;
	--L["Loss"] = true;
	--L["Sets the loss color and opacity"] = true;
	--L["Win"] = true
	--L["Sets the win color and opacity"] = true;
	--L["Reset"] = true;
	--L["Reset dots to default"] = true;
end

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_EventMap", true);

VanasKoSEventMap = VanasKoS:NewModule("EventMap", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0");

local VanasKoSEventMap = VanasKoSEventMap;
local Cartographer3_Data = nil;
local zoneContinentZoneID = {};
VanasKoSEventMap.POIGRIDALIGN = 16;
VanasKoSEventMap.ICONSIZE = 16;
VanasKoSEventMap.DOTSIZE = 16;
VanasKoSEventMap.lastzoom = 20;
VanasKoSEventMap.lastzone = "";
VanasKoSEventMap.lastcontinent = "";


local function GetColor(which)
	return VanasKoSEventMap.db.profile[which .. "R"], VanasKoSEventMap.db.profile[which .. "G"], VanasKoSEventMap.db.profile[which .. "B"], VanasKoSEventMap.db.profile[which .. "A"];
end

local function SetColor(which, r, g, b, a)
	VanasKoSEventMap.db.profile[which .. "R"] = r;
	VanasKoSEventMap.db.profile[which .. "G"] = g;
	VanasKoSEventMap.db.profile[which .. "B"] = b;
	VanasKoSEventMap.db.profile[which .. "A"] = a;

	VanasKoSEventMap:RedrawMap();
end

function VanasKoSEventMap:POI_Resize(frame)
	if (self.db.profile.icons) then
		frame:SetWidth(self.ICONSIZE);
		frame:SetHeight(self.ICONSIZE);
	else
		frame:SetWidth(self.DOTSIZE);
		frame:SetHeight(self.DOTSIZE);
	end
end

function VanasKoSEventMap:POI_OnShow(frame, id)
	frame:Resize(frame);
end

function VanasKoSEventMap:POI_OnEnter(frame, id)
	if (not self.db.profile.showTooltip) then
		return
	end

	local x = WorldMapButton:GetCenter();
	local anchor = "ANCHOR_RIGHT";
	if (x < frame.x) then
		anchor = "ANCHOR_LEFT";
	end
	WorldMapTooltip:ClearLines();
	WorldMapTooltip:SetOwner(frame, anchor);
	WorldMapTooltip:AddLine(format(L["PvP Encounter"]));
	for i,v in ipairs(frame.event) do
		local player = "";
		if (v.myname) then
			player = player .. v.myname;
		end
		if (v.mylevel) then
			player = player .. " (" .. v.mylevel .. ")";
		end

		local playerdata = VanasKoS:GetPlayerData(v.enemy);
		local enemy = (playerdata and playerdata.displayname) or string.Capitalize(v.enemy);
		local enemyNote = v.enemylevel or "";

		if (playerdata) then
			enemy = playerdata.displayname or string.Capitalize(v.enemy);
			if (playerdata.guild) then
				enemy = enemy .. " <" .. playerdata.guild .. ">";
			end
			if (playerdata.race) then
				enemyNote = enemyNote .. " " .. playerdata.race;
			end
			if (playerdata.class) then
				enemyNote = enemyNote .. " " .. playerdata.class;
			end
		end

		if (enemyNote ~= "") then
			enemy = enemy .. " (" .. enemyNote .. ")";
		end

		if (v.type == "loss") then
			WorldMapTooltip:AddLine(format(L["%s - %s killed by %s"], date("%c", v.time), player, enemy));
		elseif (v.type == "win") then
			WorldMapTooltip:AddLine(format(L["%s - %s killed %s"], date("%c", v.time), player, enemy));
		end
	end
	
	WorldMapTooltip:Show();
end

function VanasKoSEventMap:POI_OnLeave(frame, id)
	WorldMapTooltip:Hide();
end

function VanasKoSEventMap:CreatePOI(x, y)
	local POI = CreateFrame("Button", "VanasKoSEventMapPOI"..self.POICnt, WorldMapButton);
	local id = self.POICnt + 1;
	POI:SetWidth(16);
	POI:SetHeight(16);
	POI:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	POI:SetToplevel(true);

	POI.Resize = function(frame) VanasKoSEventMap:POI_Resize(frame, id); end;
	POI:SetScript("OnEnter", function(frame, id) VanasKoSEventMap:POI_OnEnter(frame, id); end);
	POI:SetScript("OnLeave", function(frame, id) VanasKoSEventMap:POI_OnLeave(frame, id); end);
	POI:SetScript("OnClick", function(frame, id) VanasKoSEventMap:POI_OnClick(frame, id); end);
	POI:SetScript("OnShow", function(frame, id) VanasKoSEventMap:POI_OnShow(frame, id); end)
	POI.x = floor(x/self.POIGRIDALIGN) * self.POIGRIDALIGN;
	POI.y = floor(y/self.POIGRIDALIGN) * self.POIGRIDALIGN;
	POI.score = 0;
	POI.event = {};
	POI:Hide();

	local tex = POI:CreateTexture("VanasKoSEventMapPOI" .. id .. "Texture");
	tex:SetAllPoints();
	tex:SetPoint("CENTER", 0, 0);

	self.POIList[id] = POI;

	if (not self.POIGrid[POI.x]) then
		self.POIGrid[POI.x] = {[POI.y] = POI};
	else
		self.POIGrid[POI.x][POI.y] = POI;
	end
	self.POICnt = self.POICnt + 1;

	return self.POIList[id];
end

function VanasKoSEventMap:GetPOI(x, y)
	local xAlign = floor(x/self.POIGRIDALIGN) * self.POIGRIDALIGN;
	local yAlign = floor(y/self.POIGRIDALIGN) * self.POIGRIDALIGN;
	
	if (self.POIGrid[xAlign] and
	    self.POIGrid[xAlign][yAlign]) then
		return self.POIGrid[xAlign][yAlign];
	end

	self.POIUsed = self.POIUsed + 1;
	if (self.POIUsed <= self.POICnt) then
		local POI = self.POIList[self.POIUsed];
		POI.x = xAlign;
		POI.y = yAlign;
		if (not self.POIGrid[xAlign]) then
			self.POIGrid[xAlign] = {[yAlign] = POI};
		else
			self.POIGrid[xAlign][yAlign] = POI;
		end
		return POI;
	end

	return self:CreatePOI(x, y);
end

function VanasKoSEventMap:drawPOI(POI)
	local alpha = 1;

	-- sanity check
	if (POI == nil) then
		return;
	end

	POI:Hide();
	POI:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", POI.x, POI.y);
	POI:SetFrameLevel(WorldMapPlayer:GetFrameLevel() - 1);
	if (not self.db.profile.icons) then
		POI:SetNormalTexture(nil);
		POI:SetBackdrop({bgFile = "Interface\\Addons\\VanasKoS\\Artwork\\dot"});
	else
		POI:SetBackdrop({});
		POI:SetBackdropColor(0, 0, 0, 0);
	end

	if (POI.score < 0) then
		if (self.db.profile.icons) then
			POI:SetNormalTexture("Interface\\AddOns\\VanasKoS\\Artwork\\loss");
		else
			local r, g, b, a = GetColor("LossBGColor");
			a = min(a * #POI.event, 1);
			POI:SetBackdropColor(r, g, b, a);
		end
	elseif (POI.score > 0) then
		if (self.db.profile.icons) then
			POI:SetNormalTexture("Interface\\AddOns\\VanasKoS\\Artwork\\win");
		else
			local r, g, b, a = GetColor("WinBGColor");
			a = min(a * #POI.event, 1);
			POI:SetBackdropColor(r, g, b, a);
		end
	else
		if (self.db.profile.icons) then
			POI:SetNormalTexture("Interface\\AddOns\\VanasKoS\\Artwork\\tie");
		else
			local rl, gl, bl, al = GetColor("LossBGColor");
			local rw, gw, bw, aw = GetColor("WinBGColor");
			local rt, gt, bt, at = rl + rw, gl + gw, bl + bw, al + aw;
			local r, g, b, a = r / min(r, g, b), g / max(r, g, b), b / max(r, g, b), max(a * #POI.event, 1);
			POI:SetBackdropColor(1, 1, 0, a);
		end
	end
	POI:Resize();
	POI:Enable();
	POI:Show();
end


function VanasKoSEventMap:CreatePoints(enemyIdx)
	local i = 0;
	local pvplog = VanasKoS:GetList("PVPLOG");
	local lastEnemy = nil;
	local continent = GetCurrentMapContinent();
	local zoneid = GetCurrentMapZone();
	local myname = UnitName("player");
	local zones = {GetMapZones(continent)};
	local zoneName = zones and zones[zoneid];

	for enemy, etable in next, pvplog, enemyIdx do
		for time, event in pairs(etable) do
			if (event.zone and event.zone == zoneName and (self.db.profile.drawAlts or event.myname == myname)) then
				local x = event.posX * WorldMapDetailFrame:GetWidth();
				local y = -event.posY * WorldMapDetailFrame:GetHeight();
				local POI = self:GetPOI(x, y);
				if (event.type == "loss") then
					POI.score = POI.score - 1;
				elseif (event.type == "win") then
					POI.score = POI.score + 1;
				end
				POI.show = true;

				table.insert(POI.event, {time = time,
							enemy = enemy,
							myname = event.myname,
							type = event.type,
							mylevel = event.mylevel,
							enemylevel = event.enemylevel,
							});
				self:drawPOI(POI);
			end
			i = i + 1;
		end

		if (i >= self.db.profile.drawPoints) then
			lastEnemy = enemy;
			break;
		end
	end

	if (lastEnemy ~= nil) then
		self:ScheduleTimer("CreatePoints", self.db.profile.drawDelay, lastEnemy);
	end
end

function VanasKoSEventMap:ClearEventMap()
	for i,POI in ipairs(self.POIList) do
		POI:Hide();
		POI.show = nil;
		POI.score = 0;
		wipe(POI.event);
		POI.x = 0;
		POI.y = 0;
	end
	wipe(self.POIGrid);
	self.POIUsed = 0;
	self:CancelAllTimers();
end

function VanasKoSEventMap:RedrawMap()
	self.lastzone = "nowhere";
	self.lastcontinent = "nowhere";
	self:UpdatePOI();
end

function VanasKoSEventMap:UpdatePOI()
	local continent = GetCurrentMapContinent();
	local zone = GetCurrentMapZone();

	-- Only draw if the zone has changed
	if (self.lastzone == zone and self.lastcontinent == continent) then
		return
	end
	self.lastzone = zone;
	self.lastcontinent = continent;

	self:ClearEventMap();

	self:CreatePoints(nil);
end

function VanasKoSEventMap:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("EventMap", 
		{
			profile = {
				Enabled = true,
				drawPoints = 50,
				drawDelay = 0.05,
				drawAlts = true,
				dynamicZoom = true,
				showTooltip = true,
				icons = true,
				dotsize = 16,
				dotloss = {1, 0, 0, .2},
				dotwin = {0, 1, 0, .2},

				LossBGColorR = 1.0,
				LossBGColorG = 0.0,
				LossBGColorB = 0.0,
				LossBGColorA = 0.5,

				WinBGColorR = 0.0,
				WinBGColorG = 1.0,
				WinBGColorB = 0.0,
				WinBGColorA = 0.5,
			},
		}
	);

	VanasKoSGUI:AddConfigOption("VanasKoS-EventMap", {
		type = 'group',
		name = L["PvP Event Map"],
		desc = L["PvP Event Map"],
		args = {
			enabled = {
				type = 'toggle',
				name = L["Enabled"],
				desc = L["Enabled"],
				order = 1,
				set = function(frame, v)
					VanasKoSEventMap.db.profile.Enabled = v;
					VanasKoS:ToggleModuleActive("EventMap");
					VanasKoS:RedrawMap();
				end,
				get = function() return VanasKoSEventMap.db.profile.Enabled; end,
			},
			drawAlts = {
				type = 'toggle',
				name = L["Draw Alts"],
				desc = L["Draws PvP events on map for all characters"],
				order = 2,
				set = function(frame, v) VanasKoSEventMap.db.profile.drawAlts = v; VanasKoSEventMap:RedrawMap(); end,
				get = function() return VanasKoSEventMap.db.profile.drawAlts; end,
			},
			dynamicZoom = {
				type = 'toggle',
				name = L["Dynamic Zoom"],
				desc = L["Redraws points based on Cartographer3 zoom level"],
				order = 3,
				set = function(frame, v) VanasKoSEventMap.db.profile.dynamicZoom = v; end,
				get = function() return VanasKoSEventMap.db.profile.dynamicZoom; end,
			},
			icons = {
				type = 'toggle',
				name = L["Show Icons"],
				desc = L["Toggle showing individual icons or simple dots"],
				order = 4,
				set = function(frame, v)
						VanasKoSEventMap.db.profile.icons = v;
						if (v) then
							VanasKoSEventMap.POIGRIDALIGN = VanasKoSEventMap.ICONSIZE;
						else
							VanasKoSEventMap.POIGRIDALIGN = 1;
						end
						VanasKoSEventMap:RedrawMap();
					end,
				get = function() return VanasKoSEventMap.db.profile.icons; end,
			},
			showTooltip = {
				type = 'toggle',
				name = L["Tooltips"],
				desc = L["Show tooltips when hovering over PvP event icons"],
				order = 5,
				set = function(frame, v) VanasKoSEventMap.db.profile.showTooltip = v; end,
				get = function() return VanasKoSEventMap.db.profile.showTooltip; end,
			},
			dotoptions = {
				type = 'header',
				name = L["Dots"],
				desc = L["Dots"],
				order = 6,
			},
			dotsize = {
				type = 'range',
				name = L["Size"],
				desc = L["Size of dots"],
				order = 7,
				set = function(frame, v)
					VanasKoSEventMap.db.profile.dotsize = v;
					VanasKoSEventMap.DOTSIZE = v;
					VanasKoSEventMap:RedrawMap(); end,
				get = function() return VanasKoSEventMap.db.profile.dotsize; end,
				min = 4,
				max = 18,
				step = 1,
			},
			lossBackgroundColor = {
				type = 'color',
				name = L["Loss"],
				desc = L["Sets the loss color and opacity"],
				order = 8,
				set = function(frame, r, g, b, a) SetColor("LossBGColor", r, g, b, a); end,
				get = function() return GetColor("LossBGColor"); end,
				hasAlpha = true
			},
			winBackgroundColor = {
				type = 'color',
				name = L["Win"],
				desc = L["Sets the win color and opacity"],
				order = 9,
				set = function(frame, r, g, b, a) SetColor("WinBGColor", r, g, b, a); end,
				get = function() return GetColor("WinBGColor"); end,
				hasAlpha = true
			},
			dotreset = {
				type = 'execute',
				name = L["Reset"],
				desc = L["Reset dots to default"],
				order = 10,
				func = function()
						SetColor("LossBGColor", 1.0, 0.0, 0.0, 0.5);
						SetColor("WinBGColor", 0.0, 1.0, 0.0, 0.5);
						VanasKoSEventMap.db.profile.dotsize = 16;
						VanasKoSEventMap.DOTSIZE = 16;
					end,
			},

			performanceHeader = {
				type = 'header',
				name = L["Performance"],
				desc = L["Performance"],
				order = 11,
			},
			drawPoints = {
				type = 'range',
				name = L["Events Processed"],
				desc = L["Number of events to process at a time"],
				order = 12,
				set = function(frame, v) VanasKoSEventMap.db.profile.drawPoints = v; end,
				get = function() return VanasKoSEventMap.db.profile.drawPoints; end,
				min = 1,
				max = 500,
				step = 1,
				isPercent = false,
			},
			drawDelay = {
				type = 'range',
				name = L["Process Delay"],
				desc = L["Delay between processing the next set of events"],
				order = 13,
				set = function(frame, v) VanasKoSEventMap.db.profile.drawDelay = v; end,
				get = function() return VanasKoSEventMap.db.profile.drawDelay; end,
				min = 0,
				max = 1,
				step = .01,
				isPercent = false,
			},
		}
	});
	self.POICnt = 0;
	self.POIUsed = 0;
	self.POIList = {};
	self.POIGrid = {};
	
	self:SetEnabledState(self.db.profile.Enabled);
end

function VanasKoSEventMap:ReadjustCamera(...)
	--Call original function
	self.hooks[Cartographer3.Utils]["ReadjustCamera"](Cartographer3.Utils, ...);

	-- Cartographer Zoom must not work the way I think it does. Using the
	-- zoom causes the icons to remain tiny no matter how close we zoom in.
	-- So using the WorldMapFrame Scale is a decent workaround for now.
	--[[
	local zoom = 20;
	if (Cartographer3_Data and Cartographer3_Data.cameraZoom > 20) then
		zoom = Cartographer3_Data.cameraZoom;
	end
	self.ICONSIZE = 20 * 16 / zoom;
	]]

	local zoom = WorldMapFrame:GetScale();
	if (WorldMapFrame:GetScale() < 1) then
		zoom = 1;
	end
	self.ICONSIZE = 16 / zoom;
	self.DOTSIZE = self.db.profile.dotsize / zoom;

	if (self.lastzoom == zoom) then
		return;
	end
	self.lastzoom = zoom;

	if (self.db.profile.dynamicZoom == true) then
		if (self.db.profile.icons) then
			self.POIGRIDALIGN = self.ICONSIZE;
		else
			self.POIGRIDALIGN = 1;
		end
		-- redraw all the points based on new zoom
		self.lastzone = "";
		self:UpdatePOI();
	else
		-- Resize all points
		for i,POI in ipairs(self.POIList) do
			POI:Resize();
		end
	end
end

function VanasKoSEventMap:WORLD_MAP_UPDATE()
	self:UpdatePOI();
end

function VanasKoSEventMap:OnEnable()
	self:RegisterEvent("WORLD_MAP_UPDATE");
	if (Cartographer3) then
		Cartographer3_Data = Cartographer3.Data;
		self:RawHook(Cartographer3.Utils, "ReadjustCamera");
	end

	self.DOTSIZE = self.db.profile.dotsize;
	if (self.db.profile.icons) then
		self.POIGRIDALIGN = self.ICONSIZE;
	else
		self.POIGRIDALIGN = 1;
	end
end

function VanasKoSEventMap:OnDisable()
	self:UnregisterEvent("WORLD_MAP_UPDATE");
	ClearEventMap();
end
