--[[----------------------------------------------------------------------
      MinimapButton Module - Part of VanasKoS
Creates a MinimapButton with a menu for VanasKoS
------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.2"):new("VanasKoSMinimapButton");

L:RegisterTranslations("enUS", function() return {
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

L:RegisterTranslations("deDE", function() return {
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

L:RegisterTranslations("frFR", function() return {
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

L:RegisterTranslations("koKR", function() return {
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

L:RegisterTranslations("esES", function() return {
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

L:RegisterTranslations("ruRU", function() return {
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

local dewdrop = AceLibrary("Dewdrop-2.0");
local ang = 290
local r = 75;

local minimapOptions = {
	type = 'group',
	args = {
		header = {
			type = 'header',
			name = VANASKOS.NAME .. " " .. VANASKOS.VERSION,
			order = 1,
		},
		mainwindow = {
			type = 'toggle',
			name = L["Main Window"],
			desc = L["Main Window"],
			order = 2,
			set = function() VanasKoS:ToggleMenu(); end,
			get = function() return VanasKoSFrame:IsVisible(); end,
		},
		warningwindow = {
			type = 'toggle',
			name = L["Warning Window"],
			desc = L["Warning Window"],
			order = 3,
			set = function(v) VanasKoSWarnFrame.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("WarnFrame", v); VanasKoSWarnFrame:Update(); end,
			get = function() return VanasKoSWarnFrame.db.profile.Enabled; end,
		},
		locked = {
			type = 'toggle',
			name = L["Locked"],
			desc = L["Locked"],
			order = 4,
			set = function(v) VanasKoSWarnFrame.db.profile.Locked = v; end,
			get = function() return VanasKoSWarnFrame.db.profile.Locked; end,
		},
		addplayerkos = {
			type = 'execute',
			name = L["Add Player to KoS"],
			desc = L["Add Player to KoS"],
			order = 5,
			func = function() VanasKoS:AddEntryFromTarget("PLAYERKOS"); end,
		},
		addguildkos = {
			type = 'execute',
			name = L["Add Guild to KoS"],
			desc = L["Add Guild to KoS"],
			order = 6,
			func = function()
						VanasKoS:AddEntryFromTarget("GUILDKOS");
				end,
		},
		addhatelist = {
			type = 'execute',
			name = L["Add Player to Hatelist"],
			desc = L["Add Player to Hatelist"],
			order = 7,
			func = function() VanasKoS:AddEntryFromTarget("HATELIST"); end,
		},
		addnicelist = {
			type = 'execute',
			name = L["Add Player to Nicelist"],
			desc = L["Add Player to Nicelist"],
			order = 8,
			func = function() VanasKoS:AddEntryFromTarget("NICELIST"); end,
		},
		addattacker = {
			type = 'group',
			name = L["Add Attacker to KoS"],
			desc = L["Add Attacker to KoS"],
			order = 9,
			args = {
			},
		},
	}
};


function VanasKoSMinimapButton:OnInitialize()
	VanasKoS:RegisterDefaults("MinimapButton", "profile", {
		Enabled = true,
		Locked = false,
		Moved = false,
	});

	self.db = VanasKoS:AcquireDBNamespace("MinimapButton");

	local name = "VanasKoS_MinimapButton";
	self.frame = CreateFrame("Button", name, Minimap);

	local frame = self.frame;

	frame:SetWidth(31);
	frame:SetHeight(31);
	frame:SetFrameStrata("LOW");
	frame:SetToplevel(1);
	frame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
	frame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT");
	frame:SetMovable(true);

	local button = frame:CreateTexture(name .. "Texture", "BACKGROUND");
	button:SetTexture("Interface\\Icons\\Ability_Parry");
	button:SetWidth(20);
	button:SetHeight(20);
	button:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -5);

	local overlay = frame:CreateTexture(name .. "Overlay", "OVERLAY");
	overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder");
	overlay:SetWidth(53);
	overlay:SetHeight(53);
	overlay:SetPoint("TOPLEFT", frame, "TOPLEFT");

	dewdrop:Register(frame,
			'children', minimapOptions,
			'dontHook', true);

	frame:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	frame:RegisterForDrag("LeftButton");

	frame:SetScript("OnClick", self.OnClick);
	frame:SetScript("OnDragStart",
								function()
									if(VanasKoSWarnFrame.db.profile.Locked) then
										return;
									end
									if(IsShiftKeyDown()) then
										frame:StartMoving();
									end
								end);
	frame:SetScript("OnDragStop",
								function()
									frame:StopMovingOrSizing();
									VanasKoSMinimapButton.db.profile.Moved = true;
								end);

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
					set = function(v) VanasKoSMinimapButton.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("MinimapButton", v); end,
					get = function() return VanasKoSMinimapButton.db.profile.Enabled; end,
				},
				reset = {
					type = 'execute',
					name = L["Reset Position"],
					desc = L["Reset Position"],
					order = 3,
					func = function() VanasKoSMinimapButton:ResetPosition(); end,
				},
--[[				angle = {
					type = 'range',
					name = L["Angle"],
					desc = L["Angle"],
					min = 0,
					max = 360,
					step = 1,
					set = function(value) VanasKoSMinimapButton:SetAngle(value); VanasKoSMinimapButton.db.profile.Angle = value; end,
					get = function() return VanasKoSMinimapButton.db.profile.Angle; end,
				},
				distance = {
					type = 'range',
					name = L["Distance"],
					desc = L["Distance"],
					min = 40,
					max = 150,
					step = 1,
					set = function(value) VanasKoSMinimapButton:SetDist(value); VanasKoSMinimapButton.db.profile.Dist = value; end,
					get = function() return VanasKoSMinimapButton.db.profile.Dist; end,
				} ]]--
			}
		});

	self.frame:Hide();
end

function VanasKoSMinimapButton:SetPosition()
	self.frame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 58 - (r * cos(ang)), (r * sin(ang)) - 58);

	self.db.profile.Moved = false;
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
	if(self.frame:IsVisible()) then
		self.frame:Hide();
	else
		self.frame:Show();
	end
end

function VanasKoSMinimapButton:UpdateOptions()
	local list = VanasKoSPvPDataGatherer:GetDamageFromArray();

	minimapOptions.args.addattacker.args = { };
	for k,v in pairs(list) do
		minimapOptions.args.addattacker.args[k] = {
			type = 'execute',
			name = v[1] .. " " .. date("%c", v[2]),
			desc = v[1] .. " " .. date("%c", v[2]),
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
		dewdrop:Open(VanasKoSMinimapButton.frame);
	end
	if(arg1 == "RightButton") then
		VanasKoS:AddEntryFromTarget("PLAYERKOS");
	end
end

function VanasKoSMinimapButton:OnEnable()
	if(not self.db.profile.Enabled) then
		return;
	end

	minimapOptions.args.header.name = VANASKOS.NAME .. " " .. VANASKOS.VERSION;
	if(not self.db.profile.Moved) then
		self:ResetPosition();
	end

	self.frame:Show();
end

function VanasKoSMinimapButton:ResetPosition()
	self.frame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 58 - (r * cos(ang)), (r * sin(ang)) - 58);
end

function VanasKoSMinimapButton:OnDisable()
	self.frame:Hide();
end

