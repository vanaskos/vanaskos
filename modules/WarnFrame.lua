--[[----------------------------------------------------------------------
      WarnFrame Module - Part of VanasKoS
Creates the WarnFrame to alert of nearby KoS, Hostile and Friendly
------------------------------------------------------------------------]]

VanasKoSWarnFrame = VanasKoS:NewModule("WarnFrame", "AceEvent-3.0", "AceTimer-3.0");

local VanasKoSWarnFrame = VanasKoSWarnFrame;
local VanasKoS = VanasKoS;

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_WarnFrame", false);

local warnFrame = nil;
local warnButtonsOOC = nil;
local warnButtonsCombat = nil;
local classIcons = nil;
local tooltipFrame = nil;
local testFontFrame = nil;
local testFontString = nil;

local nearbyKoS = nil;
local nearbyEnemy = nil;
local nearbyFriendly = nil;
local nearbyKoSCount = 0;
local nearbyEnemyCount = 0;
local nearbyFriendlyCount = 0;

local dataCache = nil;
local buttonData = nil;

local timer = nil;

local function GetColor(which)
	return VanasKoSWarnFrame.db.profile[which .. "R"], VanasKoSWarnFrame.db.profile[which .. "G"], VanasKoSWarnFrame.db.profile[which .. "B"], VanasKoSWarnFrame.db.profile[which .. "A"];
end

local function SetColor(which, r, g, b, a)
	warnFrame:SetBackdropColor(r, g, b, a);

	VanasKoSWarnFrame.db.profile[which .. "R"] = r;
	VanasKoSWarnFrame.db.profile[which .. "G"] = g;
	VanasKoSWarnFrame.db.profile[which .. "B"] = b;
	VanasKoSWarnFrame.db.profile[which .. "A"] = a;
end

local function GetTooltipText(name, data)
	local result = "";
	local data = VanasKoS:GetPlayerData(name);
	
	if (data and data.level ~= nil) then
		result = result .. L["Level"] .. " " .. data.level .. " ";
	end
	if (data and data.race ~= nil) then
		result = result .. data.race .. " ";
	end
	if (data and data.class ~= nil) then
		result = result .. data.class .. " ";
	end
	if (data and data.guild ~= nil) then
		result = result .. "<" .. data.guild .. "> ";
	end

	local playerkos = VanasKoS:IsOnList("PLAYERKOS", name) and VanasKoS:IsOnList("PLAYERKOS", name).reason;
	local nicelist = VanasKoS:IsOnList("NICELIST", name) and VanasKoS:IsOnList("NICELIST", name).reason;
	local hatelist = VanasKoS:IsOnList("HATELIST", name) and VanasKoS:IsOnList("HATELIST", name).reason;
	local guildkos = nil;
	if (showDetails and data.guild) then
		guildkos = VanasKoS:IsOnList("GUILDKOS", data.guild) and VanasKoS:IsOnList("GUILDKOS", data.guild).reason;
	end

	local reason = nil;
	if (playerkos ~= nil) then
		reason = playerkos;
	elseif (nicelist ~= nil) then
		reason = nicelist;
	elseif (hatelist ~= nil) then
		reason = hatelist;
	elseif (guildkos ~= nil) then
		reason = guildkos;
	end

	if (reason ~= nil) then
		result = result .. "(" .. reason .. ") ";
	end

	if(result == "") then
		result = L["No Information Available"];
	end

	return result;
end

local function ShowTooltip(buttonNr)
	if(not VanasKoSWarnFrame.db.profile.ShowMouseOverInfos) then
		if(tooltipFrame:IsVisible()) then
			tooltipFrame:Hide();
		end
		return;
	end

	local name = buttonData[buttonNr];
	tooltipFrame:SetText(GetTooltipText(name), dataCache[name]);

	tooltipFrame:ClearAllPoints();

	local x, y = GetCursorPosition(); -- gets coordinates based on WorldFrame position
	local scale = UIParent:GetEffectiveScale();

	if(WorldFrame:GetRight() < (x + (tooltipFrame:GetTextWidth()+10)*scale)) then
		tooltipFrame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", x/scale, y/scale);
	else
		tooltipFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x/scale, y/scale);
	end

	tooltipFrame:SetWidth(tooltipFrame:GetTextWidth()+10);
	tooltipFrame:SetHeight(VanasKoSWarnFrame.db.profile.WARN_TOOLTIP_HEIGHT);

	tooltipFrame:Show();
end

local function CreateWarnFrame()
	if(warnFrame ~= nil) then
		return;
	end
	-- Create the Main Window
	warnFrame = CreateFrame("Button", "VanasKoS_WarnFrame", UIParent);
	warnFrame:SetWidth(VanasKoSWarnFrame.db.profile.WARN_FRAME_WIDTH);
	warnFrame:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTONS * VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT +
			    VanasKoSWarnFrame.db.profile.WARN_FRAME_HEIGHT_PADDING * 2 + 1);
	warnFrame:SetPoint("CENTER");
	warnFrame:SetToplevel(true);
	warnFrame:SetMovable(true);
	warnFrame:SetFrameStrata("LOW");
	if(VanasKoSWarnFrame.db.profile.WarnFrameBorder) then
		VanasKoS_WarnFrame:SetBackdrop( {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
					insets = { left = 5, right = 4, top = 5, bottom = 5 },
		});
		warnFrame:EnableMouse(true);
	else
		VanasKoS_WarnFrame:SetBackdrop({bgfile = nil, edgeFile = nil});
		warnFrame:EnableMouse(false);
	end
	-- set the default backdrop color
	local r, g, b, a = GetColor("DefaultBGColor");
	warnFrame:SetBackdropColor(r, g, b, a);

	-- allow dragging or the window
	warnFrame:RegisterForDrag("LeftButton");
	warnFrame:SetScript("OnDragStart",
							function()
								if(VanasKoSWarnFrame.db.profile.Locked) then
									return;
								end
								warnFrame:StartMoving();
							end);
	warnFrame:SetScript("OnDragStop",
							function()
								warnFrame:StopMovingOrSizing();
							end);
	warnFrame:Hide();
end

local function CreateTooltipFrame()
	if(tooltipFrame) then
		return;
	end

	tooltipFrame = CreateFrame("Button", nil, UIParent);
	tooltipFrame:SetWidth(400);
	tooltipFrame:SetHeight(VanasKoSWarnFrame.db.profile.WARN_TOOLTIP_HEIGHT);
	tooltipFrame:SetPoint("CENTER");
	tooltipFrame:SetFrameStrata("DIALOG");
	tooltipFrame:SetToplevel(true);
	tooltipFrame:SetBackdrop( {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 5, right = 4, top = 5, bottom = 5 }
	});
	local r, g, b, a = GetColor("DefaultBGColor");
	tooltipFrame:SetBackdropColor(r, g, b, a);
	tooltipFrame:SetNormalFontObject("GameFontWhite");

	tooltipFrame:Hide();
end

-- tnx to pitbull =)
local classIconNameToCoords = {
	["WARRIOR"] = {0, 0.25, 0, 0.25},
	["MAGE"] = {0.25, 0.49609375, 0, 0.25},
	["ROGUE"] = {0.49609375, 0.7421875, 0, 0.25},
	["DRUID"] = {0.7421875, 0.98828125, 0, 0.25},
	["HUNTER"] = {0, 0.25, 0.25, 0.5},
	["SHAMAN"] = {0.25, 0.49609375, 0.25, 0.5},
	["PRIEST"] = {0.49609375, 0.7421875, 0.25, 0.5},
	["WARLOCK"] = {0.7421875, 0.98828125, 0.25, 0.5},
	["PALADIN"] = {0, 0.25, 0.5, 0.75},
	["DEATHKNIGHT"] = {0.25, 0.49609375, 0.5, 0.75},
}

local function CreateWarnFrameFonts(size)
	local warnFont;

	if (testFontFrame == nil) then
		testFontFrame = CreateFrame("Button", nil, UIParent);
		testFontFrame:SetText("XXXXXXXXXXXX [00+]");
		testFontFrame:Hide();
	end

	warnFont = CreateFont("VanasKoS_FontKos");
	warnFont:SetFont("Fonts\\FRIZQT__.TTF", size);
	warnFont:SetTextColor(1.0, 0.82, 0.0);

	warnFont = CreateFont("VanasKoS_FontEnemy");
	warnFont:SetFont("Fonts\\FRIZQT__.TTF", size);
	warnFont:SetTextColor(0.9, 0.0, 0.0);

	warnFont = CreateFont("VanasKoS_FontFriendly");
	warnFont:SetFont("Fonts\\FRIZQT__.TTF", size);
	warnFont:SetTextColor(0.0, 1.0, 0.0);

	warnFont = CreateFont("VanasKoS_FontNormal");
	warnFont:SetFont("Fonts\\FRIZQT__.TTF", size);
	warnFont:SetTextColor(1.0, 1.0, 1.0);

	testFontFrame:SetNormalFontObject("VanasKoS_FontNormal");
	local h = math.floor(testFontFrame:GetTextHeight() + 5);
	local w = math.floor(testFontFrame:GetTextWidth() + 5) + h;
	VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT = h;
	VanasKoSWarnFrame.db.profile.WARN_FRAME_WIDTH = w;
end


local function CreateClassIcons()
	if(classIcons) then
		return;
	end

	classIcons = { };
	local i = 1;
	for i=1,VanasKoSWarnFrame.db.profile.WARN_BUTTONS_MAX do
			local classIcon = CreateFrame("Button", nil, warnFrame);
			classIcon:SetPoint("LEFT", warnButtonsCombat[i], "LEFT", 5, 0);
			classIcon:SetWidth(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT);
			classIcon:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT);

			local texture = classIcon:CreateTexture(nil, "ARTWORK");
			texture:SetAllPoints(classIcon);
			texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");

			classIcon:Hide();

			classIcons[i] = { classIcon, texture };
		end
	end

	local function setButtonClassIcon(iconNr, class)
		if(class == nil) then
			classIcons[iconNr][1]:Hide();
			return;
		end

		local coords = classIconNameToCoords[class];
		if(not coords) then
			VanasKoS:Print("Unknown class " .. class);
			return;
		end
		classIcons[iconNr][2]:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
		classIcons[iconNr][1]:Show();
	end

	local function CreateOOCButtons()
		if(warnButtonsOOC) then
			return;
		end
		warnButtonsOOC = { };
		
		local i=1;
		for i=1,VanasKoSWarnFrame.db.profile.WARN_BUTTONS_MAX do
			local warnButton = CreateFrame("Button", nil, warnFrame, "SecureActionButtonTemplate");
		if(i == 1) then
			warnButton:SetPoint("TOP", warnFrame, 0, -5);
		else
			warnButton:SetPoint("TOP", warnButtonsOOC[i-1], "BOTTOM", 0, 0);
		end

		warnButton:SetWidth(VanasKoSWarnFrame.db.profile.WARN_FRAME_WIDTH);
		warnButton:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT);
		warnButton:EnableMouse(true);
		warnButton:SetFrameStrata("MEDIUM");
		warnButton:RegisterForClicks("LeftButtonUp");
		warnButton:SetAttribute("type1", "macro");
		warnButton:SetAttribute("macrotext", "/wave");

		warnButton:SetScript("OnEnter", function()
											ShowTooltip(i);
										end);
		warnButton:SetScript("OnLeave", function()
											tooltipFrame:Hide();
										end);
		if (i <= VanasKoSWarnFrame.db.profile.WARN_BUTTONS) then
			warnButton:Show();
		else
			warnButton:Hide();
		end

		warnButtonsOOC[i] = warnButton;
	end
end

local function CreateCombatButtons()
	if(warnButtonsCombat) then
		return;
	end
	warnButtonsCombat = { };

	local i = 0;
	for i=1,VanasKoSWarnFrame.db.profile.WARN_BUTTONS_MAX do
		local warnButton = CreateFrame("Button", nil, warnFrame);
		-- same size as OOC buttons
		warnButton:SetAllPoints(warnButtonsOOC[i]);
		warnButton:EnableMouse(true);
		warnButton:SetNormalFontObject("GameFontWhiteSmall");
		warnButton:RegisterForClicks("LeftButtonUp");
		warnButton:SetFrameStrata("HIGH");

		warnButton:SetScript("OnEnter", function() ShowTooltip(i); end);
		warnButton:SetScript("OnLeave", function() tooltipFrame:Hide(); end);

		warnButton:Hide();

		warnButtonsCombat[i] = warnButton;
	end
end

local function HideButton(buttonNr)
	if(not warnButtonsOOC or not warnButtonsOOC[buttonNr]) then
		return;
	end
	if(InCombatLockdown()) then
		warnButtonsOOC[buttonNr]:SetText("");
		warnButtonsOOC[buttonNr]:SetAlpha(0);
		warnButtonsCombat[buttonNr]:SetText("");
		warnButtonsCombat[buttonNr]:EnableMouse(false);
		warnButtonsCombat[buttonNr]:Hide();
	else
		warnButtonsOOC[buttonNr]:SetText("");
		warnButtonsOOC[buttonNr]:EnableMouse(false);
		warnButtonsOOC[buttonNr]:SetAlpha(0);
		warnButtonsOOC[buttonNr]:Hide();
		warnButtonsCombat[buttonNr]:SetText("");
		warnButtonsCombat[buttonNr]:EnableMouse(false);
		warnButtonsCombat[buttonNr]:Hide();
	end

	if (VanasKoSWarnFrame.db.profile.ShowClassIcons) then
		setButtonClassIcon(buttonNr, nil);
	end
	buttonData[buttonNr] = nil;
end

local function HideWarnFrame()
	if (not InCombatLockdown()) then
		warnFrame:Hide();
	end
end

local function ShowWarnFrame()
	if (not InCombatLockdown()) then
		warnFrame:Show();
	end
end

local function UpdateWarnSize()
	warnFrame:SetWidth(VanasKoSWarnFrame.db.profile.WARN_FRAME_WIDTH);
	warnFrame:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTONS * VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT +
				VanasKoSWarnFrame.db.profile.WARN_FRAME_HEIGHT_PADDING * 2 + 1);
	for i=1, VanasKoSWarnFrame.db.profile.WARN_BUTTONS_MAX do
		warnButtonsCombat[i]:SetWidth(VanasKoSWarnFrame.db.profile.WARN_FRAME_WIDTH);
		warnButtonsCombat[i]:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT);
		warnButtonsOOC[i]:SetWidth(VanasKoSWarnFrame.db.profile.WARN_FRAME_WIDTH);
		warnButtonsOOC[i]:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT);
		classIcons[i][1]:SetWidth(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT);
		classIcons[i][1]:SetHeight(VanasKoSWarnFrame.db.profile.WARN_BUTTON_HEIGHT);
		if (i > VanasKoSWarnFrame.db.profile.WARN_BUTTONS) then
			HideButton(i);
		end
	end
end

local function RegisterConfiguration()
	VanasKoSGUI:AddConfigOption("VanasKoS-WarnFrame", {
		type = 'group',
		name = L["Warning Window"],
		desc = L["KoS/Enemy/Friendly Warning Window"],
		args = {
			enabled = {
				type = 'toggle',
				name = L["Enabled"],
				desc = L["Enabled"],
				order = 1,
				set = function(frame, v) VanasKoS:ToggleModuleActive("WarnFrame"); VanasKoSWarnFrame:Update();end,
				get = function() return VanasKoSWarnFrame.db.profile.Enabled; end,
			},
			locked = {
				type = 'toggle',
				name = L["Locked"],
				desc = L["Locked"],
				order = 2,
				set = function(frame, v) VanasKoSWarnFrame.db.profile.Locked = v; end,
				get = function() return VanasKoSWarnFrame.db.profile.Locked; end,
			},
			hideifinactive = {
				type = 'toggle',
				name = L["Hide if inactive"],
				desc = L["Hide if inactive"],
				order = 3,
				set = function(frame, v) VanasKoSWarnFrame.db.profile.HideIfInactive = v; VanasKoSWarnFrame:Update(); end,
				get = function() return VanasKoSWarnFrame.db.profile.HideIfInactive; end,
			},
			setLines = {
				type = 'range',
				name = L["Number of lines"],
				desc = L["Sets the number of entries to display in the Warnframe"],
				order = 4,
				get = function() return VanasKoSWarnFrame.db.profile.WARN_BUTTONS; end,
				set = function(frame, v)
						VanasKoSWarnFrame.db.profile.WARN_BUTTONS = v;
						UpdateWarnSize();
						VanasKoSWarnFrame:Update();
					end,
				min = 1,
				max = VanasKoSWarnFrame.db.profile.WARN_BUTTONS_MAX,
				step = 1,
				isPercent = false,
			},
			showBorder = {
				type = 'toggle',
				name = L["Show border"],
				desc = L["Show border"],
				order = 5,
				set = function(frame, v) 
						VanasKoSWarnFrame.db.profile.WarnFrameBorder = v;
						if (v == true) then
							VanasKoS_WarnFrame:SetBackdrop( {
								bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
								edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
								insets = { left = 5, right = 4, top = 5, bottom = 5 },
							});
							warnFrame:EnableMouse(true);
						else
							VanasKoS_WarnFrame:SetBackdrop({bgfile = nil, edgeFile = nil});
							warnFrame:EnableMouse(false);
						end
						VanasKoSWarnFrame:Update();
					end,
				get = function() return VanasKoSWarnFrame.db.profile.WarnFrameBorder; end,
			},
			fontSize = {
				type = 'range',
				name = L["Font Size"],
				desc = L["Sets the size of the font in the Warnframe"],
				order = 6,
				get = function() return VanasKoSWarnFrame.db.profile.FontSize; end,
				set = function(frame, v)
						VanasKoSWarnFrame.db.profile.FontSize = v;
						CreateWarnFrameFonts(VanasKoSWarnFrame.db.profile.FontSize);
						UpdateWarnSize();
						VanasKoSWarnFrame:Update();
					end,
				min = 6,
				max = 20,
				step = 1,
				isPercent = false,
			},
			growUp = {
				type = 'toggle',
				name = L["Grow list upwards"],
				desc = L["Grow list from the bottom of the WarnFrame"],
				order = 7,
				get = function () return VanasKoSWarnFrame.db.profile.GrowUp; end,
				set = function (frame, v)
					VanasKoSWarnFrame.db.profile.GrowUp = v;
					VanasKoSWarnFrame:Update();
				end,
			},
			reset = {
				type = 'execute',
				name = L["Reset Position"],
				desc= L["Reset Position"],
				order = 8,
				func = function() VanasKoS_WarnFrame:ClearAllPoints(); VanasKoS_WarnFrame:SetPoint("CENTER"); end,
			},
			contentHeader = {
				type = 'header',
				name = L["Content"],
				desc = L["What to show in it"],
				order = 9,
			},
			contentShowLevel = {
				type = 'toggle',
				name = L["Show Target Level When Possible"],
				desc = L["Show Target Level When Possible"],
				order = 9,
				get = function() return VanasKoSWarnFrame.db.profile.ShowTargetLevel; end,
				set = function(frame, v) VanasKoSWarnFrame.db.profile.ShowTargetLevel = v; VanasKoSWarnFrame:Update(); end
			},
			contentShowKoS = {
				type = 'toggle',
				name = L["Show KoS Targets"],
				desc = L["Show KoS Targets"],
				order = 10,
				get = function() return VanasKoSWarnFrame.db.profile.ShowKoS; end,
				set = function(frame, v) VanasKoSWarnFrame.db.profile.ShowKoS = v; VanasKoSWarnFrame:Update(); end
			},
			contentShowHostile = {
				type = 'toggle',
				name = L["Show Hostile Targets"],
				desc = L["Show Hostile Targets"],
				order = 11,
				get = function() return VanasKoSWarnFrame.db.profile.ShowHostile; end,
				set = function(frame, v) VanasKoSWarnFrame.db.profile.ShowHostile = v; VanasKoSWarnFrame:Update(); end
			},
			contentShowFriendly = {
				type = 'toggle',
				name = L["Show Friendly Targets"],
				desc = L["Show Friendly Targets"],
				order = 12,
				get = function() return VanasKoSWarnFrame.db.profile.ShowFriendly; end,
				set = function(frame, v) VanasKoSWarnFrame.db.profile.ShowFriendly = v; VanasKoSWarnFrame:Update(); end
			},
			contentShowMouseOverInfos = {
				type = 'toggle',
				name = L["Show additional Information on Mouse Over"],
				desc = L["Toggles the display of additional Information on Mouse Over"],
				order = 13,
				get = function() return VanasKoSWarnFrame.db.profile.ShowMouseOverInfos; end,
				set = function(frame, v) VanasKoSWarnFrame.db.profile.ShowMouseOverInfos = v; VanasKoSWarnFrame:Update(); end
			},
			contentShowClassIcons = {
				type = 'toggle',
				name = L["Show class icons"],
				desc = L["Toggles the display of Class icons in the Warnframe"],
				order = 14,
				get = function() return VanasKoSWarnFrame.db.profile.ShowClassIcons; end,
				set = function(frame, v)
						VanasKoSWarnFrame.db.profile.ShowClassIcons = v;
						VanasKoSWarnFrame:Update();
						for i=1,VanasKoSWarnFrame.db.profile.WARN_BUTTONS do
							setButtonClassIcon(i, nil);
						end
					end
			},
			designHeader = {
				type = 'header',
				name = L["Design"],
				desc = L["How the content is shown"],
				order = 15,
			},
			designDefaultBackdropBackgroundColor = {
				type = 'color',
				name = L["Default Background Color"],
				desc = L["Sets the default Background Color and Opacity"],
				order = 16,
				get = function() return GetColor("DefaultBGColor") end,
				set = function(frame, r, g, b, a) SetColor("DefaultBGColor", r, g, b, a); end,
				hasAlpha = true,
			},
			designMoreHostilesBackdropBackgroundColor = {
				type = 'color',
				name = L["More Hostiles than Allied Background Color"],
				desc = L["Sets the more Hostiles than Allied Background Color and Opacity"],
				order = 17,
				get = function() return GetColor("MoreHostileBGColor"); end,
				set = function(frame, r, g, b, a) SetColor("MoreHostileBGColor", r, g, b, a); end,
				hasAlpha = true
			},
			designMoreAlliedBackdropBackgroundColor = {
				type = 'color',
				name = L["More Allied than Hostiles Background Color"],
				desc = L["Sets the more Allied than Hostiles Background Color and Opacity"],
				order = 18,
				get = function() return GetColor("MoreAlliedBGColor"); end,
				set = function(frame, r, g, b, a) SetColor("MoreAlliedBGColor", r, g, b, a); end,
				hasAlpha = true
			},
			designResetBackgroundColors = {
				type = 'execute',
				name = L["Reset Background Colors"],
				desc = L["Resets all Background Colors to default Settings"],
				order = 19,
				func = function()
							SetColor("MoreHostileBGColor", 1.0, 0.0, 0.0, 0.5);
							SetColor("MoreAlliedBGColor", 0.0, 1.0, 0.0, 0.5);
							SetColor("DefaultBGColor", 0.5, 0.5, 1.0, 0.5);
						end,
			},
		}
	});

end

function VanasKoSWarnFrame:OnInitialize()
	self.db = VanasKoS.db:RegisterNamespace("WarnFrame", {
		profile = {
			Enabled = true,
			HideIfInactive = false,
			Locked = false,
			WarnFrameBorder = true,

			ShowTargetLevel = true,
			ShowKoS = true,
			ShowHostile = true,
			ShowFriendly = true,
			ShowMouseOverInfos = false,
			ShowClassIcons = true,
			GrowUp = false,

			DefaultBGColorR = 0.5,
			DefaultBGColorG = 0.5,
			DefaultBGColorB = 1.0,
			DefaultBGColorA = 0.5,

			MoreHostileBGColorR = 1.0,
			MoreHostileBGColorG = 0.0,
			MoreHostileBGColorB = 0.0,
			MoreHostileBGColorA = 0.5,

			MoreAlliedBGColorR = 0.0,
			MoreAlliedBGColorG = 1.0,
			MoreAlliedBGColorB = 0.0,
			MoreAlliedBGColorA = 0.5,

			FontSize = 10;
			WARN_FRAME_WIDTH = 130;
			WARN_FRAME_WIDTH_PADDING = 5;
			WARN_FRAME_WIDTH_EMPTY = 130;
			WARN_FRAME_HEIGHT_PADDING = 5;
			WARN_FRAME_HEIGHT_EMPTY = 5;

			WARN_TOOLTIP_HEIGHT = 24;

			WARN_BUTTON_HEIGHT = 16;
			WARN_BUTTONS = 5;

			WARN_BUTTONS_MAX = 20;
		}
	});

	nearbyKoS = { };
	nearbyEnemy = { };
	nearbyFriendly = { };
	dataCache = { };
	buttonData = { };

	CreateWarnFrame();
	RegisterConfiguration();
	
	self:SetEnabledState(self.db.profile.Enabled);
end

function VanasKoSWarnFrame:OnEnable()
	--CreateWarnFrame();
	CreateOOCButtons();
	CreateCombatButtons();
	CreateTooltipFrame();
	CreateClassIcons();
	CreateWarnFrameFonts(self.db.profile.FontSize);

	self:RegisterMessage("VanasKoS_Player_Detected", "Player_Detected");

	warnFrame:SetAlpha(1);
	self:Update();

	if(timer == nil) then
		timer = self:ScheduleRepeatingTimer("UpdateList", 1);
	end
	self:RegisterEvent("PLAYER_REGEN_ENABLED");
end

function VanasKoSWarnFrame:OnDisable()
	self:UnregisterAllEvents();
	self:CancelAllTimers();
	timer = nil;
	
	wipe(nearbyKoS);
	wipe(nearbyEnemy);
	wipe(nearbyFriendly);
	wipe(dataCache);
	wipe(buttonData);
	
	self:Update();
	warnFrame:Hide();
end

function VanasKoSWarnFrame:PLAYER_REGEN_ENABLED(event) -- ...
	self:Update();
end

local function RemovePlayer(name)
	if(nearbyKoS[name]) then
		nearbyKoS[name] = nil;
		nearbyKoSCount = nearbyKoSCount - 1;
	end

	if(nearbyEnemy[name]) then
		nearbyEnemy[name] = nil;
		nearbyEnemyCount = nearbyEnemyCount - 1;
	end

	if(nearbyFriendly[name]) then
		nearbyFriendly[name] = nil;
		nearbyFriendlyCount = nearbyFriendlyCount - 1;
	end

	if(dataCache[name]) then
		wipe(dataCache[name]);
		dataCache[name] = nil;
	end
end

function VanasKoSWarnFrame:UpdateList()
	local t = time();
	for k, v in pairs(nearbyKoS) do
		if(t-v > 60) then
			RemovePlayer(k);
		end
	end
	for k, v in pairs(nearbyEnemy) do
		if(t-v > 10) then
			RemovePlayer(k);
		end
	end
	for k, v in pairs(nearbyFriendly) do
		if(t-v > 10) then
			RemovePlayer(k);
		end
	end
	
	VanasKoSWarnFrame:Update();
end


-- /Script VanasKoSWarnFrame:Player_Detected("xxx", nil, "enemy"); VanasKoSWarnFrame:Player_Detected("xxx2", nil, "enemy");
-- /script local x = {  ['name'] = 'x', ['faction'] = 'enemy', ['class'] = 'Poser',  ['race'] = 'GM', ['level'] = "31336"} ; for i=1,10000 do x.name = "xxx" .. math.random(1, 1000); VanasKoSWarnFrame:Player_Detected("VanasKoS_Player_Detected", x); end
local UNKNOWNLOWERCASE = UNKNOWN:lower();


function VanasKoSWarnFrame:Player_Detected(message, data)
	if(not self.db.profile.Enabled) then
		return;
	end

	assert(data.name ~= nil);

	local name = data.name:trim():lower();
	local faction = data.faction;

	-- exclude unknown entitity entries
	if(name == UNKNOWNLOWERCASE) then
		return;
	end

	if(faction == "kos" and self.db.profile.ShowKoS) then
		if(not nearbyKoS[name]) then
			nearbyKoSCount = nearbyKoSCount + 1;
		end
		nearbyKoS[name] = time();
	elseif(faction == "enemy" and self.db.profile.ShowHostile) then
		if(not nearbyEnemy[name]) then
			nearbyEnemyCount = nearbyEnemyCount + 1;
		end
		nearbyEnemy[name] = time();
	elseif(faction == "friendly" and self.db.profile.ShowFriendly) then
		if(not nearbyFriendly[name]) then
			nearbyFriendlyCount = nearbyFriendlyCount + 1;
		end
		nearbyFriendly[name] = time();
	else
		return;
	end

	if (not dataCache[name]) then
		dataCache[name] = { };
	end
	dataCache[name]['name'] = data.name:trim();
	dataCache[name]['faction'] = faction;

	if(data.level) then
		dataCache[name]['level'] = data.level;
	end
	if(data.classEnglish) then
		dataCache[name]['classEnglish'] = data.classEnglish;
	end
	if(data.class) then
		dataCache[name]['class'] = data.class;
	end
	if(data.race) then
		dataCache[name]['race'] = data.race;
	end
	
	self:Update();
end

local function GetButtonText(name, data)
	assert(name ~= nil);
	
	local result = string.Capitalize(name);

	local data = VanasKoS:GetPlayerData(name);
	
	-- Create a cache entry.
	if(VanasKoSWarnFrame.db.profile.ShowTargetLevel) then
		local level = nil;

		-- If there is a player level coming in, record it.
		if (data ~= nil and data.level ~= nil and data.level ~= "") then
			level = data.level;
			if (tonumber(level) == -1) then
				level = "??";
			end
		end

		-- If we have a level, append it.
		if (level ~= nil) then
			result = result .. " [" .. tostring(level) .. "]";
		end

		-- TODO: lookup in last seen list
	end

	return result;
end

local function GetFactionFont(faction)
	if(faction == "kos") then
		return "VanasKoS_FontKos";
	elseif(faction == "enemy") then
		return "VanasKoS_FontEnemy";
	elseif(faction == "friendly") then
		return "VanasKoS_FontFriendly";
	end

	return "VanasKoS_FontNormal";
end

local function SetButton(buttonNr, name, faction, data)
	if(InCombatLockdown()) then
		warnFrame:SetBackdropBorderColor(1.0, 0.0, 0.0);
		if(buttonData[buttonNr] ~= name) then
			-- new data for the button, we have to do something
			if(warnButtonsOOC[buttonNr]:GetAlpha() > 0) then
				-- ooc button visible
				warnButtonsOOC[buttonNr]:SetAlpha(0);
			end

			warnButtonsCombat[buttonNr]:SetNormalFontObject(GetFactionFont(faction));
			warnButtonsCombat[buttonNr]:SetText(GetButtonText(name), data);
			warnButtonsCombat[buttonNr]:Show();
		else
			warnButtonsOOC[buttonNr]:SetText(GetButtonText(name), data);
			warnButtonsCombat[buttonNr]:SetText(GetButtonText(name), data);
		end
	else
		warnFrame:SetBackdropBorderColor(0.8, 0.8, 0.8);
		if(buttonData[buttonNr] ~= name or warnButtonsOOC[buttonNr]:GetAlpha() == 0) then
			warnButtonsOOC[buttonNr]:SetAlpha(1);
			warnButtonsCombat[buttonNr]:Hide();
			warnButtonsOOC[buttonNr]:SetNormalFontObject(GetFactionFont(faction));
			warnButtonsOOC[buttonNr]:SetText(GetButtonText(name), data);
			warnButtonsOOC[buttonNr]:EnableMouse(true);
			warnButtonsOOC[buttonNr]:SetAttribute("macrotext", "/targetexact " .. name);
			warnButtonsOOC[buttonNr]:Show();
		else
			warnButtonsOOC[buttonNr]:SetText(GetButtonText(name), data);
		end
	end

	buttonData[buttonNr] = name;
end

function VanasKoSWarnFrame:Update()
	-- more hostile
	if( (nearbyKoSCount+nearbyEnemyCount) > (nearbyFriendlyCount)) then
		local r, g, b, a = GetColor("MoreHostileBGColor");
		warnFrame:SetBackdropColor(r, g, b, a);
	-- more allied
	elseif( (nearbyKoSCount+nearbyEnemyCount) < (nearbyFriendlyCount)) then
		local r, g, b, a = GetColor("MoreAlliedBGColor");
		warnFrame:SetBackdropColor(r, g, b, a);
	-- default
	else
		local r, g, b, a = GetColor("DefaultBGColor");
		warnFrame:SetBackdropColor(r, g, b, a);
	end

	local counter = 0;
	if(self.db.profile.GrowUp) then
		counter = self.db.profile.WARN_BUTTONS - 1;
	end

	if(self.db.profile.ShowKoS) then
		for k,v in pairs(nearbyKoS) do
			if(counter < VanasKoSWarnFrame.db.profile.WARN_BUTTONS and counter >= 0) then
				SetButton(counter+1, k, "kos", dataCache and dataCache[k] or nil);
				if(self.db.profile.ShowClassIcons) then
					setButtonClassIcon(counter + 1, dataCache and dataCache[k] and dataCache[k].classEnglish);
				end
			end

			if (self.db.profile.GrowUp == true) then
				counter = counter - 1;
			else
				counter = counter + 1;
			end
		end
	end

	if(self.db.profile.ShowHostile) then
		for k,v in pairs(nearbyEnemy) do
			if(counter < VanasKoSWarnFrame.db.profile.WARN_BUTTONS and counter >= 0) then
				SetButton(counter+1, k, "enemy", dataCache and dataCache[k] or nil);
				if(self.db.profile.ShowClassIcons) then
					setButtonClassIcon(counter + 1, dataCache and dataCache[k] and dataCache[k].classEnglish);
				end
			end

			if (self.db.profile.GrowUp == true) then
				counter = counter - 1;
			else
				counter = counter + 1;
			end
		end
	end

	if(self.db.profile.ShowFriendly) then
		for k,v in pairs(nearbyFriendly) do
			if(counter < VanasKoSWarnFrame.db.profile.WARN_BUTTONS and counter >= 0) then
				SetButton(counter+1, k, "friendly", dataCache and dataCache[k] or nil);
				if(self.db.profile.ShowClassIcons) then
					setButtonClassIcon(counter + 1, dataCache and dataCache[k] and dataCache[k].classEnglish);
				end
			end

			if (self.db.profile.GrowUp == true) then
				counter = counter - 1;
			else
				counter = counter + 1;
			end
		end
	end

	for i=0,self.db.profile.WARN_BUTTONS-1 do
		if ((i <= counter and self.db.profile.GrowUp == true) or
			(i >= counter and self.db.profile.GrowUp == false)) then
			HideButton(i+1);
		end
	end

	-- show or hide/fade frame according to settings
	if(self.db.profile.Enabled) then
		if(self.db.profile.HideIfInactive) then
			if((counter > 0 and self.db.profile.GrowUp == false) or (counter < (self.db.profile.WARN_BUTTONS - 1) and self.db.profile.GrowUp == true)) then
				if(not warnFrame:IsVisible()) then
					UIFrameFadeIn(warnFrame, 0.1, 0.0, 1.0);
					ShowWarnFrame();
				end
			else
				if(warnFrame:IsVisible()) then
					UIFrameFadeOut(warnFrame, 0.1, 1.0, 0.0);
					warnFrame.fadeInfo.finishedFunc = HideWarnFrame;
				end
			end
		else
			if(not warnFrame:IsVisible()) then
				UIFrameFadeIn(warnFrame, 0.1, 0.0, 1.0);
				ShowWarnFrame();
			end
		end
	else
		HideWarnFrame();
	end
end
