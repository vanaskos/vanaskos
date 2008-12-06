--[[
	Name: LibLevelGuess-1.0
	Revision: $Rev: 0 $
	Author(s): Vana (boredvana@gmail.com) - data from others
	Description: A library to provide a good guess about the level of a player
	Dependencies: None
	License: MIT
]]

-- This library is meant to be extended by other means of Level Estimation in the future.

local MAJOR_VERSION = "LibLevelGuess-1.0";
local MINOR_VERSION = tonumber(("$Revision: 0$"):match("%d+"));

if(not LibStub) then error("LibLevelGuess-1.0 requires LibStub."); end

local lib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION);
if(not lib) then return; end

lib.spellIdData = nil;

--[[------------------------------------------------------------------------------------------------------------------------------------------------
Returns:
	The Estimated (=minimal) level a player needs to be to cast that spell and the english (
	class (WARRIOR, DEATHKNIGHT) that can cast it.
--------------------------------------------------------------------------------------------------------------------------------------------------]]

function lib:GetEstimatedLevelAndClassFromSpellId(spellId)
	assert(lib.spellIdData ~= nil);
	
	local spell = lib.spellIdData[spellId];
	if(spell == nil) then
		return nil;
	end
	
	return spell.Level, spell.Class;
end
