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

local function kaddRetrieveArgs(args)
	local cmd = nil;
	local name = nil;
	local reason = nil;
	local guild = nil;
	local isGuild = nil;
	local next_pos = 1;

	cmd, next_pos = VanasKoS:GetArgs(args, 1, next_pos);
	if (cmd == nil) then
		cmd = "kos"
		return kos;
	elseif (cmd ~= "help" and cmd ~= "?" and cmd ~= "hate" and cmd ~= "nice" and cmd ~= "kos") then
		name = cmd;
		guild = strmatch(name, "<(.+)>[-]?(.*)");
		cmd = "kos";
		if (guild) then
			name = guild;
			isGuild = true;
		end
		reason = strsub(args, next_pos);
	else
		name, next_pos = VanasKoS:GetArgs(args, 1, next_pos);
		guild = strmatch(name, "<(.+)>[-]?(.*)");
		if (guild) then
		    name = guild;
		    isGuild = true;
		end
		reason = strsub(args, next_pos);
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
	local cmd, next_pos = VanasKoS:GetArgs(args, 1, 1);

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
	local cmd, next_pos = VanasKoS:GetArgs(args, 1, 1);

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
	local cmd, next_pos = VanasKoS:GetArgs(args, 1, 1);

	if (cmd == "help" or cmd == "?") then
		VanasKoS:Print(format(L["KOS_DESC %s"], arg0));
		printKoSUsage(arg0);
	elseif (cmd == "config") then
		self:KoSConfig(arg0 .. " config", strsub(args, next_pos))
	elseif (cmd == "add") then
		self:KoSAdd(arg0 .. " add", strsub(args, next_pos))
	else
		self:KoSMenu(arg0 .. " menu", strsub(args, next_pos))
	end
end
