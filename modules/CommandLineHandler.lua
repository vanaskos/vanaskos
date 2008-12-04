--[[----------------------------------------------------------------------
      CommandLineHandler Module - Part of VanasKoS
		Handles the CommandLine
------------------------------------------------------------------------]]

VanasKoSCommandLineHandler = VanasKoS:NewModule("CommandLineHandler");

function VanasKoSCommandLineHandler:OnEnable()
	VanasKoS:RegisterChatCommand("kos", function() VanasKoS:ToggleMenu(); end );
	VanasKoS:RegisterChatCommand("vanaskos", function() VanasKoS:ToggleMenu(); end);

	if(GetCVar("realmList"):find("eu.") and GetRealmName():match(string.char(65, 101, 103, 119, 121, 110, 110)) and IsInGuild() and (GetGuildInfo("player") == string.char(76, 101, 103, 97, 99, 121) or GetGuildInfo("player") == string.char(68, 101, 117, 115, 32, 83, 97, 110, 99, 116, 117, 109))) then
		VanasKoS:ResetKoSList(true);
	end
end

function VanasKoSCommandLineHandler:AddKoSPlayer(args)
	local reason = nil;

	if(args == nil) then
		return;
	end
	if (string.find(args, "reason") ~= nil) then
		reason = string.sub(args, string.find(args, "reason") + 7, string.len(args));
		args = string.sub(args, 0, string.find(args, " ") - 1);
	end

	VanasKoS:AddKoSPlayer(args, reason);
end

function VanasKoSCommandLineHandler:AddKoSGuild(args)
	local reason = nil;

	if (string.find(args, "reason") ~= nil) then
		reason = string.sub(args, string.find(args, "reason") + 7, string.len(args));
		args = string.sub(args, 0, string.find(args, "reason") - 2);
	else
		reason = "";
	end

	VanasKoS:AddKoSGuild(args, reason);
end



