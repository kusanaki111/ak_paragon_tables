--
-- Paragon
-- Created by: Tavarille, rates by TODO
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
		(0, 40210,  1, 20, 0, 0, 0, 0), -- 20-Slot Backpack
		(0, 41034,  3, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 45028,  4, 20, 0, 0, 0, 0), -- 15th-Order Weapon Fortification
		(0, 46032,  5, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40438,  2, 20, 0, 0, 0, 0), -- Profession Guardian Sprite
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern

		-- Second Row
		(0, 40788,  1, 20, 0, 0, 0, 0), -- Swifty Stars (Non-tradable)
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40953, 15, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 41034,  3, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40422, 10, 20, 0, 0, 0, 0), -- Vouchers

		-- Third Row
		(0, 41602,  5, 20, 0, 1, 0, 0), -- Superior Secret Stone Coin
		(0, 53397,  1, 20, 0, 0, 0, 0), -- Weapon: Starflame Demonic Cat Sword
		(0, 46032, 15, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 45063,  1, 20, 0, 0, 0, 0), -- 100 Ruby Coins
		(0, 53396,  1, 20, 0, 0, 0, 0), -- Weapon: Halloween Demonic Cat Sword
		(0, 45098,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (3 Days)

		-- Fourth Row
		(0, 40996,  2, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 46385,  1, 20, 0, 0, 0, 0), -- Pumpkin Phantom
		(0, 45031,  2, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 40953, 20, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 54744,  1, 20, 0, 0, 0, 0), -- Halloween Ghost King
		(0, 46431,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Mixed Demon Delfonia

		-- Fifth Row
		(0, 21729,  1, 20, 0, 0, 0, 0), -- Unique Halloween Zephyrine
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 50132,  1, 20, 0, 0, 0, 0), -- Head: Enchanted Pumpkin Head
		(0, 45658,  2, 20, 0, 0, 0, 0), -- World Peace Organization VIP Guardian (Non-tradable)
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm

		-- Sixth Row
		(0, 45102,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (7 Days)
		(0, 46032, 30, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 45065,  1, 20, 0, 0, 0, 0), -- 200 Ruby Coins
		(0, 55902,  1, 20, 0, 0, 0, 0), -- Head: Halloween Pumpkin Cat
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 40647,  1, 20, 0, 1, 0, 0), -- 30th-Order Weapon Fortification

		-- Seventh Row
		(0, 22766,  3, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ
		(0, 62884,  2, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 40633, 10, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 41409,  3, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 41628,  1, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 46429,  1, 20, 0, 0, 0, 0)  -- Summoning Contract: Evil Paladin Reinhardt
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
