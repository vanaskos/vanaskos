local lib = LibStub("LibLevelGuess-1.0");

if(not lib) then error("SpellIdData for LibLevelGuess needs library to be loaded before"); return; end

-- Spell Id Date from Paranoia EPA, with permission from the author of it
lib.spellIdData = {

	-- The Paranoia SpellList was originally derived from the Personal Sentry addon's SpellList.
	-- Paranoia 1.11 introduces a completely new SpellList that allows for greatly increased
	-- accuracy when detecting levels, since it includes the minimum level for every rank of a
	-- skill. The SpellList was automatically parsed from thottbot using Lua (I stored the output
	-- in a SavedVariable so I could easily retrieve it from the WTF folder), the code for which
	-- can be found at the end of this file.

	--<<<DEATH KNIGHT>>>

		[52285] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[57623] = {
			Level = 75,
			Class = "DEATHKNIGHT",
		},
		[49892] = {
			Level = 62,
			Class = "DEATHKNIGHT",
		},
		[49896] = {
			Level = 61,
			Class = "DEATHKNIGHT",
		},
		[51424] = {
			Level = 73,
			Class = "DEATHKNIGHT",
		},
		[49142] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[45463] = {
			Level = 70,
			Class = "DEATHKNIGHT",
		},
		[48265] = {
			Level = 70,
			Class = "DEATHKNIGHT",
		},
		[49920] = {
			Level = 75,
			Class = "DEATHKNIGHT",
		},
		[49924] = {
			Level = 80,
			Class = "DEATHKNIGHT",
		},
		[49928] = {
			Level = 69,
			Class = "DEATHKNIGHT",
		},
		[49936] = {
			Level = 67,
			Class = "DEATHKNIGHT",
		},
		[49940] = {
			Level = 72,
			Class = "DEATHKNIGHT",
		},
		[52373] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[57330] = {
			Level = 65,
			Class = "DEATHKNIGHT",
		},
		[43265] = {
			Level = 60,
			Class = "DEATHKNIGHT",
		},
		[52286] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[47476] = {
			Level = 59,
			Class = "DEATHKNIGHT",
		},
		[49893] = {
			Level = 68,
			Class = "DEATHKNIGHT",
		},
		[51425] = {
			Level = 79,
			Class = "DEATHKNIGHT",
		},
		[51429] = {
			Level = 79,
			Class = "DEATHKNIGHT",
		},
		[49020] = {
			Level = 61,
			Class = "DEATHKNIGHT",
		},
		[49913] = {
			Level = 65,
			Class = "DEATHKNIGHT",
		},
		[49917] = {
			Level = 60,
			Class = "DEATHKNIGHT",
		},
		[49921] = {
			Level = 80,
			Class = "DEATHKNIGHT",
		},
		[49929] = {
			Level = 74,
			Class = "DEATHKNIGHT",
		},
		[49937] = {
			Level = 73,
			Class = "DEATHKNIGHT",
		},
		[47528] = {
			Level = 57,
			Class = "DEATHKNIGHT",
		},
		[50842] = {
			Level = 56,
			Class = "DEATHKNIGHT",
		},
		[49576] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[50977] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[45524] = {
			Level = 58,
			Class = "DEATHKNIGHT",
		},
		[48707] = {
			Level = 68,
			Class = "DEATHKNIGHT",
		},
		[47568] = {
			Level = 75,
			Class = "DEATHKNIGHT",
		},
		[48743] = {
			Level = 66,
			Class = "DEATHKNIGHT",
		},
		[49894] = {
			Level = 76,
			Class = "DEATHKNIGHT",
		},
		[51426] = {
			Level = 62,
			Class = "DEATHKNIGHT",
		},
		[3714] = {
			Level = 61,
			Class = "DEATHKNIGHT",
		},
		[48263] = {
			Level = 57,
			Class = "DEATHKNIGHT",
		},
		[49918] = {
			Level = 65,
			Class = "DEATHKNIGHT",
		},
		[45477] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[49926] = {
			Level = 59,
			Class = "DEATHKNIGHT",
		},
		[49930] = {
			Level = 80,
			Class = "DEATHKNIGHT",
		},
		[49938] = {
			Level = 80,
			Class = "DEATHKNIGHT",
		},
		[47541] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[56816] = {
			Level = 67,
			Class = "DEATHKNIGHT",
		},
		[52375] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[45902] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[45529] = {
			Level = 64,
			Class = "DEATHKNIGHT",
		},
		[49998] = {
			Level = 56,
			Class = "DEATHKNIGHT",
		},
		[49909] = {
			Level = 78,
			Class = "DEATHKNIGHT",
		},
		[42650] = {
			Level = 80,
			Class = "DEATHKNIGHT",
		},
		[49916] = {
			Level = 79,
			Class = "DEATHKNIGHT",
		},
		[49895] = {
			Level = 80,
			Class = "DEATHKNIGHT",
		},
		[51423] = {
			Level = 67,
			Class = "DEATHKNIGHT",
		},
		[49903] = {
			Level = 67,
			Class = "DEATHKNIGHT",
		},
		[45462] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[49941] = {
			Level = 78,
			Class = "DEATHKNIGHT",
		},
		[49915] = {
			Level = 74,
			Class = "DEATHKNIGHT",
		},
		[47633] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[49923] = {
			Level = 75,
			Class = "DEATHKNIGHT",
		},
		[49927] = {
			Level = 64,
			Class = "DEATHKNIGHT",
		},
		[51427] = {
			Level = 68,
			Class = "DEATHKNIGHT",
		},
		[48792] = {
			Level = 62,
			Class = "DEATHKNIGHT",
		},
		[49939] = {
			Level = 66,
			Class = "DEATHKNIGHT",
		},
		[52374] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[49919] = {
			Level = 70,
			Class = "DEATHKNIGHT",
		},
		[46584] = {
			Level = 56,
			Class = "DEATHKNIGHT",
		},
		[51428] = {
			Level = 74,
			Class = "DEATHKNIGHT",
		},
		[52372] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[49904] = {
			Level = 73,
			Class = "DEATHKNIGHT",
		},
		[47632] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[49914] = {
			Level = 69,
			Class = "DEATHKNIGHT",
		},
		[53428] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[49410] = {
			Level = 55,
			Class = "DEATHKNIGHT",
		},
		[56222] = {
			Level = 65,
			Class = "DEATHKNIGHT",
		},
		[49999] = {
			Level = 63,
			Class = "DEATHKNIGHT",
		},
		[48721] = {
			Level = 58,
			Class = "DEATHKNIGHT",
		},
		[56815] = {
			Level = 67,
			Class = "DEATHKNIGHT",
		},

	--<<<DRUID>>>

		[22570] = {
			Level = 62,
			Class = "DRUID",
		},
		[3025] = {
			Level = 20,
			Class = "DRUID",
		},
		[3029] = {
			Level = 28,
			Class = "DRUID",
		},
		[49804] = {
			Level = 77,
			Class = "DRUID",
		},
		[48447] = {
			Level = 80,
			Class = "DRUID",
		},
		[48463] = {
			Level = 80,
			Class = "DRUID",
		},
		[48479] = {
			Level = 73,
			Class = "DRUID",
		},
		[18658] = {
			Level = 58,
			Class = "DRUID",
		},
		[48559] = {
			Level = 71,
			Class = "DRUID",
		},
		[20742] = {
			Level = 40,
			Class = "DRUID",
		},
		[33357] = {
			Level = 65,
			Class = "DRUID",
		},
		[50763] = {
			Level = 80,
			Class = "DRUID",
		},
		[26978] = {
			Level = 62,
			Class = "DRUID",
		},
		[26986] = {
			Level = 67,
			Class = "DRUID",
		},
		[26994] = {
			Level = 69,
			Class = "DRUID",
		},
		[768] = {
			Level = 20,
			Class = "DRUID",
		},
		[769] = {
			Level = 34,
			Class = "DRUID",
		},
		[770] = {
			Level = 18,
			Class = "DRUID",
		},
		[48464] = {
			Level = 72,
			Class = "DRUID",
		},
		[48480] = {
			Level = 79,
			Class = "DRUID",
		},
		[29166] = {
			Level = 40,
			Class = "DRUID",
		},
		[48576] = {
			Level = 72,
			Class = "DRUID",
		},
		[9752] = {
			Level = 44,
			Class = "DRUID",
		},
		[9756] = {
			Level = 44,
			Class = "DRUID",
		},
		[774] = {
			Level = 4,
			Class = "DRUID",
		},
		[50764] = {
			Level = 69,
			Class = "DRUID",
		},
		[9824] = {
			Level = 46,
			Class = "DRUID",
		},
		[5177] = {
			Level = 6,
			Class = "DRUID",
		},
		[5179] = {
			Level = 22,
			Class = "DRUID",
		},
		[9840] = {
			Level = 52,
			Class = "DRUID",
		},
		[778] = {
			Level = 30,
			Class = "DRUID",
		},
		[5187] = {
			Level = 14,
			Class = "DRUID",
		},
		[9852] = {
			Level = 48,
			Class = "DRUID",
		},
		[9856] = {
			Level = 48,
			Class = "DRUID",
		},
		[779] = {
			Level = 16,
			Class = "DRUID",
		},
		[20719] = {
			Level = 40,
			Class = "DRUID",
		},
		[2091] = {
			Level = 28,
			Class = "DRUID",
		},
		[48561] = {
			Level = 72,
			Class = "DRUID",
		},
		[9876] = {
			Level = 58,
			Class = "DRUID",
		},
		[3627] = {
			Level = 34,
			Class = "DRUID",
		},
		[9884] = {
			Level = 50,
			Class = "DRUID",
		},
		[9888] = {
			Level = 50,
			Class = "DRUID",
		},
		[9892] = {
			Level = 52,
			Class = "DRUID",
		},
		[5211] = {
			Level = 14,
			Class = "DRUID",
		},
		[9904] = {
			Level = 54,
			Class = "DRUID",
		},
		[9908] = {
			Level = 54,
			Class = "DRUID",
		},
		[50765] = {
			Level = 60,
			Class = "DRUID",
		},
		[5221] = {
			Level = 22,
			Class = "DRUID",
		},
		[6756] = {
			Level = 20,
			Class = "DRUID",
		},
		[5225] = {
			Level = 32,
			Class = "DRUID",
		},
		[26979] = {
			Level = 69,
			Class = "DRUID",
		},
		[8910] = {
			Level = 40,
			Class = "DRUID",
		},
		[8914] = {
			Level = 34,
			Class = "DRUID",
		},
		[8918] = {
			Level = 40,
			Class = "DRUID",
		},
		[1823] = {
			Level = 34,
			Class = "DRUID",
		},
		[8926] = {
			Level = 22,
			Class = "DRUID",
		},
		[1824] = {
			Level = 44,
			Class = "DRUID",
		},
		[1058] = {
			Level = 10,
			Class = "DRUID",
		},
		[8938] = {
			Level = 18,
			Class = "DRUID",
		},
		[3137] = {
			Level = 26,
			Class = "DRUID",
		},
		[8946] = {
			Level = 14,
			Class = "DRUID",
		},
		[8950] = {
			Level = 34,
			Class = "DRUID",
		},
		[48466] = {
			Level = 80,
			Class = "DRUID",
		},
		[1062] = {
			Level = 18,
			Class = "DRUID",
		},
		[48562] = {
			Level = 77,
			Class = "DRUID",
		},
		[9493] = {
			Level = 36,
			Class = "DRUID",
		},
		[6800] = {
			Level = 30,
			Class = "DRUID",
		},
		[1066] = {
			Level = 16,
			Class = "DRUID",
		},
		[6808] = {
			Level = 18,
			Class = "DRUID",
		},
		[50766] = {
			Level = 48,
			Class = "DRUID",
		},
		[33983] = {
			Level = 68,
			Class = "DRUID",
		},
		[1075] = {
			Level = 24,
			Class = "DRUID",
		},
		[48451] = {
			Level = 80,
			Class = "DRUID",
		},
		[48467] = {
			Level = 80,
			Class = "DRUID",
		},
		[1079] = {
			Level = 20,
			Class = "DRUID",
		},
		[48563] = {
			Level = 75,
			Class = "DRUID",
		},
		[99] = {
			Level = 10,
			Class = "DRUID",
		},
		[22812] = {
			Level = 44,
			Class = "DRUID",
		},
		[1082] = {
			Level = 20,
			Class = "DRUID",
		},
		[22828] = {
			Level = 48,
			Class = "DRUID",
		},
		[1850] = {
			Level = 26,
			Class = "DRUID",
		},
		[50767] = {
			Level = 36,
			Class = "DRUID",
		},
		[26980] = {
			Level = 65,
			Class = "DRUID",
		},
		[26988] = {
			Level = 70,
			Class = "DRUID",
		},
		[26996] = {
			Level = 67,
			Class = "DRUID",
		},
		[27004] = {
			Level = 69,
			Class = "DRUID",
		},
		[27012] = {
			Level = 70,
			Class = "DRUID",
		},
		[50464] = {
			Level = 80,
			Class = "DRUID",
		},
		[33745] = {
			Level = 66,
			Class = "DRUID",
		},
		[9749] = {
			Level = 42,
			Class = "DRUID",
		},
		[339] = {
			Level = 8,
			Class = "DRUID",
		},
		[53307] = {
			Level = 74,
			Class = "DRUID",
		},
		[467] = {
			Level = 6,
			Class = "DRUID",
		},
		[5421] = {
			Level = 16,
			Class = "DRUID",
		},
		[9821] = {
			Level = 46,
			Class = "DRUID",
		},
		[9829] = {
			Level = 46,
			Class = "DRUID",
		},
		[9833] = {
			Level = 46,
			Class = "DRUID",
		},
		[9841] = {
			Level = 58,
			Class = "DRUID",
		},
		[9845] = {
			Level = 48,
			Class = "DRUID",
		},
		[9849] = {
			Level = 48,
			Class = "DRUID",
		},
		[9853] = {
			Level = 58,
			Class = "DRUID",
		},
		[9857] = {
			Level = 54,
			Class = "DRUID",
		},
		[48565] = {
			Level = 75,
			Class = "DRUID",
		},
		[9881] = {
			Level = 58,
			Class = "DRUID",
		},
		[9885] = {
			Level = 60,
			Class = "DRUID",
		},
		[9889] = {
			Level = 56,
			Class = "DRUID",
		},
		[16689] = {
			Level = 10,
			Class = "DRUID",
		},
		[22829] = {
			Level = 56,
			Class = "DRUID",
		},
		[9901] = {
			Level = 54,
			Class = "DRUID",
		},
		[53308] = {
			Level = 78,
			Class = "DRUID",
		},
		[24905] = {
			Level = 40,
			Class = "DRUID",
		},
		[8903] = {
			Level = 38,
			Class = "DRUID",
		},
		[26981] = {
			Level = 63,
			Class = "DRUID",
		},
		[26989] = {
			Level = 68,
			Class = "DRUID",
		},
		[5487] = {
			Level = 10,
			Class = "DRUID",
		},
		[27005] = {
			Level = 66,
			Class = "DRUID",
		},
		[8927] = {
			Level = 28,
			Class = "DRUID",
		},
		[8939] = {
			Level = 24,
			Class = "DRUID",
		},
		[8951] = {
			Level = 42,
			Class = "DRUID",
		},
		[8955] = {
			Level = 38,
			Class = "DRUID",
		},
		[9490] = {
			Level = 32,
			Class = "DRUID",
		},
		[8983] = {
			Level = 46,
			Class = "DRUID",
		},
		[9007] = {
			Level = 36,
			Class = "DRUID",
		},
		[33987] = {
			Level = 68,
			Class = "DRUID",
		},
		[2782] = {
			Level = 24,
			Class = "DRUID",
		},
		[25297] = {
			Level = 60,
			Class = "DRUID",
		},
		[48567] = {
			Level = 73,
			Class = "DRUID",
		},
		[9634] = {
			Level = 40,
			Class = "DRUID",
		},
		[50212] = {
			Level = 71,
			Class = "DRUID",
		},
		[33876] = {
			Level = 50,
			Class = "DRUID",
		},
		[26982] = {
			Level = 69,
			Class = "DRUID",
		},
		[26990] = {
			Level = 70,
			Class = "DRUID",
		},
		[26998] = {
			Level = 62,
			Class = "DRUID",
		},
		[27006] = {
			Level = 66,
			Class = "DRUID",
		},
		[16810] = {
			Level = 18,
			Class = "DRUID",
		},
		[17329] = {
			Level = 58,
			Class = "DRUID",
		},
		[48440] = {
			Level = 75,
			Class = "DRUID",
		},
		[17401] = {
			Level = 50,
			Class = "DRUID",
		},
		[48568] = {
			Level = 80,
			Class = "DRUID",
		},
		[16914] = {
			Level = 40,
			Class = "DRUID",
		},
		[9754] = {
			Level = 44,
			Class = "DRUID",
		},
		[9758] = {
			Level = 44,
			Class = "DRUID",
		},
		[50213] = {
			Level = 79,
			Class = "DRUID",
		},
		[9826] = {
			Level = 56,
			Class = "DRUID",
		},
		[9830] = {
			Level = 54,
			Class = "DRUID",
		},
		[9834] = {
			Level = 52,
			Class = "DRUID",
		},
		[48441] = {
			Level = 80,
			Class = "DRUID",
		},
		[9846] = {
			Level = 60,
			Class = "DRUID",
		},
		[9850] = {
			Level = 58,
			Class = "DRUID",
		},
		[25298] = {
			Level = 60,
			Class = "DRUID",
		},
		[9858] = {
			Level = 60,
			Class = "DRUID",
		},
		[9862] = {
			Level = 50,
			Class = "DRUID",
		},
		[9866] = {
			Level = 50,
			Class = "DRUID",
		},
		[20739] = {
			Level = 30,
			Class = "DRUID",
		},
		[20747] = {
			Level = 50,
			Class = "DRUID",
		},
		[9894] = {
			Level = 52,
			Class = "DRUID",
		},
		[9898] = {
			Level = 52,
			Class = "DRUID",
		},
		[33878] = {
			Level = 50,
			Class = "DRUID",
		},
		[9910] = {
			Level = 54,
			Class = "DRUID",
		},
		[24907] = {
			Level = 40,
			Class = "DRUID",
		},
		[21849] = {
			Level = 50,
			Class = "DRUID",
		},
		[49799] = {
			Level = 71,
			Class = "DRUID",
		},
		[26983] = {
			Level = 70,
			Class = "DRUID",
		},
		[26991] = {
			Level = 70,
			Class = "DRUID",
		},
		[5232] = {
			Level = 10,
			Class = "DRUID",
		},
		[5234] = {
			Level = 30,
			Class = "DRUID",
		},
		[8924] = {
			Level = 10,
			Class = "DRUID",
		},
		[8928] = {
			Level = 34,
			Class = "DRUID",
		},
		[16811] = {
			Level = 28,
			Class = "DRUID",
		},
		[8936] = {
			Level = 12,
			Class = "DRUID",
		},
		[8940] = {
			Level = 30,
			Class = "DRUID",
		},
		[48442] = {
			Level = 71,
			Class = "DRUID",
		},
		[6783] = {
			Level = 40,
			Class = "DRUID",
		},
		[6785] = {
			Level = 32,
			Class = "DRUID",
		},
		[6787] = {
			Level = 42,
			Class = "DRUID",
		},
		[48572] = {
			Level = 80,
			Class = "DRUID",
		},
		[52610] = {
			Level = 75,
			Class = "DRUID",
		},
		[17402] = {
			Level = 60,
			Class = "DRUID",
		},
		[6795] = {
			Level = 10,
			Class = "DRUID",
		},
		[20484] = {
			Level = 20,
			Class = "DRUID",
		},
		[27007] = {
			Level = 66,
			Class = "DRUID",
		},
		[2893] = {
			Level = 26,
			Class = "DRUID",
		},
		[8992] = {
			Level = 38,
			Class = "DRUID",
		},
		[48469] = {
			Level = 80,
			Class = "DRUID",
		},
		[6807] = {
			Level = 10,
			Class = "DRUID",
		},
		[6809] = {
			Level = 26,
			Class = "DRUID",
		},
		[48566] = {
			Level = 80,
			Class = "DRUID",
		},
		[48564] = {
			Level = 80,
			Class = "DRUID",
		},
		[16979] = {
			Level = 20,
			Class = "DRUID",
		},
		[48470] = {
			Level = 80,
			Class = "DRUID",
		},
		[9005] = {
			Level = 36,
			Class = "DRUID",
		},
		[33943] = {
			Level = 68,
			Class = "DRUID",
		},
		[49800] = {
			Level = 80,
			Class = "DRUID",
		},
		[48579] = {
			Level = 79,
			Class = "DRUID",
		},
		[48378] = {
			Level = 79,
			Class = "DRUID",
		},
		[48570] = {
			Level = 79,
			Class = "DRUID",
		},
		[2908] = {
			Level = 22,
			Class = "DRUID",
		},
		[48465] = {
			Level = 78,
			Class = "DRUID",
		},
		[42231] = {
			Level = 40,
			Class = "DRUID",
		},
		[48574] = {
			Level = 78,
			Class = "DRUID",
		},
		[2912] = {
			Level = 20,
			Class = "DRUID",
		},
		[53312] = {
			Level = 78,
			Class = "DRUID",
		},
		[48577] = {
			Level = 78,
			Class = "DRUID",
		},
		[48443] = {
			Level = 77,
			Class = "DRUID",
		},
		[48459] = {
			Level = 74,
			Class = "DRUID",
		},
		[49803] = {
			Level = 77,
			Class = "DRUID",
		},
		[25299] = {
			Level = 60,
			Class = "DRUID",
		},
		[48560] = {
			Level = 77,
			Class = "DRUID",
		},
		[8998] = {
			Level = 28,
			Class = "DRUID",
		},
		[48575] = {
			Level = 76,
			Class = "DRUID",
		},
		[48446] = {
			Level = 75,
			Class = "DRUID",
		},
		[48571] = {
			Level = 75,
			Class = "DRUID",
		},
		[20748] = {
			Level = 60,
			Class = "DRUID",
		},
		[6793] = {
			Level = 36,
			Class = "DRUID",
		},
		[1178] = {
			Level = 10,
			Class = "DRUID",
		},
		[9635] = {
			Level = 40,
			Class = "DRUID",
		},
		[48377] = {
			Level = 74,
			Class = "DRUID",
		},
		[48578] = {
			Level = 73,
			Class = "DRUID",
		},
		[48569] = {
			Level = 73,
			Class = "DRUID",
		},
		[48573] = {
			Level = 72,
			Class = "DRUID",
		},
		[48450] = {
			Level = 72,
			Class = "DRUID",
		},
		[42233] = {
			Level = 60,
			Class = "DRUID",
		},
		[21850] = {
			Level = 60,
			Class = "DRUID",
		},
		[24248] = {
			Level = 63,
			Class = "DRUID",
		},
		[40120] = {
			Level = 70,
			Class = "DRUID",
		},
		[26984] = {
			Level = 61,
			Class = "DRUID",
		},
		[26992] = {
			Level = 64,
			Class = "DRUID",
		},
		[27000] = {
			Level = 67,
			Class = "DRUID",
		},
		[27008] = {
			Level = 67,
			Class = "DRUID",
		},
		[8972] = {
			Level = 34,
			Class = "DRUID",
		},
		[42232] = {
			Level = 50,
			Class = "DRUID",
		},
		[16812] = {
			Level = 38,
			Class = "DRUID",
		},
		[26995] = {
			Level = 70,
			Class = "DRUID",
		},
		[27002] = {
			Level = 70,
			Class = "DRUID",
		},
		[9492] = {
			Level = 28,
			Class = "DRUID",
		},
		[42230] = {
			Level = 70,
			Class = "DRUID",
		},
		[50768] = {
			Level = 24,
			Class = "DRUID",
		},
		[48476] = {
			Level = 76,
			Class = "DRUID",
		},
		[9000] = {
			Level = 40,
			Class = "DRUID",
		},
		[9896] = {
			Level = 60,
			Class = "DRUID",
		},
		[5209] = {
			Level = 28,
			Class = "DRUID",
		},
		[33986] = {
			Level = 58,
			Class = "DRUID",
		},
		[49376] = {
			Level = 20,
			Class = "DRUID",
		},
		[740] = {
			Level = 30,
			Class = "DRUID",
		},
		[1735] = {
			Level = 20,
			Class = "DRUID",
		},
		[8907] = {
			Level = 40,
			Class = "DRUID",
		},
		[33763] = {
			Level = 64,
			Class = "DRUID",
		},
		[9745] = {
			Level = 42,
			Class = "DRUID",
		},
		[782] = {
			Level = 14,
			Class = "DRUID",
		},
		[22842] = {
			Level = 36,
			Class = "DRUID",
		},
		[31018] = {
			Level = 60,
			Class = "DRUID",
		},
		[5178] = {
			Level = 14,
			Class = "DRUID",
		},
		[780] = {
			Level = 24,
			Class = "DRUID",
		},
		[5180] = {
			Level = 30,
			Class = "DRUID",
		},
		[1430] = {
			Level = 16,
			Class = "DRUID",
		},
		[50769] = {
			Level = 12,
			Class = "DRUID",
		},
		[49802] = {
			Level = 74,
			Class = "DRUID",
		},
		[2090] = {
			Level = 22,
			Class = "DRUID",
		},
		[5186] = {
			Level = 8,
			Class = "DRUID",
		},
		[5188] = {
			Level = 20,
			Class = "DRUID",
		},
		[5189] = {
			Level = 26,
			Class = "DRUID",
		},
		[9880] = {
			Level = 50,
			Class = "DRUID",
		},
		[9823] = {
			Level = 46,
			Class = "DRUID",
		},
		[9827] = {
			Level = 56,
			Class = "DRUID",
		},
		[5195] = {
			Level = 28,
			Class = "DRUID",
		},
		[9835] = {
			Level = 58,
			Class = "DRUID",
		},
		[9839] = {
			Level = 46,
			Class = "DRUID",
		},
		[5196] = {
			Level = 38,
			Class = "DRUID",
		},
		[48461] = {
			Level = 79,
			Class = "DRUID",
		},
		[48477] = {
			Level = 79,
			Class = "DRUID",
		},
		[18657] = {
			Level = 38,
			Class = "DRUID",
		},
		[5201] = {
			Level = 38,
			Class = "DRUID",
		},
		[9863] = {
			Level = 60,
			Class = "DRUID",
		},
		[9867] = {
			Level = 58,
			Class = "DRUID",
		},
		[783] = {
			Level = 30,
			Class = "DRUID",
		},
		[9875] = {
			Level = 50,
			Class = "DRUID",
		},
		[9747] = {
			Level = 42,
			Class = "DRUID",
		},
		[33786] = {
			Level = 70,
			Class = "DRUID",
		},
		[26987] = {
			Level = 63,
			Class = "DRUID",
		},
		[5215] = {
			Level = 20,
			Class = "DRUID",
		},
		[5217] = {
			Level = 24,
			Class = "DRUID",
		},
		[1822] = {
			Level = 24,
			Class = "DRUID",
		},
		[26997] = {
			Level = 64,
			Class = "DRUID",
		},
		[9907] = {
			Level = 54,
			Class = "DRUID",
		},
		[2637] = {
			Level = 18,
			Class = "DRUID",
		},
		[22568] = {
			Level = 32,
			Class = "DRUID",
		},
		[22827] = {
			Level = 40,
			Class = "DRUID",
		},
		[5229] = {
			Level = 12,
			Class = "DRUID",
		},
		[8905] = {
			Level = 46,
			Class = "DRUID",
		},
		[26985] = {
			Level = 69,
			Class = "DRUID",
		},
		[26993] = {
			Level = 66,
			Class = "DRUID",
		},
		[27001] = {
			Level = 61,
			Class = "DRUID",
		},
		[27009] = {
			Level = 68,
			Class = "DRUID",
		},
		[8925] = {
			Level = 16,
			Class = "DRUID",
		},
		[8929] = {
			Level = 40,
			Class = "DRUID",
		},
		[16813] = {
			Level = 48,
			Class = "DRUID",
		},
		[6778] = {
			Level = 32,
			Class = "DRUID",
		},
		[8941] = {
			Level = 36,
			Class = "DRUID",
		},
		[27003] = {
			Level = 64,
			Class = "DRUID",
		},
		[8949] = {
			Level = 26,
			Class = "DRUID",
		},
		[48462] = {
			Level = 75,
			Class = "DRUID",
		},
		[9913] = {
			Level = 60,
			Class = "DRUID",
		},
		[9912] = {
			Level = 54,
			Class = "DRUID",
		},
		[6798] = {
			Level = 30,
			Class = "DRUID",
		},
		[9750] = {
			Level = 42,
			Class = "DRUID",
		},
		[31709] = {
			Level = 60,
			Class = "DRUID",
		},
		[33982] = {
			Level = 58,
			Class = "DRUID",
		},
		[6542] = {
			Level = 60,
			Class = "DRUID",
		},
		[18960] = {
			Level = 10,
			Class = "DRUID",
		},
		[6780] = {
			Level = 38,
			Class = "DRUID",
		},


	--<<<HUNTER>>>

		[27025] = {
			Level = 61,
			Class = "HUNTER",
		},
		[14311] = {
			Level = 60,
			Class = "HUNTER",
		},
		[14315] = {
			Level = 54,
			Class = "HUNTER",
		},
		[14317] = {
			Level = 54,
			Class = "HUNTER",
		},
		[13554] = {
			Level = 50,
			Class = "HUNTER",
		},
		[14321] = {
			Level = 48,
			Class = "HUNTER",
		},
		[14323] = {
			Level = 22,
			Class = "HUNTER",
		},
		[14325] = {
			Level = 58,
			Class = "HUNTER",
		},
		[14327] = {
			Level = 46,
			Class = "HUNTER",
		},
		[25296] = {
			Level = 60,
			Class = "HUNTER",
		},
		[56641] = {
			Level = 50,
			Class = "HUNTER",
		},
		[58434] = {
			Level = 80,
			Class = "HUNTER",
		},
		[49047] = {
			Level = 74,
			Class = "HUNTER",
		},
		[49055] = {
			Level = 72,
			Class = "HUNTER",
		},
		[34026] = {
			Level = 66,
			Class = "HUNTER",
		},
		[34074] = {
			Level = 20,
			Class = "HUNTER",
		},
		[2974] = {
			Level = 12,
			Class = "HUNTER",
		},
		[34600] = {
			Level = 68,
			Class = "HUNTER",
		},
		[1002] = {
			Level = 14,
			Class = "HUNTER",
		},
		[24396] = {
			Level = 40,
			Class = "HUNTER",
		},
		[53271] = {
			Level = 75,
			Class = "HUNTER",
		},
		[6197] = {
			Level = 14,
			Class = "HUNTER",
		},
		[49000] = {
			Level = 73,
			Class = "HUNTER",
		},
		[49008] = {
			Level = 76,
			Class = "HUNTER",
		},
		[1495] = {
			Level = 16,
			Class = "HUNTER",
		},
		[3111] = {
			Level = 20,
			Class = "HUNTER",
		},
		[49048] = {
			Level = 80,
			Class = "HUNTER",
		},
		[27014] = {
			Level = 63,
			Class = "HUNTER",
		},
		[19878] = {
			Level = 32,
			Class = "HUNTER",
		},
		[19882] = {
			Level = 40,
			Class = "HUNTER",
		},
		[27026] = {
			Level = 61,
			Class = "HUNTER",
		},
		[27046] = {
			Level = 68,
			Class = "HUNTER",
		},
		[42243] = {
			Level = 40,
			Class = "HUNTER",
		},
		[1499] = {
			Level = 20,
			Class = "HUNTER",
		},
		[6991] = {
			Level = 10,
			Class = "HUNTER",
		},
		[49001] = {
			Level = 79,
			Class = "HUNTER",
		},
		[49065] = {
			Level = 77,
			Class = "HUNTER",
		},
		[13481] = {
			Level = 10,
			Class = "HUNTER",
		},
		[42244] = {
			Level = 50,
			Class = "HUNTER",
		},
		[14260] = {
			Level = 8,
			Class = "HUNTER",
		},
		[14262] = {
			Level = 24,
			Class = "HUNTER",
		},
		[14264] = {
			Level = 40,
			Class = "HUNTER",
		},
		[14266] = {
			Level = 56,
			Class = "HUNTER",
		},
		[14270] = {
			Level = 44,
			Class = "HUNTER",
		},
		[14280] = {
			Level = 56,
			Class = "HUNTER",
		},
		[14282] = {
			Level = 20,
			Class = "HUNTER",
		},
		[14284] = {
			Level = 36,
			Class = "HUNTER",
		},
		[1510] = {
			Level = 40,
			Class = "HUNTER",
		},
		[14288] = {
			Level = 30,
			Class = "HUNTER",
		},
		[14290] = {
			Level = 54,
			Class = "HUNTER",
		},
		[14294] = {
			Level = 50,
			Class = "HUNTER",
		},
		[14298] = {
			Level = 26,
			Class = "HUNTER",
		},
		[14300] = {
			Level = 46,
			Class = "HUNTER",
		},
		[14302] = {
			Level = 26,
			Class = "HUNTER",
		},
		[14304] = {
			Level = 46,
			Class = "HUNTER",
		},
		[19879] = {
			Level = 50,
			Class = "HUNTER",
		},
		[13543] = {
			Level = 52,
			Class = "HUNTER",
		},
		[1513] = {
			Level = 14,
			Class = "HUNTER",
		},
		[14314] = {
			Level = 44,
			Class = "HUNTER",
		},
		[14316] = {
			Level = 44,
			Class = "HUNTER",
		},
		[13553] = {
			Level = 42,
			Class = "HUNTER",
		},
		[14320] = {
			Level = 38,
			Class = "HUNTER",
		},
		[42245] = {
			Level = 58,
			Class = "HUNTER",
		},
		[14324] = {
			Level = 40,
			Class = "HUNTER",
		},
		[1515] = {
			Level = 10,
			Class = "HUNTER",
		},
		[3661] = {
			Level = 28,
			Class = "HUNTER",
		},
		[3662] = {
			Level = 36,
			Class = "HUNTER",
		},
		[20190] = {
			Level = 56,
			Class = "HUNTER",
		},
		[2643] = {
			Level = 18,
			Class = "HUNTER",
		},
		[20736] = {
			Level = 12,
			Class = "HUNTER",
		},
		[53338] = {
			Level = 58,
			Class = "HUNTER",
		},
		[58433] = {
			Level = 80,
			Class = "HUNTER",
		},
		[49051] = {
			Level = 71,
			Class = "HUNTER",
		},
		[49064] = {
			Level = 71,
			Class = "HUNTER",
		},
		[3034] = {
			Level = 36,
			Class = "HUNTER",
		},
		[48990] = {
			Level = 80,
			Class = "HUNTER",
		},
		[49070] = {
			Level = 80,
			Class = "HUNTER",
		},
		[14310] = {
			Level = 40,
			Class = "HUNTER",
		},
		[49054] = {
			Level = 78,
			Class = "HUNTER",
		},
		[49056] = {
			Level = 78,
			Class = "HUNTER",
		},
		[27018] = {
			Level = 66,
			Class = "HUNTER",
		},
		[48996] = {
			Level = 77,
			Class = "HUNTER",
		},
		[49067] = {
			Level = 77,
			Class = "HUNTER",
		},
		[20043] = {
			Level = 46,
			Class = "HUNTER",
		},
		[49071] = {
			Level = 76,
			Class = "HUNTER",
		},
		[13159] = {
			Level = 40,
			Class = "HUNTER",
		},
		[53351] = {
			Level = 71,
			Class = "HUNTER",
		},
		[2641] = {
			Level = 10,
			Class = "HUNTER",
		},
		[13551] = {
			Level = 26,
			Class = "HUNTER",
		},
		[27045] = {
			Level = 68,
			Class = "HUNTER",
		},
		[24406] = {
			Level = 60,
			Class = "HUNTER",
		},
		[13549] = {
			Level = 10,
			Class = "HUNTER",
		},
		[3043] = {
			Level = 22,
			Class = "HUNTER",
		},
		[48995] = {
			Level = 71,
			Class = "HUNTER",
		},
		[3044] = {
			Level = 6,
			Class = "HUNTER",
		},
		[1462] = {
			Level = 24,
			Class = "HUNTER",
		},
		[3045] = {
			Level = 26,
			Class = "HUNTER",
		},
		[58431] = {
			Level = 74,
			Class = "HUNTER",
		},
		[53339] = {
			Level = 80,
			Class = "HUNTER",
		},
		[34477] = {
			Level = 70,
			Class = "HUNTER",
		},
		[49066] = {
			Level = 71,
			Class = "HUNTER",
		},
		[13555] = {
			Level = 58,
			Class = "HUNTER",
		},
		[27019] = {
			Level = 69,
			Class = "HUNTER",
		},
		[49044] = {
			Level = 73,
			Class = "HUNTER",
		},
		[49052] = {
			Level = 77,
			Class = "HUNTER",
		},
		[27016] = {
			Level = 67,
			Class = "HUNTER",
		},
		[19880] = {
			Level = 26,
			Class = "HUNTER",
		},
		[27024] = {
			Level = 65,
			Class = "HUNTER",
		},
		[42234] = {
			Level = 67,
			Class = "HUNTER",
		},
		[136] = {
			Level = 12,
			Class = "HUNTER",
		},
		[27022] = {
			Level = 67,
			Class = "HUNTER",
		},
		[27021] = {
			Level = 67,
			Class = "HUNTER",
		},
		[27044] = {
			Level = 68,
			Class = "HUNTER",
		},
		[34120] = {
			Level = 62,
			Class = "HUNTER",
		},
		[14322] = {
			Level = 58,
			Class = "HUNTER",
		},
		[25294] = {
			Level = 60,
			Class = "HUNTER",
		},
		[14281] = {
			Level = 12,
			Class = "HUNTER",
		},
		[36916] = {
			Level = 70,
			Class = "HUNTER",
		},
		[14285] = {
			Level = 44,
			Class = "HUNTER",
		},
		[1978] = {
			Level = 4,
			Class = "HUNTER",
		},
		[14286] = {
			Level = 52,
			Class = "HUNTER",
		},
		[25295] = {
			Level = 60,
			Class = "HUNTER",
		},
		[781] = {
			Level = 20,
			Class = "HUNTER",
		},
		[883] = {
			Level = 10,
			Class = "HUNTER",
		},
		[27023] = {
			Level = 65,
			Class = "HUNTER",
		},
		[24395] = {
			Level = 40,
			Class = "HUNTER",
		},
		[24397] = {
			Level = 40,
			Class = "HUNTER",
		},
		[14295] = {
			Level = 58,
			Class = "HUNTER",
		},
		[48989] = {
			Level = 74,
			Class = "HUNTER",
		},
		[58432] = {
			Level = 74,
			Class = "HUNTER",
		},
		[5384] = {
			Level = 30,
			Class = "HUNTER",
		},
		[13161] = {
			Level = 30,
			Class = "HUNTER",
		},
		[13544] = {
			Level = 60,
			Class = "HUNTER",
		},
		[13165] = {
			Level = 10,
			Class = "HUNTER",
		},
		[19883] = {
			Level = 10,
			Class = "HUNTER",
		},
		[49045] = {
			Level = 79,
			Class = "HUNTER",
		},
		[49053] = {
			Level = 72,
			Class = "HUNTER",
		},
		[13550] = {
			Level = 18,
			Class = "HUNTER",
		},
		[49069] = {
			Level = 74,
			Class = "HUNTER",
		},
		[13552] = {
			Level = 34,
			Class = "HUNTER",
		},
		[1130] = {
			Level = 6,
			Class = "HUNTER",
		},
		[13809] = {
			Level = 28,
			Class = "HUNTER",
		},
		[14318] = {
			Level = 18,
			Class = "HUNTER",
		},
		[19263] = {
			Level = 60,
			Class = "HUNTER",
		},
		[14319] = {
			Level = 28,
			Class = "HUNTER",
		},
		[13812] = {
			Level = 34,
			Class = "HUNTER",
		},
		[13813] = {
			Level = 34,
			Class = "HUNTER",
		},
		[14261] = {
			Level = 16,
			Class = "HUNTER",
		},
		[14263] = {
			Level = 32,
			Class = "HUNTER",
		},
		[14265] = {
			Level = 48,
			Class = "HUNTER",
		},
		[19801] = {
			Level = 60,
			Class = "HUNTER",
		},
		[14269] = {
			Level = 30,
			Class = "HUNTER",
		},
		[14271] = {
			Level = 58,
			Class = "HUNTER",
		},
		[19885] = {
			Level = 24,
			Class = "HUNTER",
		},
		[14326] = {
			Level = 30,
			Class = "HUNTER",
		},
		[982] = {
			Level = 10,
			Class = "HUNTER",
		},
		[14279] = {
			Level = 46,
			Class = "HUNTER",
		},
		[5116] = {
			Level = 8,
			Class = "HUNTER",
		},
		[14283] = {
			Level = 28,
			Class = "HUNTER",
		},
		[5118] = {
			Level = 20,
			Class = "HUNTER",
		},
		[14287] = {
			Level = 60,
			Class = "HUNTER",
		},
		[14289] = {
			Level = 42,
			Class = "HUNTER",
		},
		[34471] = {
			Level = 50,
			Class = "HUNTER",
		},
		[14305] = {
			Level = 56,
			Class = "HUNTER",
		},
		[1543] = {
			Level = 32,
			Class = "HUNTER",
		},
		[13542] = {
			Level = 44,
			Class = "HUNTER",
		},
		[14299] = {
			Level = 36,
			Class = "HUNTER",
		},
		[14301] = {
			Level = 56,
			Class = "HUNTER",
		},
		[14303] = {
			Level = 36,
			Class = "HUNTER",
		},
		[13795] = {
			Level = 16,
			Class = "HUNTER",
		},
		[13797] = {
			Level = 16,
			Class = "HUNTER",
		},
		[19884] = {
			Level = 18,
			Class = "HUNTER",
		},


	--<<<MAGE>>>

		[42985] = {
			Level = 77,
			Class = "MAGE",
		},
		[32271] = {
			Level = 20,
			Class = "MAGE",
		},
		[8494] = {
			Level = 28,
			Class = "MAGE",
		},
		[44614] = {
			Level = 75,
			Class = "MAGE",
		},
		[759] = {
			Level = 28,
			Class = "MAGE",
		},
		[10059] = {
			Level = 40,
			Class = "MAGE",
		},
		[28271] = {
			Level = 60,
			Class = "MAGE",
		},
		[3552] = {
			Level = 38,
			Class = "MAGE",
		},
		[42842] = {
			Level = 79,
			Class = "MAGE",
		},
		[42858] = {
			Level = 73,
			Class = "MAGE",
		},
		[53142] = {
			Level = 74,
			Class = "MAGE",
		},
		[3561] = {
			Level = 20,
			Class = "MAGE",
		},
		[3562] = {
			Level = 20,
			Class = "MAGE",
		},
		[3563] = {
			Level = 20,
			Class = "MAGE",
		},
		[10139] = {
			Level = 50,
			Class = "MAGE",
		},
		[3565] = {
			Level = 30,
			Class = "MAGE",
		},
		[3566] = {
			Level = 30,
			Class = "MAGE",
		},
		[10151] = {
			Level = 60,
			Class = "MAGE",
		},
		[10159] = {
			Level = 42,
			Class = "MAGE",
		},
		[6117] = {
			Level = 34,
			Class = "MAGE",
		},
		[10179] = {
			Level = 44,
			Class = "MAGE",
		},
		[10187] = {
			Level = 60,
			Class = "MAGE",
		},
		[10191] = {
			Level = 44,
			Class = "MAGE",
		},
		[6127] = {
			Level = 30,
			Class = "MAGE",
		},
		[6129] = {
			Level = 32,
			Class = "MAGE",
		},
		[6131] = {
			Level = 40,
			Class = "MAGE",
		},
		[10207] = {
			Level = 58,
			Class = "MAGE",
		},
		[10211] = {
			Level = 48,
			Class = "MAGE",
		},
		[10215] = {
			Level = 48,
			Class = "MAGE",
		},
		[10219] = {
			Level = 50,
			Class = "MAGE",
		},
		[6141] = {
			Level = 28,
			Class = "MAGE",
		},
		[6143] = {
			Level = 22,
			Class = "MAGE",
		},
		[42843] = {
			Level = 75,
			Class = "MAGE",
		},
		[27082] = {
			Level = 70,
			Class = "MAGE",
		},
		[27090] = {
			Level = 70,
			Class = "MAGE",
		},
		[42939] = {
			Level = 74,
			Class = "MAGE",
		},
		[42955] = {
			Level = 75,
			Class = "MAGE",
		},
		[12826] = {
			Level = 60,
			Class = "MAGE",
		},
		[32272] = {
			Level = 20,
			Class = "MAGE",
		},
		[12355] = {
			Level = 10,
			Class = "MAGE",
		},
		[28272] = {
			Level = 60,
			Class = "MAGE",
		},
		[49359] = {
			Level = 35,
			Class = "MAGE",
		},
		[130] = {
			Level = 12,
			Class = "MAGE",
		},
		[38692] = {
			Level = 70,
			Class = "MAGE",
		},
		[42844] = {
			Level = 75,
			Class = "MAGE",
		},
		[42940] = {
			Level = 80,
			Class = "MAGE",
		},
		[42956] = {
			Level = 80,
			Class = "MAGE",
		},
		[11417] = {
			Level = 40,
			Class = "MAGE",
		},
		[43020] = {
			Level = 79,
			Class = "MAGE",
		},
		[7269] = {
			Level = 16,
			Class = "MAGE",
		},
		[8407] = {
			Level = 32,
			Class = "MAGE",
		},
		[49360] = {
			Level = 35,
			Class = "MAGE",
		},
		[8419] = {
			Level = 32,
			Class = "MAGE",
		},
		[8423] = {
			Level = 40,
			Class = "MAGE",
		},
		[8427] = {
			Level = 36,
			Class = "MAGE",
		},
		[8439] = {
			Level = 38,
			Class = "MAGE",
		},
		[27075] = {
			Level = 63,
			Class = "MAGE",
		},
		[8451] = {
			Level = 36,
			Class = "MAGE",
		},
		[7301] = {
			Level = 20,
			Class = "MAGE",
		},
		[66] = {
			Level = 68,
			Class = "MAGE",
		},
		[27131] = {
			Level = 68,
			Class = "MAGE",
		},
		[8495] = {
			Level = 36,
			Class = "MAGE",
		},
		[2136] = {
			Level = 6,
			Class = "MAGE",
		},
		[2137] = {
			Level = 14,
			Class = "MAGE",
		},
		[2138] = {
			Level = 22,
			Class = "MAGE",
		},
		[2139] = {
			Level = 24,
			Class = "MAGE",
		},
		[49361] = {
			Level = 35,
			Class = "MAGE",
		},
		[42846] = {
			Level = 79,
			Class = "MAGE",
		},
		[42894] = {
			Level = 71,
			Class = "MAGE",
		},
		[42926] = {
			Level = 79,
			Class = "MAGE",
		},
		[10140] = {
			Level = 60,
			Class = "MAGE",
		},
		[10144] = {
			Level = 42,
			Class = "MAGE",
		},
		[10148] = {
			Level = 42,
			Class = "MAGE",
		},
		[10156] = {
			Level = 42,
			Class = "MAGE",
		},
		[10160] = {
			Level = 50,
			Class = "MAGE",
		},
		[543] = {
			Level = 20,
			Class = "MAGE",
		},
		[10180] = {
			Level = 50,
			Class = "MAGE",
		},
		[10192] = {
			Level = 52,
			Class = "MAGE",
		},
		[42208] = {
			Level = 20,
			Class = "MAGE",
		},
		[10212] = {
			Level = 56,
			Class = "MAGE",
		},
		[10216] = {
			Level = 56,
			Class = "MAGE",
		},
		[10220] = {
			Level = 60,
			Class = "MAGE",
		},
		[28609] = {
			Level = 60,
			Class = "MAGE",
		},
		[23028] = {
			Level = 56,
			Class = "MAGE",
		},
		[27124] = {
			Level = 69,
			Class = "MAGE",
		},
		[116] = {
			Level = 4,
			Class = "MAGE",
		},
		[32266] = {
			Level = 40,
			Class = "MAGE",
		},
		[43023] = {
			Level = 71,
			Class = "MAGE",
		},
		[42209] = {
			Level = 28,
			Class = "MAGE",
		},
		[42832] = {
			Level = 74,
			Class = "MAGE",
		},
		[25304] = {
			Level = 60,
			Class = "MAGE",
		},
		[42896] = {
			Level = 76,
			Class = "MAGE",
		},
		[11418] = {
			Level = 40,
			Class = "MAGE",
		},
		[43008] = {
			Level = 79,
			Class = "MAGE",
		},
		[43024] = {
			Level = 79,
			Class = "MAGE",
		},
		[8400] = {
			Level = 24,
			Class = "MAGE",
		},
		[8408] = {
			Level = 38,
			Class = "MAGE",
		},
		[8412] = {
			Level = 30,
			Class = "MAGE",
		},
		[8416] = {
			Level = 32,
			Class = "MAGE",
		},
		[38697] = {
			Level = 70,
			Class = "MAGE",
		},
		[5505] = {
			Level = 10,
			Class = "MAGE",
		},
		[8444] = {
			Level = 28,
			Class = "MAGE",
		},
		[24530] = {
			Level = 60,
			Class = "MAGE",
		},
		[27101] = {
			Level = 68,
			Class = "MAGE",
		},
		[42913] = {
			Level = 72,
			Class = "MAGE",
		},
		[27125] = {
			Level = 69,
			Class = "MAGE",
		},
		[118] = {
			Level = 8,
			Class = "MAGE",
		},
		[32267] = {
			Level = 40,
			Class = "MAGE",
		},
		[205] = {
			Level = 8,
			Class = "MAGE",
		},
		[37420] = {
			Level = 65,
			Class = "MAGE",
		},
		[34913] = {
			Level = 62,
			Class = "MAGE",
		},
		[475] = {
			Level = 18,
			Class = "MAGE",
		},
		[10053] = {
			Level = 48,
			Class = "MAGE",
		},
		[42211] = {
			Level = 44,
			Class = "MAGE",
		},
		[10] = {
			Level = 20,
			Class = "MAGE",
		},
		[58659] = {
			Level = 80,
			Class = "MAGE",
		},
		[42914] = {
			Level = 78,
			Class = "MAGE",
		},
		[42930] = {
			Level = 72,
			Class = "MAGE",
		},
		[22782] = {
			Level = 46,
			Class = "MAGE",
		},
		[30455] = {
			Level = 66,
			Class = "MAGE",
		},
		[143] = {
			Level = 6,
			Class = "MAGE",
		},
		[10145] = {
			Level = 52,
			Class = "MAGE",
		},
		[10149] = {
			Level = 48,
			Class = "MAGE",
		},
		[10157] = {
			Level = 56,
			Class = "MAGE",
		},
		[10161] = {
			Level = 58,
			Class = "MAGE",
		},
		[10169] = {
			Level = 42,
			Class = "MAGE",
		},
		[10173] = {
			Level = 48,
			Class = "MAGE",
		},
		[10177] = {
			Level = 52,
			Class = "MAGE",
		},
		[10181] = {
			Level = 56,
			Class = "MAGE",
		},
		[10185] = {
			Level = 44,
			Class = "MAGE",
		},
		[10193] = {
			Level = 60,
			Class = "MAGE",
		},
		[10197] = {
			Level = 46,
			Class = "MAGE",
		},
		[42212] = {
			Level = 52,
			Class = "MAGE",
		},
		[10205] = {
			Level = 46,
			Class = "MAGE",
		},
		[38699] = {
			Level = 69,
			Class = "MAGE",
		},
		[10225] = {
			Level = 60,
			Class = "MAGE",
		},
		[27070] = {
			Level = 66,
			Class = "MAGE",
		},
		[27078] = {
			Level = 61,
			Class = "MAGE",
		},
		[27086] = {
			Level = 64,
			Class = "MAGE",
		},
		[45438] = {
			Level = 30,
			Class = "MAGE",
		},
		[33717] = {
			Level = 70,
			Class = "MAGE",
		},
		[42931] = {
			Level = 79,
			Class = "MAGE",
		},
		[27126] = {
			Level = 70,
			Class = "MAGE",
		},
		[120] = {
			Level = 26,
			Class = "MAGE",
		},
		[145] = {
			Level = 12,
			Class = "MAGE",
		},
		[10273] = {
			Level = 48,
			Class = "MAGE",
		},
		[837] = {
			Level = 14,
			Class = "MAGE",
		},
		[43043] = {
			Level = 71,
			Class = "MAGE",
		},
		[42213] = {
			Level = 60,
			Class = "MAGE",
		},
		[38700] = {
			Level = 64,
			Class = "MAGE",
		},
		[587] = {
			Level = 6,
			Class = "MAGE",
		},
		[25306] = {
			Level = 60,
			Class = "MAGE",
		},
		[22783] = {
			Level = 58,
			Class = "MAGE",
		},
		[25346] = {
			Level = 60,
			Class = "MAGE",
		},
		[11419] = {
			Level = 50,
			Class = "MAGE",
		},
		[43012] = {
			Level = 79,
			Class = "MAGE",
		},
		[43044] = {
			Level = 79,
			Class = "MAGE",
		},
		[7268] = {
			Level = 8,
			Class = "MAGE",
		},
		[7270] = {
			Level = 24,
			Class = "MAGE",
		},
		[12485] = {
			Level = 10,
			Class = "MAGE",
		},
		[8401] = {
			Level = 30,
			Class = "MAGE",
		},
		[42198] = {
			Level = 68,
			Class = "MAGE",
		},
		[8413] = {
			Level = 38,
			Class = "MAGE",
		},
		[8417] = {
			Level = 40,
			Class = "MAGE",
		},
		[1953] = {
			Level = 20,
			Class = "MAGE",
		},
		[8437] = {
			Level = 22,
			Class = "MAGE",
		},
		[27071] = {
			Level = 63,
			Class = "MAGE",
		},
		[8445] = {
			Level = 34,
			Class = "MAGE",
		},
		[27087] = {
			Level = 65,
			Class = "MAGE",
		},
		[7300] = {
			Level = 10,
			Class = "MAGE",
		},
		[8457] = {
			Level = 30,
			Class = "MAGE",
		},
		[8461] = {
			Level = 32,
			Class = "MAGE",
		},
		[27127] = {
			Level = 70,
			Class = "MAGE",
		},
		[43987] = {
			Level = 70,
			Class = "MAGE",
		},
		[122] = {
			Level = 10,
			Class = "MAGE",
		},
		[597] = {
			Level = 12,
			Class = "MAGE",
		},
		[1449] = {
			Level = 14,
			Class = "MAGE",
		},
		[7320] = {
			Level = 40,
			Class = "MAGE",
		},
		[7322] = {
			Level = 20,
			Class = "MAGE",
		},
		[10054] = {
			Level = 58,
			Class = "MAGE",
		},
		[1460] = {
			Level = 14,
			Class = "MAGE",
		},
		[1461] = {
			Level = 28,
			Class = "MAGE",
		},
		[604] = {
			Level = 12,
			Class = "MAGE",
		},
		[1463] = {
			Level = 20,
			Class = "MAGE",
		},
		[10138] = {
			Level = 40,
			Class = "MAGE",
		},
		[10150] = {
			Level = 54,
			Class = "MAGE",
		},
		[43046] = {
			Level = 79,
			Class = "MAGE",
		},
		[55342] = {
			Level = 80,
			Class = "MAGE",
		},
		[47610] = {
			Level = 80,
			Class = "MAGE",
		},
		[990] = {
			Level = 22,
			Class = "MAGE",
		},
		[10174] = {
			Level = 60,
			Class = "MAGE",
		},
		[33944] = {
			Level = 67,
			Class = "MAGE",
		},
		[42873] = {
			Level = 80,
			Class = "MAGE",
		},
		[10186] = {
			Level = 52,
			Class = "MAGE",
		},
		[42938] = {
			Level = 80,
			Class = "MAGE",
		},
		[42995] = {
			Level = 80,
			Class = "MAGE",
		},
		[42921] = {
			Level = 80,
			Class = "MAGE",
		},
		[10202] = {
			Level = 54,
			Class = "MAGE",
		},
		[10206] = {
			Level = 52,
			Class = "MAGE",
		},
		[43002] = {
			Level = 80,
			Class = "MAGE",
		},
		[865] = {
			Level = 26,
			Class = "MAGE",
		},
		[38703] = {
			Level = 64,
			Class = "MAGE",
		},
		[42897] = {
			Level = 80,
			Class = "MAGE",
		},
		[42845] = {
			Level = 79,
			Class = "MAGE",
		},
		[2948] = {
			Level = 22,
			Class = "MAGE",
		},
		[27080] = {
			Level = 62,
			Class = "MAGE",
		},
		[27088] = {
			Level = 67,
			Class = "MAGE",
		},
		[10199] = {
			Level = 54,
			Class = "MAGE",
		},
		[42859] = {
			Level = 78,
			Class = "MAGE",
		},
		[12536] = {
			Level = 10,
			Class = "MAGE",
		},
		[10223] = {
			Level = 50,
			Class = "MAGE",
		},
		[27128] = {
			Level = 69,
			Class = "MAGE",
		},
		[42833] = {
			Level = 78,
			Class = "MAGE",
		},
		[49358] = {
			Level = 35,
			Class = "MAGE",
		},
		[12825] = {
			Level = 40,
			Class = "MAGE",
		},
		[10274] = {
			Level = 56,
			Class = "MAGE",
		},
		[43010] = {
			Level = 78,
			Class = "MAGE",
		},
		[27073] = {
			Level = 65,
			Class = "MAGE",
		},
		[5143] = {
			Level = 8,
			Class = "MAGE",
		},
		[5144] = {
			Level = 16,
			Class = "MAGE",
		},
		[5145] = {
			Level = 24,
			Class = "MAGE",
		},
		[43017] = {
			Level = 77,
			Class = "MAGE",
		},
		[35715] = {
			Level = 60,
			Class = "MAGE",
		},
		[10170] = {
			Level = 54,
			Class = "MAGE",
		},
		[8492] = {
			Level = 34,
			Class = "MAGE",
		},
		[32796] = {
			Level = 70,
			Class = "MAGE",
		},
		[30449] = {
			Level = 70,
			Class = "MAGE",
		},
		[42841] = {
			Level = 75,
			Class = "MAGE",
		},
		[2120] = {
			Level = 16,
			Class = "MAGE",
		},
		[42210] = {
			Level = 36,
			Class = "MAGE",
		},
		[10201] = {
			Level = 46,
			Class = "MAGE",
		},
		[42925] = {
			Level = 72,
			Class = "MAGE",
		},
		[43015] = {
			Level = 76,
			Class = "MAGE",
		},
		[38704] = {
			Level = 70,
			Class = "MAGE",
		},
		[27072] = {
			Level = 69,
			Class = "MAGE",
		},
		[43019] = {
			Level = 73,
			Class = "MAGE",
		},
		[43045] = {
			Level = 71,
			Class = "MAGE",
		},
		[3140] = {
			Level = 18,
			Class = "MAGE",
		},
		[42872] = {
			Level = 74,
			Class = "MAGE",
		},
		[33690] = {
			Level = 60,
			Class = "MAGE",
		},
		[42920] = {
			Level = 76,
			Class = "MAGE",
		},
		[53140] = {
			Level = 71,
			Class = "MAGE",
		},
		[27079] = {
			Level = 70,
			Class = "MAGE",
		},
		[27085] = {
			Level = 68,
			Class = "MAGE",
		},
		[2121] = {
			Level = 24,
			Class = "MAGE",
		},
		[11416] = {
			Level = 40,
			Class = "MAGE",
		},
		[11420] = {
			Level = 50,
			Class = "MAGE",
		},
		[30482] = {
			Level = 62,
			Class = "MAGE",
		},
		[27074] = {
			Level = 70,
			Class = "MAGE",
		},
		[28612] = {
			Level = 60,
			Class = "MAGE",
		},
		[7302] = {
			Level = 30,
			Class = "MAGE",
		},
		[25345] = {
			Level = 60,
			Class = "MAGE",
		},
		[35717] = {
			Level = 65,
			Class = "MAGE",
		},
		[27076] = {
			Level = 64,
			Class = "MAGE",
		},
		[30451] = {
			Level = 64,
			Class = "MAGE",
		},
		[33946] = {
			Level = 69,
			Class = "MAGE",
		},
		[10230] = {
			Level = 54,
			Class = "MAGE",
		},
		[12486] = {
			Level = 10,
			Class = "MAGE",
		},
		[8402] = {
			Level = 36,
			Class = "MAGE",
		},
		[12494] = {
			Level = 10,
			Class = "MAGE",
		},
		[27130] = {
			Level = 63,
			Class = "MAGE",
		},
		[1008] = {
			Level = 18,
			Class = "MAGE",
		},
		[8418] = {
			Level = 40,
			Class = "MAGE",
		},
		[8422] = {
			Level = 32,
			Class = "MAGE",
		},
		[8455] = {
			Level = 30,
			Class = "MAGE",
		},
		[42917] = {
			Level = 75,
			Class = "MAGE",
		},
		[12824] = {
			Level = 20,
			Class = "MAGE",
		},
		[8438] = {
			Level = 30,
			Class = "MAGE",
		},
		[5506] = {
			Level = 20,
			Class = "MAGE",
		},
		[8446] = {
			Level = 40,
			Class = "MAGE",
		},
		[8450] = {
			Level = 24,
			Class = "MAGE",
		},
		[33691] = {
			Level = 65,
			Class = "MAGE",
		},
		[8458] = {
			Level = 40,
			Class = "MAGE",
		},
		[8462] = {
			Level = 42,
			Class = "MAGE",
		},
		[42937] = {
			Level = 74,
			Class = "MAGE",
		},
		[3567] = {
			Level = 20,
			Class = "MAGE",
		},
		[12051] = {
			Level = 20,
			Class = "MAGE",
		},
		[8406] = {
			Level = 26,
			Class = "MAGE",
		},

	--<<<PALADIN>>>

		[19897] = {
			Level = 44,
			Class = "PALADIN",
		},
		[647] = {
			Level = 14,
			Class = "PALADIN",
		},
		[20164] = {
			Level = 22,
			Class = "PALADIN",
		},
		[31898] = {
			Level = 64,
			Class = "PALADIN",
		},
		[25782] = {
			Level = 52,
			Class = "PALADIN",
		},
		[20184] = {
			Level = 22,
			Class = "PALADIN",
		},
		[1038] = {
			Level = 26,
			Class = "PALADIN",
		},
		[3472] = {
			Level = 38,
			Class = "PALADIN",
		},
		[54043] = {
			Level = 76,
			Class = "PALADIN",
		},
		[20467] = {
			Level = 20,
			Class = "PALADIN",
		},
		[6940] = {
			Level = 46,
			Class = "PALADIN",
		},
		[48784] = {
			Level = 74,
			Class = "PALADIN",
		},
		[19742] = {
			Level = 14,
			Class = "PALADIN",
		},
		[1042] = {
			Level = 30,
			Class = "PALADIN",
		},
		[19750] = {
			Level = 20,
			Class = "PALADIN",
		},
		[10291] = {
			Level = 30,
			Class = "PALADIN",
		},
		[10293] = {
			Level = 60,
			Class = "PALADIN",
		},
		[10299] = {
			Level = 36,
			Class = "PALADIN",
		},
		[10301] = {
			Level = 56,
			Class = "PALADIN",
		},
		[1044] = {
			Level = 18,
			Class = "PALADIN",
		},
		[53733] = {
			Level = 66,
			Class = "PALADIN",
		},
		[10313] = {
			Level = 52,
			Class = "PALADIN",
		},
		[48936] = {
			Level = 77,
			Class = "PALADIN",
		},
		[31803] = {
			Level = 64,
			Class = "PALADIN",
		},
		[10329] = {
			Level = 54,
			Class = "PALADIN",
		},
		[19834] = {
			Level = 12,
			Class = "PALADIN",
		},
		[19838] = {
			Level = 52,
			Class = "PALADIN",
		},
		[19850] = {
			Level = 24,
			Class = "PALADIN",
		},
		[19854] = {
			Level = 54,
			Class = "PALADIN",
		},
		[48785] = {
			Level = 79,
			Class = "PALADIN",
		},
		[48801] = {
			Level = 79,
			Class = "PALADIN",
		},
		[53407] = {
			Level = 28,
			Class = "PALADIN",
		},
		[19898] = {
			Level = 56,
			Class = "PALADIN",
		},
		[20922] = {
			Level = 40,
			Class = "PALADIN",
		},
		[20165] = {
			Level = 30,
			Class = "PALADIN",
		},
		[53726] = {
			Level = 66,
			Class = "PALADIN",
		},
		[53742] = {
			Level = 66,
			Class = "PALADIN",
		},
		[20185] = {
			Level = 30,
			Class = "PALADIN",
		},
		[879] = {
			Level = 20,
			Class = "PALADIN",
		},
		[19942] = {
			Level = 50,
			Class = "PALADIN",
		},
		[48945] = {
			Level = 77,
			Class = "PALADIN",
		},
		[27138] = {
			Level = 68,
			Class = "PALADIN",
		},
		[27142] = {
			Level = 65,
			Class = "PALADIN",
		},
		[53408] = {
			Level = 12,
			Class = "PALADIN",
		},
		[27154] = {
			Level = 69,
			Class = "PALADIN",
		},
		[25899] = {
			Level = 60,
			Class = "PALADIN",
		},
		[32841] = {
			Level = 70,
			Class = "PALADIN",
		},
		[48938] = {
			Level = 77,
			Class = "PALADIN",
		},
		[31804] = {
			Level = 64,
			Class = "PALADIN",
		},
		[4987] = {
			Level = 42,
			Class = "PALADIN",
		},
		[19835] = {
			Level = 22,
			Class = "PALADIN",
		},
		[5502] = {
			Level = 20,
			Class = "PALADIN",
		},
		[53600] = {
			Level = 75,
			Class = "PALADIN",
		},
		[853] = {
			Level = 8,
			Class = "PALADIN",
		},
		[7294] = {
			Level = 16,
			Class = "PALADIN",
		},
		[48819] = {
			Level = 80,
			Class = "PALADIN",
		},
		[19891] = {
			Level = 36,
			Class = "PALADIN",
		},
		[19895] = {
			Level = 40,
			Class = "PALADIN",
		},
		[19899] = {
			Level = 48,
			Class = "PALADIN",
		},
		[20923] = {
			Level = 50,
			Class = "PALADIN",
		},
		[31892] = {
			Level = 64,
			Class = "PALADIN",
		},
		[20166] = {
			Level = 38,
			Class = "PALADIN",
		},
		[20425] = {
			Level = 20,
			Class = "PALADIN",
		},
		[53736] = {
			Level = 66,
			Class = "PALADIN",
		},
		[20186] = {
			Level = 38,
			Class = "PALADIN",
		},
		[25290] = {
			Level = 60,
			Class = "PALADIN",
		},
		[24274] = {
			Level = 52,
			Class = "PALADIN",
		},
		[26573] = {
			Level = 20,
			Class = "PALADIN",
		},
		[48947] = {
			Level = 78,
			Class = "PALADIN",
		},
		[633] = {
			Level = 10,
			Class = "PALADIN",
		},
		[53601] = {
			Level = 80,
			Class = "PALADIN",
		},
		[32223] = {
			Level = 62,
			Class = "PALADIN",
		},
		[27135] = {
			Level = 62,
			Class = "PALADIN",
		},
		[27139] = {
			Level = 69,
			Class = "PALADIN",
		},
		[27143] = {
			Level = 65,
			Class = "PALADIN",
		},
		[10290] = {
			Level = 10,
			Class = "PALADIN",
		},
		[10292] = {
			Level = 50,
			Class = "PALADIN",
		},
		[27137] = {
			Level = 66,
			Class = "PALADIN",
		},
		[10298] = {
			Level = 26,
			Class = "PALADIN",
		},
		[10300] = {
			Level = 46,
			Class = "PALADIN",
		},
		[48806] = {
			Level = 80,
			Class = "PALADIN",
		},
		[48950] = {
			Level = 79,
			Class = "PALADIN",
		},
		[31801] = {
			Level = 64,
			Class = "PALADIN",
		},
		[10308] = {
			Level = 54,
			Class = "PALADIN",
		},
		[10310] = {
			Level = 50,
			Class = "PALADIN",
		},
		[25916] = {
			Level = 60,
			Class = "PALADIN",
		},
		[10314] = {
			Level = 60,
			Class = "PALADIN",
		},
		[31789] = {
			Level = 14,
			Class = "PALADIN",
		},
		[10318] = {
			Level = 60,
			Class = "PALADIN",
		},
		[48932] = {
			Level = 79,
			Class = "PALADIN",
		},
		[10322] = {
			Level = 24,
			Class = "PALADIN",
		},
		[10324] = {
			Level = 36,
			Class = "PALADIN",
		},
		[10326] = {
			Level = 24,
			Class = "PALADIN",
		},
		[10328] = {
			Level = 46,
			Class = "PALADIN",
		},
		[10312] = {
			Level = 44,
			Class = "PALADIN",
		},
		[19836] = {
			Level = 32,
			Class = "PALADIN",
		},
		[48788] = {
			Level = 78,
			Class = "PALADIN",
		},
		[48817] = {
			Level = 78,
			Class = "PALADIN",
		},
		[48943] = {
			Level = 76,
			Class = "PALADIN",
		},
		[19852] = {
			Level = 34,
			Class = "PALADIN",
		},
		[48805] = {
			Level = 74,
			Class = "PALADIN",
		},
		[48818] = {
			Level = 75,
			Class = "PALADIN",
		},
		[48781] = {
			Level = 75,
			Class = "PALADIN",
		},
		[25780] = {
			Level = 16,
			Class = "PALADIN",
		},
		[48933] = {
			Level = 73,
			Class = "PALADIN",
		},
		[19876] = {
			Level = 28,
			Class = "PALADIN",
		},
		[48800] = {
			Level = 73,
			Class = "PALADIN",
		},
		[33776] = {
			Level = 66,
			Class = "PALADIN",
		},
		[19888] = {
			Level = 32,
			Class = "PALADIN",
		},
		[48931] = {
			Level = 73,
			Class = "PALADIN",
		},
		[19896] = {
			Level = 52,
			Class = "PALADIN",
		},
		[19900] = {
			Level = 60,
			Class = "PALADIN",
		},
		[20924] = {
			Level = 60,
			Class = "PALADIN",
		},
		[27141] = {
			Level = 70,
			Class = "PALADIN",
		},
		[48816] = {
			Level = 72,
			Class = "PALADIN",
		},
		[48937] = {
			Level = 71,
			Class = "PALADIN",
		},
		[2800] = {
			Level = 30,
			Class = "PALADIN",
		},
		[54428] = {
			Level = 71,
			Class = "PALADIN",
		},
		[48935] = {
			Level = 71,
			Class = "PALADIN",
		},
		[5588] = {
			Level = 24,
			Class = "PALADIN",
		},
		[25291] = {
			Level = 60,
			Class = "PALADIN",
		},
		[19940] = {
			Level = 34,
			Class = "PALADIN",
		},
		[48941] = {
			Level = 74,
			Class = "PALADIN",
		},
		[48949] = {
			Level = 72,
			Class = "PALADIN",
		},
		[27153] = {
			Level = 70,
			Class = "PALADIN",
		},
		[27149] = {
			Level = 70,
			Class = "PALADIN",
		},
		[27173] = {
			Level = 70,
			Class = "PALADIN",
		},
		[27140] = {
			Level = 70,
			Class = "PALADIN",
		},
		[31884] = {
			Level = 70,
			Class = "PALADIN",
		},
		[27180] = {
			Level = 68,
			Class = "PALADIN",
		},
		[1152] = {
			Level = 8,
			Class = "PALADIN",
		},
		[5589] = {
			Level = 40,
			Class = "PALADIN",
		},
		[53720] = {
			Level = 66,
			Class = "PALADIN",
		},
		[27150] = {
			Level = 66,
			Class = "PALADIN",
		},
		[48782] = {
			Level = 80,
			Class = "PALADIN",
		},
		[27136] = {
			Level = 70,
			Class = "PALADIN",
		},
		[1026] = {
			Level = 22,
			Class = "PALADIN",
		},
		[53651] = {
			Level = 60,
			Class = "PALADIN",
		},
		[20773] = {
			Level = 60,
			Class = "PALADIN",
		},
		[27152] = {
			Level = 68,
			Class = "PALADIN",
		},
		[20271] = {
			Level = 4,
			Class = "PALADIN",
		},
		[20772] = {
			Level = 48,
			Class = "PALADIN",
		},
		[25292] = {
			Level = 60,
			Class = "PALADIN",
		},
		[2812] = {
			Level = 50,
			Class = "PALADIN",
		},
		[643] = {
			Level = 20,
			Class = "PALADIN",
		},
		[5614] = {
			Level = 28,
			Class = "PALADIN",
		},
		[5615] = {
			Level = 36,
			Class = "PALADIN",
		},
		[19752] = {
			Level = 30,
			Class = "PALADIN",
		},
		[639] = {
			Level = 6,
			Class = "PALADIN",
		},
		[31785] = {
			Level = 18,
			Class = "PALADIN",
		},
		[25894] = {
			Level = 54,
			Class = "PALADIN",
		},
		[5599] = {
			Level = 24,
			Class = "PALADIN",
		},
		[27151] = {
			Level = 63,
			Class = "PALADIN",
		},
		[48934] = {
			Level = 79,
			Class = "PALADIN",
		},
		[48942] = {
			Level = 79,
			Class = "PALADIN",
		},
		[498] = {
			Level = 6,
			Class = "PALADIN",
		},
		[24239] = {
			Level = 60,
			Class = "PALADIN",
		},
		[19746] = {
			Level = 22,
			Class = "PALADIN",
		},
		[25918] = {
			Level = 60,
			Class = "PALADIN",
		},
		[19837] = {
			Level = 42,
			Class = "PALADIN",
		},
		[1032] = {
			Level = 40,
			Class = "PALADIN",
		},
		[1022] = {
			Level = 10,
			Class = "PALADIN",
		},
		[7328] = {
			Level = 12,
			Class = "PALADIN",
		},
		[19853] = {
			Level = 44,
			Class = "PALADIN",
		},
		[25898] = {
			Level = 60,
			Class = "PALADIN",
		},
		[20116] = {
			Level = 30,
			Class = "PALADIN",
		},
		[642] = {
			Level = 34,
			Class = "PALADIN",
		},
		[19939] = {
			Level = 26,
			Class = "PALADIN",
		},
		[19941] = {
			Level = 42,
			Class = "PALADIN",
		},
		[19943] = {
			Level = 58,
			Class = "PALADIN",
		},
		[24275] = {
			Level = 44,
			Class = "PALADIN",
		},
		[10278] = {
			Level = 38,
			Class = "PALADIN",
		},


	--=="PRIEST"== 

		[48127] = {
			Level = 79,
			Class = "PRIEST",
		},
		[21564] = {
			Level = 60,
			Class = "PRIEST",
		},
		[8103] = {
			Level = 22,
			Class = "PRIEST",
		},
		[8105] = {
			Level = 34,
			Class = "PRIEST",
		},
		[6063] = {
			Level = 28,
			Class = "PRIEST",
		},
		[6065] = {
			Level = 30,
			Class = "PRIEST",
		},
		[6075] = {
			Level = 20,
			Class = "PRIEST",
		},
		[6077] = {
			Level = 32,
			Class = "PRIEST",
		},
		[8129] = {
			Level = 24,
			Class = "PRIEST",
		},
		[8131] = {
			Level = 32,
			Class = "PRIEST",
		},
		[48112] = {
			Level = 74,
			Class = "PRIEST",
		},
		[19241] = {
			Level = 42,
			Class = "PRIEST",
		},
		[15261] = {
			Level = 60,
			Class = "PRIEST",
		},
		[15265] = {
			Level = 42,
			Class = "PRIEST",
		},
		[19265] = {
			Level = 50,
			Class = "PRIEST",
		},
		[19273] = {
			Level = 40,
			Class = "PRIEST",
		},
		[19281] = {
			Level = 20,
			Class = "PRIEST",
		},
		[25437] = {
			Level = 66,
			Class = "PRIEST",
		},
		[49821] = {
			Level = 75,
			Class = "PRIEST",
		},
		[25461] = {
			Level = 70,
			Class = "PRIEST",
		},
		[25477] = {
			Level = 68,
			Class = "PRIEST",
		},
		[2053] = {
			Level = 10,
			Class = "PRIEST",
		},
		[2054] = {
			Level = 16,
			Class = "PRIEST",
		},
		[2055] = {
			Level = 22,
			Class = "PRIEST",
		},
		[2060] = {
			Level = 40,
			Class = "PRIEST",
		},
		[2061] = {
			Level = 20,
			Class = "PRIEST",
		},
		[48113] = {
			Level = 79,
			Class = "PRIEST",
		},
		[44041] = {
			Level = 20,
			Class = "PRIEST",
		},
		[27681] = {
			Level = 60,
			Class = "PRIEST",
		},
		[48161] = {
			Level = 80,
			Class = "PRIEST",
		},
		[48177] = {
			Level = 73,
			Class = "PRIEST",
		},
		[14914] = {
			Level = 20,
			Class = "PRIEST",
		},
		[13896] = {
			Level = 20,
			Class = "PRIEST",
		},
		[25222] = {
			Level = 70,
			Class = "PRIEST",
		},
		[13908] = {
			Level = 10,
			Class = "PRIEST",
		},
		[453] = {
			Level = 20,
			Class = "PRIEST",
		},
		[10874] = {
			Level = 40,
			Class = "PRIEST",
		},
		[27873] = {
			Level = 50,
			Class = "PRIEST",
		},
		[10890] = {
			Level = 56,
			Class = "PRIEST",
		},
		[10894] = {
			Level = 58,
			Class = "PRIEST",
		},
		[10898] = {
			Level = 42,
			Class = "PRIEST",
		},
		[2096] = {
			Level = 22,
			Class = "PRIEST",
		},
		[19242] = {
			Level = 50,
			Class = "PRIEST",
		},
		[48162] = {
			Level = 80,
			Class = "PRIEST",
		},
		[19266] = {
			Level = 60,
			Class = "PRIEST",
		},
		[19274] = {
			Level = 50,
			Class = "PRIEST",
		},
		[19282] = {
			Level = 30,
			Class = "PRIEST",
		},
		[10938] = {
			Level = 60,
			Class = "PRIEST",
		},
		[10946] = {
			Level = 52,
			Class = "PRIEST",
		},
		[25446] = {
			Level = 66,
			Class = "PRIEST",
		},
		[528] = {
			Level = 14,
			Class = "PRIEST",
		},
		[10958] = {
			Level = 56,
			Class = "PRIEST",
		},
		[25470] = {
			Level = 70,
			Class = "PRIEST",
		},
		[9473] = {
			Level = 32,
			Class = "PRIEST",
		},
		[9485] = {
			Level = 40,
			Class = "PRIEST",
		},
		[48067] = {
			Level = 75,
			Class = "PRIEST",
		},
		[44043] = {
			Level = 30,
			Class = "PRIEST",
		},
		[2651] = {
			Level = 20,
			Class = "PRIEST",
		},
		[2652] = {
			Level = 10,
			Class = "PRIEST",
		},
		[28377] = {
			Level = 20,
			Class = "PRIEST",
		},
		[28385] = {
			Level = 68,
			Class = "PRIEST",
		},
		[6347] = {
			Level = 20,
			Class = "PRIEST",
		},
		[48068] = {
			Level = 80,
			Class = "PRIEST",
		},
		[48084] = {
			Level = 75,
			Class = "PRIEST",
		},
		[25367] = {
			Level = 65,
			Class = "PRIEST",
		},
		[25375] = {
			Level = 69,
			Class = "PRIEST",
		},
		[19251] = {
			Level = 30,
			Class = "PRIEST",
		},
		[15266] = {
			Level = 48,
			Class = "PRIEST",
		},
		[19267] = {
			Level = 30,
			Class = "PRIEST",
		},
		[19275] = {
			Level = 60,
			Class = "PRIEST",
		},
		[19283] = {
			Level = 40,
			Class = "PRIEST",
		},
		[19299] = {
			Level = 26,
			Class = "PRIEST",
		},
		[48085] = {
			Level = 80,
			Class = "PRIEST",
		},
		[44045] = {
			Level = 50,
			Class = "PRIEST",
		},
		[27683] = {
			Level = 56,
			Class = "PRIEST",
		},
		[552] = {
			Level = 32,
			Class = "PRIEST",
		},
		[3747] = {
			Level = 24,
			Class = "PRIEST",
		},
		[10875] = {
			Level = 48,
			Class = "PRIEST",
		},
		[28378] = {
			Level = 28,
			Class = "PRIEST",
		},
		[48070] = {
			Level = 73,
			Class = "PRIEST",
		},
		[139] = {
			Level = 8,
			Class = "PRIEST",
		},
		[19236] = {
			Level = 18,
			Class = "PRIEST",
		},
		[48134] = {
			Level = 72,
			Class = "PRIEST",
		},
		[25384] = {
			Level = 66,
			Class = "PRIEST",
		},
		[32546] = {
			Level = 64,
			Class = "PRIEST",
		},
		[10927] = {
			Level = 44,
			Class = "PRIEST",
		},
		[19276] = {
			Level = 28,
			Class = "PRIEST",
		},
		[19284] = {
			Level = 50,
			Class = "PRIEST",
		},
		[34433] = {
			Level = 66,
			Class = "PRIEST",
		},
		[10947] = {
			Level = 58,
			Class = "PRIEST",
		},
		[10951] = {
			Level = 50,
			Class = "PRIEST",
		},
		[10955] = {
			Level = 60,
			Class = "PRIEST",
		},
		[10963] = {
			Level = 46,
			Class = "PRIEST",
		},
		[33076] = {
			Level = 68,
			Class = "PRIEST",
		},
		[9474] = {
			Level = 38,
			Class = "PRIEST",
		},
		[48071] = {
			Level = 79,
			Class = "PRIEST",
		},
		[2767] = {
			Level = 34,
			Class = "PRIEST",
		},
		[44047] = {
			Level = 70,
			Class = "PRIEST",
		},
		[8092] = {
			Level = 10,
			Class = "PRIEST",
		},
		[9035] = {
			Level = 10,
			Class = "PRIEST",
		},
		[8104] = {
			Level = 28,
			Class = "PRIEST",
		},
		[8106] = {
			Level = 40,
			Class = "PRIEST",
		},
		[6064] = {
			Level = 34,
			Class = "PRIEST",
		},
		[32379] = {
			Level = 62,
			Class = "PRIEST",
		},
		[25233] = {
			Level = 61,
			Class = "PRIEST",
		},
		[6074] = {
			Level = 14,
			Class = "PRIEST",
		},
		[6076] = {
			Level = 26,
			Class = "PRIEST",
		},
		[8122] = {
			Level = 14,
			Class = "PRIEST",
		},
		[8124] = {
			Level = 28,
			Class = "PRIEST",
		},
		[2791] = {
			Level = 36,
			Class = "PRIEST",
		},
		[28379] = {
			Level = 36,
			Class = "PRIEST",
		},
		[34754] = {
			Level = 10,
			Class = "PRIEST",
		},
		[48072] = {
			Level = 76,
			Class = "PRIEST",
		},
		[20770] = {
			Level = 58,
			Class = "PRIEST",
		},
		[15263] = {
			Level = 30,
			Class = "PRIEST",
		},
		[19261] = {
			Level = 20,
			Class = "PRIEST",
		},
		[19269] = {
			Level = 50,
			Class = "PRIEST",
		},
		[19277] = {
			Level = 36,
			Class = "PRIEST",
		},
		[19285] = {
			Level = 60,
			Class = "PRIEST",
		},
		[25433] = {
			Level = 68,
			Class = "PRIEST",
		},
		[19309] = {
			Level = 36,
			Class = "PRIEST",
		},
		[53023] = {
			Level = 80,
			Class = "PRIEST",
		},
		[48169] = {
			Level = 76,
			Class = "PRIEST",
		},
		[28276] = {
			Level = 70,
			Class = "PRIEST",
		},
		[25218] = {
			Level = 70,
			Class = "PRIEST",
		},
		[586] = {
			Level = 8,
			Class = "PRIEST",
		},
		[970] = {
			Level = 18,
			Class = "PRIEST",
		},
		[10876] = {
			Level = 56,
			Class = "PRIEST",
		},
		[10880] = {
			Level = 34,
			Class = "PRIEST",
		},
		[25314] = {
			Level = 60,
			Class = "PRIEST",
		},
		[10888] = {
			Level = 42,
			Class = "PRIEST",
		},
		[10892] = {
			Level = 42,
			Class = "PRIEST",
		},
		[10900] = {
			Level = 54,
			Class = "PRIEST",
		},
		[589] = {
			Level = 4,
			Class = "PRIEST",
		},
		[19238] = {
			Level = 26,
			Class = "PRIEST",
		},
		[10916] = {
			Level = 50,
			Class = "PRIEST",
		},
		[19254] = {
			Level = 60,
			Class = "PRIEST",
		},
		[19262] = {
			Level = 30,
			Class = "PRIEST",
		},
		[10928] = {
			Level = 50,
			Class = "PRIEST",
		},
		[19278] = {
			Level = 44,
			Class = "PRIEST",
		},
		[591] = {
			Level = 6,
			Class = "PRIEST",
		},
		[19302] = {
			Level = 34,
			Class = "PRIEST",
		},
		[19310] = {
			Level = 44,
			Class = "PRIEST",
		},
		[10952] = {
			Level = 60,
			Class = "PRIEST",
		},
		[592] = {
			Level = 12,
			Class = "PRIEST",
		},
		[10960] = {
			Level = 50,
			Class = "PRIEST",
		},
		[10964] = {
			Level = 52,
			Class = "PRIEST",
		},
		[976] = {
			Level = 30,
			Class = "PRIEST",
		},
		[594] = {
			Level = 10,
			Class = "PRIEST",
		},
		[32999] = {
			Level = 70,
			Class = "PRIEST",
		},
		[48178] = {
			Level = 80,
			Class = "PRIEST",
		},
		[19296] = {
			Level = 18,
			Class = "PRIEST",
		},
		[48158] = {
			Level = 80,
			Class = "PRIEST",
		},
		[48074] = {
			Level = 80,
			Class = "PRIEST",
		},
		[48066] = {
			Level = 80,
			Class = "PRIEST",
		},
		[53022] = {
			Level = 80,
			Class = "PRIEST",
		},
		[596] = {
			Level = 30,
			Class = "PRIEST",
		},
		[2006] = {
			Level = 10,
			Class = "PRIEST",
		},
		[48176] = {
			Level = 80,
			Class = "PRIEST",
		},
		[48175] = {
			Level = 80,
			Class = "PRIEST",
		},
		[19280] = {
			Level = 60,
			Class = "PRIEST",
		},
		[48123] = {
			Level = 79,
			Class = "PRIEST",
		},
		[48173] = {
			Level = 80,
			Class = "PRIEST",
		},
		[48299] = {
			Level = 73,
			Class = "PRIEST",
		},
		[21562] = {
			Level = 48,
			Class = "PRIEST",
		},
		[48171] = {
			Level = 78,
			Class = "PRIEST",
		},
		[48135] = {
			Level = 78,
			Class = "PRIEST",
		},
		[7128] = {
			Level = 20,
			Class = "PRIEST",
		},
		[48120] = {
			Level = 78,
			Class = "PRIEST",
		},
		[48170] = {
			Level = 77,
			Class = "PRIEST",
		},
		[48128] = {
			Level = 77,
			Class = "PRIEST",
		},
		[48168] = {
			Level = 77,
			Class = "PRIEST",
		},
		[600] = {
			Level = 18,
			Class = "PRIEST",
		},
		[48174] = {
			Level = 77,
			Class = "PRIEST",
		},
		[48303] = {
			Level = 75,
			Class = "PRIEST",
		},
		[984] = {
			Level = 22,
			Class = "PRIEST",
		},
		[25235] = {
			Level = 67,
			Class = "PRIEST",
		},
		[48302] = {
			Level = 75,
			Class = "PRIEST",
		},
		[25308] = {
			Level = 68,
			Class = "PRIEST",
		},
		[19308] = {
			Level = 28,
			Class = "PRIEST",
		},
		[602] = {
			Level = 30,
			Class = "PRIEST",
		},
		[8102] = {
			Level = 16,
			Class = "PRIEST",
		},
		[48065] = {
			Level = 75,
			Class = "PRIEST",
		},
		[18137] = {
			Level = 20,
			Class = "PRIEST",
		},
		[48122] = {
			Level = 74,
			Class = "PRIEST",
		},
		[25392] = {
			Level = 70,
			Class = "PRIEST",
		},
		[25315] = {
			Level = 60,
			Class = "PRIEST",
		},
		[6346] = {
			Level = 20,
			Class = "PRIEST",
		},
		[19268] = {
			Level = 40,
			Class = "PRIEST",
		},
		[48126] = {
			Level = 74,
			Class = "PRIEST",
		},
		[25372] = {
			Level = 63,
			Class = "PRIEST",
		},
		[988] = {
			Level = 36,
			Class = "PRIEST",
		},
		[605] = {
			Level = 30,
			Class = "PRIEST",
		},
		[48124] = {
			Level = 75,
			Class = "PRIEST",
		},
		[25379] = {
			Level = 63,
			Class = "PRIEST",
		},
		[15264] = {
			Level = 36,
			Class = "PRIEST",
		},
		[48172] = {
			Level = 73,
			Class = "PRIEST",
		},
		[19271] = {
			Level = 30,
			Class = "PRIEST",
		},
		[19279] = {
			Level = 52,
			Class = "PRIEST",
		},
		[25316] = {
			Level = 60,
			Class = "PRIEST",
		},
		[28380] = {
			Level = 44,
			Class = "PRIEST",
		},
		[19303] = {
			Level = 42,
			Class = "PRIEST",
		},
		[19311] = {
			Level = 52,
			Class = "PRIEST",
		},
		[27874] = {
			Level = 60,
			Class = "PRIEST",
		},
		[48300] = {
			Level = 79,
			Class = "PRIEST",
		},
		[25467] = {
			Level = 68,
			Class = "PRIEST",
		},
		[25441] = {
			Level = 70,
			Class = "PRIEST",
		},
		[992] = {
			Level = 26,
			Class = "PRIEST",
		},
		[19243] = {
			Level = 58,
			Class = "PRIEST",
		},
		[2943] = {
			Level = 10,
			Class = "PRIEST",
		},
		[2944] = {
			Level = 20,
			Class = "PRIEST",
		},
		[48119] = {
			Level = 72,
			Class = "PRIEST",
		},
		[48040] = {
			Level = 71,
			Class = "PRIEST",
		},
		[25210] = {
			Level = 63,
			Class = "PRIEST",
		},
		[19249] = {
			Level = 20,
			Class = "PRIEST",
		},
		[25364] = {
			Level = 69,
			Class = "PRIEST",
		},
		[25368] = {
			Level = 70,
			Class = "PRIEST",
		},
		[19252] = {
			Level = 40,
			Class = "PRIEST",
		},
		[25380] = {
			Level = 70,
			Class = "PRIEST",
		},
		[19305] = {
			Level = 58,
			Class = "PRIEST",
		},
		[48045] = {
			Level = 75,
			Class = "PRIEST",
		},
		[39374] = {
			Level = 70,
			Class = "PRIEST",
		},
		[32548] = {
			Level = 10,
			Class = "PRIEST",
		},
		[996] = {
			Level = 40,
			Class = "PRIEST",
		},
		[588] = {
			Level = 12,
			Class = "PRIEST",
		},
		[48125] = {
			Level = 80,
			Class = "PRIEST",
		},
		[19304] = {
			Level = 50,
			Class = "PRIEST",
		},
		[48157] = {
			Level = 75,
			Class = "PRIEST",
		},
		[10797] = {
			Level = 10,
			Class = "PRIEST",
		},
		[48189] = {
			Level = 80,
			Class = "PRIEST",
		},
		[32996] = {
			Level = 70,
			Class = "PRIEST",
		},
		[25460] = {
			Level = 70,
			Class = "PRIEST",
		},
		[10933] = {
			Level = 46,
			Class = "PRIEST",
		},
		[25213] = {
			Level = 68,
			Class = "PRIEST",
		},
		[25217] = {
			Level = 65,
			Class = "PRIEST",
		},
		[25221] = {
			Level = 65,
			Class = "PRIEST",
		},
		[48301] = {
			Level = 80,
			Class = "PRIEST",
		},
		[25389] = {
			Level = 70,
			Class = "PRIEST",
		},
		[527] = {
			Level = 18,
			Class = "PRIEST",
		},
		[32375] = {
			Level = 70,
			Class = "PRIEST",
		},
		[15267] = {
			Level = 54,
			Class = "PRIEST",
		},
		[28381] = {
			Level = 52,
			Class = "PRIEST",
		},
		[44044] = {
			Level = 40,
			Class = "PRIEST",
		},
		[32676] = {
			Level = 20,
			Class = "PRIEST",
		},
		[2010] = {
			Level = 22,
			Class = "PRIEST",
		},
		[25435] = {
			Level = 68,
			Class = "PRIEST",
		},
		[25440] = {
			Level = 70,
			Class = "PRIEST",
		},
		[10899] = {
			Level = 48,
			Class = "PRIEST",
		},
		[10915] = {
			Level = 44,
			Class = "PRIEST",
		},
		[10881] = {
			Level = 46,
			Class = "PRIEST",
		},
		[28382] = {
			Level = 60,
			Class = "PRIEST",
		},
		[25431] = {
			Level = 69,
			Class = "PRIEST",
		},
		[10893] = {
			Level = 50,
			Class = "PRIEST",
		},
		[48062] = {
			Level = 73,
			Class = "PRIEST",
		},
		[10901] = {
			Level = 60,
			Class = "PRIEST",
		},
		[1004] = {
			Level = 30,
			Class = "PRIEST",
		},
		[10909] = {
			Level = 44,
			Class = "PRIEST",
		},
		[19240] = {
			Level = 34,
			Class = "PRIEST",
		},
		[10917] = {
			Level = 56,
			Class = "PRIEST",
		},
		[7001] = {
			Level = 40,
			Class = "PRIEST",
		},
		[19264] = {
			Level = 40,
			Class = "PRIEST",
		},
		[48190] = {
			Level = 70,
			Class = "PRIEST",
		},
		[1244] = {
			Level = 12,
			Class = "PRIEST",
		},
		[10937] = {
			Level = 48,
			Class = "PRIEST",
		},
		[1245] = {
			Level = 24,
			Class = "PRIEST",
		},
		[10945] = {
			Level = 46,
			Class = "PRIEST",
		},
		[19312] = {
			Level = 60,
			Class = "PRIEST",
		},
		[17] = {
			Level = 6,
			Class = "PRIEST",
		},
		[10957] = {
			Level = 42,
			Class = "PRIEST",
		},
		[10961] = {
			Level = 60,
			Class = "PRIEST",
		},
		[10965] = {
			Level = 58,
			Class = "PRIEST",
		},
		[598] = {
			Level = 14,
			Class = "PRIEST",
		},
		[25363] = {
			Level = 61,
			Class = "PRIEST",
		},
		[1706] = {
			Level = 34,
			Class = "PRIEST",
		},
		[44046] = {
			Level = 60,
			Class = "PRIEST",
		},
		[10929] = {
			Level = 56,
			Class = "PRIEST",
		},
		[6066] = {
			Level = 36,
			Class = "PRIEST",
		},
		[19270] = {
			Level = 60,
			Class = "PRIEST",
		},
		[47951] = {
			Level = 80,
			Class = "PRIEST",
		},
		[6060] = {
			Level = 38,
			Class = "PRIEST",
		},
		[9472] = {
			Level = 26,
			Class = "PRIEST",
		},
		[6078] = {
			Level = 38,
			Class = "PRIEST",
		},
		[1006] = {
			Level = 40,
			Class = "PRIEST",
		},
		[9484] = {
			Level = 20,
			Class = "PRIEST",
		},
		[19253] = {
			Level = 50,
			Class = "PRIEST",
		},
		[48063] = {
			Level = 78,
			Class = "PRIEST",
		},
		[15262] = {
			Level = 24,
			Class = "PRIEST",
		},
		[10934] = {
			Level = 54,
			Class = "PRIEST",
		},


	--<<<ROGUE>>>

		[1776] = {
			Level = 6,
			Class = "ROGUE",
		},
		[1856] = {
			Level = 22,
			Class = "ROGUE",
		},
		[8696] = {
			Level = 34,
			Class = "ROGUE",
		},
		[48638] = {
			Level = 80,
			Class = "ROGUE",
		},
		[48676] = {
			Level = 80,
			Class = "ROGUE",
		},
		[26669] = {
			Level = 50,
			Class = "ROGUE",
		},
		[51723] = {
			Level = 80,
			Class = "ROGUE",
		},
		[1787] = {
			Level = 60,
			Class = "ROGUE",
		},
		[1857] = {
			Level = 42,
			Class = "ROGUE",
		},
		[408] = {
			Level = 30,
			Class = "ROGUE",
		},
		[26679] = {
			Level = 64,
			Class = "ROGUE",
		},
		[57933] = {
			Level = 75,
			Class = "ROGUE",
		},
		[48657] = {
			Level = 80,
			Class = "ROGUE",
		},
		[2589] = {
			Level = 12,
			Class = "ROGUE",
		},
		[51722] = {
			Level = 20,
			Class = "ROGUE",
		},
		[1842] = {
			Level = 30,
			Class = "ROGUE",
		},
		[48656] = {
			Level = 74,
			Class = "ROGUE",
		},
		[2590] = {
			Level = 20,
			Class = "ROGUE",
		},
		[48690] = {
			Level = 75,
			Class = "ROGUE",
		},
		[5277] = {
			Level = 8,
			Class = "ROGUE",
		},
		[25302] = {
			Level = 60,
			Class = "ROGUE",
		},
		[2591] = {
			Level = 28,
			Class = "ROGUE",
		},
		[48672] = {
			Level = 79,
			Class = "ROGUE",
		},
		[48668] = {
			Level = 79,
			Class = "ROGUE",
		},
		[48659] = {
			Level = 78,
			Class = "ROGUE",
		},
		[11290] = {
			Level = 54,
			Class = "ROGUE",
		},
		[57993] = {
			Level = 80,
			Class = "ROGUE",
		},
		[8721] = {
			Level = 36,
			Class = "ROGUE",
		},
		[27096] = {
			Level = 60,
			Class = "ROGUE",
		},
		[48674] = {
			Level = 76,
			Class = "ROGUE",
		},
		[8724] = {
			Level = 26,
			Class = "ROGUE",
		},
		[8725] = {
			Level = 34,
			Class = "ROGUE",
		},
		[1860] = {
			Level = 40,
			Class = "ROGUE",
		},
		[11267] = {
			Level = 42,
			Class = "ROGUE",
		},
		[11268] = {
			Level = 50,
			Class = "ROGUE",
		},
		[11269] = {
			Level = 58,
			Class = "ROGUE",
		},
		[48671] = {
			Level = 74,
			Class = "ROGUE",
		},
		[48675] = {
			Level = 75,
			Class = "ROGUE",
		},
		[26862] = {
			Level = 70,
			Class = "ROGUE",
		},
		[11273] = {
			Level = 44,
			Class = "ROGUE",
		},
		[11274] = {
			Level = 52,
			Class = "ROGUE",
		},
		[11275] = {
			Level = 60,
			Class = "ROGUE",
		},
		[1766] = {
			Level = 12,
			Class = "ROGUE",
		},
		[57934] = {
			Level = 75,
			Class = "ROGUE",
		},
		[48667] = {
			Level = 73,
			Class = "ROGUE",
		},
		[11279] = {
			Level = 44,
			Class = "ROGUE",
		},
		[11280] = {
			Level = 52,
			Class = "ROGUE",
		},
		[11281] = {
			Level = 60,
			Class = "ROGUE",
		},
		[57992] = {
			Level = 74,
			Class = "ROGUE",
		},
		[26884] = {
			Level = 70,
			Class = "ROGUE",
		},
		[48691] = {
			Level = 80,
			Class = "ROGUE",
		},
		[48658] = {
			Level = 72,
			Class = "ROGUE",
		},
		[31016] = {
			Level = 60,
			Class = "ROGUE",
		},
		[5938] = {
			Level = 70,
			Class = "ROGUE",
		},
		[8621] = {
			Level = 38,
			Class = "ROGUE",
		},
		[11289] = {
			Level = 46,
			Class = "ROGUE",
		},
		[8623] = {
			Level = 32,
			Class = "ROGUE",
		},
		[8624] = {
			Level = 40,
			Class = "ROGUE",
		},
		[48673] = {
			Level = 70,
			Class = "ROGUE",
		},
		[11293] = {
			Level = 46,
			Class = "ROGUE",
		},
		[11294] = {
			Level = 54,
			Class = "ROGUE",
		},
		[1943] = {
			Level = 20,
			Class = "ROGUE",
		},
		[48689] = {
			Level = 70,
			Class = "ROGUE",
		},
		[11297] = {
			Level = 48,
			Class = "ROGUE",
		},
		[6760] = {
			Level = 8,
			Class = "ROGUE",
		},
		[2983] = {
			Level = 10,
			Class = "ROGUE",
		},
		[6761] = {
			Level = 16,
			Class = "ROGUE",
		},
		[1785] = {
			Level = 20,
			Class = "ROGUE",
		},
		[6762] = {
			Level = 24,
			Class = "ROGUE",
		},
		[11303] = {
			Level = 52,
			Class = "ROGUE",
		},
		[8637] = {
			Level = 40,
			Class = "ROGUE",
		},
		[11305] = {
			Level = 58,
			Class = "ROGUE",
		},
		[8639] = {
			Level = 28,
			Class = "ROGUE",
		},
		[8640] = {
			Level = 36,
			Class = "ROGUE",
		},
		[32684] = {
			Level = 69,
			Class = "ROGUE",
		},
		[1786] = {
			Level = 40,
			Class = "ROGUE",
		},
		[8643] = {
			Level = 50,
			Class = "ROGUE",
		},
		[27448] = {
			Level = 64,
			Class = "ROGUE",
		},
		[51724] = {
			Level = 71,
			Class = "ROGUE",
		},
		[27095] = {
			Level = 60,
			Class = "ROGUE",
		},
		[6768] = {
			Level = 28,
			Class = "ROGUE",
		},
		[26866] = {
			Level = 66,
			Class = "ROGUE",
		},
		[8649] = {
			Level = 26,
			Class = "ROGUE",
		},
		[8650] = {
			Level = 36,
			Class = "ROGUE",
		},
		[6770] = {
			Level = 10,
			Class = "ROGUE",
		},
		[31224] = {
			Level = 66,
			Class = "ROGUE",
		},
		[921] = {
			Level = 4,
			Class = "ROGUE",
		},
		[27441] = {
			Level = 66,
			Class = "ROGUE",
		},
		[1833] = {
			Level = 26,
			Class = "ROGUE",
		},
		[8647] = {
			Level = 14,
			Class = "ROGUE",
		},
		[11197] = {
			Level = 46,
			Class = "ROGUE",
		},
		[11198] = {
			Level = 56,
			Class = "ROGUE",
		},
		[6774] = {
			Level = 42,
			Class = "ROGUE",
		},
		[27099] = {
			Level = 60,
			Class = "ROGUE",
		},
		[27097] = {
			Level = 60,
			Class = "ROGUE",
		},
		[1725] = {
			Level = 22,
			Class = "ROGUE",
		},
		[2070] = {
			Level = 28,
			Class = "ROGUE",
		},
		[1757] = {
			Level = 6,
			Class = "ROGUE",
		},
		[32645] = {
			Level = 62,
			Class = "ROGUE",
		},
		[26839] = {
			Level = 61,
			Class = "ROGUE",
		},
		[48637] = {
			Level = 76,
			Class = "ROGUE",
		},
		[26861] = {
			Level = 62,
			Class = "ROGUE",
		},
		[26863] = {
			Level = 68,
			Class = "ROGUE",
		},
		[26865] = {
			Level = 64,
			Class = "ROGUE",
		},
		[26867] = {
			Level = 68,
			Class = "ROGUE",
		},
		[1758] = {
			Level = 14,
			Class = "ROGUE",
		},
		[25300] = {
			Level = 60,
			Class = "ROGUE",
		},
		[11300] = {
			Level = 56,
			Class = "ROGUE",
		},
		[48669] = {
			Level = 77,
			Class = "ROGUE",
		},
		[8676] = {
			Level = 18,
			Class = "ROGUE",
		},
		[5171] = {
			Level = 10,
			Class = "ROGUE",
		},
		[703] = {
			Level = 14,
			Class = "ROGUE",
		},
		[2836] = {
			Level = 24,
			Class = "ROGUE",
		},
		[1759] = {
			Level = 22,
			Class = "ROGUE",
		},
		[2094] = {
			Level = 34,
			Class = "ROGUE",
		},
		[26889] = {
			Level = 62,
			Class = "ROGUE",
		},
		[24224] = {
			Level = 60,
			Class = "ROGUE",
		},
		[11299] = {
			Level = 48,
			Class = "ROGUE",
		},
		[1966] = {
			Level = 16,
			Class = "ROGUE",
		},
		[8633] = {
			Level = 38,
			Class = "ROGUE",
		},
		[8631] = {
			Level = 22,
			Class = "ROGUE",
		},
		[1760] = {
			Level = 30,
			Class = "ROGUE",
		},
		[8632] = {
			Level = 30,
			Class = "ROGUE",
		},


	  --<<<SHAMAN>>>

		[10526] = {
			Level = 48,
			Class = "SHAMAN",
		},
		[6041] = {
			Level = 32,
			Class = "SHAMAN",
		},
		[10538] = {
			Level = 58,
			Class = "SHAMAN",
		},
		[8498] = {
			Level = 22,
			Class = "SHAMAN",
		},
		[49277] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[10586] = {
			Level = 46,
			Class = "SHAMAN",
		},
		[45301] = {
			Level = 63,
			Class = "SHAMAN",
		},
		[51992] = {
			Level = 60,
			Class = "SHAMAN",
		},
		[58699] = {
			Level = 71,
			Class = "SHAMAN",
		},
		[10622] = {
			Level = 46,
			Class = "SHAMAN",
		},
		[58731] = {
			Level = 73,
			Class = "SHAMAN",
		},
		[52136] = {
			Level = 48,
			Class = "SHAMAN",
		},
		[26363] = {
			Level = 56,
			Class = "SHAMAN",
		},
		[26371] = {
			Level = 63,
			Class = "SHAMAN",
		},
		[8143] = {
			Level = 18,
			Class = "SHAMAN",
		},
		[8155] = {
			Level = 24,
			Class = "SHAMAN",
		},
		[49230] = {
			Level = 74,
			Class = "SHAMAN",
		},
		[8161] = {
			Level = 38,
			Class = "SHAMAN",
		},
		[49278] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[55458] = {
			Level = 74,
			Class = "SHAMAN",
		},
		[1535] = {
			Level = 12,
			Class = "SHAMAN",
		},
		[45286] = {
			Level = 8,
			Class = "SHAMAN",
		},
		[16339] = {
			Level = 36,
			Class = "SHAMAN",
		},
		[8181] = {
			Level = 24,
			Class = "SHAMAN",
		},
		[51993] = {
			Level = 70,
			Class = "SHAMAN",
		},
		[25525] = {
			Level = 67,
			Class = "SHAMAN",
		},
		[25533] = {
			Level = 69,
			Class = "SHAMAN",
		},
		[25557] = {
			Level = 67,
			Class = "SHAMAN",
		},
		[58796] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[2062] = {
			Level = 66,
			Class = "SHAMAN",
		},
		[8227] = {
			Level = 28,
			Class = "SHAMAN",
		},
		[8235] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[49231] = {
			Level = 79,
			Class = "SHAMAN",
		},
		[49279] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[324] = {
			Level = 8,
			Class = "SHAMAN",
		},
		[45287] = {
			Level = 14,
			Class = "SHAMAN",
		},
		[905] = {
			Level = 24,
			Class = "SHAMAN",
		},
		[51994] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[325] = {
			Level = 16,
			Class = "SHAMAN",
		},
		[43339] = {
			Level = 10,
			Class = "SHAMAN",
		},
		[58749] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[52138] = {
			Level = 55,
			Class = "SHAMAN",
		},
		[26364] = {
			Level = 8,
			Class = "SHAMAN",
		},
		[10391] = {
			Level = 38,
			Class = "SHAMAN",
		},
		[10395] = {
			Level = 48,
			Class = "SHAMAN",
		},
		[10399] = {
			Level = 24,
			Class = "SHAMAN",
		},
		[10407] = {
			Level = 44,
			Class = "SHAMAN",
		},
		[526] = {
			Level = 16,
			Class = "SHAMAN",
		},
		[36936] = {
			Level = 30,
			Class = "SHAMAN",
		},
		[5730] = {
			Level = 8,
			Class = "SHAMAN",
		},
		[25422] = {
			Level = 61,
			Class = "SHAMAN",
		},
		[10431] = {
			Level = 48,
			Class = "SHAMAN",
		},
		[49280] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[25454] = {
			Level = 69,
			Class = "SHAMAN",
		},
		[10447] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[529] = {
			Level = 8,
			Class = "SHAMAN",
		},
		[10463] = {
			Level = 60,
			Class = "SHAMAN",
		},
		[10467] = {
			Level = 52,
			Class = "SHAMAN",
		},
		[913] = {
			Level = 18,
			Class = "SHAMAN",
		},
		[10479] = {
			Level = 54,
			Class = "SHAMAN",
		},
		[10495] = {
			Level = 36,
			Class = "SHAMAN",
		},
		[58734] = {
			Level = 78,
			Class = "SHAMAN",
		},
		[915] = {
			Level = 20,
			Class = "SHAMAN",
		},
		[25590] = {
			Level = 69,
			Class = "SHAMAN",
		},
		[30708] = {
			Level = 50,
			Class = "SHAMAN",
		},
		[8499] = {
			Level = 32,
			Class = "SHAMAN",
		},
		[2645] = {
			Level = 20,
			Class = "SHAMAN",
		},
		[49281] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[20608] = {
			Level = 30,
			Class = "SHAMAN",
		},
		[10587] = {
			Level = 56,
			Class = "SHAMAN",
		},
		[10595] = {
			Level = 30,
			Class = "SHAMAN",
		},
		[58703] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[10623] = {
			Level = 54,
			Class = "SHAMAN",
		},
		[58751] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[26365] = {
			Level = 16,
			Class = "SHAMAN",
		},
		[20776] = {
			Level = 48,
			Class = "SHAMAN",
		},
		[6363] = {
			Level = 20,
			Class = "SHAMAN",
		},
		[6365] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[25423] = {
			Level = 68,
			Class = "SHAMAN",
		},
		[6375] = {
			Level = 30,
			Class = "SHAMAN",
		},
		[6377] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[45290] = {
			Level = 32,
			Class = "SHAMAN",
		},
		[6391] = {
			Level = 28,
			Class = "SHAMAN",
		},
		[546] = {
			Level = 28,
			Class = "SHAMAN",
		},
		[16356] = {
			Level = 58,
			Class = "SHAMAN",
		},
		[930] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[547] = {
			Level = 12,
			Class = "SHAMAN",
		},
		[25567] = {
			Level = 69,
			Class = "SHAMAN",
		},
		[548] = {
			Level = 14,
			Class = "SHAMAN",
		},
		[8232] = {
			Level = 30,
			Class = "SHAMAN",
		},
		[11314] = {
			Level = 42,
			Class = "SHAMAN",
		},
		[49235] = {
			Level = 73,
			Class = "SHAMAN",
		},
		[20609] = {
			Level = 24,
			Class = "SHAMAN",
		},
		[3738] = {
			Level = 64,
			Class = "SHAMAN",
		},
		[45291] = {
			Level = 38,
			Class = "SHAMAN",
		},
		[8004] = {
			Level = 20,
			Class = "SHAMAN",
		},
		[939] = {
			Level = 24,
			Class = "SHAMAN",
		},
		[8008] = {
			Level = 28,
			Class = "SHAMAN",
		},
		[8010] = {
			Level = 36,
			Class = "SHAMAN",
		},
		[26366] = {
			Level = 24,
			Class = "SHAMAN",
		},
		[10392] = {
			Level = 44,
			Class = "SHAMAN",
		},
		[10396] = {
			Level = 56,
			Class = "SHAMAN",
		},
		[8018] = {
			Level = 8,
			Class = "SHAMAN",
		},
		[20777] = {
			Level = 60,
			Class = "SHAMAN",
		},
		[10408] = {
			Level = 54,
			Class = "SHAMAN",
		},
		[8024] = {
			Level = 10,
			Class = "SHAMAN",
		},
		[6495] = {
			Level = 34,
			Class = "SHAMAN",
		},
		[8030] = {
			Level = 26,
			Class = "SHAMAN",
		},
		[10428] = {
			Level = 58,
			Class = "SHAMAN",
		},
		[10432] = {
			Level = 56,
			Class = "SHAMAN",
		},
		[943] = {
			Level = 26,
			Class = "SHAMAN",
		},
		[10448] = {
			Level = 52,
			Class = "SHAMAN",
		},
		[8044] = {
			Level = 8,
			Class = "SHAMAN",
		},
		[10456] = {
			Level = 38,
			Class = "SHAMAN",
		},
		[45292] = {
			Level = 44,
			Class = "SHAMAN",
		},
		[8050] = {
			Level = 10,
			Class = "SHAMAN",
		},
		[10468] = {
			Level = 60,
			Class = "SHAMAN",
		},
		[10472] = {
			Level = 46,
			Class = "SHAMAN",
		},
		[8056] = {
			Level = 20,
			Class = "SHAMAN",
		},
		[8058] = {
			Level = 34,
			Class = "SHAMAN",
		},
		[25552] = {
			Level = 65,
			Class = "SHAMAN",
		},
		[25560] = {
			Level = 67,
			Class = "SHAMAN",
		},
		[52127] = {
			Level = 20,
			Class = "SHAMAN",
		},
		[49237] = {
			Level = 73,
			Class = "SHAMAN",
		},
		[8512] = {
			Level = 32,
			Class = "SHAMAN",
		},
		[49269] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[20610] = {
			Level = 36,
			Class = "SHAMAN",
		},
		[45293] = {
			Level = 50,
			Class = "SHAMAN",
		},
		[21169] = {
			Level = 30,
			Class = "SHAMAN",
		},
		[58643] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[15207] = {
			Level = 50,
			Class = "SHAMAN",
		},
		[58739] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[8134] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[58771] = {
			Level = 71,
			Class = "SHAMAN",
		},
		[26367] = {
			Level = 32,
			Class = "SHAMAN",
		},
		[25361] = {
			Level = 60,
			Class = "SHAMAN",
		},
		[8154] = {
			Level = 14,
			Class = "SHAMAN",
		},
		[49238] = {
			Level = 79,
			Class = "SHAMAN",
		},
		[8160] = {
			Level = 24,
			Class = "SHAMAN",
		},
		[49270] = {
			Level = 74,
			Class = "SHAMAN",
		},
		[8166] = {
			Level = 22,
			Class = "SHAMAN",
		},
		[25457] = {
			Level = 70,
			Class = "SHAMAN",
		},
		[8170] = {
			Level = 38,
			Class = "SHAMAN",
		},
		[25489] = {
			Level = 64,
			Class = "SHAMAN",
		},
		[16341] = {
			Level = 46,
			Class = "SHAMAN",
		},
		[25505] = {
			Level = 68,
			Class = "SHAMAN",
		},
		[8184] = {
			Level = 28,
			Class = "SHAMAN",
		},
		[8190] = {
			Level = 26,
			Class = "SHAMAN",
		},
		[2825] = {
			Level = 70,
			Class = "SHAMAN",
		},
		[52129] = {
			Level = 27,
			Class = "SHAMAN",
		},
		[58804] = {
			Level = 68,
			Class = "SHAMAN",
		},
		[51730] = {
			Level = 30,
			Class = "SHAMAN",
		},
		[11315] = {
			Level = 52,
			Class = "SHAMAN",
		},
		[49239] = {
			Level = 73,
			Class = "SHAMAN",
		},
		[49271] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[5675] = {
			Level = 26,
			Class = "SHAMAN",
		},
		[6196] = {
			Level = 26,
			Class = "SHAMAN",
		},
		[421] = {
			Level = 32,
			Class = "SHAMAN",
		},
		[58741] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[58757] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[58773] = {
			Level = 76,
			Class = "SHAMAN",
		},
		[58789] = {
			Level = 76,
			Class = "SHAMAN",
		},
		[2860] = {
			Level = 48,
			Class = "SHAMAN",
		},
		[10413] = {
			Level = 48,
			Class = "SHAMAN",
		},
		[49240] = {
			Level = 79,
			Class = "SHAMAN",
		},
		[2870] = {
			Level = 22,
			Class = "SHAMAN",
		},
		[49272] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[10437] = {
			Level = 50,
			Class = "SHAMAN",
		},
		[45296] = {
			Level = 67,
			Class = "SHAMAN",
		},
		[10473] = {
			Level = 58,
			Class = "SHAMAN",
		},
		[25546] = {
			Level = 61,
			Class = "SHAMAN",
		},
		[10497] = {
			Level = 56,
			Class = "SHAMAN",
		},
		[25570] = {
			Level = 65,
			Class = "SHAMAN",
		},
		[52131] = {
			Level = 34,
			Class = "SHAMAN",
		},
		[58790] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[2894] = {
			Level = 68,
			Class = "SHAMAN",
		},
		[10537] = {
			Level = 42,
			Class = "SHAMAN",
		},
		[58774] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[57960] = {
			Level = 76,
			Class = "SHAMAN",
		},
		[51514] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[49273] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[30824] = {
			Level = 50,
			Class = "SHAMAN",
		},
		[58745] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[49233] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[10585] = {
			Level = 36,
			Class = "SHAMAN",
		},
		[45297] = {
			Level = 32,
			Class = "SHAMAN",
		},
		[55459] = {
			Level = 80,
			Class = "SHAMAN",
		},
		[58753] = {
			Level = 78,
			Class = "SHAMAN",
		},
		[10601] = {
			Level = 60,
			Class = "SHAMAN",
		},
		[10605] = {
			Level = 56,
			Class = "SHAMAN",
		},
		[15208] = {
			Level = 56,
			Class = "SHAMAN",
		},
		[58582] = {
			Level = 78,
			Class = "SHAMAN",
		},
		[49236] = {
			Level = 78,
			Class = "SHAMAN",
		},
		[8052] = {
			Level = 18,
			Class = "SHAMAN",
		},
		[58756] = {
			Level = 76,
			Class = "SHAMAN",
		},
		[58795] = {
			Level = 76,
			Class = "SHAMAN",
		},
		[57622] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[33736] = {
			Level = 69,
			Class = "SHAMAN",
		},
		[58581] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[26369] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[58704] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[25357] = {
			Level = 60,
			Class = "SHAMAN",
		},
		[51505] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[1064] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[16355] = {
			Level = 48,
			Class = "SHAMAN",
		},
		[6364] = {
			Level = 30,
			Class = "SHAMAN",
		},
		[49232] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[10496] = {
			Level = 46,
			Class = "SHAMAN",
		},
		[58737] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[556] = {
			Level = 30,
			Class = "SHAMAN",
		},
		[58580] = {
			Level = 71,
			Class = "SHAMAN",
		},
		[49268] = {
			Level = 74,
			Class = "SHAMAN",
		},
		[3599] = {
			Level = 10,
			Class = "SHAMAN",
		},
		[58794] = {
			Level = 71,
			Class = "SHAMAN",
		},
		[25469] = {
			Level = 63,
			Class = "SHAMAN",
		},
		[16387] = {
			Level = 58,
			Class = "SHAMAN",
		},
		[26372] = {
			Level = 70,
			Class = "SHAMAN",
		},
		[45298] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[6390] = {
			Level = 18,
			Class = "SHAMAN",
		},
		[6392] = {
			Level = 38,
			Class = "SHAMAN",
		},
		[8249] = {
			Level = 38,
			Class = "SHAMAN",
		},
		[25391] = {
			Level = 63,
			Class = "SHAMAN",
		},
		[131] = {
			Level = 22,
			Class = "SHAMAN",
		},
		[16362] = {
			Level = 60,
			Class = "SHAMAN",
		},
		[25547] = {
			Level = 70,
			Class = "SHAMAN",
		},
		[45294] = {
			Level = 56,
			Class = "SHAMAN",
		},
		[25563] = {
			Level = 68,
			Class = "SHAMAN",
		},
		[45302] = {
			Level = 70,
			Class = "SHAMAN",
		},
		[25396] = {
			Level = 70,
			Class = "SHAMAN",
		},
		[58755] = {
			Level = 71,
			Class = "SHAMAN",
		},
		[370] = {
			Level = 12,
			Class = "SHAMAN",
		},
		[5394] = {
			Level = 20,
			Class = "SHAMAN",
		},
		[58785] = {
			Level = 71,
			Class = "SHAMAN",
		},
		[25509] = {
			Level = 70,
			Class = "SHAMAN",
		},
		[51988] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[25472] = {
			Level = 70,
			Class = "SHAMAN",
		},
		[32182] = {
			Level = 70,
			Class = "SHAMAN",
		},
		[29228] = {
			Level = 60,
			Class = "SHAMAN",
		},
		[25448] = {
			Level = 62,
			Class = "SHAMAN",
		},
		[32176] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[25442] = {
			Level = 70,
			Class = "SHAMAN",
		},
		[25464] = {
			Level = 68,
			Class = "SHAMAN",
		},
		[49275] = {
			Level = 72,
			Class = "SHAMAN",
		},
		[10600] = {
			Level = 44,
			Class = "SHAMAN",
		},
		[57994] = {
			Level = 16,
			Class = "SHAMAN",
		},
		[25574] = {
			Level = 69,
			Class = "SHAMAN",
		},
		[45288] = {
			Level = 20,
			Class = "SHAMAN",
		},
		[25528] = {
			Level = 65,
			Class = "SHAMAN",
		},
		[58803] = {
			Level = 68,
			Class = "SHAMAN",
		},
		[45299] = {
			Level = 48,
			Class = "SHAMAN",
		},
		[8012] = {
			Level = 32,
			Class = "SHAMAN",
		},
		[2484] = {
			Level = 6,
			Class = "SHAMAN",
		},
		[58801] = {
			Level = 68,
			Class = "SHAMAN",
		},
		[58649] = {
			Level = 67,
			Class = "SHAMAN",
		},
		[8019] = {
			Level = 16,
			Class = "SHAMAN",
		},
		[25500] = {
			Level = 66,
			Class = "SHAMAN",
		},
		[945] = {
			Level = 32,
			Class = "SHAMAN",
		},
		[25449] = {
			Level = 67,
			Class = "SHAMAN",
		},
		[10427] = {
			Level = 48,
			Class = "SHAMAN",
		},
		[8005] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[8038] = {
			Level = 28,
			Class = "SHAMAN",
		},
		[52134] = {
			Level = 41,
			Class = "SHAMAN",
		},
		[58656] = {
			Level = 67,
			Class = "SHAMAN",
		},
		[26370] = {
			Level = 48,
			Class = "SHAMAN",
		},
		[25420] = {
			Level = 66,
			Class = "SHAMAN",
		},
		[332] = {
			Level = 6,
			Class = "SHAMAN",
		},
		[2008] = {
			Level = 12,
			Class = "SHAMAN",
		},
		[10406] = {
			Level = 34,
			Class = "SHAMAN",
		},
		[8046] = {
			Level = 24,
			Class = "SHAMAN",
		},
		[10414] = {
			Level = 60,
			Class = "SHAMAN",
		},
		[8027] = {
			Level = 18,
			Class = "SHAMAN",
		},
		[58652] = {
			Level = 67,
			Class = "SHAMAN",
		},
		[24398] = {
			Level = 62,
			Class = "SHAMAN",
		},
		[8033] = {
			Level = 20,
			Class = "SHAMAN",
		},
		[49276] = {
			Level = 77,
			Class = "SHAMAN",
		},
		[10438] = {
			Level = 60,
			Class = "SHAMAN",
		},
		[10442] = {
			Level = 52,
			Class = "SHAMAN",
		},
		[8053] = {
			Level = 28,
			Class = "SHAMAN",
		},
		[16342] = {
			Level = 56,
			Class = "SHAMAN",
		},
		[8045] = {
			Level = 14,
			Class = "SHAMAN",
		},
		[45289] = {
			Level = 26,
			Class = "SHAMAN",
		},
		[10462] = {
			Level = 50,
			Class = "SHAMAN",
		},
		[10466] = {
			Level = 44,
			Class = "SHAMAN",
		},
		[25508] = {
			Level = 63,
			Class = "SHAMAN",
		},
		[51991] = {
			Level = 50,
			Class = "SHAMAN",
		},
		[10478] = {
			Level = 38,
			Class = "SHAMAN",
		},
		[32175] = {
			Level = 40,
			Class = "SHAMAN",
		},
		[10486] = {
			Level = 50,
			Class = "SHAMAN",
		},
		[25439] = {
			Level = 63,
			Class = "SHAMAN",
		},
		[45300] = {
			Level = 56,
			Class = "SHAMAN",
		},
		[45295] = {
			Level = 62,
			Class = "SHAMAN",
		},
		[58746] = {
			Level = 75,
			Class = "SHAMAN",
		},
		[8071] = {
			Level = 4,
			Class = "SHAMAN",
		},
		[8177] = {
			Level = 30,
			Class = "SHAMAN",
		},
		[8075] = {
			Level = 10,
			Class = "SHAMAN",
		},
		[959] = {
			Level = 32,
			Class = "SHAMAN",
		},
		[10412] = {
			Level = 36,
			Class = "SHAMAN",
		},

	--<<<WARLOCK>>>

			[47811] = {
			Level = 80,
			Class = "WARLOCK",
		},
		[47819] = {
			Level = 72,
			Class = "WARLOCK",
		},
		[42225] = {
			Level = 46,
			Class = "WARLOCK",
		},
		[29858] = {
			Level = 66,
			Class = "WARLOCK",
		},
		[5138] = {
			Level = 24,
			Class = "WARLOCK",
		},
		[47891] = {
			Level = 78,
			Class = "WARLOCK",
		},
		[18662] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[29886] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[712] = {
			Level = 20,
			Class = "WARLOCK",
		},
		[17921] = {
			Level = 42,
			Class = "WARLOCK",
		},
		[17925] = {
			Level = 50,
			Class = "WARLOCK",
		},
		[47206] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[17953] = {
			Level = 56,
			Class = "WARLOCK",
		},
		[1106] = {
			Level = 28,
			Class = "WARLOCK",
		},
		[17924] = {
			Level = 56,
			Class = "WARLOCK",
		},
		[47812] = {
			Level = 71,
			Class = "WARLOCK",
		},
		[47820] = {
			Level = 79,
			Class = "WARLOCK",
		},
		[42218] = {
			Level = 69,
			Class = "WARLOCK",
		},
		[1490] = {
			Level = 32,
			Class = "WARLOCK",
		},
		[47836] = {
			Level = 80,
			Class = "WARLOCK",
		},
		[1108] = {
			Level = 12,
			Class = "WARLOCK",
		},
		[47860] = {
			Level = 78,
			Class = "WARLOCK",
		},
		[47834] = {
			Level = 80,
			Class = "WARLOCK",
		},
		[58887] = {
			Level = 80,
			Class = "WARLOCK",
		},
		[47884] = {
			Level = 76,
			Class = "WARLOCK",
		},
		[47892] = {
			Level = 74,
			Class = "WARLOCK",
		},
		[57946] = {
			Level = 80,
			Class = "WARLOCK",
		},
		[47838] = {
			Level = 80,
			Class = "WARLOCK",
		},
		[27209] = {
			Level = 69,
			Class = "WARLOCK",
		},
		[58889] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[27217] = {
			Level = 67,
			Class = "WARLOCK",
		},
		[27221] = {
			Level = 63,
			Class = "WARLOCK",
		},
		[8289] = {
			Level = 38,
			Class = "WARLOCK",
		},
		[6201] = {
			Level = 10,
			Class = "WARLOCK",
		},
		[6202] = {
			Level = 22,
			Class = "WARLOCK",
		},
		[48020] = {
			Level = 80,
			Class = "WARLOCK",
		},
		[48018] = {
			Level = 80,
			Class = "WARLOCK",
		},
		[6205] = {
			Level = 22,
			Class = "WARLOCK",
		},
		[17926] = {
			Level = 58,
			Class = "WARLOCK",
		},
		[5697] = {
			Level = 16,
			Class = "WARLOCK",
		},
		[47867] = {
			Level = 80,
			Class = "WARLOCK",
		},
		[5699] = {
			Level = 34,
			Class = "WARLOCK",
		},
		[1010] = {
			Level = 38,
			Class = "WARLOCK",
		},
		[47815] = {
			Level = 79,
			Class = "WARLOCK",
		},
		[18093] = {
			Level = 35,
			Class = "WARLOCK",
		},
		[6213] = {
			Level = 32,
			Class = "WARLOCK",
		},
		[47818] = {
			Level = 79,
			Class = "WARLOCK",
		},
		[6215] = {
			Level = 56,
			Class = "WARLOCK",
		},
		[47822] = {
			Level = 78,
			Class = "WARLOCK",
		},
		[6217] = {
			Level = 28,
			Class = "WARLOCK",
		},
		[47837] = {
			Level = 74,
			Class = "WARLOCK",
		},
		[6219] = {
			Level = 34,
			Class = "WARLOCK",
		},
		[47858] = {
			Level = 79,
			Class = "WARLOCK",
		},
		[47864] = {
			Level = 79,
			Class = "WARLOCK",
		},
		[6222] = {
			Level = 14,
			Class = "WARLOCK",
		},
		[18647] = {
			Level = 48,
			Class = "WARLOCK",
		},
		[47897] = {
			Level = 75,
			Class = "WARLOCK",
		},
		[47893] = {
			Level = 79,
			Class = "WARLOCK",
		},
		[6226] = {
			Level = 34,
			Class = "WARLOCK",
		},
		[11704] = {
			Level = 54,
			Class = "WARLOCK",
		},
		[11660] = {
			Level = 52,
			Class = "WARLOCK",
		},
		[6229] = {
			Level = 32,
			Class = "WARLOCK",
		},
		[755] = {
			Level = 12,
			Class = "WARLOCK",
		},
		[25309] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[11668] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[17922] = {
			Level = 50,
			Class = "WARLOCK",
		},
		[11672] = {
			Level = 54,
			Class = "WARLOCK",
		},
		[27211] = {
			Level = 64,
			Class = "WARLOCK",
		},
		[1120] = {
			Level = 10,
			Class = "WARLOCK",
		},
		[1949] = {
			Level = 30,
			Class = "WARLOCK",
		},
		[47855] = {
			Level = 77,
			Class = "WARLOCK",
		},
		[11682] = {
			Level = 54,
			Class = "WARLOCK",
		},
		[20755] = {
			Level = 40,
			Class = "WARLOCK",
		},
		[47813] = {
			Level = 77,
			Class = "WARLOCK",
		},
		[11688] = {
			Level = 46,
			Class = "WARLOCK",
		},
		[47856] = {
			Level = 76,
			Class = "WARLOCK",
		},
		[1122] = {
			Level = 50,
			Class = "WARLOCK",
		},
		[11694] = {
			Level = 52,
			Class = "WARLOCK",
		},
		[126] = {
			Level = 22,
			Class = "WARLOCK",
		},
		[47814] = {
			Level = 74,
			Class = "WARLOCK",
		},
		[11700] = {
			Level = 54,
			Class = "WARLOCK",
		},
		[5484] = {
			Level = 40,
			Class = "WARLOCK",
		},
		[5740] = {
			Level = 20,
			Class = "WARLOCK",
		},
		[47793] = {
			Level = 76,
			Class = "WARLOCK",
		},
		[11708] = {
			Level = 52,
			Class = "WARLOCK",
		},
		[47824] = {
			Level = 75,
			Class = "WARLOCK",
		},
		[11712] = {
			Level = 48,
			Class = "WARLOCK",
		},
		[47878] = {
			Level = 79,
			Class = "WARLOCK",
		},
		[47886] = {
			Level = 72,
			Class = "WARLOCK",
		},
		[47835] = {
			Level = 75,
			Class = "WARLOCK",
		},
		[47833] = {
			Level = 75,
			Class = "WARLOCK",
		},
		[11722] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[18540] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[11726] = {
			Level = 58,
			Class = "WARLOCK",
		},
		[27218] = {
			Level = 67,
			Class = "WARLOCK",
		},
		[11730] = {
			Level = 58,
			Class = "WARLOCK",
		},
		[27226] = {
			Level = 69,
			Class = "WARLOCK",
		},
		[5500] = {
			Level = 24,
			Class = "WARLOCK",
		},
		[47810] = {
			Level = 75,
			Class = "WARLOCK",
		},
		[27238] = {
			Level = 70,
			Class = "WARLOCK",
		},
		[693] = {
			Level = 18,
			Class = "WARLOCK",
		},
		[980] = {
			Level = 8,
			Class = "WARLOCK",
		},
		[27250] = {
			Level = 66,
			Class = "WARLOCK",
		},
		[27223] = {
			Level = 68,
			Class = "WARLOCK",
		},
		[47859] = {
			Level = 73,
			Class = "WARLOCK",
		},
		[32231] = {
			Level = 70,
			Class = "WARLOCK",
		},
		[47871] = {
			Level = 73,
			Class = "WARLOCK",
		},
		[47890] = {
			Level = 72,
			Class = "WARLOCK",
		},
		[691] = {
			Level = 30,
			Class = "WARLOCK",
		},
		[50511] = {
			Level = 71,
			Class = "WARLOCK",
		},
		[30545] = {
			Level = 70,
			Class = "WARLOCK",
		},
		[6789] = {
			Level = 42,
			Class = "WARLOCK",
		},
		[47823] = {
			Level = 68,
			Class = "WARLOCK",
		},
		[27285] = {
			Level = 70,
			Class = "WARLOCK",
		},
		[20757] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[30459] = {
			Level = 70,
			Class = "WARLOCK",
		},
		[695] = {
			Level = 6,
			Class = "WARLOCK",
		},
		[47863] = {
			Level = 73,
			Class = "WARLOCK",
		},
		[1014] = {
			Level = 18,
			Class = "WARLOCK",
		},
		[30908] = {
			Level = 70,
			Class = "WARLOCK",
		},
		[11675] = {
			Level = 52,
			Class = "WARLOCK",
		},
		[30910] = {
			Level = 70,
			Class = "WARLOCK",
		},
		[27212] = {
			Level = 69,
			Class = "WARLOCK",
		},
		[11677] = {
			Level = 46,
			Class = "WARLOCK",
		},
		[696] = {
			Level = 10,
			Class = "WARLOCK",
		},
		[28189] = {
			Level = 69,
			Class = "WARLOCK",
		},
		[27220] = {
			Level = 69,
			Class = "WARLOCK",
		},
		[27228] = {
			Level = 69,
			Class = "WARLOCK",
		},
		[17919] = {
			Level = 26,
			Class = "WARLOCK",
		},
		[1454] = {
			Level = 6,
			Class = "WARLOCK",
		},
		[30909] = {
			Level = 69,
			Class = "WARLOCK",
		},
		[11659] = {
			Level = 44,
			Class = "WARLOCK",
		},
		[697] = {
			Level = 10,
			Class = "WARLOCK",
		},
		[1455] = {
			Level = 16,
			Class = "WARLOCK",
		},
		[3698] = {
			Level = 20,
			Class = "WARLOCK",
		},
		[20752] = {
			Level = 30,
			Class = "WARLOCK",
		},
		[17951] = {
			Level = 36,
			Class = "WARLOCK",
		},
		[1456] = {
			Level = 26,
			Class = "WARLOCK",
		},
		[27222] = {
			Level = 68,
			Class = "WARLOCK",
		},
		[27214] = {
			Level = 68,
			Class = "WARLOCK",
		},
		[698] = {
			Level = 20,
			Class = "WARLOCK",
		},
		[27213] = {
			Level = 68,
			Class = "WARLOCK",
		},
		[47808] = {
			Level = 74,
			Class = "WARLOCK",
		},
		[27230] = {
			Level = 68,
			Class = "WARLOCK",
		},
		[17728] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[603] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[11678] = {
			Level = 58,
			Class = "WARLOCK",
		},
		[28172] = {
			Level = 66,
			Class = "WARLOCK",
		},
		[699] = {
			Level = 22,
			Class = "WARLOCK",
		},
		[1714] = {
			Level = 26,
			Class = "WARLOCK",
		},
		[27210] = {
			Level = 65,
			Class = "WARLOCK",
		},
		[20756] = {
			Level = 50,
			Class = "WARLOCK",
		},
		[47888] = {
			Level = 78,
			Class = "WARLOCK",
		},
		[2941] = {
			Level = 30,
			Class = "WARLOCK",
		},
		[11740] = {
			Level = 52,
			Class = "WARLOCK",
		},
		[28610] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[18541] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[27215] = {
			Level = 69,
			Class = "WARLOCK",
		},
		[27219] = {
			Level = 62,
			Class = "WARLOCK",
		},
		[8288] = {
			Level = 24,
			Class = "WARLOCK",
		},
		[25307] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[11661] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[11695] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[5857] = {
			Level = 30,
			Class = "WARLOCK",
		},
		[27243] = {
			Level = 70,
			Class = "WARLOCK",
		},
		[25311] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[17923] = {
			Level = 58,
			Class = "WARLOCK",
		},
		[42226] = {
			Level = 58,
			Class = "WARLOCK",
		},
		[27259] = {
			Level = 67,
			Class = "WARLOCK",
		},
		[7641] = {
			Level = 36,
			Class = "WARLOCK",
		},
		[6366] = {
			Level = 28,
			Class = "WARLOCK",
		},
		[11717] = {
			Level = 56,
			Class = "WARLOCK",
		},
		[702] = {
			Level = 4,
			Class = "WARLOCK",
		},
		[706] = {
			Level = 20,
			Class = "WARLOCK",
		},
		[47809] = {
			Level = 79,
			Class = "WARLOCK",
		},
		[47817] = {
			Level = 72,
			Class = "WARLOCK",
		},
		[47825] = {
			Level = 80,
			Class = "WARLOCK",
		},
		[42223] = {
			Level = 20,
			Class = "WARLOCK",
		},
		[6223] = {
			Level = 24,
			Class = "WARLOCK",
		},
		[3699] = {
			Level = 28,
			Class = "WARLOCK",
		},
		[47857] = {
			Level = 78,
			Class = "WARLOCK",
		},
		[47865] = {
			Level = 78,
			Class = "WARLOCK",
		},
		[11703] = {
			Level = 44,
			Class = "WARLOCK",
		},
		[5782] = {
			Level = 8,
			Class = "WARLOCK",
		},
		[47889] = {
			Level = 80,
			Class = "WARLOCK",
		},
		[6353] = {
			Level = 48,
			Class = "WARLOCK",
		},
		[57595] = {
			Level = 69,
			Class = "WARLOCK",
		},
		[1086] = {
			Level = 30,
			Class = "WARLOCK",
		},
		[704] = {
			Level = 14,
			Class = "WARLOCK",
		},
		[29893] = {
			Level = 68,
			Class = "WARLOCK",
		},
		[11665] = {
			Level = 40,
			Class = "WARLOCK",
		},
		[11667] = {
			Level = 50,
			Class = "WARLOCK",
		},
		[17920] = {
			Level = 34,
			Class = "WARLOCK",
		},
		[11671] = {
			Level = 44,
			Class = "WARLOCK",
		},
		[17928] = {
			Level = 54,
			Class = "WARLOCK",
		},
		[1088] = {
			Level = 20,
			Class = "WARLOCK",
		},
		[705] = {
			Level = 12,
			Class = "WARLOCK",
		},
		[3700] = {
			Level = 36,
			Class = "WARLOCK",
		},
		[11681] = {
			Level = 42,
			Class = "WARLOCK",
		},
		[11683] = {
			Level = 42,
			Class = "WARLOCK",
		},
		[17952] = {
			Level = 46,
			Class = "WARLOCK",
		},
		[11687] = {
			Level = 36,
			Class = "WARLOCK",
		},
		[11689] = {
			Level = 56,
			Class = "WARLOCK",
		},
		[7646] = {
			Level = 32,
			Class = "WARLOCK",
		},
		[11693] = {
			Level = 44,
			Class = "WARLOCK",
		},
		[7648] = {
			Level = 34,
			Class = "WARLOCK",
		},
		[28176] = {
			Level = 62,
			Class = "WARLOCK",
		},
		[11699] = {
			Level = 46,
			Class = "WARLOCK",
		},
		[7651] = {
			Level = 38,
			Class = "WARLOCK",
		},
		[42224] = {
			Level = 34,
			Class = "WARLOCK",
		},
		[29722] = {
			Level = 64,
			Class = "WARLOCK",
		},
		[11707] = {
			Level = 42,
			Class = "WARLOCK",
		},
		[707] = {
			Level = 10,
			Class = "WARLOCK",
		},
		[11711] = {
			Level = 38,
			Class = "WARLOCK",
		},
		[11713] = {
			Level = 58,
			Class = "WARLOCK",
		},
		[7658] = {
			Level = 28,
			Class = "WARLOCK",
		},
		[7659] = {
			Level = 42,
			Class = "WARLOCK",
		},
		[11719] = {
			Level = 50,
			Class = "WARLOCK",
		},
		[11721] = {
			Level = 46,
			Class = "WARLOCK",
		},
		[1094] = {
			Level = 20,
			Class = "WARLOCK",
		},
		[11725] = {
			Level = 44,
			Class = "WARLOCK",
		},
		[27216] = {
			Level = 65,
			Class = "WARLOCK",
		},
		[11729] = {
			Level = 46,
			Class = "WARLOCK",
		},
		[27224] = {
			Level = 61,
			Class = "WARLOCK",
		},
		[11733] = {
			Level = 40,
			Class = "WARLOCK",
		},
		[11735] = {
			Level = 60,
			Class = "WARLOCK",
		},
		[2362] = {
			Level = 36,
			Class = "WARLOCK",
		},
		[11739] = {
			Level = 42,
			Class = "WARLOCK",
		},
		[709] = {
			Level = 30,
			Class = "WARLOCK",
		},
		[17727] = {
			Level = 48,
			Class = "WARLOCK",
		},
		[5676] = {
			Level = 18,
			Class = "WARLOCK",
		},
		[689] = {
			Level = 14,
			Class = "WARLOCK",
		},
		[27260] = {
			Level = 70,
			Class = "WARLOCK",
		},
		[132] = {
			Level = 26,
			Class = "WARLOCK",
		},
		[11684] = {
			Level = 54,
			Class = "WARLOCK",
		},
		[1098] = {
			Level = 30,
			Class = "WARLOCK",
		},
		[710] = {
			Level = 28,
			Class = "WARLOCK",
		},
		[11734] = {
			Level = 50,
			Class = "WARLOCK",
		},


	--<<<WARRIOR>>> 

		[20658] = {
			Level = 32,
			Class = "WARRIOR",
		},
		[20662] = {
			Level = 56,
			Class = "WARRIOR",
		},
		[30356] = {
			Level = 70,
			Class = "WARRIOR",
		},
		[25264] = {
			Level = 67,
			Class = "WARRIOR",
		},
		[8205] = {
			Level = 38,
			Class = "WARRIOR",
		},
		[871] = {
			Level = 28,
			Class = "WARRIOR",
		},
		[47437] = {
			Level = 79,
			Class = "WARRIOR",
		},
		[11550] = {
			Level = 42,
			Class = "WARRIOR",
		},
		[11554] = {
			Level = 34,
			Class = "WARRIOR",
		},
		[47501] = {
			Level = 73,
			Class = "WARRIOR",
		},
		[6178] = {
			Level = 26,
			Class = "WARRIOR",
		},
		[11564] = {
			Level = 32,
			Class = "WARRIOR",
		},
		[1680] = {
			Level = 36,
			Class = "WARRIOR",
		},
		[29707] = {
			Level = 66,
			Class = "WARRIOR",
		},
		[11572] = {
			Level = 40,
			Class = "WARRIOR",
		},
		[11574] = {
			Level = 60,
			Class = "WARRIOR",
		},
		[18499] = {
			Level = 32,
			Class = "WARRIOR",
		},
		[11578] = {
			Level = 46,
			Class = "WARRIOR",
		},
		[11580] = {
			Level = 48,
			Class = "WARRIOR",
		},
		[6190] = {
			Level = 24,
			Class = "WARRIOR",
		},
		[6192] = {
			Level = 22,
			Class = "WARRIOR",
		},
		[11596] = {
			Level = 46,
			Class = "WARRIOR",
		},
		[11600] = {
			Level = 44,
			Class = "WARRIOR",
		},
		[11604] = {
			Level = 46,
			Class = "WARRIOR",
		},
		[11608] = {
			Level = 40,
			Class = "WARRIOR",
		},
		[23922] = {
			Level = 40,
			Class = "WARRIOR",
		},
		[47470] = {
			Level = 73,
			Class = "WARRIOR",
		},
		[47502] = {
			Level = 78,
			Class = "WARRIOR",
		},
		[845] = {
			Level = 20,
			Class = "WARRIOR",
		},
		[25225] = {
			Level = 67,
			Class = "WARRIOR",
		},
		[55694] = {
			Level = 75,
			Class = "WARRIOR",
		},
		[25241] = {
			Level = 61,
			Class = "WARRIOR",
		},
		[30357] = {
			Level = 70,
			Class = "WARRIOR",
		},
		[25269] = {
			Level = 63,
			Class = "WARRIOR",
		},
		[25289] = {
			Level = 60,
			Class = "WARRIOR",
		},
		[12678] = {
			Level = 20,
			Class = "WARRIOR",
		},
		[47439] = {
			Level = 74,
			Class = "WARRIOR",
		},
		[47471] = {
			Level = 80,
			Class = "WARRIOR",
		},
		[47487] = {
			Level = 75,
			Class = "WARRIOR",
		},
		[47519] = {
			Level = 72,
			Class = "WARRIOR",
		},
		[57823] = {
			Level = 80,
			Class = "WARRIOR",
		},
		[5242] = {
			Level = 12,
			Class = "WARRIOR",
		},
		[47440] = {
			Level = 80,
			Class = "WARRIOR",
		},
		[5246] = {
			Level = 22,
			Class = "WARRIOR",
		},
		[23923] = {
			Level = 48,
			Class = "WARRIOR",
		},
		[25202] = {
			Level = 62,
			Class = "WARRIOR",
		},
		[47488] = {
			Level = 80,
			Class = "WARRIOR",
		},
		[47520] = {
			Level = 77,
			Class = "WARRIOR",
		},
		[694] = {
			Level = 16,
			Class = "WARRIOR",
		},
		[25242] = {
			Level = 69,
			Class = "WARRIOR",
		},
		[20660] = {
			Level = 40,
			Class = "WARRIOR",
		},
		[8198] = {
			Level = 18,
			Class = "WARRIOR",
		},
		[8204] = {
			Level = 28,
			Class = "WARRIOR",
		},
		[12798] = {
			Level = 10,
			Class = "WARRIOR",
		},
		[25286] = {
			Level = 60,
			Class = "WARRIOR",
		},
		[6546] = {
			Level = 10,
			Class = "WARRIOR",
		},
		[6547] = {
			Level = 20,
			Class = "WARRIOR",
		},
		[6548] = {
			Level = 30,
			Class = "WARRIOR",
		},
		[34428] = {
			Level = 62,
			Class = "WARRIOR",
		},
		[71] = {
			Level = 10,
			Class = "WARRIOR",
		},
		[47449] = {
			Level = 72,
			Class = "WARRIOR",
		},
		[47465] = {
			Level = 76,
			Class = "WARRIOR",
		},
		[11549] = {
			Level = 32,
			Class = "WARRIOR",
		},
		[11551] = {
			Level = 52,
			Class = "WARRIOR",
		},
		[11555] = {
			Level = 44,
			Class = "WARRIOR",
		},
		[11565] = {
			Level = 40,
			Class = "WARRIOR",
		},
		[11567] = {
			Level = 56,
			Class = "WARRIOR",
		},
		[11573] = {
			Level = 50,
			Class = "WARRIOR",
		},
		[11581] = {
			Level = 58,
			Class = "WARRIOR",
		},
		[6572] = {
			Level = 14,
			Class = "WARRIOR",
		},
		[6574] = {
			Level = 24,
			Class = "WARRIOR",
		},
		[23880] = {
			Level = 40,
			Class = "WARRIOR",
		},
		[1715] = {
			Level = 8,
			Class = "WARRIOR",
		},
		[11597] = {
			Level = 58,
			Class = "WARRIOR",
		},
		[11601] = {
			Level = 54,
			Class = "WARRIOR",
		},
		[11605] = {
			Level = 54,
			Class = "WARRIOR",
		},
		[47450] = {
			Level = 76,
			Class = "WARRIOR",
		},
		[11609] = {
			Level = 50,
			Class = "WARRIOR",
		},
		[23924] = {
			Level = 54,
			Class = "WARRIOR",
		},
		[47474] = {
			Level = 74,
			Class = "WARRIOR",
		},
		[1464] = {
			Level = 30,
			Class = "WARRIOR",
		},
		[8820] = {
			Level = 38,
			Class = "WARRIOR",
		},
		[25231] = {
			Level = 68,
			Class = "WARRIOR",
		},
		[6343] = {
			Level = 6,
			Class = "WARRIOR",
		},
		[20661] = {
			Level = 48,
			Class = "WARRIOR",
		},
		[46845] = {
			Level = 71,
			Class = "WARRIOR",
		},
		[7376] = {
			Level = 10,
			Class = "WARRIOR",
		},
		[7379] = {
			Level = 34,
			Class = "WARRIOR",
		},
		[72] = {
			Level = 12,
			Class = "WARRIOR",
		},
		[7381] = {
			Level = 30,
			Class = "WARRIOR",
		},
		[47467] = {
			Level = 77,
			Class = "WARRIOR",
		},
		[7384] = {
			Level = 12,
			Class = "WARRIOR",
		},
		[7386] = {
			Level = 10,
			Class = "WARRIOR",
		},
		[7369] = {
			Level = 30,
			Class = "WARRIOR",
		},
		[2458] = {
			Level = 30,
			Class = "WARRIOR",
		},
		[25258] = {
			Level = 66,
			Class = "WARRIOR",
		},
		[47475] = {
			Level = 79,
			Class = "WARRIOR",
		},
		[20569] = {
			Level = 60,
			Class = "WARRIOR",
		},
		[8380] = {
			Level = 34,
			Class = "WARRIOR",
		},
		[57755] = {
			Level = 80,
			Class = "WARRIOR",
		},
		[285] = {
			Level = 16,
			Class = "WARRIOR",
		},
		[2048] = {
			Level = 69,
			Class = "WARRIOR",
		},
		[1160] = {
			Level = 14,
			Class = "WARRIOR",
		},
		[7405] = {
			Level = 22,
			Class = "WARRIOR",
		},
		[2687] = {
			Level = 10,
			Class = "WARRIOR",
		},
		[20230] = {
			Level = 20,
			Class = "WARRIOR",
		},
		[11566] = {
			Level = 48,
			Class = "WARRIOR",
		},
		[6552] = {
			Level = 38,
			Class = "WARRIOR",
		},
		[23920] = {
			Level = 64,
			Class = "WARRIOR",
		},
		[25203] = {
			Level = 70,
			Class = "WARRIOR",
		},
		[23885] = {
			Level = 40,
			Class = "WARRIOR",
		},
		[20252] = {
			Level = 30,
			Class = "WARRIOR",
		},
		[676] = {
			Level = 18,
			Class = "WARRIOR",
		},
		[1719] = {
			Level = 50,
			Class = "WARRIOR",
		},
		[2565] = {
			Level = 16,
			Class = "WARRIOR",
		},
		[772] = {
			Level = 4,
			Class = "WARRIOR",
		},
		[47436] = {
			Level = 78,
			Class = "WARRIOR",
		},
		[3411] = {
			Level = 70,
			Class = "WARRIOR",
		},
		[469] = {
			Level = 68,
			Class = "WARRIOR",
		},
		[25234] = {
			Level = 65,
			Class = "WARRIOR",
		},
		[23925] = {
			Level = 60,
			Class = "WARRIOR",
		},
		[355] = {
			Level = 10,
			Class = "WARRIOR",
		},
		[25208] = {
			Level = 68,
			Class = "WARRIOR",
		},
		[25288] = {
			Level = 60,
			Class = "WARRIOR",
		},
		[11556] = {
			Level = 54,
			Class = "WARRIOR",
		},
		[1161] = {
			Level = 26,
			Class = "WARRIOR",
		},
		[30324] = {
			Level = 70,
			Class = "WARRIOR",
		},
		[5308] = {
			Level = 24,
			Class = "WARRIOR",
		},
		[1608] = {
			Level = 24,
			Class = "WARRIOR",
		},
		[25236] = {
			Level = 70,
			Class = "WARRIOR",
		},
		[284] = {
			Level = 8,
			Class = "WARRIOR",
		},
	};

-- end SpellList

--[[
function lib:ParseHTML()
  
  local sfStart, sfEnd, sfHtml = string.find(thottbotHTMLString, "<tr class(.-)\<table class=thin width=\'100%%\'>");
  local spStart, spEnd, spID, spLevel;
  local parseCount = 0;
  Paranoia_html = {}
  while sfHtml ~= nil do
    sfStart, sfEnd, sfHtml = string.find(thottbotHTMLString, "<tr class(.-)<table class=thin width='100%%'>", sfEnd+1);
    if sfHtml then
      spStart, spEnd, spID, spLevel = string.find(sfHtml, "none'>(.-)</td><td align='center'>(.-)</td><td align=")
      Paranoia:Msg("SpellID: "..tonumber(spID).." | Level: "..tonumber(spLevel));
      Paranoia_html[tonumber(spID)] = {Class = "DEATHKNIGHT", Level = tonumber(spLevel)};
      parseCount = parseCount + 1;
    end
  end  
  Paranoia:Msg("Done parsing "..parseCount.." spells!");
end
]]