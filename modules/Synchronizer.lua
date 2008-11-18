--[[----------------------------------------------------------------------
      Synchronizer Module - Part of VanasKoS
Synchronizes a list with other players
------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.2"):new("VanasKoSSynchronizer");

VanasKoSSynchronizer = VanasKoS:NewModule("Synchronizer");
local VanasKoSSynchronizer = VanasKoSSynchronizer;
local VanasKoS = VanasKoS;
local VanasKoSGUI = VanasKoSGUI;

-- sync every 6 hours
local SYNCTIME = 3600*6;

L:RegisterTranslations("enUS", function() return {
	["Accept %d entries for list %s from %s?"] = true,
	["KoS-List was received but couldn't be processed due to previous received list."] = true,
	["Accept"] = true,
	["Cancel"] = true,
	["selected entry to the party"] = true,
	["transfers the selected entry to the party"] = true,
	["all entries to the party"] = true,
	["transfers all entries to the party"] = true,
	["No Autosync partner named %s"] = true,
	["Synchronize with"] = true,
	["Initiates a manual Synchronize Request to..."] = true,
	["Sent entry to party"] = true,
	["Sent list to party"] = true,
	["Auto Synchronization"] = true,
	["Options for automatic Synchronization with other people"] = true,
	["Enabled"] = true,
	["No Synchronization Options - Enable Auto Sync"] = true,
	["Receive"] = true,
	["Allow the reception of these lists"] = true,
	["Send"] = true,
	["Send these lists"] = true,
	["Auto Sync"] = true,
	["Receive: %s, Send: %s"] = true,
	["None"] = true,

	["Guild Sharing"] = true,
	["Options for Sharing your Lists with your Guild"] = true,
	["Interval for broadcasting the List(s) to Guild (hours)"] = true,
	["Sets how often the selected List(s) get sent to the Guild (in Hours)"] = true,
	["Lists to Share"] = true,
	["Select the Lists you want to share with your Guild"] = true,
} end);

L:RegisterTranslations("deDE", function() return {
	["Accept %d entries for list %s from %s?"] = "%d Einträge fuer Liste %s von %s akzeptieren?",
	["KoS-List was received but couldn't be processed due to previous received list."] = "Eine KoS-List wurde empfangen, konnte aber aufgrund einer vorher empfangenen und unbestaetigten KoS-Liste nicht bearbeitet werden",
	["Accept"] = "Annehmen",
	["Cancel"] = "Abbrechen",
	["selected entry to the party"] = "Gewaehlter Eintrag an Gruppe",
	["transfers the selected entry to the party"] = "Sendet gewaehlte Eintraege an Gruppe",
	["all entries to the party"] = "Alle Eintraege an Gruppe",
	["transfers all entries to the party"] = "Sendet alle Eintraege an Gruppe",
	["No Autosync partner named %s"] = "Kein Auto Sync Partner namens %s",
	["Synchronize with"] = "Synchronisieren mit",
	["Initiates a manual Synchronize Request to..."] = "Startet die Synchronisation mit...",
	["Auto Synchronization"] = "Automatische Synchronisation",
	["Options for automatic Synchronization with other people"] = "Optionen fuerr die automatische Synchronisiserung mit anderen Spielern",
	["Enabled"] = "Aktiviert",
	["No Synchronization Options - Enable Auto Sync"] = "Keine Synchronisations Optionen, Aktiviere die Auto Synchronisation.",
	["Receive"] = "Empfang",
	["Allow the reception of these lists"] = "Erlaubt den Empfang aktivierter Listen",
	["Send"] = "Senden",
	["Send these lists"] = "Aktivierte Listen werden versendet",
	["Auto Sync"] = "Auto Sync",
	["Receive: %s, Send: %s"] = "Empfangen: %s, Senden: %s",
	["None"] = "Keine",

	["Guild Sharing"] = "Gilden Synchronisation",
	["Options for Sharing your Lists with your Guild"] = "Optionen um die Listen mit der Gilde zu teilen",
	["Interval for broadcasting the List(s) to Guild (hours)"] = "Intervall zwischen dem Senden der Liste(n) (Stunden)",
	["Sets how often the selected List(s) get sent to the Guild (in Hours)"] = "Setzt die Zeit die zwischen dem veröffentlichen der Liste(n) vergehen muß (in Stunden)",
	["Lists to Share"] = "Listen die geteilt werden sollen",
	["Select the Lists you want to share with your Guild"] = "Auswahl aus Listen, die mit der Gilde geteilt werden können",
} end);

L:RegisterTranslations("frFR", function() return {
	["Accept %d entries for list %s from %s?"] = "Accepter les entrées de %d pour la liste %s de %s?",
	["KoS-List was received but couldn't be processed due to previous received list."] = "La liste KoS a \195\169t\195\169 re�ue mais n'a pas pu \195\170tre trait\195\169e avec la pr\195\169c\195\169dente liste.",
	["Accept"] = "Accepter",
	["Cancel"] = "Annuler",
	["selected entry to the party"] = "S\195\169lectionnez une entr\195\169e \195\160 partager (groupe)",
	["transfers the selected entry to the party"] = "Transfaire l'entr\195\169e s\195\169lectionn\195\169 au groupe",
	["all entries to the party"] = "S\195\169lectionnez toutes les entr\195\169es \195\160 partager (groupe)",
	["transfers all entries to the party"] = "Transfaire les entr\195\169es s\195\169lectionn\195\169s au groupe",
	["No Autosync partner named %s"] = "Pas de partenaire Autosync appelé %s",
	["Synchronize with"] = "Synchroniser avec",
	["Initiates a manual Synchronize Request to..."] = "Débuter la synchronisation manuelle",
	["Auto Synchronization"] = "Synchronisation automatique",
	["Options for automatic Synchronization with other people"] = "Options pour la synchronisation automatique avec d'autres joueurs",
	["No Synchronization Options - Enable Auto Sync"] = "Aucunes options de synchronisation - Auto Sync actif",
	["Receive"] = "Recevoir",
	["Allow the reception of these lists"] = "Permettre la réception de ces listes",
	["Send"] = "Envoyer",
	["Send these lists"] = "Envoyer ces listes",
	["Enabled"] = "Actif",
	["Auto Sync"] = "Auto Sync",
	["Receive: %s, Send: %s"] = "Recevoir: %s, Envoyer: %s",
	["None"] = "Aucun",

	["Guild Sharing"] = "Partage de guilde",
	["Options for Sharing your Lists with your Guild"] = "Options pour partager vos listes avec votre guilde",
	["Interval for broadcasting the List(s) to Guild (hours)"] = "Intervalle pour annoncer les liste(s) à la guilde (heures)",
	["Sets how often the selected List(s) get sent to the Guild (in Hours)"] = "Choisissez combien de fois les listes sélectionnées sont envoyées à la guilde (en heures)",
	["Lists to Share"] = "Listes à partager",
	["Select the Lists you want to share with your Guild"] = "Sélectionner les listes que vous voulez partager avec votre guilde",
} end);

L:RegisterTranslations("koKR", function() return {
	["Accept %d entries for list %s from %s?"] = "%3$s로 부터 받은 %2$s 목록에 대해 %1$d개를 허용합니다.",
	["KoS-List was received but couldn't be processed due to previous received list."] = "KoS-List was received but couldn't be processed due to previous received list.",

	["Accept"] = "확인",
	["Cancel"] = "취소",

	["selected entry to the party"] = "선택된 대상 파티에 알림",
	["transfers the selected entry to the party"] ="선택된 대상을 파티에 전송합니다.",
	["all entries to the party"] = "모든 대상을 파티에 알림",
	["transfers all entries to the party"] = "모든 대상을 파티에 전송합니다.",
	["No Autosync partner named %s"] = "%s|1은;는; 자동 동기화 동료가 아닙니다.",
	["Synchronize with"] = "동기화 신청 : ",
	["Initiates a manual Synchronize Request to..."] = "수동 동기화 요청 시작 : ",
	["Auto Synchronization"] = "자동 동기화",
	["Options for automatic Synchronization with other people"] = "다른 사람과의 자동 동기화 설정",
	["Enabled"] = "사용중",
	["No Synchronization Options - Enable Auto Sync"] = "동기화 설정이 없습니다 - 자동 동기화를 활성화하세요",
	["Receive"] = "받기",
	["Allow the reception of these lists"] = "이 목록의 받기를 허용합니다.",
	["Send"] = "보내기",
	["Send these lists"] = "이 목록을 보냅니다.",
	["Auto Sync"] = "자동 동기화",
	["Receive: %s, Send: %s"] = "받음: %s, 보냄: %s",
	["None"] = "없음",

	["Guild Sharing"] = "길드 공유",
	["Options for Sharing your Lists with your Guild"] = "길드에 명부 공유 설정",
	["Interval for broadcasting the List(s) to Guild (hours)"] = "길드에 명부를 알리는 간격(시간)",
	["Sets how often the selected List(s) get sent to the Guild (in Hours)"] = "얼마나 자주 길드에 선택된 명부를 보낼지를 설정합니다.(시단위)",
	["Lists to Share"] = "명부 공유",
	["Select the Lists you want to share with your Guild"] = "길드에 공유할 명부를 선택하세요.",
} end);

L:RegisterTranslations("esES", function() return {
	["Accept %d entries for list %s from %s?"] = "¿Aceptar %d entradas para la lista %s desde %s?",
	["KoS-List was received but couldn't be processed due to previous received list."] = "Se ha recibido una lista de KoS pero no ha podido ser procesada debido a la lista recibida previamente.",
	["Accept"] = "Aceptar",
	["Cancel"] = "Cancelar",
	["selected entry to the party"] = "Entrada seleccionada al grupo",
	["transfers the selected entry to the party"] = "Transfiere la entrada seleccionada al grupo",
	["all entries to the party"] = "Todas las entradas al grupo",
	["transfers all entries to the party"] = "Transfiere todas las entradas al grupo",
	["No Autosync partner named %s"] = "No AutoSincronizar con el compañero llamado %s",
	["Synchronize with"] = "Sincronicar con",
	["Initiates a manual Synchronize Request to..."] = "Inicia una Petición de Sincronización manual a...",
	["Auto Synchronization"] = "Auto Sincronización",
	["Options for automatic Synchronization with other people"] = "Opciones para la sincronización automática con otra gente",
	["Enabled"] = "Activado",
	["No Synchronization Options - Enable Auto Sync"] = "No hay opciones de sincronización - Activa Auto Sinc",
	["Receive"] = "Recibir",
	["Allow the reception of these lists"] = "Permite la recepción de estas listas",
	["Send"] = "Enviar",
	["Send these lists"] = "Envía estas listas",
	["Auto Sync"] = "Auto Sinc",
	["Receive: %s, Send: %s"] = "Recibir: %s, Enviar: %s",
	["None"] = "Ninguno",

	["Guild Sharing"] = "Compartir con Hermandad",
	["Options for Sharing your Lists with your Guild"] = "Opciones para compartir tus listas con tu hermandad",
	["Interval for broadcasting the List(s) to Guild (hours)"] = "Intervalo para emitir la(s) lista(s) a la hermandad (horas)",
	["Sets how often the selected List(s) get sent to the Guild (in Hours)"] = "Establece cuán a menudo la(s) lista(s) seleccionada(s) se envía a la hermandad (en Horas)",
	["Lists to Share"] = "Listas a Compartir",
	["Select the Lists you want to share with your Guild"] = "Elige qué listas quieres compartir con tu hermandad",
} end);

L:RegisterTranslations("ruRU", function() return {
	["Accept %d entries for list %s from %s?"] = "Принять %d записей для списка %s от %s?",
	["KoS-List was received but couldn't be processed due to previous received list."] = "Был получен KoS-список но не обработан из за предыдущего полученного списка.",
	["Accept"] = "Принять",
	["Cancel"] = "Отмена",
	["selected entry to the party"] = "выбранные записи в группу",
	["transfers the selected entry to the party"] = "отправляет выбранные записи в группу",
	["all entries to the party"] = "все записи в группу",
	["transfers all entries to the party"] = "отправляет все записи в группу",
	["No Autosync partner named %s"] = "Партнер по имении %s для автосинхронизации не найден",
	["Synchronize with"] = "Синхронизировать с",
	["Initiates a manual Synchronize Request to..."] = "Отправляет ручной запрос на синхронизацию к...",
	["Auto Synchronization"] = "Автозинхронизация",
	["Options for automatic Synchronization with other people"] = "Опции для автоматической синхронизации с другими людьми",
	["Enabled"] = "Включено",
	["No Synchronization Options - Enable Auto Sync"] = "Нет опций синхронизации - Включаем Автосинхронизацию",
	["Receive"] = "Получать",
	["Allow the reception of these lists"] = "Разрешить получение этих списков",
	["Send"] = "Отправить",
	["Send these lists"] = "Отправить эти списки",
	["Auto Sync"] = "Авто Синх-я",
	["Receive: %s, Send: %s"] = "Получить: %s, Отправить: %s",
	["None"] = "Нет",

	["Guild Sharing"] = "Раздача для Гильдии",
	["Options for Sharing your Lists with your Guild"] = "Опции по раздаче списков внутри своей гильдии",
	["Interval for broadcasting the List(s) to Guild (hours)"] = "Интервал для раздачи списков внутри гильдии (в часах)",
	["Sets how often the selected List(s) get sent to the Guild (in Hours)"] = "Задает как часто выбранные списки будут транслироваться в гильдии (в часах)",
	["Lists to Share"] = "Списки для раздачи",
	["Select the Lists you want to share with your Guild"] = "Выбор списков, которыми вы хотите делиться с гильдией",
} end);

local dewdrop = AceLibrary("Dewdrop-2.0");
local contextMenu = {};

function VanasKoSSynchronizer:InitContextMenu()
	contextMenu = {
		type = 'group',
		args = {
			receive = {
				type = "group",
				name = L["Receive"],
				desc = L["Allow the reception of these lists"],
				args = {
				}
			},
			send = {
				type = "group",
				name = L["Send"],
				desc = L["Send these lists"],
				args = {
				}
			}
		}
	};
	for i=1,4 do
		contextMenu.args.receive.args[(VANASKOS.Lists[i])[1]] = {
			type = 'toggle',
			name = (VANASKOS.Lists[i])[2],
			desc = (VANASKOS.Lists[i])[2],
			order = i,
			get = function() return VanasKoSSynchronizer:IsListEnabled((VANASKOS.Lists[i])[1]); end,
			set = function(enabled) VanasKoSSynchronizer:SetList((VANASKOS.Lists[i])[1], nil, enabled); end,
		};
	end
	for i=1,4 do
		contextMenu.args.send.args[(VANASKOS.Lists[i])[1]] = {
			type = 'toggle',
			name = (VANASKOS.Lists[i])[2],
			desc = (VANASKOS.Lists[i])[2],
			order = i,
			get = function() return VanasKoSSynchronizer:IsListEnabled((VANASKOS.Lists[i])[1], 1); end,
			set = function(enabled) VanasKoSSynchronizer:SetList((VANASKOS.Lists[i])[1], 1, enabled); end,
		};
	end


	for i=1,10 do
		dewdrop:Register(getglobal("VanasKoSListFrameListButton" .. i),
							'children', contextMenu,
							'point', function(parent) return "TOPLEFT", "TOPRIGHT" end,
							'dontHook', true);
	end

end

local syncOptions = { };
local syncConfigOptions = {
			type = 'group',
			name = L["Auto Synchronization"],
			desc = L["Options for automatic Synchronization with other people"],
			args = {
				enabled = {
					type = 'toggle',
					name = L["Enabled"],
					desc = L["Enabled"],
					order = 1,
					set = function(v) VanasKoSSynchronizer.db.profile.Enabled = v; VanasKoS:ToggleModuleActive("Synchronizer", v); end,
					get = function() return VanasKoSSynchronizer.db.profile.Enabled end,
				},
				guildsync = {
					type = 'group',
					name = L["Guild Sharing"],
					desc = L["Options for Sharing your Lists with your Guild"],
					order = 2,
					args = {
						sharingInterval = {
							type = 'range',
							name = L["Interval for broadcasting the List(s) to Guild (hours)"],
							desc = L["Sets how often the selected List(s) get sent to the Guild (in Hours)"],
							min = 1,
							max = 5,
							step = 0.5,
							set = function(value) VanasKoSSynchronizer.db.profile.GuildShareInterval = value; end,
							get = function() return VanasKoSSynchronizer.db.profile.GuildShareInterval; end,
						},
						sharedLists = {
							type = 'group',
							name = L["Lists to Share"],
							desc = L["Select the Lists you want to share with your Guild"],
							args = {
							},
						},
					},
				},
			},
		};

local tempList = { };

function VanasKoSSynchronizer:UpdateConfigurationOptions()
	for k,v in pairs({"PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST"}) do
		-- fill the options with the lists i can share
		if(not syncConfigOptions.args.guildsync.args.sharedLists.args[v]) then
			syncConfigOptions.args.guildsync.args.sharedLists.args[v] = {
				type = 'toggle',
				name = VanasKoS:GetListNameByShortName(v),
				desc = VanasKoS:GetListNameByShortName(v),
				order = k + 4,
				set = function(val) VanasKoSSynchronizer.db.profile.GuildListsToShare[v] = val; end,
				get = function() return VanasKoSSynchronizer.db.profile.GuildListsToShare[v]; end,
			};
		end

		-- add lists for selection of players you wish to accept lists from
		if(not syncConfigOptions.args.guildsync.args[v]) then
			syncConfigOptions.args.guildsync.args[v] = {
				type = 'group',
				name = VanasKoS:GetListNameByShortName(v),
				desc = VanasKoS:GetListNameByShortName(v),
				order = k,
				args = {
				},
			};
		end

		-- add all players in guild, splitted by guild rank
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status;
		tempList = { };
		for i=1, GetNumGuildMembers(1) do
			name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i);
			if(not tempList[rank]) then
				tempList[rank] = { name };
			else
				if(name ~= nil) then
					tinsert(tempList[rank], name);
				end
			end
		end
		for rank,namelist in pairs(tempList) do
			if(not syncConfigOptions.args.guildsync.args[v].args[rank]) then
				syncConfigOptions.args.guildsync.args[v].args[rank] = {
					type = 'group',
					name = rank,
					desc = rank,
					args = {
					},
				};
			end
			for index,name in pairs(namelist) do
				if(not syncConfigOptions.args.guildsync.args[v].args[rank].args[name]) then
					syncConfigOptions.args.guildsync.args[v].args[rank].args[name] = {
						type = 'toggle',
						name = name,
						desc = name,
						set = function(val) VanasKoSSynchronizer.db.profile.GuildAcceptList[v][name:lower()] = val; end,
						get = function() return VanasKoSSynchronizer.db.profile.GuildAcceptList[v][name:lower()]; end,
					};
				end
			end
		end
	end
end

function VanasKoSSynchronizer:UpdateSyncOptions()
	syncOptions = {
		type = 'group',
		args = {
			entrytoplayer = {
				name = L["selected entry to the party"],
				desc = L["transfers the selected entry to the party"],
				type = "execute",
				order = 1,
				func = function()
					local name = VanasKoSGUI:GetSelectedEntryName();
					local list = VanasKoS:GetList(VANASKOS.showList);
					local reason = list[name].reason;
					local creator = list[name].creator;
					if(creator == nil or creator == "") then
						creator = UnitName("player");
					end

					local listToSend = { [VANASKOS.showList] = { [name] = { ["name"] = name, ["reason"] = reason, ["creator"] = creator } }};

					VanasKoSSynchronizer:SendCommMessage("PARTY", "addplayer", listToSend);
					VanasKoS:Print(L["Sent entry to party"]);
				end
			},
			alltoplayer = {
				name = L["all entries to the party"],
				desc = L["transfers all entries to the party"],
				type = "execute",
				order = 2,
				func = function()
					local list = { }
					local koslist = VanasKoS:GetList(VANASKOS.showList);
					for k,v in pairs(koslist) do
						local name = k;
						local reason = v.reason;
						local creator = v.creator;

						if(v.creator == nil or creator == "") then
							creator = UnitName("player");
						end
						list[k] = { ["name"] = name,
									["reason"] = reason,
									["creator"] = creator };
					end

					local listToSend = { [VANASKOS.showList] = list };
					VanasKoSSynchronizer:SendCommMessage("PARTY", "addplayer", listToSend);
					VanasKoS:Print(L["Sent list to party"]);
				end
			},
			syncwith = {
				type = "group",
				name = L["Synchronize with"],
				desc = L["Initiates a manual Synchronize Request to..."],
				args = {
				}
			}
		}
	};

	local list = VanasKoS:GetList("SYNCPLAYER");
	if(list == nil) then
		return;
	end
	for k,v in pairs(list) do
		syncOptions.args.syncwith.args[k] = {
			type = "execute",
			name = string.Capitalize(k),
			desc = string.Capitalize(k),
			func = function()
				VanasKoSSynchronizer:StartSyncRequest(k);
			end,
		}
	end

	dewdrop:Unregister(this);
	VanasKoSListFrameSyncButton:SetScript("OnClick", function()
			dewdrop:Register(this,
				'children', syncOptions,
				'point', "TOPLEFT",
				'dontHook', true,
				'relativePoint', "TOPRIGHT"
			);
			this:SetScript("OnClick", function()
				if(dewdrop:IsOpen(this)) then
					dewdrop:Close();
				else
					dewdrop:Open(this);
				end
			end);
			this:GetScript("OnClick")();
	end);
end

function VanasKoSSynchronizer:SetList(listname, send, enabled)
	local name = VanasKoSGUI:GetSelectedEntryName();
	local list = VanasKoS:GetList("SYNCPLAYER");

	if(list[name] == nil) then
		return false;
	end

	if(send) then
		list = list[name].sendlists;
	else
		list = list[name].receivelists;
	end

	if(enabled) then
		if(not list[listname]) then
			list[listname] = { };
		end
		list[listname].synctype = "auto";
	else
		list[listname] = nil;
	end

	VanasKoSGUI:ScrollFrameUpdate();
end

function VanasKoSSynchronizer:IsListEnabled(listname, send)
	local name = VanasKoSGUI:GetSelectedEntryName():lower();
	local list = VanasKoS:GetList("SYNCPLAYER");

	if(list[name] == nil) then
		return false;
	end

	if(send) then
		list = list[name].sendlists;
	else
		list = list[name].receivelists;
	end

	if(list[listname] ~= nil) then
		return true;
	else
		return false;
	end
end

function VanasKoSSynchronizer:OnInitialize()
	VanasKoS:RegisterDefaults("Synchronizer", "profile", {
		Enabled = true,
		GuildShareInterval = 1.0,
		GuildListsToShare = {
			['*'] = false,
		},
		GuildAcceptList = {
			['*'] = {				-- PLAYERKOS, GUILDKOS, HATELIST, NICELIST
				['*'] = false,		-- playernames
			},
		}
	});
	VanasKoS:RegisterDefaults("Synchronizer", "realm", {
		autosync = {
			players = {
			},
			twinks = {
			},
		}
	});

	self:SetCommPrefix("VanasKoS");
	self.db = VanasKoS:AcquireDBNamespace("Synchronizer");

	-- import of old data, will be removed in some version in the future
	if(VanasKoS.db.realm.autosync) then
		self.db.realm.autosync = VanasKoS.db.realm.autosync;
		VanasKoS.db.realm.autosync = nil;
	end

	self.ReceivedLists = { };

	self:UpdateConfigurationOptions();
	VanasKoSGUI:AddConfigOption("Synchronizer", syncConfigOptions);

	VanasKoS:RegisterList(6, "SYNCPLAYER", L["Auto Sync"], self);
	VanasKoS:RegisterList(nil, "SYNCTWINKS", nil, self);

	self:RegisterThisChar();

	VanasKoSGUI:RegisterList("SYNCPLAYER", self);
end

function VanasKoSSynchronizer:OnEnable()
	if(not self.db.profile.Enabled) then
		return;
	end

	self:InitContextMenu();

	self:RegisterComm(self.commPrefix, "PARTY", "MessageReceived");

	self:UpdateSyncOptions();

	VanasKoSListFrameSyncButton:SetScript("OnClick", function()
			dewdrop:Register(this,
				'children', syncOptions,
				'point', "TOPLEFT",
				'dontHook', true,
				'relativePoint', "TOPRIGHT"
			);
			this:SetScript("OnClick", function()
				if(dewdrop:IsOpen(this)) then
					dewdrop:Close();
				else
					dewdrop:Open(this);
				end
			end);
			this:GetScript("OnClick")();
	end);
	self:RegisterComm(self.commPrefix, "WHISPER", "MessageReceived");
	self:RegisterComm(self.commPrefix, "GUILD", "MessageReceived");
	self.PeopleThatNeedSync = { };

	self:UpdateSyncNeedList();
	-- update need to sync with list every hour (number must be > than TryToSyncWithSomeOne number)
	VanasKoSSynchronizer:ScheduleRepeatingEvent("UpdateSyncNeedListID", self.UpdateSyncNeedList, 3600);
	VanasKoSSynchronizer:ScheduleRepeatingEvent("BroadcastListsToGuild", self.BroadcastToGuild, self.db.profile.GuildShareInterval * 3600);

	self:RegisterEvent("FRIENDLIST_UPDATE");
	if(IsInGuild()) then
		self:RegisterEvent("GUILD_ROSTER_UPDATE");
		-- update the guild roster
		GuildRoster();
	end

	-- update the friends list
	ShowFriends();
end

function VanasKoSSynchronizer:RegisterThisChar()
	VanasKoS:AddEntry("SYNCTWINKS", UnitName("player"), nil);
end

function VanasKoSSynchronizer:OnDisable()
	VanasKoSSynchronizer:CancelAllScheduledEvents();
	VanasKoSListFrameSyncButton:SetScript("OnClick", function() VanasKoS:Print(L["No Synchronization Options - Enable Auto Sync"]); end);
end

function VanasKoSSynchronizer:BroadcastToGuild()
	local list = { };
	local entries = 0;
	for listindex,listname in pairs({ "PLAYERKOS", "GUILDKOS", "HATELIST", "NICELIST" }) do
		if(VanasKoSSynchronizer.db.profile.GuildListsToShare[listname] == true) then
			list[listname] = { };
			local sourceList = VanasKoS:GetList(listname);
			for index, value in pairs(sourceList) do
				if(value.owner == nil) then
					list[listname][index] = value;
					entries = entries + 1;
				end
			end
		end
	end

	if(VANASKOS.DEBUG == 1) then
		VanasKoS:PrintLiteral("[DEBUG]: Guild Broadcast:", entries, "Entries", list);
		--VanasKoSSynchronizer:MessageReceived("VanasKoS", "Fake", "GUILD", "guildbroad", list)
	end
	if(entries > 0) then
		VanasKoSSynchronizer:SendCommMessage("GUILD", "guildbroad", list);
	end
	--VanasKoS:PrintLiteral(list);
end

function VanasKoSSynchronizer:RenderButton(list, buttonIndex, button, key, value, buttonText1, buttonText2)
	if(VANASKOS.showList == "SYNCPLAYER") then
		buttonText1:SetText(string.Capitalize(key));
		local receivelists = nil;
		if(value.receivelists == nil) then
			receivelists = L["None"];
		else
			receivelists = "";
			for k,v in pairs(value.receivelists) do
				receivelists = receivelists .. VanasKoSGUI:GetListName(k) .. " ";
			end
		end

		local sendlists = nil
		if(value.sendlists == nil) then
			sendlists = L["None"];
		else
			sendlists = "";
			for k,v in pairs(value.sendlists) do
				sendlists = sendlists .. VanasKoSGUI:GetListName(k) .. " ";
			end
		end
		buttonText2:SetText(format(L["Receive: %s, Send: %s"], receivelists, sendlists));

		button:Show();
	end

end

local oldChangeButtonScript = nil;
function VanasKoSSynchronizer:ShowList(list)
	oldChangeButtonScript = VanasKoSListFrameChangeButton:GetScript("OnClick");
	VanasKoSListFrameChangeButton:SetScript("OnClick",
		function()
			local buttonNr = VanasKoSGUI:GetSelectedButtonNumber();

			if(buttonNr ~= nil) then
				local button = getglobal("VanasKoSListFrameListButton" .. buttonNr);
				VanasKoSSynchronizer:ShowContextMenuForSyncList(button);
			end
		end
	);
	VanasKoSListFrameSyncButton:Disable();
end

function VanasKoSSynchronizer:HideList(list)
	VanasKoSListFrameChangeButton:SetScript("OnClick", oldChangeButtonScript);
	VanasKoSListFrameSyncButton:Enable();
end

function VanasKoSSynchronizer:AddEntry(listname, name, data)
	if(listname == "SYNCPLAYER") then
		local list = VanasKoS:GetList("SYNCPLAYER");
		list[name] = {
					["receivelists"] = {
							["PLAYERKOS"] = {
								["synctype"] = "auto",
							},
						},
					["sendlists"] = {
							["PLAYERKOS"] = {
								["synctype"] = "auto",
							},
						}
					};
		self:TriggerEvent("VanasKoS_List_Entry_Added", listname, name, nil);
		self:UpdateSyncOptions();
	elseif(listname == "SYNCTWINKS") then
		local list = VanasKoS:GetList("SYNCTWINKS");
		list[name] = true;
	else
		return nil;
	end
end

function VanasKoSSynchronizer:RemoveEntry(listname, name)
	local list = self:GetList(listname);
	if(list and list[name]) then
		list[name] = nil;
		self:TriggerEvent("VanasKoS_List_Entry_Removed", listname, name);
		self:UpdateSyncOptions();
	end
end

function VanasKoSSynchronizer:GetList(list)
	if(list == "SYNCPLAYER") then
		return self.db.realm.autosync.players;
	elseif(list == "SYNCTWINKS") then
		return self.db.realm.autosync.twinks;
	end
	return nil;
end

function VanasKoSSynchronizer:IsOnList(list, name)
	if(list == "SYNCPLAYER") then
		local listVar = self:GetList(list);
		if(listVar ~= nil and listVar[name]) then
			return true;
		else
			return nil;
		end
	end
	return nil;
end

function VanasKoSSynchronizer:FRIENDLIST_UPDATE()
	--[[if(VANASKOS.DEBUG == 1) then
		self:Print("[DEBUG]: FRIENDLIST_UPDATE");
	end]]
	for i=1, GetNumFriends() do
		local name, level, class, area, online, status = GetFriendInfo(i);
		if(name ~= nil) then
			local entry = VanasKoSSynchronizer.PeopleThatNeedSync[name:lower()];
			if(entry) then
				if(online) then
					entry.online = true;
				else
					entry.online = nil;
				end
			end
		end
	end
end

function VanasKoSSynchronizer:GuildRosterUpdate()
	for i=1, GetNumGuildMembers(1) do
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i);
		if(name ~= nil) then
			local entry = VanasKoSSynchronizer.PeopleThatNeedSync[name:lower()];
			if(entry) then
				if(online) then
					entry.online = true;
				else
					entry.online = nil;
				end
			end
		end
	end
	self:UpdateConfigurationOptions();
end

function VanasKoSSynchronizer:GUILD_ROSTER_UPDATE()
	if(arg1 ~= nil) then
		self:GuildRosterUpdate();
--[[		if(VANASKOS.DEBUG == 1) then
			self:Print("[DEBUG]: GUILD_ROSTER_UPDATE", arg1);
		end ]]
	end
end

function VanasKoSSynchronizer:UpdateSyncNeedList()
	local list = VanasKoS:GetList("SYNCPLAYER");
	local count = 0;
	PeopleThatNeedSync = { };

	for k,v in pairs(list) do
		if(not v.lastsynced or v.lastsynced < (time() - SYNCTIME)) then
			VanasKoSSynchronizer.PeopleThatNeedSync[k] = { ["lastsynced"] = v.lastsynced };
			count = count + 1;
		end
	end

	if(count > 0) then
		-- try a sync every 2 minutes
		VanasKoSSynchronizer:ScheduleRepeatingEvent("SyncTry", VanasKoSSynchronizer.TryToSyncWithSomeOne, 120)
	else
		VanasKoSSynchronizer:CancelScheduledEvent("SyncTry");
	end
end

function VanasKoSSynchronizer:TryToSyncWithSomeOne()
	VanasKoSSynchronizer:GuildRosterUpdate();

	local count = 0;
	for k,v in pairs(VanasKoSSynchronizer.PeopleThatNeedSync) do
		if(v.online) then
			VanasKoSSynchronizer:StartSyncRequest(k);

			-- even though it might not be correct - don't sync again if we didn't sync the entry will get reinserted as soon as the needsynclist is rebuilt.
			VanasKoSSynchronizer.PeopleThatNeedSync[k] = nil;
			return;
		end
		count = count + 1;
	end

	-- if there are no entries in the list, cancel the SyncTry repeating event (calling this function)
	if(count == 0) then
		VanasKoSSynchronizer:CancelScheduledEvent("SyncTry");
		return;
	end

	-- only offline entries
end

function VanasKoSSynchronizer:MessageReceived(prefix, sender, distribution, command, list)
	if(VANASKOS.DEBUG == 1) then
		self:PrintLiteral("Command", command, "received from", sender, list);
	end
	if(command == nil or sender == nil or list == nil) then
		return;
	end
	if(type(command) ~= "string" or
		type(list) ~= "table") then
		return;
	end

	sender = sender:lower();

	-- to not have compatibility problems when implementing guild sync
	if(distribution == "WHISPER") then
		if(command == "SYNCREQUESTDATA") then
			if(not self:ProcessList(sender, list)) then
				if(VANASKOS.DEBUG == 1) then
					VanasKoS:Print(L["No Autosync partner named %s"], sender);
				end
				return;
			end


			if(VANASKOS.DEBUG == 1) then
				self:Print("start Sync response to " .. sender);
			end
			VanasKoSSynchronizer.PeopleThatNeedSync[sender] = nil;

			self:StartSyncResponse(sender);
		end

		if(command == "SYNCRESPONSEDATA") then
			if(VANASKOS.DEBUG == 1) then
				self:Print("sync response received" .. sender);
			end
			self:ProcessList(sender, list);
		end
	end

	if(distribution == "GUILD") then
		if(command == "guildbroad") then
			if(VANASKOS.DEBUG == 1) then
				self:Print("[DEBUG]: Guild Broadcast List received from", sender);
			end
			for listname, listentry in pairs(list) do
				if(VanasKoSSynchronizer.db.profile.GuildAcceptList and
					VanasKoSSynchronizer.db.profile.GuildAcceptList[listname] and
					VanasKoSSynchronizer.db.profile.GuildAcceptList[listname][sender] == true) then
					-- let the entry as it is
				else
					list[listname] = nil;
				end
			end

			self:SyncListGeneric(sender, sender, time(), list);
		end
	end

	if(command == "addplayer") then
		if(list == nil) then
			return;
		end

		if(VanasKoSSynchronizer.ReceivedLists[sender] ~= nil) then
			self:Print(L["KoS-List was received but couldn't be processed due to previous received list."]);
			return nil;
		end

		local count = 0;
		local nameOfList = nil;
		for listname, listlist in pairs(list) do
			nameOfList = listname;
			for k,v in pairs(listlist) do
				count = count + 1;
			end
		end

		if(nameOfList ~= "PLAYERKOS" and
			nameOfList ~= "GUILDKOS" and
			nameOfList ~= "HATELIST" and
			nameOfList ~= "NICELIST") then

			return;
		end
		VanasKoSSynchronizer.ReceivedLists[sender] = list;
		local dialog = StaticPopup_Show("VANASKOS_QUESTION_ADD");
		if(dialog) then
			dialog.sender = sender;
			getglobal(dialog:GetName() .. "Text"):SetText(format(L["Accept %d entries for list %s from %s?"], count, VanasKoSGUI:GetListName(nameOfList), sender));
		end
	end
end

function VanasKoSSynchronizer:StartSyncRequest(receiver)
	local list = self:CreateList(receiver);
	if(list == nil) then
		VanasKoS:Print(L["No Autosync partner named %s"], receiver);
		return;
	end

	if(VANASKOS.DEBUG == 1) then
		self:Print("Initiating Sync Request to", receiver);
	end
	self:SendCommMessage("WHISPER", receiver, "SYNCREQUESTDATA", list);
end

function VanasKoSSynchronizer:StartSyncResponse(receiver)
	local list = self:CreateList(receiver);
	if(list == nil) then
		VanasKoS:Print(L["No Autosync partner named %s"], receiver);
		return;
	end

	if(VANASKOS.DEBUG == 1) then
		self:Print("Sync Response to", receiver);
	end

	self:SendCommMessage("WHISPER", receiver, "SYNCRESPONSEDATA", list);
end

-- TODO: fix memory leak if the received for that list isn't available - list doesnt get deleted
function VanasKoSSynchronizer:CreateList(receiver)
	local listVar = VanasKoS:GetList("SYNCPLAYER");
	local name = self:IsSenderAllowedToSync(receiver);

	if(name == nil) then
		return nil;
	end
	name = name:lower();

	local newList = { };
	-- sendlists = lists to send to the receiver
	for listname,listdata in pairs(listVar[name].sendlists) do
		local list = VanasKoS:GetList(listname);
		if(list ~= nil) then
			newList[listname] = { };
			for k,v in pairs(list) do
				if(v.owner == nil or v.owner == "") then
					newList[listname][k] = { };
					newList[listname][k].name = k;
					newList[listname][k].reason = v.reason;
					newList[listname][k].creator = v.creator;
				end
			end
		end
	end

	listVar = VanasKoS:GetList("SYNCTWINKS");
	newList["TWINKS"] = { };
	for k,v in pairs(listVar) do
		newList["TWINKS"][k] = v;
	end

	return newList;
end

function VanasKoSSynchronizer:GetAllowedAutoSyncList(sender)
	local allowedSyncs = VanasKoS:GetList("SYNCPLAYER");
	local name = self:IsSenderAllowedToSync(sender)

	if(allowedSyncs == nil or allowedSyncs[name] == nil) then
		return nil;
	end

	return allowedSyncs[name].receivelists;
end

function VanasKoSSynchronizer:AddTwinksToSyncPartner(sender, twinkList)
	local syncPlayer = VanasKoS:GetList("SYNCPLAYER");
	if(syncPlayer[sender:lower()]) then
		syncPlayer[sender:lower()].twinks = twinkList;
	end
end


function VanasKoSSynchronizer:ProcessList(sender, requestList)
	if(requestList == nil) then
		return false;
	end

	local allowedSyncs = self:GetAllowedAutoSyncList(sender);
	if(allowedSyncs == nil) then
		return false;
	end

	if(requestList["TWINKS"] ~= nil) then
		self:AddTwinksToSyncPartner(sender, requestList["TWINKS"]);
		requestList["TWINKS"] = nil;
	end

	-- delete lists that aren't allowed to be received
	for listname, list in pairs(requestList) do
		if(allowedSyncs[listname] == nil) then
			clear(requestList[listname]);
			requestList[listname] = nil;
		end
	end

	-- sync local list with cleaned requestList and check if sender is allowed to sync and set owner to mainchar
	VanasKoSSynchronizer:SyncList(sender, requestList);
	return true;
end

function VanasKoSSynchronizer:ListButtonOnClick(button)
	if(button == "RightButton") then
		VanasKoSSynchronizer:ShowContextMenuForSyncList();
	end
end

function VanasKoSSynchronizer:ShowContextMenuForSyncList(button)
	if(VANASKOS.showList ~= "SYNCPLAYER") then
		return;
	end

	if(button) then
		if(dewdrop:IsOpen(button)) then
			dewdrop:Close();
		else
			dewdrop:Open(button);
		end
		return;
	end

	if(dewdrop:IsOpen(this)) then
		dewdrop:Close();
	else
		dewdrop:Open(this);
	end
end

function VanasKoSSynchronizer:IsSenderAllowedToSync(name)
	assert(name ~= nil);
	local list = VanasKoS:GetList("SYNCPLAYER");
	name = name:lower();

	if(list[name]) then
		return name;
	else
		for k,v in pairs(list) do
			if(v.twinks ~= nil and v.twinks[name] ~= nil) then
				return k;
			end
		end

		return nil;
	end
end

-- synchronize all entries from sender to list
function VanasKoSSynchronizer:SyncList(sender, newlist)
	local currentTime = time();
	local owner = self:IsSenderAllowedToSync(sender);

	if(owner == nil) then
		return;
	else
		owner = owner:lower();
	end

	-- update lastsynced
	local synclist = VanasKoS:GetList("SYNCPLAYER")
	if(synclist[owner]) then
		synclist[owner].lastsynced = currentTime;

		self:UpdateSyncNeedList();
	end

	self:SyncListGeneric(sender, owner, currentTime, newlist);

	-- force a refresh of the gui list
	VanasKoSGUI:ScrollFrameUpdate();
end

function VanasKoSSynchronizer:SyncListGeneric(sender, owner, synctime, newlist)
	for listname, list in pairs(newlist) do
		local destList = VanasKoS:GetList(listname);
		if(destList ~= nil) then
			-- create and update all entries on the list
			for k,v in pairs(list) do
				local name = k:lower();
				if(destList[name] and
					(destList[name].owner == nil or
					destList[name].owner == "")) then
					-- i already created the kos entry, don't touch it
				else
					if(v.owner == nil or v.owner == "") then
						v.owner = sender:lower();
					end
					if(v.creator == nil or v.creator == "") then
						v.creator = sender:lower();
					end

					if(destList[name]) then
						destList[name].reason = v.reason;
						destList[name].sender = sender:lower();
						destList[name].creator = v.creator:lower();
						destList[name].owner = owner;
						destList[name].lastupdated = synctime;
					else
						destList[name] = { ["reason"] = v.reason,
											["sender"] = sender:lower(),
											["creator"] = v.creator:lower(),
											["owner"] = owner:lower(),
											["lastupdated"] = synctime };
					end
					if(destList[name].created == nil) then
						destList[name].created = synctime;
					end
				end
			end

			-- delete old from that owner  that werent just synced
			for k,v in pairs(destList) do
				if(v.owner ~= nil and
					v.owner:lower() == owner:lower() and
					(not v.lastupdated or
						(v.lastupdated and v.lastupdated ~= synctime))) then
					destList[k] = nil
				end
			end
		end
	end
end

function VanasKoSSynchronizer:AddEntrySync(sender, rlist)
	if(sender == nil or rlist == nil) then
		return;
	end

	for listname, list in pairs(rlist) do
		local listVar = VanasKoS:GetList(listname);
		for k, v in pairs(list) do
			local name = k:lower();
			if(not VanasKoS:IsOnList(listname, name)) then
				if(not v.creator or v.creator == "") then
					v.creator = sender;
				end
				listVar[name] = { ["reason"] = v.reason, ["sender"] = sender, ["creator"] = v.creator, ["created"] = time(), ["lastupdated"] = time() };
				self:TriggerEvent("VanasKoS_List_Entry_Added", listname, name, { ['reason'] = v.reason });
			end
		end

		-- only add entries from the first list
		return;
	end
end

StaticPopupDialogs["VANASKOS_QUESTION_ADD"] = {
	text = "TEMPLATE",
	button1 = L["Accept"],
	button2 = L["Cancel"],
	OnAccept = function()
		local dialog = this:GetParent();

		VanasKoSSynchronizer:AddEntrySync(dialog.sender, VanasKoSSynchronizer.ReceivedLists[dialog.sender]);
		VanasKoSGUI:Update();
	end,
	OnHide = function()
		VanasKoSSynchronizer.ReceivedLists[this.sender] = nil;

		if(ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
	end,
	timeout = 10,
	exclusive = 0,
	whileDead = 1,
	hideOnEscape = 1
}
