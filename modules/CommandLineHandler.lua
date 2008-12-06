--[[----------------------------------------------------------------------
      CommandLineHandler Module - Part of VanasKoS
		Handles the CommandLine
------------------------------------------------------------------------]]

VanasKoSCommandLineHandler = VanasKoS:NewModule("CommandLineHandler");

function VanasKoSCommandLineHandler:OnEnable()
	VanasKoS:RegisterChatCommand("kos", function() VanasKoS:ToggleMenu(); end );
	VanasKoS:RegisterChatCommand("vanaskos", function() VanasKoS:ToggleMenu(); end);
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



