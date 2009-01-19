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
end

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_EventMap", true);

VanasKoSEventMap = VanasKoS:NewModule("EventMap", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0");

local VanasKoSEventMap = VanasKoSEventMap;
local Cartographer3_Data = nil;
VanasKoSEventMap.POIGRIDALIGN = 16;
VanasKoSEventMap.ICONSIZE = 16;
VanasKoSEventMap.lastzoom = 20;
VanasKoSEventMap.lastzone = "";
VanasKoSEventMap.lastcontinent = "";

local function POI_Resize(self)
	self:SetWidth(VanasKoSEventMap.ICONSIZE);
	self:SetHeight(VanasKoSEventMap.ICONSIZE);
end

local function POI_OnShow(self, id)
	self:Resize(self);
end

local function POI_OnEnter(self, id)
	local x = WorldMapButton:GetCenter();
	local anchor = "ANCHOR_RIGHT";
	if (x < self.x) then
		anchor = "ANCHOR_LEFT";
	end
	WorldMapTooltip:ClearLines();
	WorldMapTooltip:SetOwner(self, anchor);
	WorldMapTooltip:AddLine(format(L["PvP Encounter"]));
	for i,v in ipairs(self.event) do
		local player = "";
		if (v.myname) then
			player = player .. v.myname;
		end
		if (v.mylevel) then
			player = player .. " (" .. v.mylevel .. ")";
		end

		local playerdata = VanasKoS:GetPlayerData(v.enemy);
		local enemy = (playerdata and playerdata.displayname) or string.Capitalize(v.enemy);
		local enemyNote = "";

		if (v.enemylevel) then
			enemyNote = v.enemylevel .. " " .. enemyNote;
		end

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


local function POI_OnLeave(self, id)
	WorldMapTooltip:Hide();
end

local function VanasKoSEventMap_CreatePOI(x, y)
	local POI = CreateFrame("Button", "VanasKoSEventMapPOI"..VanasKoSEventMap.POICnt, WorldMapButton);
	local id = VanasKoSEventMap.POICnt + 1;
	POI:SetWidth(16);
	POI:SetHeight(16);
	POI:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	POI:SetToplevel(true);

	POI.Resize = POI_Resize;
	POI:SetScript("OnEnter", POI_OnEnter);
	POI:SetScript("OnLeave", POI_OnLeave);
	POI:SetScript("OnClick", POI_OnClick);
	POI:SetScript("OnShow", POI_OnShow)
	POI.x = floor(x/VanasKoSEventMap.POIGRIDALIGN) * VanasKoSEventMap.POIGRIDALIGN;
	POI.y = floor(y/VanasKoSEventMap.POIGRIDALIGN) * VanasKoSEventMap.POIGRIDALIGN;
	POI.score = 0;
	POI.event = {};
	POI:Hide();

	local tex = POI:CreateTexture("VanasKoSEventMapPOI" .. id .. "Texture");
	tex:SetAllPoints();
	tex:SetPoint("CENTER", 0, 0);

	VanasKoSEventMap.POIList[id] = POI;

	if (not VanasKoSEventMap.POIGrid[POI.x]) then
		VanasKoSEventMap.POIGrid[POI.x] = {[POI.y] = POI};
	else
		VanasKoSEventMap.POIGrid[POI.x][POI.y] = POI;
	end
	VanasKoSEventMap.POICnt = VanasKoSEventMap.POICnt + 1;

	return VanasKoSEventMap.POIList[id];
end

local function VanasKoSEventMap_GetPOI(x, y)
	local xAlign = floor(x/VanasKoSEventMap.POIGRIDALIGN) * VanasKoSEventMap.POIGRIDALIGN;
	local yAlign = floor(y/VanasKoSEventMap.POIGRIDALIGN) * VanasKoSEventMap.POIGRIDALIGN;
	
	if (VanasKoSEventMap.POIGrid[xAlign] and
	    VanasKoSEventMap.POIGrid[xAlign][yAlign]) then
		return VanasKoSEventMap.POIGrid[xAlign][yAlign];
	end

	VanasKoSEventMap.POIUsed = VanasKoSEventMap.POIUsed + 1;
	if (VanasKoSEventMap.POIUsed <= VanasKoSEventMap.POICnt) then
		local POI = VanasKoSEventMap.POIList[VanasKoSEventMap.POIUsed];
		POI.x = xAlign;
		POI.y = yAlign;
		if (not VanasKoSEventMap.POIGrid[xAlign]) then
			VanasKoSEventMap.POIGrid[xAlign] = {[yAlign] = POI};
		else
			VanasKoSEventMap.POIGrid[xAlign][yAlign] = POI;
		end
		return POI;
	end

	return VanasKoSEventMap_CreatePOI(x, y);
end

local function drawPOI(POI)
	-- sanity check
	if (POI == nil) then
		return;
	end

	POI:Hide();
	POI:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", POI.x, POI.y);
	POI:SetFrameLevel(WorldMapPlayer:GetFrameLevel() - 1);
	if (POI.score < 0) then
		POI:SetNormalTexture("Interface\\AddOns\\VanasKoS\\Artwork\\loss");
	elseif (POI.score > 0) then
		POI:SetNormalTexture("Interface\\AddOns\\VanasKoS\\Artwork\\win");
	else
		POI:SetNormalTexture("Interface\\AddOns\\VanasKoS\\Artwork\\tie");
	end
	POI:Resize();
	POI:Enable();
	POI:Show();
end


local function CreatePoints(enemyIdx)
	local i = 0;
	local pvplog = VanasKoS:GetList("PVPLOG");
	local lastEnemy = nil;
	local continent = GetCurrentMapContinent();
	local zone = GetCurrentMapZone();
	local myname = UnitName("player");

	for enemy, etable in next, pvplog, enemyIdx do
		for time, event in pairs(etable) do
			if (event.continent == continent and event.zoneid == zone and (VanasKoSEventMap.db.profile.drawAlts or event.myname == myname)) then
				local x = event.posX * WorldMapDetailFrame:GetWidth();
				local y = -event.posY * WorldMapDetailFrame:GetHeight();
				local POI = VanasKoSEventMap_GetPOI(x, y);
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
							});
				drawPOI(POI);
			end
			i = i + 1;
		end

		if (i >= VanasKoSEventMap.db.profile.drawPoints) then
			lastEnemy = enemy;
			break;
		end
	end

	if (lastEnemy ~= nil) then
		VanasKoSEventMap:ScheduleTimer(CreatePoints, VanasKoSEventMap.db.profile.drawDelay, lastEnemy);
	end
end

local function ClearEventMap()
	for i,POI in ipairs(VanasKoSEventMap.POIList) do
		POI:Hide();
		POI.show = nil;
		POI.score = 0;
		wipe(POI.event);
		POI.x = 0;
		POI.y = 0;
	end
	wipe(VanasKoSEventMap.POIGrid);
	VanasKoSEventMap.POIUsed = 0;
	VanasKoSEventMap:CancelAllTimers();
end

local function UpdatePOI()
	local continent = GetCurrentMapContinent();
	local zone = GetCurrentMapZone();

	-- Only draw if the zone has changed
	if (VanasKoSEventMap.lastzone == zone and VanasKoSEventMap.lastcontinent == continent) then
		return
	end
	VanasKoSEventMap.lastzone = zone;
	VanasKoSEventMap.lastcontinent = continent;

	ClearEventMap();

	CreatePoints(nil);
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
			},
		}
	);

	VanasKoSGUI:AddConfigOption("EventMap", {
		type = 'group',
		name = L["PvP Event Map"],
		desc = L["PvP Event Map"],
		args = {
			enabled = {
				type = 'toggle',
				name = L["Enabled"],
				desc = L["Enabled"],
				order = 1,
				set = function(frame, v) VanasKoSEventMap.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("EventMap"); end,
				get = function() return VanasKoSEventMap.db.profile.Enabled; end,
			},
			drawAlts = {
				type = 'toggle',
				name = L["Draw Alts"],
				desc = L["Draws PvP events on map for all characters"],
				order = 2,
				set = function(frame, v) VanasKoSEventMap.db.profile.drawAlts = v; VanasKoSEventMap.lastzone=""; UpdatePOI(); end,
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
			performanceHeader = {
				type = 'header',
				name = L["Performance"],
				desc = L["Performance"],
				order = 4,
			},
			drawPoints = {
				type = 'range',
				name = L["Events Processed"],
				desc = L["Number of events to process at a time"],
				order = 5,
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
				order = 6,
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
	VanasKoSEventMap.ICONSIZE = 20 * 16 / zoom;
	]]

	local zoom = WorldMapFrame:GetScale();
	if (WorldMapFrame:GetScale() < 1) then
		zoom = 1;
	end
	VanasKoSEventMap.ICONSIZE = 16 / zoom;

	if (self.lastzoom == zoom) then
		return;
	end
	self.lastzoom = zoom;

	if (self.db.profile.dynamicZoom == true) then
		VanasKoSEventMap.POIGRIDALIGN = VanasKoSEventMap.ICONSIZE;
		-- redraw all the points based on new zoom
		self.lastzone = "";
		UpdatePOI();
	else
		-- Resize all points
		for i,POI in ipairs(VanasKoSEventMap.POIList) do
			POI:Resize();
		end
	end
end

function VanasKoSEventMap:OnEnable()
	self:RegisterEvent("WORLD_MAP_UPDATE", UpdatePOI);
	if (Cartographer3) then
		Cartographer3_Data = Cartographer3.Data;
		self:RawHook(Cartographer3.Utils, "ReadjustCamera");
	end
end

function VanasKoSEventMap:OnDisable()
	self:UnregisterEvent("WORLD_MAP_UPDATE");
	ClearEventMap();
end
