--[[----------------------------------------------------------------------
	ChatNotifier Module - Part of VanasKoS
modifies the ChatMessage if a player speaks whom is on your hatelist
------------------------------------------------------------------------]]

local function RegisterTranslations(locale, translationfunction)
	local defaultLocale = false;
	if(locale == "enUS") then
		defaultLocale = true;
	end
	
	local liblocale = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_ChatNotifier", locale, defaultLocale);
	if liblocale then
		for k, v in pairs(translationfunction()) do
			liblocale[k] = v;
		end
	end
end

RegisterTranslations("enUS", function() return {
--	["[HateList: %s] %s"] = true,

	["Chat Modifications"] = true,
	["Modifies the Chat Window for Hate/Nicelist Entries."] = true,
	["Enabled"] = true,
	["Hatelist Color"] = true,
	["Sets the Foreground Color for Hatelist Entries"] = true,
	["Nicelist Color"] = true,
	["Sets the Foreground Color for Nicelist Entries"] = true,
	["Modify only my Entries"] = true,
	["Modifies the Chat only for your Entries"] = true,

	["Lookup in VanasKoS"] = true,
	["Add Lookup in VanasKoS"] = true,
	["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = true,
	["Player: %s is on List: %s - Reason: %s"] = "Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r",
	["No entry for %s"] = "No entry for |cff00ff00%s|r",
} end);

RegisterTranslations("deDE", function() return {
--	["[HateList: %s] %s"] = "[Hassliste: %s] %s",

	["Chat Modifications"] = "Chat Modifikationen",
	["Modifies the Chat Window for Hate/Nicelist Entries."] = "Modifiziert das Chatfenster Spieler auf der Hass- und Nette-Leuteliste",
	["Enabled"] = "Aktiviert",
	["Hatelist Color"] = "Farbe für Hassliste",
	["Sets the Foreground Color for Hatelist Entries"] = "Setzt die Vordergrundfarbe für Einträge der Hassliste",
	["Nicelist Color"] = "Farbe für Nette-Leuteliste",
	["Sets the Foreground Color for Nicelist Entries"] = "Setzt die Hintergrundfarbe für Einträge der Nette-Leuteliste",
	["Modifies the Chat only for your Entries"] = "Nur für meine Einträge Chat ändern",

	["Lookup in VanasKoS"] = "In VanasKoS suchen",
	["Add Lookup in VanasKoS"] = "In VanasKoS suchen hinzufügen",
	["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = "Fügt die Suche in VanasKoS zum Context Menu hinzu",
	["Player: %s is on List: %s - Reason: %s"] = "Spieler: |cff00ff00%s|r ist auf Liste: |cff00ff00%s|r - Grund: |cff00ff00%s|r",
	["No entry for %s"] = "Kein Eintrag für |cff00ff00%s|r",
} end);

RegisterTranslations("frFR", function() return {
--	["[HateList: %s] %s"] = "[Liste noire: %s] %s",

	["Chat Modifications"] = "Modifications du chat",
	["Modifies the Chat Window for Hate/Nicelist Entries."] = "Modifie la fenêtre du chat pour les entrées des listes blanche/noire",
	["Enabled"] = "Actif",
	["Hatelist Color"] = "Couleur pour liste noire",
	["Sets the Foreground Color for Hatelist Entries"] = "Choisir la couleur de texte pour les entrées de la liste noire",
	["Nicelist Color"] = "Couleur pour liste blanche",
	["Sets the Foreground Color for Nicelist Entries"] = "Choisir la couleur de texte pour les entrées de la liste blanche",
	["Modify only my Entries"] = "Modifier seulement mes entrées",
	["Modifies the Chat only for your Entries"] = "Modifie le chat seulement pour vos entrées",

--	["Lookup in VanasKoS"] = true,
--	["Add Lookup in VanasKoS"] = true,
--	["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = true,
--	["Player: %s is on List: %s - Reason: %s"] = "Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r",
--	["No entry for %s"] = "No entry for |cff00ff00%s|r",
} end);

RegisterTranslations("koKR", function() return {
--	["[HateList: %s] %s"] = "[악인명부: %s] %s",

	["Chat Modifications"] = "대화창 변경",
	["Modifies the Chat Window for Hate/Nicelist Entries."] = "악인/호인에 대해 대화창을 변경합니다.",
	["Enabled"] = "사용",
	["Hatelist Color"] = "악인명부 색상",
	["Sets the Foreground Color for Hatelist Entries"] = "싫어하는 사람에 대한 전경 색상을 설정합니다.",
	["Nicelist Color"] = "호인명부 색상",
	["Sets the Foreground Color for Nicelist Entries"] = "좋아하는 사람에 대한 전경 색상을 설정합니다.",
	["Modify only my Entries"] = "내 명부만 변경",
	["Modifies the Chat only for your Entries"] = "당신의 명부에 대한 대화만 변경합니다.",

--	["Lookup in VanasKoS"] = true,
--	["Add Lookup in VanasKoS"] = true,
--	["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = true,
--	["Player: %s is on List: %s - Reason: %s"] = "Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r",
--	["No entry for %s"] = "No entry for |cff00ff00%s|r",
} end);

RegisterTranslations("esES", function() return {
--	["[HateList: %s] %s"] = "[Odiados: %s] %s",

	["Chat Modifications"] = "Modificaciones de Chat",
	["Modifies the Chat Window for Hate/Nicelist Entries."] = "Modifica la ventana de chat para las entradas de Simpáticos/Odiados",
	["Enabled"] = "Activado",
	["Hatelist Color"] = "Color de Odiados",
	["Sets the Foreground Color for Hatelist Entries"] = "Establece el color de las entradas de Odiados",
	["Nicelist Color"] = "Color de Simpáticos",
	["Sets the Foreground Color for Nicelist Entries"] = "Establece el color de las entradas de Simpáticos",
	["Modify only my Entries"] = "Modificar sólo mis entradas",
	["Modifies the Chat only for your Entries"] = "Modifica el chat sólo para tus entradas",

--	["Lookup in VanasKoS"] = true,
--	["Add Lookup in VanasKoS"] = true,
--	["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = true,
--	["Player: %s is on List: %s - Reason: %s"] = "Player: |cff00ff00%s|r is on List: |cff00ff00%s|r - Reason: |cff00ff00%s|r",
--	["No entry for %s"] = "No entry for |cff00ff00%s|r",
} end);

RegisterTranslations("ruRU", function() return {
--	["[HateList: %s] %s"] = "[Список ненавистных: %s] %s",

	["Chat Modifications"] = "Модификации чата",
	["Modifies the Chat Window for Hate/Nicelist Entries."] = "Вносит изменения в окно чата для записей из списка ненавистных/хороших.",
	["Enabled"] = "Включено",
	["Hatelist Color"] = "Цвет списка ненавистных",
	["Sets the Foreground Color for Hatelist Entries"] = "Задает цвет для записей из списка ненавистных",
	["Nicelist Color"] = "Цвет списка хороших",
	["Sets the Foreground Color for Nicelist Entries"] = "Задает цвет для записей из списка хороших",
	["Modify only my Entries"] = "Модифицировать только для моих",
	["Modifies the Chat only for your Entries"] = "Модифицирует чат только для записей, сделанных мной",

	["Lookup in VanasKoS"] = "Проверить в VanasKoS",
	["Add Lookup in VanasKoS"] = "Добавить проверку в меню",
	["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."] = "Добавляет в контекстное меню пункт \"Проверить в Vanas KoS\"",
	["Player: %s is on List: %s - Reason: %s"] = "Игрок: |cff00ff00%s|r в Списке: |cff00ff00%s|r - Причина: |cff00ff00%s|r",
	["No entry for %s"] = "Записей с |cff00ff00%s|r не найдено",
} end);

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_ChatNotifier", false);

VanasKoSChatNotifier = VanasKoS:NewModule("ChatNotifier", "AceHook-3.0");

local VanasKoSChatNotifier = VanasKoSChatNotifier;
local VanasKoS = VanasKoS;

local function SetLookup(enable)
	if(enable) then
		if(not VanasKoSChatNotifier:IsHooked("UnitPopup_OnClick")) then
			VanasKoSChatNotifier:SecureHook("UnitPopup_OnClick");
			if(not UnitPopupButtons) then
				return;
			end

			UnitPopupButtons["VANASKOS_LOOKUP"] = { text = L["Lookup in VanasKoS"], dist = 0 };

			tinsert(UnitPopupMenus["FRIEND"], "VANASKOS_LOOKUP");
--			VanasKoSChatNotifier:SecureHook("UnitPopup_ShowMenu");
--			VanasKoSChatNotifier:SecureHook("UnitPopup_HideButtons");
		end
	else
		if(VanasKoSChatNotifier:IsHooked("UnitPopup_OnClick")) then
			VanasKoSChatNotifier:Unhook("UnitPopup_OnClick");
			if(UnitPopupButtons and UnitPopupButtons["VANASKOS_LOOKUP"]) then
				UnitPopupButtons["VANASKOS_LOOKUP"] = nil;

				for k,v in pairs(UnitPopupMenus["FRIEND"]) do
					if(v == "VANASKOS_LOOKUP") then
						UnitPopupMenus["FRIEND"][k] = nil;
						break;
					end
				end
			end
		end
	end
end

local function GetColor(which)
	return VanasKoSChatNotifier.db.profile[which .. "R"], VanasKoSChatNotifier.db.profile[which .. "G"], VanasKoSChatNotifier.db.profile[which .. "B"], VanasKoSChatNotifier.db.profile[which .. "A"];
end

local function SetColor(which, r, g, b)
	VanasKoSChatNotifier.db.profile[which .. "R"] = r;
	VanasKoSChatNotifier.db.profile[which .. "G"] = g;
	VanasKoSChatNotifier.db.profile[which .. "B"] = b;
end

local function GetColorHex(which)
	local r,g,b,a = GetColor(which);

	return string.format("%02x%02x%02x", r*255, g*255, b*255);
end

function VanasKoSChatNotifier:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("ChatNotifier", {
		profile = {
			Enabled = true,
			OnlyMyEntries = false,
			AddLookupEntry = true,

			HateListColorR = 1.0,
			HateListColorG = 0.0,
			HateListColorB = 0.0,

			NiceListColorR = 0.0,
			NiceListColorG = 1.0,
			NiceListColorB = 0.0,
		}
	});

	VanasKoSGUI:AddConfigOption("ChatNotifier", {
		type = 'group',
		name = L["Chat Modifications"],
		desc = L["Modifies the Chat Window for Hate/Nicelist Entries."],
		args = {
			enabled = {
				type = 'toggle',
				name = L["Enabled"],
				desc = L["Enabled"],
				order = 1,
				set = function(frame, v) VanasKoSChatNotifier.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("ChatNotifier"); end,
				get = function() return VanasKoS:GetModule("ChatNotifier").enabledState; end,
			},
			hateListColor = {
				type = 'color',
				name = L["Hatelist Color"],
				desc = L["Sets the Foreground Color for Hatelist Entries"],
				order = 2,
				get = function() return GetColor("HateListColor") end,
				set = function(frame, r, g, b, a) SetColor("HateListColor", r, g, b); VanasKoSChatNotifier:Update(); end,
				hasAlpha = false,
			},
			niceListColor = {
				type = 'color',
				name = L["Nicelist Color"],
				desc = L["Sets the Foreground Color for Nicelist Entries"],
				order = 3,
				get = function() return GetColor("NiceListColor") end,
				set = function(frame, r, g, b, a) SetColor("NiceListColor", r, g, b); VanasKoSChatNotifier:Update(); end,
				hasAlpha = false,
			},
			modifyOnlyMyEntries = {
				type = 'toggle',
				name = L["Modify only my Entries"],
				desc = L["Modifies the Chat only for your Entries"],
				order = 4,
				set = function(frame, v) VanasKoSChatNotifier.db.profile.OnlyMyEntries = v; end,
				get = function() return VanasKoSChatNotifier.db.profile.OnlyMyEntries; end,
			},
			addLookupEntry = {
				type = 'toggle',
				name = L["Add Lookup in VanasKoS"],
				desc = L["Modifies the Chat Context Menu to add a \"Lookup in VanasKoS\" option."],
				order = 4,
				set = function(frame, v) VanasKoSChatNotifier.db.profile.AddLookupEntry = v; SetLookup(v); end,
				get = function() return VanasKoSChatNotifier.db.profile.AddLookupEntry; end,
			},
		}
	});
end

function VanasKoSChatNotifier:OnEnable()
	if(not self.db.profile.Enabled) then
		self:SetEnabledState(false);
		return;
	end
	
	self:Update();
	self:RawHook("ChatFrame_OnEvent", true);
	SetLookup(self.db.profile.AddLookupEntry);
end

function VanasKoSChatNotifier:OnDisable()
	self:Unhook("ChatFrame_OnEvent");
	if(self.db.profile.AddLookupEntry) then
		SetLookup(false);
	end
end

--[[
function VanasKoSChatNotifier:UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
end

function VanasKoSChatNotifier:UnitPopup_HideButtons()
end
]]
function VanasKoSChatNotifier:UnitPopup_OnClick()
	local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	if(not dropdownFrame) then
		return;
	end
	local name = dropdownFrame.name;
	if(not name) then
		return;
	end
	local button = this.value;

	if(button == "VANASKOS_LOOKUP") then
		local data, list = VanasKoS:IsOnList(nil, dropdownFrame.name);
		if(list ~= nil) then
			VanasKoS:Print(format(L["Name: %s is on List: %s - Reason: %s"], dropdownFrame.name, VanasKoS:GetListNameByShortName(list), data.reason or ""));
		else
			VanasKoS:Print(format(L["No entry for %s"], dropdownFrame.name));
		end
	end
end

-- tnx to tastethenaimbow for the idea on how to do it
local channelWatchList = {
	["CHAT_MSG_CHANNEL"] = "CHAT_CHANNEL_GET",
	["CHAT_MSG_GUILD"] = "CHAT_GUILD_GET",
	["CHAT_MSG_PARTY"] = "CHAT_PARTY_GET",
	["CHAT_MSG_RAID"] = "CHAT_RAID_GET",
	["CHAT_MSG_RAID_LEADER"] = "CHAT_RAID_LEADER_GET",
	["CHAT_MSG_SAY"] = "CHAT_SAY_GET",
	["CHAT_MSG_WHISPER"] = "CHAT_WHISPER_GET",
	["CHAT_MSG_OFFICER"] = "CHAT_OFFICER_GET",
	["CHAT_MSG_WHISPER_INFORM"] = "CHAT_WHISPER_INFORM_GET",
}

local HATELISTCOLOR = "ff0000";
local NICELISTCOLOR = "00ff00";

function VanasKoSChatNotifier:ChatFrame_OnEvent(frame, event, ...)

	-- if switched to disabled, remove hook on first intercept
	if(not VanasKoSChatNotifier.enabledState) then
		local ret = self.hooks["ChatFrame_OnEvent"](frame, event, ...);
		self:Unhook("ChatFrame_OnEvent");
		return ret;
	end
	if(channelWatchList[event]) then
		local listColor = (VanasKoS:BooleanIsOnList("HATELIST", arg2) and HATELISTCOLOR) or
							(VanasKoS:BooleanIsOnList("NICELIST", arg2) and NICELISTCOLOR);

		if(listColor) then
			if(self.db.profile.OnlyMyEntries) then
				local data1 = VanasKoS:IsOnList("HATELIST", arg2);
				local data2 = VanasKoS:IsOnList("NICELIST", arg2);

				if( (data1 and data1.owner and not data2) or -- hatelist entry from someone else, no nicelist entry
					(data2 and data2.owner and not data1) or -- nicelist entry from someone else, no hatelist entry
					(data1 and data1.owner and data2 and data2.owner) -- hatelist and nicelist entry from someone else
					) then
					return self.hooks["ChatFrame_OnEvent"](frame, event, ...);
				end

				if(data1 and not data1.owner) then
					listColor = HATELISTCOLOR;
				elseif(data2 and not data2.owner) then
					listColor = NICELISTCOLOR;
				end
			end

			local originalText = getglobal(channelWatchList[event]);
			setglobal(channelWatchList[event], gsub(originalText, "%%s", "|cff" .. listColor .. "%%s|r"));

			local ret = self.hooks["ChatFrame_OnEvent"](frame, event, ...);

			setglobal(channelWatchList[event], originalText);

			return ret;
		end
	end

	return self.hooks["ChatFrame_OnEvent"](frame, event, ...);
end

function VanasKoSChatNotifier:Update()
	HATELISTCOLOR = GetColorHex("HateListColor");
	NICELISTCOLOR = GetColorHex("NiceListColor");
end
