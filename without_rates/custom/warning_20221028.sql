--
-- Paragon
-- Created by: Warning, rates by TODO
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
		(0, 22766,  1, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ
		(0, 40633,  5, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 41034,  4, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 40197,  1, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 16058,  1, 20, 0, 0, 0, 0), -- Maple Syrup Grilled Turkey
		(0, 40782,  1, 20, 0, 0, 0, 0), -- Eidolon Oath Ring

		-- Second Row
		(0, 40635,  5, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20706,  1, 20, 0, 0, 0, 0), -- Zephyr Step (Non-Tradable)
		(0, 41409,  3, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 46032, 20, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40647,  1, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification

		-- Third Row
		(0, 62247,  2, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 41034,  4, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 45593,  2, 20, 0, 0, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 40199,  1, 20, 0, 0, 0, 0), -- 20th-Order Armor Fortification
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 41472,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Salome in Arms

		-- Fourth Row
		(0, 40637,  5, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 40953, 15, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20707,  1, 20, 0, 0, 0, 0), -- Breezy Step (Non-Tradable)
		(0, 41096,  5, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 40501,  4, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 40987,  2, 20, 0, 0, 0, 0), -- Premium XP Card

		-- Fifth Row
		(0, 40655,  1, 20, 0, 0, 0, 0), -- 30th-Order Armor Fortification
		(0, 45098,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (3 Days)
		(0, 45594,  1, 20, 0, 0, 0, 0), -- Fantasy Gift Voucher: 100 Points
		(0, 40574,  1, 20, 0, 0, 0, 0), -- Lv.20 Accessory Blessing Scroll
		(0, 41065,  4, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone II
		(0, 40647,  1, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification

		-- Sixth Row
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 20705,  1, 20, 0, 0, 0, 0), -- Godly Paced Flash (Non-Tradable)
		(0, 46032, 30, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40996,  2, 20, 0, 0, 0, 0), -- Super XP Card

		-- Seventh Row
		(0, 46032, 40, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40953, 30, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20511,  5, 20, 0, 0, 0, 0), -- Heart of the Deep
		(0, 22766,  2, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41510,  1, 20, 0, 0, 0, 0)  -- Anima Crystal: Rachel in Arms
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
