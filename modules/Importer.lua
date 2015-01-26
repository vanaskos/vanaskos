--[[----------------------------------------------------------------------
      Importer Module - Part of VanasKoS
Handles import of other AddOns KoS Data
------------------------------------------------------------------------]]
local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/Importer", false);

local LCM = LOCALIZED_CLASS_NAMES_MALE;

VanasKoSImporter = VanasKoS:NewModule("Importer", "AceEvent-3.0");

function VanasKoSImporter:OnInitialize()
end

function VanasKoSImporter:OnEnable()
	self:ConvertFromOldVanasKoSList();
end

function VanasKoSImporter:OnDisable()
end

function VanasKoSImporter:ConvertFromOldVanasKoSList()
	local zoneIDAreaID = {};
	local areaID = -1;
	local count = 0;

	for _, areaID in pairs(GetAreaMaps()) do
		zoneIDAreaID[GetMapNameByID(areaID)] = areaID;
	end


	if(VanasKoSDB and VanasKoSDB.namespaces and VanasKoSDB.namespaces.PvPDataGatherer and VanasKoSDB.namespaces.PvPDataGatherer.realm) then
		for k,v in pairs(VanasKoSDB.namespaces.PvPDataGatherer.realm) do
			local pvplog = v.pvpstats and v.pvpstats.pvplog;
			local arealog = {};
			--convert zone information to area id
			if (pvplog and pvplog.zone and pvplog.event) then
				pvplog.area = pvplog.zone
				for i, event in pairs(pvplog.event) do
					local areaID = event.areaID or nil;
					if (event.zone) then
						areaID = zoneIDAreaID[event.zone];
						if (areaID and areaID ~= -1) then
							event.areaID = areaID;
							event.zone = nil;
							count = count + 1;
						end
					end
					if (areaID and areaID ~= -1) then
						if (not arealog[areaID]) then
						    arealog[areaID] = {};
						end
						tinsert(arealog[areaID], i);
					end
				end
				wipe(pvplog.zone);
				pvplog.zone = nil;
				pvplog.area = arealog;
			end
		end
	end
	if (count > 0) then
		VanasKoS:Print(format(L["Imported %d PvP events"], count));
	end

	count = 0;
	if(VanasKoSDB and VanasKoSDB.namespaces and VanasKoSDB.namespaces.DataGatherer and VanasKoSDB.namespaces.DataGatherer.realm) then
		for k,v in pairs(VanasKoSDB.namespaces.DataGatherer.realm) do
			--convert zone information to area id
			if (v.data and v.data.players and not v.data.area) then
				for player, data in pairs(v.data.players) do
					if (data and data.zone) then
						areaID = zoneIDAreaID[data.zone];
						if (areaID and areaID ~= -1) then
							data.areaID = areaID;
							data.zone = nil;
							count = count + 1;
						end
					end
				end
				v.data.area = true;
			end
		end
	end
	if (count > 0) then
		VanasKoS:Print(format(L["Imported %d player data"], count));
	end
end
