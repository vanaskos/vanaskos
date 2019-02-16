--[[---------------------------------------------------------------------------------------------
      PvPDataGatherer Module - Part of VanasKoS
Gathers PvP Wins and Losses
---------------------------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/PvPDataGatherer", false)
VanasKoSPvPDataGatherer = VanasKoS:NewModule("PvPDataGatherer", "AceEvent-3.0")

-- Declare some common global functions local
local time = time
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local UnitName = UnitName
local UnitLevel = UnitLevel
local SetMapToCurrentZone = SetMapToCurrentZone
local GetRealmName = GetRealmName
local GetPlayerMapPosition = GetPlayerMapPosition
local GetCurrentMapAreaID = GetCurrentMapAreaID
local hashName = VanasKoS.hashName

-- Local Variables
local myName = nil
local myRealm = nil
local lastDamageFrom = {}
local lastDamageTo = {}
local DamageFromArray = {}

function VanasKoSPvPDataGatherer:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("PvPDataGatherer", {
		profile = {
			Enabled = true,
		},
		global = {
			pvpstats = {
				pvplog = {
					event = {},
					player = {},
					map = {},
				},
			}
		}
	})

	VanasKoSGUI:AddModuleToggle("PvPDataGatherer", L["PvP Data Gathering"])

	VanasKoS:RegisterList(nil, "PVPLOG", nil, self)

	self:SetEnabledState(self.db.profile.Enabled)
	myName = UnitName("player")
	myRealm = GetRealmName()
end

function VanasKoSPvPDataGatherer:FilterFunction(key, value, searchBoxText)
	return (searchBoxText == "") or (key:find(searchBoxText) ~= nil)
end

function VanasKoSPvPDataGatherer:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2, buttonText3, buttonText4, buttonText5, buttonText6)
end

function VanasKoSPvPDataGatherer:ShowList(list)
end

function VanasKoSPvPDataGatherer:HideList(list)
end

function VanasKoSPvPDataGatherer:GetList(list)
	if(list == "PVPLOG") then
		return self.db.global.pvpstats.pvplog
	else
		return nil
	end
end


function VanasKoSPvPDataGatherer:AddEntry(list, key, data)
	if(list == "PVPLOG") then
		local pvplog = VanasKoS:GetList("PVPLOG")
		eventkey = key .. (data.time or time())
		pvplog.event[eventkey] = {
			name = data.name,
			realm = data.realm,
			time = data.time,
			myname = data.myname,
			myrealm = data.myrealm,
			mylevel = data.mylevel,
			enemylevel = data.enemylevel,
			type = data.type,
			mapID  = data.mapID,
			x = data.x,
			y = data.y
		}

		if (data.mapID) then
			if (not pvplog.map[data.mapID]) then
				pvplog.map[data.mapID] = {}
			end
			tinsert(pvplog.map[data.mapID], eventkey)
		end

		if (not pvplog.player[key]) then
			pvplog.player[key] = {}
		end
		tinsert(pvplog.player[key], eventkey)
	end
	return true
end

function VanasKoSPvPDataGatherer:RemoveEntry(listname, key, guild)
end

function VanasKoSPvPDataGatherer:IsOnList(list, key)
end

function VanasKoSPvPDataGatherer:SetupColumns(list)
end

function VanasKoSPvPDataGatherer:ToggleLeftButtonOnClick(button, frame)
end

function VanasKoSPvPDataGatherer:ToggleRightButtonOnClick(button, frame)
end

function VanasKoSPvPDataGatherer:OnDisable()
	self:UnregisterAllMessages()
end

function VanasKoSPvPDataGatherer:OnEnable()
	self:RegisterMessage("VanasKoS_PvPDamage", "PvPDamage")
	self:RegisterMessage("VanasKoS_PvPDeath", "PvPDeath")
	if(self.db.global.pvpstats.players) then
		VanasKoS:Print(L["Old pvp statistics detected. You should import old data by going to importer under VanasKoS configuration"])
	end
end

function VanasKoSPvPDataGatherer:PvPDamage(message, srcName, srcRealm, dstName, dstRealm, amount)
	if (srcName == myName) then
		self:DamageDoneTo(dstName, dstRealm, amount)
	elseif (dstName == myName) then
		self:DamageDoneFrom(srcName, srcRealm, amount)
	end
end

function VanasKoSPvPDataGatherer:PvPDeath(message, name, realm)
	if (name ~= myName and lastDamageTo) then
		for i=1,#lastDamageTo do
			if(lastDamageTo[i] and lastDamageTo[i].name == name and lastDamageTo[i].realm == realm) then
				self:SendMessage("VanasKoS_PvPWin", name, realm)
				self:LogPvPWin(name, realm)
				tremove(lastDamageTo, i)
			end
		end
	else
		-- TODO: Blame kill on player who caused the most damage?
		if (lastDamageFrom.time ~= nil) then
			if((time() - lastDamageFrom.time) < 5) then
				self:SendMessage("VanasKoS_PvPLoss", lastDamageFrom.name, lastDamageFrom.realm)
				self:LogPvPLoss(lastDamageFrom.name, lastDamageFrom.realm)
			end
		end
		wipe(lastDamageFrom)
		wipe(lastDamageTo)
	end
end

function VanasKoSPvPDataGatherer:DamageDoneFrom(name, realm)
	if(name and realm) then
		lastDamageFrom = {
			name = name,
			realm = realm,
			time = time()
		}

		self:AddLastDamageFrom(name, realm)
	end
end

function VanasKoSPvPDataGatherer:DamageDoneTo(name, realm)
	tinsert(lastDamageTo, 1,  {
		name = name,
		realm = realm,
		time = time()
	})

	if(#lastDamageTo < 2) then
		return
	end

	for i=2,#lastDamageTo do
		if(lastDamageTo[i] and lastDamageTo[i].name == name and lastDamageTo[i].realm == realm) then
			tremove(lastDamageTo, i)
		end
	end

	if(#lastDamageTo > 10) then
		tremove(lastDamageTo, 11)
	end
end

function VanasKoSPvPDataGatherer:LogPvPLoss(name, realm)
	assert(name)
	assert(realm)

	VanasKoS:Print(format(L["PvP Loss versus %s registered."], name))

	-- Should be ok to call set current zone here, pvp losses don't
	-- happen *that* often, and when they do you probably shouldn't have
	-- been staring at your map anyway...
	-- /script local t = C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player") for k,v in pairs(t) do print("k" .. k) end
	-- kx, ky, getkx, getky... lots of functions returned
	local mapID = C_Map.GetBestMapForUnit("player")
	local x, y = C_Map.GetPlayerMapPosition(mapID, "player"):GetXY()
	local data = VanasKoS:GetPlayerData(name)
	local key = hashName(name, realm)

	VanasKoS:AddEntry("PVPLOG", key, {
		time = time(),
		myname = myName,
		myrealm = myRealm,
		mylevel = UnitLevel("player"),
		name = name,
		enemyguild = data and data.guild or nil,
		realm = realm,
		enemylevel = data and data.level or 0,
		type = "loss",
		mapID = mapID,
		x = x,
		y = y
	})
end

function VanasKoSPvPDataGatherer:LogPvPWin(name, realm)
	assert(name)
	assert(realm)

	VanasKoS:Print(format(L["PvP Win versus %s registered."], name))

	-- Same as losses, but it should be even more rare that you can win in
	-- pvp while staring at the map, so shouldn't be a problem
	local mapID = C_Map.GetBestMapForUnit("player")
	local x, y = GetPlayerMapPosition(mapID, "player")
	local data = VanasKoS:GetPlayerData(name)
	local key = hashName(name, realm)

	VanasKoS:AddEntry("PVPLOG", key, {
		time = time(),
		myname = myName,
		myrealm = myRealm,
		mylevel = UnitLevel("player"),
		name = name,
		realm = realm,
		enemylevel = data and data.level or 0,
		type = "win",
		mapID  = mapID,
		x = x,
		y = y
	})
end

function VanasKoSPvPDataGatherer:AddLastDamageFrom(name, realm)
	local key = hashName(name, realm)
	tinsert(DamageFromArray, 1, {key, time()})
	if(#DamageFromArray < 2) then
		return
	end

	for i=#DamageFromArray,2,-1 do
		if(DamageFromArray[i] and DamageFromArray[i][1] == key) then
			tremove(DamageFromArray, i)
		end
	end

	for i=#DamageFromArray,11,-1 do
		tremove(DamageFromArray, i)
	end
end

function VanasKoSPvPDataGatherer:GetDamageFromArray()
	return DamageFromArray
end

function VanasKoSPvPDataGatherer:GetDamageToArray()
	return lastDamageTo
end

function VanasKoSPvPDataGatherer:HoverType()
	return "player"
end

-- /script VanasKoSPvPDataGatherer:AddTestData(100)
function VanasKoSPvPDataGatherer:AddTestData(cnt)
	for i=1,cnt do
		local name = "test" .. i
		local realm = "some random realm"
		local key = hashName(name, realm)
		VanasKoS:SendMessage("VanasKoS_Player_Detected", {
			name=name,
			realm=realm,
			guild="Evil is us",
			guildRank="Recruit",
			faction = "Alliance",
			mapID = C_Map.GetBestMapForPlayer("player"),
			class = "Tank",
			classEnglish = "Warrior",
			race = "Gerbil",
			raceEnglish = "Gnome",
			gender = FEMALE,
			guid = "Player-XXXXXXXX",
		})
		VanasKoS:AddEntry("PVPLOG", key, {
			name=name,
			realm=realm,
			time=time(),
			myname="bob",
			myrealm="the good one",
			mylevel=15,
			enemylevel=16,
			mapID=C_Map.GetBestMapForPlayer("player"),
			type=math.random() > 0.5 and "win" or "loss",
			x=math.random(),
			y=math.random()
		})
	end
end
