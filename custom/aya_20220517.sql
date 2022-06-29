--
-- Paragon
-- Created by: Aya, rates by Haruka Kasugano
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
		(0, 40459,  3, 10, 0, 0, 0, 0), -- 2-Star Eidolon Purification Scroll
		(0, 46032, 15, 25, 0, 0, 0, 0), -- Mana Starstone
		(0, 45594,  1,  5, 0, 0, 0, 0), -- Fantasy Gift Voucher: 100 Points
		(0, 16534, 10, 15, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40953, 10, 25, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 63196,  1, 20, 0, 0, 0, 0), -- Special Mastery Box

		-- Second Row
		(0, 22016,  1, 50, 0, 0, 0, 0), -- Unique Inaba
		(0, 40501,  2, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 40839,  2,  5, 0, 0, 0, 0), -- Succubus' Key Fragment
		(0, 62065,  3, 15, 0, 0, 0, 0), -- Charming Love Lucky Pack (Eidolon)
		(0, 20727,  2,  5, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 40197,  2,  5, 0, 0, 0, 0), -- 20th-Order Weapon Fortification

		-- Third Row
		(0, 40463,  3, 10, 0, 0, 0, 0), -- 4-Star Eidolon Purification Scroll
		(0, 46032, 20, 40, 0, 0, 0, 0), -- Mana Starstone
		(0, 62339,  3, 10, 0, 0, 0, 0), -- Pruina Lucky Pack (Eidolon)
		(0, 41026,  2,  5, 0, 0, 0, 0), -- Andrea's Key Fragment
		(0, 40953, 35, 15, 0, 1, 0, 0), -- Eidolon Lucky Pack
		(0, 63195,  1, 20, 0, 0, 0, 0), -- DEF Mastery Box

		-- Fourth Row
		(0, 46264,  1,  5, 0, 0, 0, 0), -- Summoning contract: Sky Dragon King Flokja
		(0, 40501,  3, 40, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41514,  2,  5, 0, 0, 0, 0), -- Nekomata's Key Fragment
		(0, 62713,  3, 15, 0, 0, 0, 0), -- Cat Lady Lucky Pack (Eidolon)
		(0, 20726,  5, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40067,  2, 15, 0, 0, 0, 0), -- 15th-Order Weapon Fortification

		-- Fifth Row
		(0, 40461,  3, 10, 0, 0, 0, 0), -- 3-Star Eidolon Purification Scroll
		(0, 46032, 40, 25, 0, 1, 0, 0), -- Mana Starstone
		(0, 62839,  2, 20, 0, 0, 0, 0), -- Crescent Maiden Lucky Pack (Eidolon)
		(0, 41565,  1,  5, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 40953, 15, 25, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 63197,  1, 15, 0, 0, 0, 0), -- Tactic Mastery Box

		-- Sixth Row
		(0, 20728,  1,  5, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 40501,  5, 25, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41554,  1,  5, 0, 0, 0, 0), -- Festival Elizabeth's Key Fragment
		(0, 62792,  1, 25, 0, 0, 0, 0), -- Bloodthirsty Baroness Lucky Pack (Eidolon)
		(0, 20726, 15, 10, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40065,  1, 30, 0, 0, 0, 0), -- 10th-Order Weapon Fortification

		-- Seventh Row
		(0, 40457,  3, 15, 0, 0, 0, 0), -- 1-Star Eidolon Purification Scroll
		(0, 46032, 25, 30, 0, 0, 0, 0), -- Mana Starstone
		(0, 62739,  3, 10, 0, 0, 0, 0), -- Queen of Wonderland Lucky Pack (Eidolon)
		(0, 41521,  2,  5, 0, 0, 0, 0), -- Queen of Hearts' Key Fragment
		(0, 40953, 20, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 63195,  1, 20, 0, 0, 0, 0)  -- DEF Mastery Box
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
