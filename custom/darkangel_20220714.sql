--
-- Paragon
-- Created by: Darkangel, rates by Haruka Kasugano
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
		(0, 40954, 15, 25, 0, 0, 0, 0), -- Eidolon Lucky Pack (Non-tradable)
		(0, 20511, 10, 20, 0, 0, 0, 0), -- Heart of the Deep
		(0, 40194, 20, 25, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 40656,  1,  5, 0, 0, 0, 0), -- 30th-Order Armor Fortification (Non-tradable)
		(0, 15087, 10, 10, 0, 0, 0, 0), -- Poseidon's Crystal
		(0, 53288,  1, 15, 0, 0, 0, 0), -- Custom Furniture: Small Summer Persephone Portrait

		-- Second Row
		(0, 62792,  3, 10, 0, 0, 0, 0), -- Bloodthirsty Baroness Lucky Pack (Eidolon)
		(0, 16840, 25, 15, 0, 1, 0, 0), -- Dazzling Experience Crystal (Non-Tradable)
		(0, 40175,  1, 10, 0, 0, 0, 0), -- 500 Loyalty Points
		(0, 45593,  1, 25, 0, 0, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 21140, 10, 35, 0, 0, 0, 0), -- Basic Card Breakthrough Device (Non-Tradable)
		(0, 41554,  1,  5, 0, 0, 0, 0), -- Festival Elizabeth's Key Fragment

		-- Third Row
		(0, 40954, 20, 50, 0, 0, 0, 0), -- Eidolon Lucky Pack (Non-tradable)
		(0, 62206,  3, 10, 0, 0, 0, 0), -- Summer Dragon Tyrant Lucky Pack (Eidolon)
		(0, 40194, 25, 20, 0, 1, 0, 0), -- Fluorescent Bead
		(0, 40664,  1,  5, 0, 0, 0, 0), -- 30th-Order Accessory Fortification (Non-tradable)
		(0, 41483,  1,  5, 0, 0, 0, 0), -- Summer Persephone's Key Fragment
		(0, 52767,  1, 10, 0, 0, 0, 0), -- Custom Furniture: Large Summer Michaela Portrait

		-- Fourth Row
		(0, 40743,  2, 25, 0, 0, 0, 0), -- Mount Upgrade Stone
		(0, 20726,  4, 25, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 62207,  3, 15, 0, 0, 0, 0), -- Summer Calamity Dragon Lucky Pack (Eidolon)
		(0, 41061,  1,  5, 0, 0, 0, 0), -- Summer Michaela's Key Fragment
		(0, 21141, 10, 10, 0, 1, 0, 0), -- Intermediate Card Breakthrough Device (Non-Tradable)
		(0, 41105,  2, 20, 0, 0, 0, 0), -- Dazzling Mount Stat Shuffle Stone

		-- Fifth Row
		(0, 40954, 25, 15, 0, 1, 0, 0), -- Eidolon Lucky Pack (Non-tradable)
		(0, 20727,  2, 20, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 40936,  1,  5, 0, 0, 0, 0), -- Summer Nidhogg's Key Fragment
		(0, 62409,  3, 20, 0, 0, 0, 0), -- Summer Guardian Angel Lucky Pack (Eidolon)
		(0, 21142, 10, 25, 0, 0, 0, 0), -- Advanced Card Breakthrough Device (Non-Tradable)
		(0, 53286,  1, 15, 0, 0, 0, 0), -- Custom Furniture: Large Summer Persephone Portrait

		-- Sixth Row
		(0, 41470,  1,  5, 0, 0, 0, 0), -- Anima Crystal: Inaba in Arms
		(0, 40934,  1,  5, 0, 0, 0, 0), -- Summer Alucard's Key Fragment
		(0, 41034, 10, 20, 0, 1, 0, 0), -- Costume Attribution Potion
		(0, 41032, 10, 25, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 62636,  3, 20, 0, 0, 0, 0), -- Summer Queen of the Underworld Lucky Pack (Eidolon)
		(0, 41541,  1, 25, 0, 0, 0, 0), -- Despair War Symbol

		-- Seventh Row
		(0, 41565,  1,  5, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 20728,  1, 10, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 40194, 30, 30, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 40648,  1, 10, 0, 0, 0, 0), -- 30th-Order Weapon Fortification (Non-tradable)
		(0, 21142, 15, 25, 0, 0, 0, 0), -- Advanced Card Breakthrough Device (Non-Tradable)
		(0, 62839,  3, 20, 0, 0, 0, 0)  -- Crescent Maiden Lucky Pack (Eidolon)
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
