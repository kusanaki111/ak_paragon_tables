--
-- Paragon
-- Created by: zwerg666, rates by Haruka Kasugano
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
		(0, 41620,  2, 20, 0, 0, 0, 0), -- Full Combo Pet Improving Potion
		(0, 41032,  3, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 53254,  1, 10, 0, 0, 0, 0), -- Back: Serena Surfboard
		(0, 45593,  2, 20, 0, 0, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 40073,  1, 20, 0, 0, 0, 0), -- 15th-Order Armor Fortification
		(0, 40199,  1, 10, 0, 0, 0, 0), -- 20th-Order Armor Fortification

		-- Second Row
		(0, 40065,  1, 20, 0, 0, 0, 0), -- 10th-Order Weapon Fortification
		(0, 40067,  1, 15, 0, 0, 0, 0), -- 15th-Order Weapon Fortification
		(0, 45593,  2, 15, 0, 0, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 53253,  1, 10, 0, 0, 0, 0), -- Back: Cesela Surfboard
		(0, 41032,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 41620,  2, 20, 0, 0, 0, 0), -- Full Combo Pet Improving Potion

		-- Third Row
		(0, 40463,  1, 15, 0, 0, 0, 0), -- 4-Star Eidolon Purification Scroll
		(0, 40461,  1, 15, 0, 0, 0, 0), -- 3-Star Eidolon Purification Scroll
		(0, 40633,  5, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 40635,  5, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40637,  5, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 41039,  2, 10, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone I

		-- Fourth Row
		(0, 40637,  7, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 40635,  7, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40633,  7, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 40645,  1,  5, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 46818,  1, 10, 0, 0, 0, 0), -- SLv.20 Equipment Restructuring Solution (Orange) (Non-tradable)
		(0, 41032,  7, 25, 0, 0, 0, 0), -- Superior Secret Stone Randomizer

		-- Fifth Row
		(0, 40645,  2, 20, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 40655,  2, 20, 0, 0, 0, 0), -- 30th-Order Armor Fortification
		(0, 62489,  2, 20, 0, 0, 0, 0), -- Festive Goddess of Creation Lucky Pack (Eidolon)
		(0, 46818,  1, 20, 0, 0, 0, 0), -- SLv.20 Equipment Restructuring Solution (Orange) (Non-tradable)
		(0, 41034,  7, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 45594,  1, 20, 0, 1, 0, 0), -- Fantasy Gift Voucher: 100 Points

		-- Sixth Row
		(0, 40934,  1,  5, 0, 0, 0, 0), -- Summer Alucard's Key Fragment
		(0, 45593,  5, 15, 0, 0, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 40647,  1,  5, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 41034,  8, 40, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 41032, 10, 30, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 40936,  1,  5, 0, 0, 0, 0), -- Summer Nidhogg's Key Fragment

		-- Seventh Row
		(0, 41034, 10, 25, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 41483,  1,  5, 0, 0, 0, 0), -- Summer Persephone's Key Fragment
		(0, 41061,  1,  5, 0, 0, 0, 0), -- Summer Michaela's Key Fragment
		(0, 41039,  6, 35, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone I
		(0, 40647,  2,  5, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 41032, 12, 25, 0, 0, 0, 0)  -- Superior Secret Stone Randomizer
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
