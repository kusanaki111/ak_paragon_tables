--
-- Paragon
-- Created by: Nyanu, rates by Haruka Kasugano
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
		(0, 41030,  5, 20, 0, 1, 0, 0), -- Superior Pet Improving Potion
		(0, 40953,  5, 25, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 41030,  5, 25, 0, 0, 0, 0), -- Superior Pet Improving Potion
		(0, 46703,  1,  5, 0, 0, 0, 0), -- Summer Alucard Panel
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 19599,  1,  5, 0, 0, 0, 0), -- Unidentified Melee Mastery Scroll VI

		-- Second Row
		(0, 41061,  1,  5, 0, 0, 0, 0), -- Summer Michaela's Key Fragment
		(0, 46706,  1,  5, 0, 0, 0, 0), -- Summer Persephone Panel
		(0, 40953, 15, 65, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 62409,  1, 10, 0, 0, 0, 0), -- Summer Guardian Angel Lucky Pack (Eidolon)
		(0, 62409,  2, 10, 0, 0, 0, 0), -- Summer Guardian Angel Lucky Pack (Eidolon)
		(0, 41061,  2,  5, 0, 0, 0, 0), -- Summer Michaela's Key Fragment

		-- Third Row
		(0, 40934,  1,  5, 0, 0, 0, 0), -- Summer Alucard's Key Fragment
		(0, 40637,  4, 25, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 41030,  5, 45, 0, 0, 0, 0), -- Superior Pet Improving Potion
		(0, 62206,  1, 10, 0, 0, 0, 0), -- Summer Dragon Tyrant Lucky Pack (Eidolon)
		(0, 62206,  2, 10, 0, 0, 0, 0), -- Summer Dragon Tyrant Lucky Pack (Eidolon)
		(0, 40934,  2,  5, 0, 0, 0, 0), -- Summer Alucard's Key Fragment

		-- Fourth Row
		(0, 40936,  1,  5, 0, 0, 0, 0), -- Summer Nidhogg's Key Fragment
		(0, 40635,  4, 25, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40953, 20, 45, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 62207,  1, 10, 0, 0, 0, 0), -- Summer Calamity Dragon Lucky Pack (Eidolon)
		(0, 62207,  2, 10, 0, 0, 0, 0), -- Summer Calamity Dragon Lucky Pack (Eidolon)
		(0, 40936,  2,  5, 0, 0, 0, 0), -- Summer Nidhogg's Key Fragment

		-- Fifth Row
		(0, 41483,  1,  5, 0, 0, 0, 0), -- Summer Persephone's Key Fragment
		(0, 40633,  4, 25, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 41030,  5, 45, 0, 0, 0, 0), -- Superior Pet Improving Potion
		(0, 62636,  1, 10, 0, 0, 0, 0), -- Summer Queen of the Underworld Lucky Pack (Eidolon)
		(0, 62636,  2, 10, 0, 0, 0, 0), -- Summer Queen of the Underworld Lucky Pack (Eidolon)
		(0, 41483,  2,  5, 0, 0, 0, 0), -- Summer Persephone's Key Fragment

		-- Sixth Row
		(0, 46705,  1,  5, 0, 0, 0, 0), -- Summer Nidhogg Panel
		(0, 40323,  1, 20, 0, 0, 0, 0), -- Guardian Sprite of Gaia (1 Day)
		(0, 19598,  1, 10, 0, 0, 0, 0), -- Unidentified Melee Mastery Scroll V
		(0, 41030, 15, 50, 0, 1, 0, 0), -- Superior Pet Improving Potion
		(0, 40439,  1, 10, 0, 0, 0, 0), -- Profession Guardian Sprite (1 Day)
		(0, 46704,  1,  5, 0, 0, 0, 0), -- Summer Michaela Panel

		-- Seventh Row
		(0, 19601,  1, 15, 0, 0, 0, 0), -- Unidentified Ranged Mastery Scroll V
		(0, 41031,  7, 20, 0, 0, 0, 0), -- Superior Pet Improving Potion (Non-tradable)
		(0, 40953, 25, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 41470,  1, 10, 0, 0, 0, 0), -- Anima Crystal: Inaba in Arms
		(0, 41032,  7, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 19599,  1, 15, 0, 0, 0, 0)  -- Unidentified Melee Mastery Scroll VI
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
