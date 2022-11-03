--
-- Paragon
-- Created by: Elvian, rates by TODO
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
		(0, 40633,  7, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 45769,  1, 20, 0, 0, 0, 0), -- 200 Loyalty Points (Non-tradable)
		(0, 62713,  2, 20, 0, 0, 0, 0), -- Cat Lady Lucky Pack (Eidolon)
		(0, 41514,  1, 20, 0, 0, 0, 0), -- Nekomata's Key Fragment
		(0, 40452,  1, 20, 0, 0, 0, 0), -- Card Duel Water of Life - 5 Points (Non-tradable)
		(0, 15326,  3, 20, 0, 0, 0, 0), -- XP Crystal Card Pack

		-- Second Row
		(0, 40712,  1, 20, 0, 0, 0, 0), -- Premium Treasure Charm (1 Day) (Non-tradable)
		(0, 40053,  5, 20, 0, 0, 0, 0), -- Advanced Weapon Fortification Scroll
		(0, 62884,  2, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 41521,  1, 20, 0, 0, 0, 0), -- Queen of Hearts' Key Fragment
		(0, 46032, 10, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 63195,  1, 20, 0, 0, 0, 0), -- DEF Mastery Box

		-- Third Row
		(0, 40987,  2, 20, 0, 0, 0, 0), -- Premium XP Card
		(0, 62841,  3, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer Lucky Pack (Non-tradable)
		(0, 62780,  2, 20, 0, 0, 0, 0), -- Goddess of the Home Lucky Pack (Eidolon)
		(0, 41550,  1, 20, 0, 0, 0, 0), -- Hestia's Key Fragment
		(0, 41409,  3, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 15326,  3, 20, 0, 0, 0, 0), -- XP Crystal Card Pack

		-- Fourth Row
		(0, 20511,  3, 20, 0, 1, 0, 0), -- Heart of the Deep
		(0, 45018,  5, 20, 0, 0, 0, 0), -- Advanced Weapon Fortification Scroll 3
		(0, 62448,  2, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 41116,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 46032, 15, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 63197,  1, 20, 0, 0, 0, 0), -- Tactic Mastery Box

		-- Fifth Row
		(0, 21664,  1, 20, 0, 0, 0, 0), -- Lv.80 Eidolon Accessory Collection Chest
		(0, 41096,  3, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 62792,  2, 20, 0, 0, 0, 0), -- Bloodthirsty Baroness Lucky Pack (Eidolon)
		(0, 41554,  1, 20, 0, 0, 0, 0), -- Festival Elizabeth's Key Fragment
		(0, 20726,  3, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 15326,  3, 20, 0, 0, 0, 0), -- XP Crystal Card Pack

		-- Sixth Row
		(0, 22766,  1, 20, 0, 1, 0, 0), -- ＴＲＩＣＫ
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 62247,  1, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40985,  1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 46032, 20, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 15360,  1, 20, 0, 0, 0, 0), -- Lava Secret Stone Lucky Pack

		-- Seventh Row
		(0, 40499,  3, 20, 0, 0, 0, 0), -- Premium Treasure Charm
		(0, 41523,  3, 20, 0, 0, 0, 0), -- Powerful Emblem Restructuring Solution (Non-tradable)
		(0, 62896,  2, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 41634,  1, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 40633,  4, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 15326,  3, 20, 0, 0, 0, 0)  -- XP Crystal Card Pack
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
