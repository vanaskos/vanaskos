--[[----------------------------------------------------------------------
      CommandLineHandler Module - Part of VanasKoS
		Handles the CommandLine
------------------------------------------------------------------------]]

local L = LibStub("AceLocale-3.0"):NewLocale("VanasKoS_CommandLineHandler", "enUS", true);
if L then
	L["Usage: /%s [<type>] <name> [<reason>]"] = true;
	L["<type>   -- hate, nice, kos"] = true;
	L["<name>   -- Name of player or guild, enclose guild in <> (eg: /kadd kos <the guild>)"] = true;
	L["<reason> -- Reason for adding player or guild"] = true;

	L["Usage: /%s [<cmd>] [<args>]"] = true;
	L["<cmd> -- config, add"] = true;
end

L = LibStub("AceLocale-3.0"):GetLocale("VanasKoS_CommandLineHandler", false);
VanasKoSCommandLineHandler = VanasKoS:NewModule("CommandLineHandler");

function VanasKoSCommandLineHandler:OnEnable()
	VanasKoS:RegisterChatCommand("kos", function(args) VanasKoSCommandLineHandler:KoS("kos", args); end );
	VanasKoS:RegisterChatCommand("vanaskos", function(args) VanasKoSCommandLineHandler:KoS("vanaskos", args); end );
	VanasKoS:RegisterChatCommand("kadd", function(args) VanasKoSCommandLineHandler:AddKoSPlayer("kadd", args) end);
end

local function printKaddUsage(name)
	VanasKoS:Print(format(L["Usage: /%s [<type>] <name> [<reason>]"], name));
	VanasKoS:Print(L["<type>   -- hate, nice, kos"]);
	VanasKoS:Print(L["<name>   -- Name of player or guild, enclose guild in <> (eg: /kadd kos <the guild>)"]);
	VanasKoS:Print(L["<reason> -- Reason for adding player or guild"]);
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

	return token, args, tagged;
end


local function kaddRetrieveArgs(args)
	local cmd = nil;
	local name = nil;
	local reason = nil;
	local isGuild = nil;

	cmd, args, tagged = getTaggedToken(args);
	if (cmd ~= nil and cmd ~= "help" and cmd ~= "?" and cmd ~= "hate" and cmd ~= "nice" and cmd ~= "kos") then
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

function VanasKoSCommandLineHandler:AddKoSPlayer(arg0, args)
	local listName = nil;

	local cmd, name, reason, isGuild = kaddRetrieveArgs(args);

	if (cmd == "help" or cmd == "?") then
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
	elseif (cmd == "kos") then
		if (isGuild) then
			listName = "GUILDKOS";
		else
			listName = "PLAYERKOS";
		end
	else
		return print_kadd_usage();
	end

	if (listName == nil or name == nil) then
		return print_kadd_usage();
	end

	
	VanasKoS:AddEntryByName(listName, name, reason);
end

local function printKoSUsage(name)
	VanasKoS:Print(format(L["Usage: /%s [<cmd>] [<args>]"], name));
	VanasKoS:Print(L["<cmd> -- config, add"]);
end

function VanasKoSCommandLineHandler:KoS(arg0, args)
	local cmd, args = getTaggedToken(args);

	if (cmd == "config") then
		VanasKoSGUI:OpenConfigWindow();
	elseif (cmd == "add") then
		VanasKoSCommandLineHandler:AddKoSPlayer(arg0 .. " add", args)
	elseif (cmd == "help") then
		printKoSUsage(arg0);
	else
		VanasKoS:ToggleMenu();
	end
end
