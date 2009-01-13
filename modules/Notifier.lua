--[[----------------------------------------------------------------------
      Notifier Module - Part of VanasKoS
Notifies the user via Tooltip, Chat and Upper Area of a KoS/other List Target
------------------------------------------------------------------------]]

VanasKoSNotifier = VanasKoS:NewModule("Notifier", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0");
local VanasKoSNotifier = VanasKoSNotifier;
local VanasKoS = VanasKoS;

local FADE_IN_TIME = 0.2;
local FADE_OUT_TIME = 0.2;
local FLASH_TIMES = 1;

local SML = LibStub("LibSharedMedia-3.0");
SML:Register("sound", "VanasKoS: String fading", "Interface\\AddOns\\VanasKoS\\Artwork\\StringFading.mp3");
SML:Register("sound", "VanasKoS: Zoidbergs whooping", "Interface\\AddOns\\VanasKoS\\Artwork\\Zoidberg-Whoopwhoopwhoop.mp3");

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Notifier", "enUS", true);
if L then
	L["Enemy Detected:|cffff0000"] = true;
	L["KoS: %s"] = "KoS: %s";
	L["KoS (Guild): %s"] = "KoS (Guild): %s";
	L["Nicelist: %s"] = "Nicelist: %s";
	L["Hatelist: %s"] = "Hatelist: %s";
	L["Wanted: %s"] = "Wanted: %s";
	L["%sKoS: %s"] = "|cffff00ff%s's|r KoS: %s";
	L["%sKoS (Guild): %s"] = "|cffff00ff%s's|r KoS (Guild): %s";
	L["%sNicelist: %s"] = "|cffff00ff%s's|r Nicelist: %s";
	L["%sHatelist: %s"] = "|cffff00ff%s's|r Hatelist: %s";
	L["%sWanted: %s"] = "|cffff00ff%s's|r Wanted: %s";

	L["Notifications"] = true;
	L["Notification in the Upper Area"] = true;
	L["Notification in the Chatframe"] = true;
	L["Notification through Target Portrait"] = true;
	L["Notification through flashing Border"] = true;
	L["Notify only on my KoS-Targets"] = true;
	L["Notify of any enemy target"] = true;
	L["Notify in Sanctuary"] = true;
	L["Additional Reason Window"] = true;
	L["Locked"] = true;

	L["Sound on KoS detection"] = true;
	L["Sound on enemy detection"] = true;
	L["Notification Interval (seconds)"] = true;
	L["Enabled"]  = true;
	L["None"] = true;
	L["wins: %d - losses: %d"] = "wins: |cff00ff00%d|r losses: |cffff0000%d|r";
	L["Show PvP-Stats in Tooltip"] = true;
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Notifier", "deDE", false);
if L then
	L["KoS: %s"] = "KoS: %s";
	L["KoS (Guild): %s"] = "KoS (Gilde): %s";
	L["Nicelist: %s"] = "Nette-Leute Liste: %s";
	L["Hatelist: %s"] = "Hassliste: %s";
	L["Wanted: %s"] = "Gesucht: %s";
	L["%sKoS: %s"] = "|cffff00ff%ss|r KoS: %s";
	L["%sKoS (Guild): %s"] = "|cffff00ff%ss|r KoS (Gilde): %s";
	L["%sNicelist: %s"] = "|cffff00ff%ss|r Nette-Leute Liste: %s";
	L["%sHatelist: %s"] = "|cffff00ff%ss|r Hassliste: %s";
	L["%sWanted: %s"] = "|cffff00ff%s's|r Gesucht-Liste: %s";

	L["Notifications"] = "Benachrichtigungen";
	L["Notification in the Upper Area"] = "Benachrichtigung im oberen Bereich";
	L["Notification in the Chatframe"] = "Benachrichtigung im Chat-Fenster";
	L["Notification through Target Portrait"] = "Benachrichtigung durch aendern des Ziel-Fensters";
	L["Notification through flashing Border"] = "Benachrichtigung durch Aufleuchten des Rahmens";
	L["Notify only on my KoS-Targets"] = "Nur bei meinen KoS-Zielen benachrichtigen";
	L["Notify in Sanctuary"] = "In friedlichen Gebieten benachrichtigen";
	L["Additional Reason Window"] = "Extra Grund Fenster";
	L["Locked"] = "Sperren";

	L["Notify only on my KoS-Targets"] = "Nur meine KoS-Ziele benachrichtigen";
	L["Sound on KoS detection"] = "Audio Benachrichtigung bei KoS";
	L["Notification Interval (seconds)"] = "Benachrichtigungs Interval (Sekunden)";
	L["Enabled"] = "Aktiviert";
	L["None"] = "Keiner";
	L["wins: %d - losses: %d"] = "gewonnen: |cff00ff00%d|r verloren: |cffff0000%d|r";
	L["Show PvP-Stats in Tooltip"] = "Anzeigen von PvP-Statistiken im Tooltip";
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Notifier", "frFR", false);
if L then
	L["KoS: %s"] = "KoS: %s";
	L["KoS (Guild): %s"] = "KoS (Guilde): %s";
	L["Nicelist: %s"] = "Liste blanche: %s";
	L["Hatelist: %s"] = "Liste noire: %s";
	L["Wanted: %s"] = "Wanted: %s";
	L["%sKoS: %s"] = "KoS à |cffff00ff%s|r: %s";
	L["%sKoS (Guild): %s"] = "KoS (Guilde) à |cffff00ff%s|r: %s";
	L["%sNicelist: %s"] = "Liste blanche à |cffff00ff%s|r: %s";
	L["%sHatelist: %s"] = "Liste noire à |cffff00ff%s|r: %s";
	L["%sWanted: %s"] = "|cffff00ff%s's|r Wanted: %s";

	L["Notifications"] = "Notifications";
	L["Notification in the Upper Area"] = "Notification en message principal central";
	L["Notification in the Chatframe"] = "Notification dans la fen\195\170tre de discussion";
	L["Notification through Target Portrait"] = "Notification avec portrait (dragon élite)";
	L["Notification through flashing Border"] = "Notification avec bordure flash";
	L["Notify only on my KoS-Targets"] = "Notification de mes propres cibles seulement";
--	L["Notify in Sanctuary"] = true;
	L["Additional Reason Window"] = "Fenêtre additionnelle de raison";
	L["Locked"] = "Verrouill\195\169";

	L["Sound on KoS detection"] = "Son de d\195\169tection KoS";
	L["Notification Interval (seconds)"] = "Intervalle entre notifications (secondes)";
	L["Enabled"] = "Actif";
	L["None"] = "Aucun";
	L["wins: %d - losses: %d"] = "victoires: |cff00ff00%d|r d\195\169faites: |cffff0000%d|r";
	L["Show PvP-Stats in Tooltip"] = "Afficher PvP-Stats dans le Tooltip";
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Notifier", "koKR", false);
if L then
	L["KoS: %s"] = "KoS: %s";
	L["KoS (Guild): %s"] = "KoS (길드): %s";
	L["Nicelist: %s"] = "호인명부: %s";
	L["Hatelist: %s"] = "악인명부: %s";
	L["Wanted: %s"] = "수배: %s";
	L["%sKoS: %s"] = "|cffff00ff%s|r의 KoS: %s";
	L["%sKoS (Guild): %s"] = "|cffff00ff%s|r의 KoS (길드): %s";
	L["%sNicelist: %s"] = "|cffff00ff%s|r의 호인명부: %s";
	L["%sHatelist: %s"] = "|cffff00ff%s|r의 악인명부: %s";
	L["%sWanted: %s"] = "|cffff00ff%s|r의 수배: %s";

	L["Notifications"] = "알림";
	L["Notification in the Upper Area"] = "상단 영역에 알림";
	L["Notification in the Chatframe"] = "대화창에 알림";
	L["Notification through Target Portrait"] = "대상 사진을 통해 알림";
	L["Notification through flashing Border"] = "테두리 반짝임을 통해 알림";
	L["Notify only on my KoS-Targets"] = "나의 KoS-대상일 경우만 알림";
--	L["Notify in Sanctuary"] = true;
	L["Additional Reason Window"] = "이유창 추가";
	L["Locked"] = "고정";

	L["Sound on KoS detection"] = "KoS 발견 효과음";
	L["Notification Interval (seconds)"] = "알림 간격(초)";
	L["Enabled"]  = "사용";
	L["None"] = "없음";
	L["wins: %d - losses: %d"] = "승: |cff00ff00%d|r 패: |cffff0000%d|r";
	L["Show PvP-Stats in Tooltip"] = "툴팁에 PvP-현황 표시";
end


L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Notifier", "esES", false);
if L then
	L["KoS: %s"] = "KoS: %s";
	L["KoS (Guild): %s"] = "KoS (Hermandad): %s";
	L["Nicelist: %s"] = "Simpático: %s";
	L["Hatelist: %s"] = "Odiado: %s";
	L["Wanted: %s"] = "Se Busca: %s";
	L["%sKoS: %s"] = "KoS de |cffff00ff%s|: %s";
	L["%sKoS (Guild): %s"] = "KoS (Hermandad) de |cffff00ff%s|r: %s";
	L["%sNicelist: %s"] = "Simpático de |cffff00ff%s|r: %s";
	L["%sHatelist: %s"] = "Odiado de |cffff00ff%s|r: %s";
	L["%sWanted: %s"] = "Se Busca de |cffff00ff%s|r: %s";

	L["Notifications"] = "Notificaciones";
	L["Notification in the Upper Area"] = "Notificar en el área superior";
	L["Notification in the Chatframe"] = "Notificar en la ventana de chat";
	L["Notification through Target Portrait"] = "Notificar mediante el retrato del Objetivo";
	L["Notification through flashing Border"] = "Notificar mediante borde intermitente";
	L["Notify only on my KoS-Targets"] = "Notificar solo mis objetivos de KoS";
--	L["Notify in Sanctuary"] = true;
	L["Additional Reason Window"] = "Ventana adicional de Razón";
	L["Locked"] = "Bloqueado";

	L["Sound on KoS detection"] = "Sonido al detectar KoS";
	L["Notification Interval (seconds)"] = "Intervalo de notificación (segundos)";
	L["Enabled"]  = "Activado";
	L["None"] = "Ninguno";
	L["wins: %d - losses: %d"] = "ganados: |cff00ff00%d|r perdidos: |cffff0000%d|r";
	L["Show PvP-Stats in Tooltip"] = "Mostrar las estadísticas de JcJ en el tooltip";
end

L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_Notifier", "ruRU", false);
if L then
	L["KoS: %s"] = "KoS: %s";
	L["KoS (Guild): %s"] = "KoS (Гильдия): %s";
	L["Nicelist: %s"] = "Хороший: %s";
	L["Hatelist: %s"] = "Ненавистный: %s";
	L["Wanted: %s"] = "Розыск: %s";
	L["%sKoS: %s"] = "KoS |cffff00ff%s'а|r: %s";
	L["%sKoS (Guild): %s"] = "KoS (Гильдия) |cffff00ff%s'а|r: %s";
	L["%sNicelist: %s"] = "Хороший |cffff00ff%s'а|r: %s";
	L["%sHatelist: %s"] = "Ненавистный |cffff00ff%s'а|r: %s";
	L["%sWanted: %s"] = "Розыск |cffff00ff%s'а|r: %s";

	L["Notifications"] = "Уведомления";
	L["Notification in the Upper Area"] = "Уведомление в Верхней части";
	L["Notification in the Chatframe"] = "Уведомление в Окне чата";
	L["Notification through Target Portrait"] = "Уведомление через Портрет цели";
	L["Notification through flashing Border"] = "Уведомлять мерцанием краев экрана";
	L["Notify only on my KoS-Targets"] = "Уведомлять только о моих KoS-целях";
--	L["Notify in Sanctuary"] = true;
	L["Additional Reason Window"] = "Дополнительное окно Причин";
	L["Locked"] = "Зафиксировано";

	L["Sound on KoS detection"] = "Звук при обнаружении KoS";
	L["Notification Interval (seconds)"] = "Интевал Уведомлений (в секундах)";
	L["Enabled"]  = "Включено";
	L["None"] = "Нет";
	L["wins: %d - losses: %d"] = "побед: |cff00ff00%d|r поражений: |cffff0000%d|r";
	L["Show PvP-Stats in Tooltip"] = "Показывать PvP-статистику в Тултипе";
end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_Notifier", false);

local notifyAllowed = true;
local flashNotifyFrame = nil;

function VanasKoSNotifier:UpdateAndCreateReasonFrame()
	if(self.db.profile.notifyExtraReasonFrameEnabled) then
		local reasonFrame = nil;
		if(VanasKoS_Notifier_ReasonFrame ~= nil) then
			reasonFrame = VanasKoS_Notifier_ReasonFrame;
		else
			reasonFrame = CreateFrame("Frame", "VanasKoS_Notifier_ReasonFrame");
		end
		reasonFrame:SetWidth(300);
		reasonFrame:SetHeight(13);
		reasonFrame:SetPoint("CENTER");
		reasonFrame:SetMovable(true);
		reasonFrame:SetToplevel(true);

		local background = nil;
		if(VanasKoS_Notifier_ReasonFrame_Background ~= nil) then
			background = VanasKoS_Notifier_ReasonFrame_Background;
		end

		if(not self.db.profile.notifyExtraReasonFrameLocked) then
			if(background == nil) then
				background = reasonFrame:CreateTexture("VanasKoS_Notifier_ReasonFrame_Background", "BACKGROUND");
			end

			background:SetAllPoints();
			background:SetTexture(1.0, 1.0, 1.0, 0.5);
		else
			if(background) then
				background:SetAlpha(0);
			end
		end

		local text = nil;
		if(VanasKoS_Notifier_ReasonFrame_Text ~= nil) then
			text = VanasKoS_Notifier_ReasonFrame_Text;
		else
			text = reasonFrame:CreateFontString("VanasKoS_Notifier_ReasonFrame_Text", "OVERLAY");
		end

		-- only set the left point, so texts longer than reasonFrame:GetWidth() will show
		text:SetPoint("LEFT", reasonFrame, "LEFT", 0, 0);
		text:SetJustifyH("LEFT");
		text:SetFontObject("GameFontNormalSmall");

		if(not self.db.profile.notifyExtraReasonFrameLocked) then
			text:SetTextColor(1.0, 0.0, 1.0);
			text:SetText(self:GetKoSString(nil, "Guild", "MyReason", UnitName("player"), nil, "GuildKoS Reason", UnitName("player"), nil));
		end

		reasonFrame:EnableMouse(true);
		reasonFrame:RegisterForDrag("LeftButton");
		reasonFrame:SetScript("OnDragStart", function()
									if(not VanasKoSNotifier.db.profile.notifyExtraReasonFrameLocked) then
										reasonFrame:StartMoving();
									end
							end);
		reasonFrame:SetScript("OnDragStart", function()
									if(not VanasKoSNotifier.db.profile.notifyExtraReasonFrameLocked) then
										reasonFrame:StartMoving();
									end
							end);
		reasonFrame:SetScript("OnDragStop",
								function()
									reasonFrame:StopMovingOrSizing();
								end);
	else
		if(VanasKoS_Notifier_ReasonFrame ~= nil) then
			VanasKoS_Notifier_ReasonFrame:Hide();
		end
	end
end

local function SetSound(faction, value)
	if (faction == "enemy") then
		VanasKoSNotifier.db.profile.enemyPlayName = value;
	else
		VanasKoSNotifier.db.profile.playName = value;
	end
	
	VanasKoSNotifier:PlaySound(value);
end

local function GetSound(faction)
	if (faction == "enemy") then
		return VanasKoSNotifier.db.profile.enemyPlayName;
	else
		return VanasKoSNotifier.db.profile.playName;
	end
end

local mediaList = { };
local function GetMediaList()
	for k,v in pairs(SML:List("sound")) do
		mediaList[v] = v;
	end
	
	return mediaList;
end

function VanasKoSNotifier:OnInitialize()
	
	self.db = VanasKoS.db:RegisterNamespace("Notifier", {
		profile = {
			Enabled = true,
			notifyVisual = true,
			notifyChatframe = true,
			notifyTargetFrame = true,
			notifyOnlyMyTargets = true,
			notifyEnemyTargets = false,
			notifyFlashingBorder = true,
			notifyInShattrathEnabled = false,
			notifyExtraReasonFrameEnabled = false,
			notifyExtraReasonFrameLocked = false,
			notifyShowPvPStats = true,

			NotifyTimerInterval = 60,

			playName = "VanasKoS: String fading",
			enemyPlayName = "None",
		}
	});

	flashNotifyFrame = CreateFrame("Frame", "VanasKoS_Notifier_Frame", WorldFrame);
	flashNotifyFrame:SetAllPoints();
	flashNotifyFrame:SetToplevel(1);
	flashNotifyFrame:SetAlpha(0);

	local texture = flashNotifyFrame:CreateTexture(nil, "BACKGROUND");
	texture:SetTexture("Interface\\AddOns\\VanasKoS\\Artwork\\KoSFrame");

	texture:SetBlendMode("ADD");
	texture:SetAllPoints(); -- important! gets set in the blizzard xml stuff implicit, while we have to do it explicit with .lua
	flashNotifyFrame:Hide();

	self:UpdateAndCreateReasonFrame();

	local configOptions = {
		type = 'group',
		name = L["Notifications"],
		desc = L["Notifications"],
		args = {
			enabled = {
				type = 'toggle',
				name = L["Enabled"],
				desc = L["Enabled"],
				order = 1,
				set = function(frame, v) VanasKoSNotifier.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("Notifier"); end,
				get = function() return VanasKoSNotifier.db.profile.Enabled; end,
			},
			upperarea = {
				type = 'toggle',
				name = L["Notification in the Upper Area"],
				desc = L["Notification in the Upper Area"],
				order = 2,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyVisual = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyVisual; end,
			},
			chatframe = {
				type = 'toggle',
				name = L["Notification in the Chatframe"],
				desc = L["Notification in the Chatframe"],
				order = 3,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyChatframe = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyChatframe; end,
			},
			targetframe = {
				type = 'toggle',
				name = L["Notification through Target Portrait"],
				desc = L["Notification through Target Portrait"],
				order = 4,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyTargetFrame = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyTargetFrame; end,
			},
			flashingborder = {
				type = 'toggle',
				name = L["Notification through flashing Border"],
				desc = L["Notification through flashing Border"],
				order = 5,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyFlashingBorder = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyFlashingBorder; end,
			},
			onlymytargets = {
				type = 'toggle',
				name = L["Notify only on my KoS-Targets"],
				desc = L["Notify only on my KoS-Targets"],
				order = 7,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyOnlyMyTargets = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyOnlyMyTargets; end,
			},
			notifyenemy = {
				type = 'toggle',
				name = L["Notify of any enemy target"],
				desc = L["Notify of any enemy target"],
				order = 7,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyEnemyTargets = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyEnemyTargets; end,
			},
			insanctuary = {
				type = 'toggle',
				name = L["Notify in Sanctuary"],
				desc = L["Notify in Sanctuary"],
				order = 8,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyInShattrathEnabled = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyInShattrathEnabled; end,
			},
			showpvpstats = {
				type = 'toggle',
				name = L["Show PvP-Stats in Tooltip"],
				desc = L["Show PvP-Stats in Tooltip"],
				order = 9,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyShowPvPStats = v; end,
				get = function() return VanasKoSNotifier.db.profile.notifyShowPvPStats; end,
			},
			notificationInterval = {
				type = 'range',
				name = L["Notification Interval (seconds)"],
				desc = L["Notification Interval (seconds)"],
				min = 0,
				max = 600,
				step = 5,
				order = 10,
				set = function(frame, value) VanasKoSNotifier.db.profile.NotifyTimerInterval = value; end,
				get = function() return VanasKoSNotifier.db.profile.NotifyTimerInterval; end,
			},
			kosSound = {
				type = 'select',
				name = L["Sound on KoS detection"],
				desc = L["Sound on KoS detection"],
				order = 11,
				get = function() return GetSound("kos"); end,
				set = function(frame, value) SetSound("kos", value); end,
				values = GetMediaList();
			},
			enemySound = {
				type = 'select',
				name = L["Sound on enemy detection"],
				desc = L["Sound on enemy detection"],
				order = 12,
				get = function() return GetSound("enemy"); end,
				set = function(frame, value) SetSound("enemy", value); end,
				values = GetMediaList();
			},
			extrareasonframetitle = {
				type = 'header',
				name = L["Additional Reason Window"],
				desc = L["Additional Reason Window"],
				order = 13,
			},
			extrareasonframeenabled = {
				type = 'toggle',
				name = L["Enabled"],
				desc = L["Enabled"],
				order = 14,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyExtraReasonFrameEnabled = v; VanasKoSNotifier:UpdateAndCreateReasonFrame(); end,
				get = function() return VanasKoSNotifier.db.profile.notifyExtraReasonFrameEnabled; end,
			},
			extrareasonframelocked = {
				type = 'toggle',
				name = L["Locked"],
				desc = L["Locked"],
				order = 15,
				set = function(frame, v) VanasKoSNotifier.db.profile.notifyExtraReasonFrameLocked = v; VanasKoSNotifier:UpdateAndCreateReasonFrame(); end,
				get = function() return VanasKoSNotifier.db.profile.notifyExtraReasonFrameLocked; end,
			},
		},
	};

	VanasKoSGUI:AddConfigOption("Notifier", configOptions);
	self:SetEnabledState(self.db.profile.Enabled);
end

function VanasKoSNotifier:OnEnable()
	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected");
	self:RegisterMessage("VanasKoS_Player_Target_Changed", "Player_Target_Changed");
	self:RegisterMessage("VanasKoS_Mob_Target_Changed", "Player_Target_Changed");
	self:HookScript(GameTooltip, "OnTooltipSetUnit");
end

function VanasKoSNotifier:OnDisable()
	self:UnregisterAllMessages();
end

local listsToCheck = {
		['PLAYERKOS'] = { L["KoS: %s"], L["%sKoS: %s"] },
		['GUILDKOS'] = { L["KoS (Guild): %s"], L["%sKoS (Guild): %s"] },
		['NICELIST'] = { L["Nicelist: %s"], L["%sNicelist: %s"] },
		['HATELIST'] = { L["Hatelist: %s"], L["%sHatelist: %s"] },
		['WANTED'] = {  L["Wanted: %s"], L["%sWanted: %s"] },
	};

function VanasKoSNotifier:OnTooltipSetUnit(tooltip, ...)
	if(not UnitIsPlayer("mouseover")) then
		--return self.hooks[tooltip].OnTooltipSetUnit(tooltip, ...);
	end

	local name, realm = UnitName("mouseover");
	if(realm ~= nil) then
		return self.hooks[tooltip].OnTooltipSetUnit(tooltip, ...);
	end
	local guild = GetGuildInfo("mouseover");

	-- add the KoS: <text> and KoS (Guild): <text> messages
	for k,v in pairs(listsToCheck) do
		local data = nil;
		if(k ~= "GUILDKOS") then
			data = VanasKoS:IsOnList(k, name);
		else
			data = VanasKoS:IsOnList(k, guild);
		end
		if(data) then
			local reason = data.reason or "";
			if(data.owner == nil) then
				tooltip:AddLine(format(v[1], reason));
			else
				tooltip:AddLine(format(v[2], data.creator or data.owner, reason));
			end
		end
	end

	-- add pvp stats line if turned on and data is available
	if(self.db.profile.notifyShowPvPStats) then
		local data = VanasKoS:IsOnList("PVPSTATS", name);

		if(data) then
			tooltip:AddLine(format(L["wins: %d - losses: %d"], data.wins or 0, data.losses or 0));
		end
	end

	--return self.hooks[tooltip].OnTooltipSetUnit(tooltip, ...);
end

function VanasKoSNotifier:UpdateReasonFrame(name, guild)
	if(self.db.profile.notifyExtraReasonFrameEnabled) then
		if(UnitIsPlayer("target")) then
			if(not VanasKoS_Notifier_ReasonFrame_Text) then
				return;
			end
			local data = VanasKoS:IsOnList("PLAYERKOS", name);
			local gdata = VanasKoS:IsOnList("GUILDKOS", guild);

			if(data) then
				VanasKoS_Notifier_ReasonFrame_Text:SetTextColor(1.0, 0.81, 0.0, 1.0);
				VanasKoS_Notifier_ReasonFrame_Text:SetText(self:GetKoSString(name, guild, data.reason, data.creator, data.owner, gdata and gdata.reason, gdata and gdata.creator, gdata and gdata.owner));
				return;
			end

			local hdata = VanasKoS:IsOnList("HATELIST", name);
			if(hdata and hdata.reason ~= nil) then
				VanasKoS_Notifier_ReasonFrame_Text:SetTextColor(1.0, 0.0, 0.0, 1.0);
				if(hdata.creator ~= nil and hdata.owner ~= nil)  then
					VanasKoS_Notifier_ReasonFrame_Text:SetText(format(L["%sHatelist: %s"], hdata.creator, hdata.reason));
				else
					VanasKoS_Notifier_ReasonFrame_Text:SetText(format(L["Hatelist: %s"], hdata.reason));
				end
				return;
			end

			local ndata = VanasKoS:IsOnList("NICELIST", name);
			if(ndata and ndata.reason ~= nil) then
				VanasKoS_Notifier_ReasonFrame_Text:SetTextColor(0.0, 1.0, 0.0, 1.0);
				if(ndata.creator ~= nil and ndata.owner ~= nil)  then
					VanasKoS_Notifier_ReasonFrame_Text:SetText(format(L["%sNicelist: %s"], ndata.creator, ndata.reason));
				else
					VanasKoS_Notifier_ReasonFrame_Text:SetText(format(L["Nicelist: %s"], ndata.reason));
				end
				return;
			end

			VanasKoS_Notifier_ReasonFrame_Text:SetText("");
		else
			VanasKoS_Notifier_ReasonFrame_Text:SetText("");
		end

	end
end

function VanasKoSNotifier:Player_Target_Changed(data)
	-- data is nil if target was changed to a mob
	if(self.db.profile.notifyTargetFrame) then
		if(UnitIsPlayer("target")) then
			if(VanasKoS:BooleanIsOnList("PLAYERKOS", data.name)) then
				TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
				TargetFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTexture:GetAlpha());
			elseif(VanasKoS:BooleanIsOnList("GUILDKOS", data.guild)) then
				TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
				TargetFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTexture:GetAlpha());
			elseif(VanasKoS:BooleanIsOnList("HATELIST", data.name)) then
				TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
				TargetFrameTexture:SetVertexColor(1.0, 0.0, 0.0, TargetFrameTexture:GetAlpha());
			elseif(VanasKoS:BooleanIsOnList("NICELIST", data.name)) then
				TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
				TargetFrameTexture:SetVertexColor(0.0, 1.0, 0.0, TargetFrameTexture:GetAlpha());
			else
				TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
				TargetFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTexture:GetAlpha());
			end
		else
			TargetFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTexture:GetAlpha());
		end
	end
	self:UpdateReasonFrame(data and data.name, data and data.guild);
end

--/script VanasKoS:SendMessage("VanasKoS_Player_Detected", "Apfelherz", nil, "kos");
function VanasKoSNotifier:GetKoSString(name, guild, reason, creator, owner, greason, gcreator, gowner)
	local msg = "";

	if(reason ~= nil) then
		if(creator ~= nil and owner ~= nil) then
			if(name == nil) then
				msg = format(L["%sKoS: %s"], creator, reason);
			else
				msg = format(L["%sKoS: %s"], creator, name .. " (" .. reason .. ")");
			end
		else
			if(name == nil) then
				msg = format(L["KoS: %s"], reason);
			else
				msg = format(L["KoS: %s"], name .. " (" .. reason .. ")");
			end
		end
		if(guild) then
			msg = msg .. " <" .. guild .. ">";
			if(greason ~= nil) then
				msg = msg .. " (" .. greason .. ")";
			end
		end
	elseif(greason ~= nil) then
		msg = format(L["KoS (Guild): %s"], name .. " <" .. guild .. "> (" ..  greason .. ")");
	else
		if(creator ~= nil and owner ~= nil) then
			if(name == nil) then
				msg = format(L["%sKoS: %s"], creator, "");
			else
				msg = format(L["%sKoS: %s"], creator, name);
			end
		else
			if(name == nil) then
				msg = format(L["KoS: %s"], "");
			else
				msg = format(L["KoS: %s"], name);
			end
		end
		if(guild) then
			msg = msg .. " <" .. guild .. ">";
		end
	end

	return msg;
end

local function ReenableNotifications()
	notifyAllowed = true;
end

function VanasKoSNotifier:Player_Detected(message, data)
	assert(data.name ~= nil);
	
	if (data.faction == nil) then
		return
	end

	if (notifyAllowed ~= true) then
		return;
	end

	-- don't notify if we're in shattrah
	if(VanasKoSDataGatherer:IsInSanctuary() and not self.db.profile.notifyInShattrathEnabled) then
		return;
	end

	if (data.faction == "kos") then
		VanasKoSNotifier:KosPlayer_Detected(data);
	elseif (data.faction == "enemy") then
		VanasKoSNotifier:EnemyPlayer_Detected(data);
	end
end

function VanasKoSNotifier:EnemyPlayer_Detected(data)
	assert(data.name ~= nil);

	if(self.db.profile.notifyEnemyTargets == false) then
		return;
	end
	notifyAllowed = false;
	-- Reallow Notifies in NotifyTimeInterval Time
	self:ScheduleTimer(ReenableNotifications, self.db.profile.NotifyTimerInterval);

	local msg = format(L["Enemy Detected:|cffff0000"]);
	if (data.level ~= nil) then
		if (data.level < 1) then
			msg = msg .. " [??]";
		else
			msg = msg .. " [" .. data.level .. "]";
		end
	end

	msg = msg .. " " .. data.name;

	if (data.guild ~= nil) then
		msg = msg .. " <" .. data.guild .. ">";
	end

	msg = msg .. "|r";

	if(self.db.profile.notifyVisual) then
		UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
	end
	if(self.db.profile.notifyChatframe) then
		VanasKoS:Print(msg);
	end
	if(self.db.profile.notifyFlashingBorder) then
		self:FlashNotify();
	end
	self:PlaySound(self.db.profile.enemyPlayName);
end

function VanasKoSNotifier:KosPlayer_Detected(data)
	assert(data.name ~= nil);

	-- get reasons for kos (if any)
	local pdata = VanasKoS:IsOnList("PLAYERKOS", data.name);
	local gdata = VanasKoS:IsOnList("GUILDKOS", data.guild);

	local msg = self:GetKoSString(data.name, data and data.guild, pdata and pdata.reason, pdata and pdata.creator, pdata and pdata.owner, gdata and gdata.reason, gdata and gdata.creator, gdata and gdata.owner);

	if(self.db.profile.notifyOnlyMyTargets and ((pdata and pdata.owner ~= nil) or (gdata and gdata.owner ~= nil))) then
		return;
	end

	notifyAllowed = false;
	-- Reallow Notifies in NotifyTimeInterval Time
	self:ScheduleTimer(ReenableNotifications, self.db.profile.NotifyTimerInterval);

	if(self.db.profile.notifyVisual) then
		UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
	end
	if(self.db.profile.notifyChatframe) then
		VanasKoS:Print(msg);
	end
	if(self.db.profile.notifyFlashingBorder) then
		self:FlashNotify();
	end
	
	self:PlaySound(self.db.profile.playName);
end

-- /script VanasKoSNotifier:FlashNotify()
function VanasKoSNotifier:FlashNotify()
	flashNotifyFrame:Show();
	UIFrameFlash(VanasKoS_Notifier_Frame, FADE_IN_TIME, FADE_OUT_TIME, FLASH_TIMES*(FADE_IN_TIME + FADE_OUT_TIME));
end

function VanasKoSNotifier:PlaySound(value)
	local soundFileName = SML:Fetch("sound", value);
	PlaySoundFile(soundFileName);
end
