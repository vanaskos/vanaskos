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
} end);

VanasKoSMinimapButton = VanasKoS:NewModule("MinimapButton");

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_MinimapButton", false);

local attackerMenu = { };

local icon = LibStub("LibDBIcon-1.0");
local ldb = LibStub:GetLibrary("LibDataBroker-1.1");
local Broker = ldb:NewDataObject("VanasKoS", {
	type = "launcher",
	icon = "Interface\\Icons\\Ability_Parry",
	OnClick = function(frame, button) VanasKoSMinimapButton:OnClick(button); end,
	OnTooltipShow = function(tt)
			tt:AddLine("VanasKoS");
		end
});

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
			button = {
			},
		}
	});

	self.name = "VanasKoSMinimapButton";

	icon:Register(self.name, Broker, self.db.profile.button);
	
	VanasKoSGUI:AddConfigOption("MinimapButton", {
			type = 'group',
			name = L["Minimap Button"],
			desc = L["Minimap Button"],
			args = {
				enabled = {
					type = 'toggle',
					name = L["Enabled"],
					desc = L["Enabled"],
					order = 1,
					set = function(frame, v) VanasKoSMinimapButton.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("MinimapButton"); end,
					get = function() return VanasKoS:GetModule("MinimapButton").enabledState; end,
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

	attackerMenu = { };
	if(not list) then
		return;
	end

	for k,v in pairs(list) do
		attackerMenu[#attackerMenu+1] = {
			name = v[1] .. " " .. date("%c", v[2]),
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
	if(not self.db.profile.Enabled) then
		self:Disable();
		return;
	end
	
	icon:Show(self.name);
end

function VanasKoSMinimapButton:OnDisable()
	icon:Hide(self.name);
end

