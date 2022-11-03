--
-- Paragon
-- Created by: Haylander, rates by TODO
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
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 41013,  5, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book
		(0, 40637,  4, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 40987,  1, 20, 0, 0, 0, 0), -- Premium XP Card
		(0, 40502,  7, 20, 0, 0, 0, 0), -- Super Treasure Charm (Non-tradable)
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)

		-- Second Row
		(0, 41096,  3, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40635,  5, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 41409,  3, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 46032, 25, 20, 0, 0, 0, 0), -- Mana Starstone

		-- Third Row
		(0, 21408, 25, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41013,  7, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book
		(0, 40987,  2, 20, 0, 0, 0, 0), -- Premium XP Card
		(0, 62448,  1, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 40637,  3, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll

		-- Fourth Row
		(0, 41096,  5, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 41013,  3, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book
		(0, 62247,  1, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 46032, 35, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 52902,  1, 20, 0, 0, 0, 0), -- Custom Furniture: Halloween Zephyrine Portrait
		(0, 41456,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Raphael in Arms

		-- Fifth Row
		(0, 46338,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Sprite Princess Haltin
		(0, 46032, 10, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40633,  5, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 55902,  1, 20, 0, 0, 0, 0), -- Head: Halloween Pumpkin Cat
		(0, 41013, 10, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book
		(0, 41096,  4, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution

		-- Sixth Row
		(0, 40501,  3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 62247,  2, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40635,  3, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40985,  1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 21408, 60, 20, 0, 1, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 40996,  1, 20, 0, 0, 0, 0), -- Super XP Card

		-- Seventh Row
		(0, 41116,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 46032, 50, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 46429,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Evil Paladin Reinhardt
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 20727,  1, 20, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 62448,  2, 20, 0, 0, 0, 0)  -- Guardian of the Temple Lucky Pack (Eidolon)
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
