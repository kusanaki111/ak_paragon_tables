--
-- Paragon
-- Created by: Valcy, rates by Haruka Kasugano
-- Type: Standard
-- Script created by Haruka Kasugano
--

-- Create PARAGON_ENTRY type
CREATE TYPE PARAGON_ENTRY AS (
	weekday INTEGER,
	item_id INTEGER,
	max_stack INTEGER,
	drop_rate DOUBLE PRECISION,
	notify INTEGER,
	get_only INTEGER,
	shining_hint INTEGER,
	jack_pot INTEGER
);

DO $$
DECLARE

	-- Set the lottery id to switch between different paragon tables
	paragon_id INTEGER := 0;

	-- Counter for ordering
	i INTEGER := 0;

	-- Array of paragon entries
	paragon_data PARAGON_ENTRY[] := ARRAY[
		-- First Row
		(0, 40067,  3,  5, 0, 0, 0, 0), -- 15th-Order Weapon Fortification
		(0, 41096, 10, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 46032, 50, 15, 0, 0, 0, 0), -- Mana Starstone
		(0, 32157, 10, 25, 0, 0, 0, 0), -- Academic Eidolon Card Pack
		(0, 53593,  1, 20, 0, 0, 0, 0), -- Weapon: Lucky Kitty Ear Flower Board
		(0, 62409,  3, 15, 0, 0, 0, 0), -- Summer Guardian Angel Lucky Pack (Eidolon)

		-- Second Row
		(0, 41061,  2,  5, 0, 0, 0, 0), -- Summer Michaela's Key Fragment
		(0, 40987,  2,  5, 0, 0, 0, 0), -- Premium XP Card
		(0, 40782,  2,  5, 0, 0, 0, 0), -- Eidolon Oath Ring
		(0, 20726, 10, 10, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 20511, 10, 10, 0, 0, 0, 0), -- Heart of the Deep
		(0, 45017, 15, 65, 0, 0, 0, 0), -- Advanced Weapon Fortification Scroll 2

		-- Third Row
		(0, 40197,  2,  5, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 41032, 10, 30, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 40853, 10, 15, 0, 0, 0, 0), -- Basic Card Breakthrough Device
		(0, 32094, 10, 20, 0, 0, 0, 0), -- Festival Eidolon Card Pack
		(0, 53552,  1, 20, 0, 0, 0, 0), -- Custom Body: Hooded Fox Robe (M)
		(0, 62839,  3, 10, 0, 0, 0, 0), -- Crescent Maiden Lucky Pack (Eidolon)

		-- Fourth Row
		(0, 41565,  2,  5, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 41470,  1,  5, 0, 0, 0, 0), -- Anima Crystal: Inaba in Arms
		(0, 40201,  2,  5, 0, 0, 0, 0), -- Brilliant Evolutionary Beads
		(0, 20727,  4,  5, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 40194, 20, 70, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 45018, 15, 10, 0, 0, 0, 0), -- Advanced Weapon Fortification Scroll 3

		-- Fifth Row
		(0, 40645,  1,  5, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 41034, 10, 25, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 40855, 10, 20, 0, 0, 0, 0), -- Intermediate Card Breakthrough Device
		(0, 21664,  3, 25, 0, 0, 0, 0), -- Lv.80 Eidolon Accessory Collection Chest
		(0, 53579,  1, 15, 0, 0, 0, 0), -- Back: Holy Light Bamboo Fox
		(0, 62792,  3, 10, 0, 0, 0, 0), -- Bloodthirsty Baroness Lucky Pack (Eidolon)

		-- Sixth Row
		(0, 41554,  2,  5, 0, 0, 0, 0), -- Festival Elizabeth's Key Fragment
		(0, 40996,  3,  5, 0, 0, 0, 0), -- Super XP Card
		(0, 40953, 25, 65, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20728,  1,  5, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 15360,  1, 10, 0, 0, 0, 0), -- Lava Secret Stone Lucky Pack
		(0, 40633, 10, 10, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll

		-- Seventh Row
		(0, 40647,  1,  5, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 41505, 10, 10, 0, 0, 0, 0), -- Holy Spirit Stat Shuffle Stone II
		(0, 40857, 10, 35, 0, 0, 0, 0), -- Advanced Card Breakthrough Device
		(0, 40501, 10, 35, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 53567,  1, 10, 0, 0, 0, 0), -- Custom Head: Shimmering Fox Hairpin (F)
		(0, 62206,  5,  5, 0, 0, 0, 0)  -- Summer Dragon Tyrant Lucky Pack (Eidolon)
	];
	entry PARAGON_ENTRY;

BEGIN

	-- Remove old table
	DELETE FROM lottery WHERE category = paragon_id;

	-- Insert entries into the lottery table
	FOREACH entry IN ARRAY paragon_data LOOP
		INSERT INTO "lottery" VALUES (i + 1, paragon_id, (i - MOD(i, 6)) / 6 + 1, entry.weekday, MOD(i, 6) + 1, entry.item_id, entry.max_stack, entry.drop_rate, entry.notify, entry.get_only, entry.shining_hint, entry.jack_pot);
		i := i + 1;
	END LOOP;

END;
$$ LANGUAGE plpgsql;

-- Delete PARAGON_ENTRY type
DROP TYPE PARAGON_ENTRY;
