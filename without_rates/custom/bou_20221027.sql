--
-- Paragon
-- Created by: Bou, rates by TODO
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
		(0, 41634,  2, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 40635,  5, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 41034,  3, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 46032, 10, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40655,  1, 20, 0, 0, 0, 0), -- 30th-Order Armor Fortification
		(0, 62896,  2, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)

		-- Second Row
		(0, 40987,  2, 20, 0, 0, 0, 0), -- Premium XP Card
		(0, 16058,  1, 20, 0, 0, 0, 0), -- Maple Syrup Grilled Turkey
		(0, 20726,  3, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 20511,  3, 20, 0, 0, 0, 0), -- Heart of the Deep
		(0, 40201,  1, 20, 0, 0, 0, 0), -- Brilliant Evolutionary Beads
		(0, 41484,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Persephone in Arms

		-- Third Row
		(0, 41032,  4, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40199,  1, 20, 0, 0, 0, 0), -- 20th-Order Armor Fortification
		(0, 46032, 20, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40782,  1, 20, 0, 0, 0, 0), -- Eidolon Oath Ring
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern

		-- Fourth Row
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 40637,  5, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 40197,  1, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 45862,  1, 20, 0, 0, 0, 0), -- Azuria Crispy Roast Meat (Non-tradable)
		(0, 40663,  1, 20, 0, 0, 0, 0), -- 30th-Order Accessory Fortification
		(0, 41065,  3, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone II

		-- Fifth Row
		(0, 40996,  2, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 40953, 15, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20726,  4, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40210,  1, 20, 0, 0, 0, 0), -- 20-Slot Backpack
		(0, 41409,  3, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 62247,  2, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)

		-- Sixth Row
		(0, 41096,  5, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 45593,  2, 20, 0, 0, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 45861,  1, 20, 0, 0, 0, 0), -- Fantastic Mapo Tofu (Non-tradable)
		(0, 46032, 40, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41105,  1, 20, 0, 0, 0, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 40647,  1, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification

		-- Seventh Row
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40633,  5, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 40501,  3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 22766,  1, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 41503,  1, 20, 0, 0, 0, 0)  -- Anima Crystal: Abe no Seimei in Arms
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
