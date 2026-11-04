--[[
	Name: LibLevelGuess-1.0
	Revision: $Rev$
	Author(s): Vana (boredvana@gmail.com), Xilcoy (xilcoy.curse@gmail.com) - data from others
	Description: A library to provide a good guess about the level of a player
	Dependencies: None
	License: MIT
]]

local MAJOR_VERSION = "LibLevelGuess-1.0";
local MINOR_VERSION = 51; -- Update this manually with new revisions

if(not LibStub) then error("LibLevelGuess-1.0 requires LibStub."); end

local lib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION);
if(not lib) then return; end

lib.spellIdData = nil;
lib.spellIdDataVersion = nil;

--[[------------------------------------------------------------------------
Returns:
	The Estimated (=minimal) level a player needs to be to cast that
	spell and the english class (WARRIOR, DEATHKNIGHT) that can cast it.
--------------------------------------------------------------------------]]

function lib:GetEstimatedLevelAndClassFromSpellId(spellId)
	assert(lib.spellIdData ~= nil);

	local spell = lib.spellIdData[spellId];
	if(spell == nil) then
		return nil;
	end
	if spell.Class == "DEATHKNIGHT" and (spell.Level or 0) < 55 then
		return 55;
	end

	return spell.Level, spell.Class;
end
