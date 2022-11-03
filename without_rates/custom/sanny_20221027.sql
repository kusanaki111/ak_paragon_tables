--
-- Paragon
-- Created by: Sanny, rates by TODO
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
		(0, 40475,  1, 20, 0, 0, 0, 0), -- World Peace VIP Guardian
		(0, 16534, 10, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40713,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (1 Day) (Non-tradable)
		(0, 53743,  1, 20, 0, 0, 0, 0), -- Custom Head: Percival's Hairstyle (F)
		(0, 40067,  4, 20, 0, 0, 0, 0), -- 15th-Order Weapon Fortification
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm

		-- Second Row
		(0, 20511,  5, 20, 0, 0, 0, 0), -- Heart of the Deep
		(0, 46032, 50, 20, 0, 1, 0, 0), -- Mana Starstone
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 53364,  1, 20, 0, 0, 0, 0), -- Back: Halloween White Kitty Claw

		-- Third Row
		(0, 40029,  4, 20, 0, 0, 0, 0), -- Advanced XP Card
		(0, 53740,  1, 20, 0, 0, 0, 0), -- Custom Body: Percival's Dress (F)
		(0, 40197,  3, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 16534, 20, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 45090,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (3 Days) (Non-tradable)
		(0, 46032,  5, 20, 0, 0, 0, 0), -- Mana Starstone

		-- Fourth Row
		(0, 45098,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (3 Days)
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40475,  2, 20, 0, 0, 0, 0), -- World Peace VIP Guardian
		(0, 40502,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm (Non-tradable)
		(0, 21408, 50, 20, 0, 1, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)

		-- Fifth Row
		(0, 40053, 10, 20, 0, 0, 0, 0), -- Advanced Weapon Fortification Scroll
		(0, 63195,  1, 20, 0, 0, 0, 0), -- DEF Mastery Box
		(0, 40987,  4, 20, 0, 0, 0, 0), -- Premium XP Card
		(0, 40645,  2, 20, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 53746,  1, 20, 0, 0, 0, 0), -- Weapon: Holy Knight's Sword
		(0, 16534, 30, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal

		-- Sixth Row
		(0, 53363,  1, 20, 0, 0, 0, 0), -- Back: Halloween Black Kitty Claw
		(0, 40501, 10, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 45592,  3, 20, 0, 0, 0, 0), -- Fantasy Gift Voucher: 1 Point
		(0, 45094,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (7 Days) (Non-tradable)
		(0, 40996,  2, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 40953, 12, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Seventh Row
		(0, 20511,  5, 20, 0, 0, 0, 0), -- Heart of the Deep
		(0, 40647,  1, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 62884,  3, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 41628,  2, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 40475,  2, 20, 0, 0, 0, 0), -- World Peace VIP Guardian
		(0, 45102,  1, 20, 0, 0, 0, 0)  -- Super Treasure Charm (7 Days)
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
