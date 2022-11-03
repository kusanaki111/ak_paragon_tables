--
-- Paragon
-- Created by: Cute Renieh, rates by TODO
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
		(0, 40081,  1, 20, 0, 0, 0, 0), -- Seven Day XP Crystal
		(0, 40065,  3, 20, 0, 0, 0, 0), -- 10th-Order Weapon Fortification
		(0, 46032,  5, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40985,  1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40953,  5, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 16534, 15, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal

		-- Second Row
		(0, 40067,  2, 20, 0, 0, 0, 0), -- 15th-Order Weapon Fortification
		(0, 40079,  2, 20, 0, 0, 0, 0), -- 24 Hour XP Crystal
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 46032, 10, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 16534, 10, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Third Row
		(0, 40987,  2, 20, 0, 0, 0, 0), -- Premium XP Card
		(0, 40197,  2, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 46032, 15, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41116,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 40953, 15, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 16534,  5, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal

		-- Fourth Row
		(0, 40645,  1, 20, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 40996,  1, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 46032, 20, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 20726,  4, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40953, 20, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Fifth Row
		(0, 22766,  1, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ
		(0, 40647,  1, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 46032, 25, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41028,  1, 20, 0, 0, 0, 0), -- Iwanaga-hime's Key Fragment
		(0, 40953, 25, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20727,  2, 20, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal

		-- Sixth Row
		(0, 11664,  5, 20, 0, 0, 0, 0), -- Advanced Weapon Fortification Scroll (Non-Tradable)
		(0, 40475,  1, 20, 0, 0, 0, 0), -- World Peace VIP Guardian
		(0, 62096,  3, 20, 0, 0, 0, 0), -- Goddess of Eternity Lucky Pack (Eidolon)
		(0, 46032, 35, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 20726,  2, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40953, 35, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Seventh Row
		(0, 45658,  2, 20, 0, 0, 0, 0), -- World Peace Organization VIP Guardian (Non-tradable)
		(0, 40633, 10, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 46032, 30, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41628,  1, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 40953, 30, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20728,  1, 20, 0, 0, 0, 0)  -- Eidolon XP Stone
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
