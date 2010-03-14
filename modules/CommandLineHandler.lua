--[[----------------------------------------------------------------------
      CommandLineHandler Module - Part of VanasKoS
		Handles the CommandLine
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS/CommandLineHandler", false);
VanasKoSCommandLineHandler = VanasKoS:NewModule("CommandLineHandler");

function VanasKoSCommandLineHandler:OnEnable()
	VanasKoS:RegisterChatCommand("kos", function(args) VanasKoSCommandLineHandler:KoS("kos", args); end );
	VanasKoS:RegisterChatCommand("vanaskos", function(args) VanasKoSCommandLineHandler:KoS("vanaskos", args); end );
	VanasKoS:RegisterChatCommand("kadd", function(args) VanasKoSCommandLineHandler:KoSAdd("kadd", args) end);
end

local function getTaggedToken(args)
	local token = nil;
	local tagged = nil;
	if (args ~= nil) then
		string.gsub(args, "^%s*(.-)%s*$", "%1");
		string.gsub(args, "%s+", " ");

		if (string.find(args, "<") == 1 and (string.find(args, ">") ~= nil)) then
			token = string.sub(args, 2, string.find(args, ">") - 1);
			args = string.sub(args, string.find(args, ">") + 1);
			tagged = true;
		elseif (string.find(args, " ")) then
			token = string.sub(args, 1, string.find(args, " ") - 1);
			args = string.sub(args, string.find(args, " ") + 1);
		else
			token = args;
			args = nil;
		end
	end

	if (token == "") then
		token = nil;
	end

	return token, args, tagged;
end


local function kaddRetrieveArgs(args)
	local cmd = nil;
	local name = nil;
	local reason = nil;
	local isGuild = nil;

	cmd, args, tagged = getTaggedToken(args);
	if (cmd == nil) then
		cmd = "kos"
		return kos;
	elseif (cmd ~= "help" and cmd ~= "?" and cmd ~= "hate" and cmd ~= "nice" and cmd ~= "kos") then
		name = cmd;
		cmd = "kos";
		if (tagged) then
			isGuild = true
		end
		reason = args;
	else
		name, reason, isGuild = getTaggedToken(args);
	end

	return cmd, name, reason, isGuild;
end

local function printKaddUsage(name)
	VanasKoS:Print(format(L["KADD_USAGE %s"], name));
	VanasKoS:Print(L["KADD_TYPE"]);
	VanasKoS:Print(L["KADD_NAME"]);
	VanasKoS:Print(L["KADD_REASON"]);
end

function VanasKoSCommandLineHandler:KoSAdd(arg0, args)
	local listName = nil;

	local cmd, name, reason, isGuild = kaddRetrieveArgs(args);

	if (cmd == "help" or cmd == "?") then
		VanasKoS:Print(L["KADD_DESC"]);
		return printKaddUsage(arg0);
	elseif (cmd == "hate") then
		if (isGuild) then
			VanasKoS:Print("Guilds unsupported in hatelist");
			return;
		end
		listName = "HATELIST";
	elseif (cmd == "nice") then
		if (isGuild) then
			VanasKoS:Print("Guilds unsupported in nicelist");
			return;
		end
		listName = "NICELIST";
	else
		if (isGuild) then
			listName = "GUILDKOS";
		else
			listName = "PLAYERKOS";
		end
	end

	if(not name) then
		VanasKoS:AddEntryFromTarget(listName, nil);
	else
		VanasKoS:AddEntryByName(listName, name, reason);
	end
end

local function printConfigUsage(name)
	VanasKoS:Print(format(L["CONFIG_USAGE %s"], name));
end

function VanasKoSCommandLineHandler:KoSConfig(arg0, args)
	local cmd, args = getTaggedToken(args);

	if (cmd == "help" or cmd == "?") then
		VanasKoS:Print(L["CONFIG_DESC"]);
		printConfigUsage(arg0);
	else
		VanasKoSGUI:OpenConfigWindow();
	end
end

local function printMenuUsage(name)
	VanasKoS:Print(format(L["MENU_USAGE %s"], name));
end

function VanasKoSCommandLineHandler:KoSMenu(arg0, args)
	local cmd, args = getTaggedToken(args);

	if (cmd == "help" or cmd == "?") then
		VanasKoS:Print(L["MENU_DESC"]);
		printMenuUsage(arg0);
	else
		VanasKoS:ToggleMenu();
	end
end

local function printKoSUsage(name)
	VanasKoS:Print(format(L["KOS_USAGE %s"], name));
	VanasKoS:Print(L["KOS_CMD"]);
end

function VanasKoSCommandLineHandler:KoS(arg0, args)
	local cmd, args = getTaggedToken(args);

	if (cmd == "help" or cmd == "?") then
		VanasKoS:Print(format(L["KOS_DESC %s"], arg0));
		printKoSUsage(arg0);
	elseif (cmd == "config") then
		self:KoSConfig(arg0 .. " config", args)
	elseif (cmd == "add") then
		self:KoSAdd(arg0 .. " add", args)
	else
		self:KoSMenu(arg0 .. " menu", args)
	end
end
