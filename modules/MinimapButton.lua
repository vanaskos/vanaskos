--[[----------------------------------------------------------------------
      MinimapButton Module - Part of VanasKoS
Creates a MinimapButton with a menu for VanasKoS
------------------------------------------------------------------------]]

local function RegisterTranslations(locale, translationfunction)
	local defaultLocale = false;
	if(locale == "enUS") then
		defaultLocale = true;
	end
	
	local liblocale = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_MinimapButton", locale, defaultLocale);
	if liblocale then
		for k, v in pairs(translationfunction()) do
			liblocale[k] = v;
		end
	end
end

RegisterTranslations("enUS", function() return {
	["Main Window"] = true,
	["Warning Window"] = true,
	["Add Player to KoS"] = true,
	["Add Guild to KoS"] = true,
	["Add Player to Hatelist"] = true,
	["Add Player to Nicelist"] = true,
	["Add Attacker to KoS"] = true,

	["Minimap Button"] = true,
	["Enabled"] = true,
	["Locked"] = true,
	["Reset Position"] = true,
--	["Angle"] = true,
--	["Distance"] = true,
--
	["Show information"] = true,
	["Show Warning Frame Infos as Text and Tooltip"] = true,
	["Last Attackers"] = true,
	["%s ago"] = true,
	
	["Click to toggle the Main Window"] = true,
	
	["Nearby People"] = true,
} end);

RegisterTranslations("deDE", function() return {
	["Main Window"] = "Programmfenster",
	["Warning Window"] = "Warnfenster",
	["Add Player to KoS"] = "Spieler zur KoS-Liste hinzufuegen",
	["Add Guild to KoS"] = "Gilde zur KoS-Liste hinzufuegen",
	["Add Player to Hatelist"] = "Spieler zur Hassliste hinzufuegen",
	["Add Player to Nicelist"] = "Spieler zur Nette-Leuteliste hinzufuegen",
	["Add Attacker to KoS"] = "Angreifer zur KoS-Liste hinzufügen",

	["Minimap Button"] = "Minimap Button",
	["Enabled"] = "Aktiviert",
	["Locked"] = "Sperren",
	["Reset Position"] = "Position zurücksetzen",
--	["Angle"] = "Winkel",
--	["Distance"] = "Abstand",
--
	--["Show information"] = true,
	["Show Warning Frame Infos as Text and Tooltip"] = "Warn-Fenster Infos als Text und Tooltip anzeigen",
	["Last Attackers"] = "Die letzten Angreifer",
	
	["Click to toggle the Main Window"] = "Klicken um Hauptfenster zu zeigen/verstecken",
	
	["Nearby People"] = "Nahe Spieler",
} end);

RegisterTranslations("frFR", function() return {
	["Main Window"] = "Fen\195\170tre principale",
	["Warning Window"] = "Fen\195\170tre d'avertissement",
	["Add Player to KoS"] = "Ajouter un joueur KoS",
	["Add Guild to KoS"] = "Ajouter une guilde KoS",
	["Add Player to Hatelist"] = "Ajouter un joueur \195\160 la liste noire",
	["Add Player to Nicelist"] = "Ajouter un joueur \195\160 la liste blanche",
	["Add Attacker to KoS"] = "Ajouter un attaquant en KoS",

	["Minimap Button"] = "Bouton Minicarte",
	["Enabled"] = "Actif",
	["Locked"] = "Verrouill\195\169",
	["Reset Position"] = "Remettre à zéro la position",
--	["Angle"] = "Angle",
--	["Distance"] = "Distance",
--
	--["Show information"] = true,
	["Show Warning Frame Infos as Text and Tooltip"] = "Afficher les infos de la fenêtre d'avertissement",
	["Last Attackers"] = "Derniers attaquants",
	["%s ago"] = "Il y'a %s",
	
	["Click to toggle the Main Window"] = "Clique pour afficher/cacher la fenêtre principale",
	
	["Nearby People"] = "Personnes voisines",
} end);

RegisterTranslations("koKR", function() return {
	["Main Window"] = "메인창",
	["Warning Window"] = "경고창",
	["Add Player to KoS"] = "KoS에 플레이어 추가",
	["Add Guild to KoS"] = "KoS에 길드 추가",
	["Add Player to Hatelist"] = "악인명부에 플레이어 추가",
	["Add Player to Nicelist"] = "호인명부에 플레이어 추가",
	["Add Attacker to KoS"] = "KoS에 공격자 추가",

	["Minimap Button"] = "미니맵 버튼",
	["Enabled"] = "사용",
	["Locked"] = "고정",
	["Reset Position"] = "위치 초기화",
--	["Angle"] = "각도",
--	["Distance"] = "거리",
--
	--["Show information"] = true,
	["Show Warning Frame Infos as Text and Tooltip"] = "텍스트와 툴팁으로 경고창 정보 표시",
	["Last Attackers"] = "마지막 공격자",
	["%s ago"] = "%s 이전",
	
	["Click to toggle the Main Window"] = "메인창을 열거나 닫으려면 클릭하세요.",
	
	["Nearby People"] = "근처에 있는 사람",
} end);

RegisterTranslations("esES", function() return {
	["Main Window"] = "Ventana Principal",
	["Warning Window"] = "Ventana de Aviso",
	["Add Player to KoS"] = "Añadir Jugador a KoS",
	["Add Guild to KoS"] = "Añadir Hermandad a KoS",
	["Add Player to Hatelist"] = "Añadir Jugador a Odiados",
	["Add Player to Nicelist"] = "Añadir Jugador a Simpáticos",
	["Add Attacker to KoS"] = "Añadir Atacante a KoS",

	["Minimap Button"] = "Botón del Minimapa",
	["Enabled"] = "Activado",
	["Locked"] = "Bloqueado",
	["Reset Position"] = "Reestablecer Posición",
--	["Angle"] = "Ángulo",
--	["Distance"] = "Distancia",
--
	--["Show information"] = true,
	--["Show Warning Frame Infos as Text and Tooltip"] = true,
	--["Last Attackers"] = true,
	--["%s ago"] = true,
	--["Click to toggle the Main Window"] = true,
	
	--["Nearby People"] = true,

} end);

RegisterTranslations("ruRU", function() return {
	["Main Window"] = "Главное окно",
	["Warning Window"] = "Окно предупреждений",
	["Add Player to KoS"] = "Добавить игрока в KoS",
	["Add Guild to KoS"] = "Добавить гильдию в KoS",
	["Add Player to Hatelist"] = "Добавить игрока в Ненавистных",
	["Add Player to Nicelist"] = "Добавить игрока в Хороших",
	["Add Attacker to KoS"] = "Добавить атакующего в KoS",

	["Minimap Button"] = "Кнопка на миникарте",
	["Enabled"] = "Включено",
	["Locked"] = "Зафиксировать",
	["Reset Position"] = "Сбросить расположение",
--	["Angle"] = "Угол",
--	["Distance"] = "Расстояние",
--
	--["Show information"] = true,
	["Show Warning Frame Infos as Text and Tooltip"] = "Показывать KoS/Врагов/Друзей на панели FuBar",
	["Last Attackers"] = "Последние напавшие",
	["%s ago"] = "%s назад",
	["Click to toggle the Main Window"] = "Щёлкните, чтобы открыть главное окно VanasKoS",
	
	["Nearby People"] = "Ближайшие игроки",
} end);

VanasKoSMinimapButton = VanasKoS:NewModule("MinimapButton", "AceEvent-3.0", "AceTimer-3.0");

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_MinimapButton", false);

local attackerMenu = { };

local icon = LibStub("LibDBIcon-1.0");
local ldb = LibStub:GetLibrary("LibDataBroker-1.1");
local Broker = ldb:NewDataObject("VanasKoS", {
	type = "launcher",
	icon = "Interface\\Icons\\Ability_Parry",
	OnClick = function(frame, button) VanasKoSMinimapButton:OnClick(button); end,
	OnTooltipShow = function(tt)
			VanasKoSMinimapButton:OnTooltipShow(tt);
		end
});
local tooltip = nil;

local minimapOptions = {
	{
		text = VANASKOS.NAME .. " " .. VANASKOS.VERSION,
		isTitle = true,
	},
	{
		text = L["Main Window"],
		func = function() VanasKoS:ToggleMenu(); end,
		checked = function() return VanasKoSFrame:IsVisible(); end,
	},
	{
		text = L["Warning Window"],
		func = function() VanasKoS:ToggleModuleActive("WarnFrame"); VanasKoSWarnFrame:Update(); end,
		checked = function() return VanasKoS:GetModule("WarnFrame").enabledState; end,
	},
--[[	{
		text = L["Locked"],
		func = function() VanasKoSWarnFrame.db.profile.Locked = not VanasKoSWarnFrame.db.profile.Locked; end,
		checked = function() return VanasKoSWarnFrame.db.profile.Locked; end,
	}, ]]
	{
		text = L["Add Player to KoS"],
		func = function() VanasKoS:AddEntryFromTarget("PLAYERKOS"); end,
	},
	{
		text = L["Add Guild to KoS"],
		func = function() VanasKoS:AddEntryFromTarget("GUILDKOS"); end,
	},
	{
		text = L["Add Player to Hatelist"],
		func = function() VanasKoS:AddEntryFromTarget("HATELIST"); end,
	},
	{
		text = L["Add Player to Nicelist"],
		func = function() VanasKoS:AddEntryFromTarget("NICELIST"); end,
	},
	{
		text = L["Add Attacker to KoS"],
		hasArrow = true;
		menuList = attackerMenu;
	},
};


function VanasKoSMinimapButton:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("MinimapButton", {
		profile = {
			Enabled = true,
			Moved = false,
			ShowWarnFrameInfoText = true,
			button = {
			},
		}
	});

	self.name = "VanasKoSMinimapButton";

	icon:Register(self.name, Broker, self.db.profile.button);
	
	VanasKoSGUI:AddConfigOption("VanasKoS-MinimapButton", {
			type = 'group',
			name = L["Minimap Button"],
			desc = L["Minimap Button"],
			args = {
				enabled = {
					type = 'toggle',
					name = L["Enabled"],
					desc = L["Enabled"],
					order = 1,
					set = function(frame, v) VanasKoS:ToggleModuleActive("MinimapButton"); end,
					get = function() return VanasKoS:GetModule("MinimapButton").enabledState; end,
				},
				showInfo = {
					type = 'toggle',
					name = L["Show information"],
					desc = L["Show Warning Frame Infos as Text and Tooltip"],
					order = 2,
					set = function(frame, v)
						VanasKoSMinimapButton.db.profile.ShowWarnFrameInfoText = v;
						if (v) then
							VanasKoSMinimapButton:EnableWarnFrameText();
						else
							VanasKoSMinimapButton:EnableWarnFrameText();
						end
					end,
					get = function() return VanasKoSMinimapButton.db.profile.ShowWarnFrameInfoText; end,
				},
--[[				reset = {
					type = 'execute',
					name = L["Reset Position"],
					desc = L["Reset Position"],
					order = 2,
					func = function() VanasKoSMinimapButton:ResetPosition(); end,
				},
				angle = {
					type = 'range',
					name = L["Angle"],
					desc = L["Angle"],
					min = 0,
					max = 360,
					step = 1,
					set = function(frame, value) VanasKoSMinimapButton:SetAngle(value); VanasKoSMinimapButton.db.profile.Angle = value; end,
					get = function() return VanasKoSMinimapButton.db.profile.Angle; end,
				},
				distance = {
					type = 'range',
					name = L["Distance"],
					desc = L["Distance"],
					min = 40,
					max = 150,
					step = 1,
					set = function(frame, value) VanasKoSMinimapButton:SetDist(value); VanasKoSMinimapButton.db.profile.Dist = value; end,
					get = function() return VanasKoSMinimapButton.db.profile.Dist; end,
				} ]]--
			}
		});

	minimapOptions[1].text = VANASKOS.NAME .. " " .. VANASKOS.VERSION;
	icon:Hide(self.name);
	self:SetEnabledState(self.db.profile.Enabled);
end

--[[
function VanasKoSMinimapButton:SetAngle(newang)
	ang = newang;
	self:SetPosition();
end

function VanasKoSMinimapButton:SetDist(newdist)
	r = newdist;
	self:SetPosition();
end
]]

function VanasKoSMinimapButton:Toggle()
	if(icon:IsVisible()) then
		icon:Hide(self.name);
	else
		icon:Show(self.name);
	end
end

function VanasKoSMinimapButton:UpdateOptions()
	local list = VanasKoSPvPDataGatherer:GetDamageFromArray();

	wipe(attackerMenu);
	if(not list) then
		return;
	end

	for k,v in pairs(list) do
		attackerMenu[#attackerMenu+1] = {
			text = v[1] .. " " .. date("%c", v[2]),
			order = #attackerMenu,
			func = function()
					VanasKoSGUI:ShowList("PLAYERKOS");
					VANASKOS.LastNameEntered = v[1];
					StaticPopup_Show("VANASKOS_ADD_REASON_ENTRY");
				end,
		};
	end
end

function VanasKoSMinimapButton:OnClick()
	if(arg1 == "LeftButton" and not IsShiftKeyDown()) then
		VanasKoSMinimapButton:UpdateOptions();
		local x, y = GetCursorPosition();
		local uiScale = UIParent:GetEffectiveScale();
		EasyMenu(minimapOptions, VanasKoSGUI.dropDownFrame, UIParent, x/uiScale, y/uiScale, "MENU");
	end
	if(arg1 == "RightButton") then
		VanasKoS:AddEntryFromTarget("PLAYERKOS");
	end
end

function VanasKoSMinimapButton:OnEnable()
	self.db.profile.button.hide = nil;
	icon:Show(self.name);
	if(self.db.profile.ShowWarnFrameInfoText) then
		self:EnableWarnFrameText();
		if(timer == nil) then
			timer = self:ScheduleRepeatingTimer("UpdateList", 1);
		end
	end
end

function VanasKoSMinimapButton:OnDisable()
	self.db.profile.button.hide = true;
	icon:Hide(self.name);
	self:CancelAllTimers();
	if(self.db.profile.ShowWarnFrameInfoText) then
		self:DisableWarnFrameText();
	end
end

local showWarnFrameInfoText = false;

function VanasKoSMinimapButton:EnableWarnFrameText()
	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected");
	showWarnFrameInfoText = true;
	self:UpdateMyText();
end

function VanasKoSMinimapButton:DisableWarnFrameText()
	self:UnregisterMessage("VanasKoS_Player_Detected");
	showWarnFrameInfoText = false;
	Broker.text = nil;
end

local NOTIFYTIMERINTERVAL = 60;
local nearbyKoS = { };
local nearbyEnemies = { };
local nearbyFriendly = { };
local nearbyKoSCount = 0;
local nearbyEnemyCount = 0;
local nearbyFriendlyCount = 0;

function VanasKoSMinimapButton:Player_Detected(message, data)
	assert(data.name ~= nil);

	local name = data.name:trim():lower();
	local faction = data.faction;

	-- exclude unknown entitity entries
	if(name == UNKNOWNLOWERCASE) then
		return;
	end

	if(name == nil or showWarnFrameInfoText == false) then
		return;
	end

	if(faction == "kos") then
		if(not nearbyKoS[name]) then
			nearbyKoSCount = nearbyKoSCount + 1;
		end
		nearbyKoS[name] = time();
	elseif(faction == "enemy") then
		if(not nearbyEnemies[name]) then
			nearbyEnemyCount = nearbyEnemyCount + 1;
		end
		nearbyEnemies[name] = time();
	elseif(faction == "friendly") then
		if(not nearbyFriendly[name]) then
			nearbyFriendlyCount = nearbyFriendlyCount + 1;
		end
		nearbyFriendly[name] = time();
	else
		return;
	end
	self:UpdateMyText();
end


function VanasKoSMinimapButton:RemovePlayer(name)
	if (nearbyKoS[name]) then
		nearbyKoS[name] = nil;
		nearbyKoSCount = nearbyKoSCount - 1;
	end
	if (nearbyEnemies[name]) then
		nearbyEnemies[name] = nil;
		nearbyEnemyCount = nearbyEnemyCount - 1;
	end
	if (nearbyFriendly[name]) then
		nearbyFriendly[name] = nil;
		nearbyFriendlyCount = nearbyFriendlyCount - 1;
	end
	self:UpdateMyText();
end

local text = "";

function VanasKoSMinimapButton:UpdateMyText()
	Broker.text = "|cffff00ff" .. nearbyKoSCount .. "|r |cffff0000" .. nearbyEnemyCount .. "|r |cff00ff00" .. nearbyFriendlyCount .. "|r";
end

function VanasKoSMinimapButton:OnTooltipShow(tt)
	local list = VanasKoSPvPDataGatherer:GetDamageFromArray();

	tt:AddLine(VANASKOS.NAME);
	if (#list > 0) then
		tt:AddLine(L["Last Attackers"] .. ":", 1.0, 1.0, 1.0);
						
		for k,v in pairs(list) do
			tt:AddDoubleLine(v[1], format(L["%s ago"], SecondsToTime(time() - v[2])), 1.0, 0.0, 0.0, 1.0, 1.0, 1.0);
		end
	end
	
	
	if(showWarnFrameInfoText and (nearbyKoSCount + nearbyEnemyCount + nearbyFriendlyCount) > 0) then
		tt:AddLine(L["Nearby People"] .. ":", 1.0, 1.0, 1.0);
		for k,v in pairs(nearbyKoS) do
			tt:AddLine(string.Capitalize(k), 1.0, 0.0, 1.0);
		end
		for k,v in pairs(nearbyEnemies) do
			tt:AddLine(string.Capitalize(k), 1.0, 0.0, 0.0);
		end
		for k,v in pairs(nearbyFriendly) do
			tt:AddLine(string.Capitalize(k), 0.0, 1.0, 0.0);
		end
	end
end

function VanasKoSMinimapButton:UpdateList()
	local t = time();
	for k, v in pairs(nearbyKoS) do
		if(t-v > 60) then
			self:RemovePlayer(k);
		end
	end
	for k, v in pairs(nearbyEnemies) do
		if(t-v > 10) then
			self:RemovePlayer(k);
		end
	end
	for k, v in pairs(nearbyFriendly) do
		if(t-v > 10) then
			self:RemovePlayer(k);
		end
	end
	
	VanasKoSWarnFrame:Update();
end
