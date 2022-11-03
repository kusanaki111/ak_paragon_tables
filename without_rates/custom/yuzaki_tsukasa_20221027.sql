--
-- Paragon
-- Created by: Yuzaki Tsukasa, rates by TODO
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
		(0, 41510,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Rachel in Arms
		(0, 40633,  5, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 40953,  5, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20728,  1, 20, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 40067,  1, 20, 0, 0, 0, 0), -- 15th-Order Weapon Fortification
		(0, 22766,  1, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ

		-- Second Row
		(0, 62884,  3, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 40987,  3, 20, 0, 0, 0, 0), -- Premium XP Card
		(0, 20727,  2, 20, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40989,  3, 20, 0, 0, 0, 0), -- Premium Mastery Pass
		(0, 41628,  1, 20, 0, 0, 0, 0), -- Percival's Key Fragment

		-- Third Row
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 40637,  5, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 40953, 15, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20726,  5, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40525,  1, 20, 0, 0, 0, 0), -- Lv.15 Accessory Fortification
		(0, 41116,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment

		-- Fourth Row
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40996,  2, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 16534, 50, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40953, 20, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40998,  2, 20, 0, 0, 0, 0), -- Ultimate Mastery Pass
		(0, 40985,  1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment

		-- Fifth Row
		(0, 46730,  1, 20, 0, 0, 0, 0), -- Halloween Zashi Panel
		(0, 40635,  5, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40953, 25, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20726,  5, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40073,  1, 20, 0, 0, 0, 0), -- 15th-Order Armor Fortification
		(0, 46730,  1, 20, 0, 0, 0, 0), -- Halloween Zashi Panel

		-- Sixth Row
		(0, 62896,  3, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 40201,  1, 20, 0, 0, 0, 0), -- Brilliant Evolutionary Beads
		(0, 20727,  2, 20, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 40953, 30, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40782,  1, 20, 0, 0, 0, 0), -- Eidolon Oath Ring
		(0, 41634,  1, 20, 0, 0, 0, 0), -- Siren's Key Fragment

		-- Seventh Row
		(0, 40996,  3, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 41013, 15, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book
		(0, 40953, 35, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20728,  1, 20, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 40194, 10, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 46732,  1, 20, 0, 0, 0, 0)  -- Summoning Contract: Jack-o-Lantern
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
