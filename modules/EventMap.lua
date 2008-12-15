--[[----------------------------------------------------------------------
      EventMap Module - Part of VanasKoS
Displays PvP Events on World Map
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "enUS", true);
if L then
	L["Enabled"] = true;
	L["PvP Event Map"] = true;
	L["%s - %s (%d) killed by %s"] = "|cffff0000%s: %s (%d) killed by %s|r";
	L["%s - %s (%d) killed %s"] = "|cff00ff00%s: %s (%d) killed %s|r";
	L["PvP Encounter"] = true;
end

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "deDE", false);
if L then
	L["Enabled"] = "Aktiviert";
	--L["PvP Event Map"] = true;
	--L["%s - %s (%d) killed by %s"] = "|cffff0000%s: %s (%d) killed by %s|r";
	--L["%s - %s (%d) killed %s"] = "|cff00ff00%s: %s (%d) killed %s|r";
	--L["PvP Encounter"] = true;
end

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "frFR", false);
if L then
	L["Enabled"] = "actif";
	--L["PvP Event Map"] = true;
	--L["%s - %s (%d) killed by %s"] = "|cffff0000%s: %s (%d) killed by %s|r";
	--L["%s - %s (%d) killed %s"] = "|cff00ff00%s: %s (%d) killed %s|r";
	--L["PvP Encounter"] = true;
end

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "koKR", false);
if L then
	L["Enabled"] = "사용";
	--L["PvP Event Map"] = true;
	--L["%s - %s (%d) killed by %s"] = "|cffff0000%s: %s (%d) killed by %s|r";
	--L["%s - %s (%d) killed %s"] = "|cff00ff00%s: %s (%d) killed %s|r";
	--L["PvP Encounter"] = true;
end

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "esES", false);
if L then
	L["Enabled"] = "Activado";
	--L["PvP Event Map"] = true;
	--L["%s - %s (%d) killed by %s"] = "|cffff0000%s: %s (%d) killed by %s|r";
	--L["%s - %s (%d) killed %s"] = "|cff00ff00%s: %s (%d) killed %s|r";
	--L["PvP Encounter"] = true;
end

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_EventMap", "ruRU", false);
if L then
	L["Enabled"] = "Включено";
	--L["PvP Event Map"] = true;
	--L["%s - %s (%d) killed by %s"] = "|cffff0000%s: %s (%d) killed by %s|r";
	--L["%s - %s (%d) killed %s"] = "|cff00ff00%s: %s (%d) killed %s|r";
	--L["PvP Encounter"] = true;
end

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_EventMap", true);

VanasKoSEventMap = VanasKoS:NewModule("EventMap", "AceEvent-3.0");

local VanasKoSEventMap = VanasKoSEventMap;

local function POI_OnEnter(self, id)
	--Add some type of tooltip or menu
	--POI.enemy = enemy;
	local x = WorldMapButton:GetCenter();
	local anchor = "ANCHOR_RIGHT";
	if (x < self.x) then
		anchor = "ANCHOR_LEFT";
	end
	WorldMapTooltip:ClearLines();
	WorldMapTooltip:SetOwner(self, anchor);
	WorldMapTooltip:AddLine(format(L["PvP Encounter"]));
	for i,v in ipairs(self.event) do
		if (v.type == "loss") then
			WorldMapTooltip:AddLine(format(L["%s - %s (%d) killed by %s"], date("%c", v.time), v.myname, v.mylevel, string.Capitalize(v.enemy)));
		elseif (v.type == "win") then
			WorldMapTooltip:AddLine(format(L["%s - %s (%d) killed %s"], date("%c", v.time), v.myname, v.mylevel, string.Capitalize(v.enemy)));
		end
	end
	
	WorldMapTooltip:Show();
end


local function POI_OnLeave(self, id)
	WorldMapTooltip:Hide();
end

local function POI_OnClick(self, id)
end

local function VanasKoSEventMap_CreatePOI(x, y)
	local POI = CreateFrame("Button", "VanasKoSEventMapPOI"..VanasKoSEventMap.POICnt, WorldMapButton);
	local id = VanasKoSEventMap.POICnt + 1;
	POI:SetWidth(16);
	POI:SetHeight(16);
	POI:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	POI:SetScript("OnEnter", POI_OnEnter);
	POI:SetScript("OnLeave", POI_OnLeave);
	POI:SetScript("OnClick", POI_OnClick);
	POI.x = x;
	POI.y = y;
	POI.score = 0;
	POI.event = {};
	POI:Hide();

	local tex = POI:CreateTexture("VanasKoSEventMapPOI" .. id .. "Texture");
	tex:SetWidth(16);
	tex:SetHeight(16);
	tex:SetPoint("CENTER", 0, 0);

	VanasKoSEventMap.POIList[id] = POI;
	VanasKoSEventMap.POICnt = VanasKoSEventMap.POICnt + 1;

	return VanasKoSEventMap.POIList[id];
end

local function VanasKoSEventMap_GetPOI(x, y)
	for i,POI in ipairs(VanasKoSEventMap.POIList) do
		if (POI.x - x < 8 and POI.x - x > -8 and POI.y - y < 8 and POI.y - y > -8) then
			return POI;
		end
	end

	VanasKoSEventMap.POIUsed = VanasKoSEventMap.POIUsed + 1;
	if (VanasKoSEventMap.POIUsed <= VanasKoSEventMap.POICnt) then
		local POI = VanasKoSEventMap.POIList[VanasKoSEventMap.POIUsed];
		POI.x = x;
		POI.y = y;
		return POI;
	end

	return VanasKoSEventMap_CreatePOI(x, y);
end

local function HideEventMap()
	for i,POI in ipairs(VanasKoSEventMap.POIList) do
		POI:Hide();
		POI.show = nil;
		POI.score = 0;
		wipe(POI.event);
		POI.event = {};
	end
	VanasKoSEventMap.POIUsed = 0;
end

local function UpdatePOI()
	local continent = GetCurrentMapContinent();
	local zone = GetCurrentMapZone();
	local pvplog = VanasKoS:GetList("PVPLOG");

	-- For some Reason the CLOSE_WORLD_MAP doesn't seem to work, so just
	-- redraw everything every time
	HideEventMap();

	for enemy, etable in pairs(pvplog) do
		for time, event in pairs(etable) do
			if (event.continent == continent and event.zoneid == zone) then
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
			end
		end
	end

	for i,POI in ipairs(VanasKoSEventMap.POIList) do
		if (POI.show) then
			POI:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", POI.x, POI.y);
			POI:SetFrameLevel(WorldMapPlayer:GetFrameLevel() - 1);
			if (POI.score < 0) then
				POI:SetNormalTexture("Interface\\AddOns\\VanasKoS\\Artwork\\loss");
			elseif (POI.score > 0) then
				POI:SetNormalTexture("Interface\\AddOns\\VanasKoS\\Artwork\\win");
			else
				POI:SetNormalTexture("Interface\\AddOns\\VanasKoS\\Artwork\\tie");
			end
			POI:Enable();
			POI:Show();
		end
	end
end

function VanasKoSEventMap:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("EventMap", 
		{
			profile = {
				Enabled = true,
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
				get = function() return VanasKoSEventMap.db.profile.Enabled end,
			},
		}
	});
	self.POICnt = 0;
	self.POIUsed = 0;
	self.POIList = {};
end

function VanasKoSEventMap:OnEnable()
	if(not self.db.profile.Enabled) then
		self:Disable();
		return;
	end

	self:RegisterEvent("WORLD_MAP_UPDATE", UpdatePOI);
	self:RegisterEvent("CLOSE_WORLD_MAP", HideEventMap);
end

function VanasKoSEventMap:OnDisable()
	self:UnregisterEvent("WORLD_MAP_UPDATE");
	self:UnregisterEvent("CLOSE_WORLD_MAP");
	HideEventMap();
end
