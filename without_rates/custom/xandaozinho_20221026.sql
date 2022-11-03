--
-- Paragon
-- Created by: xandaozinho, rates by TODO
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
		(0, 40953, 20, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40525,  3, 20, 0, 0, 0, 0), -- Lv.15 Accessory Fortification
		(0, 41522,  5, 20, 0, 0, 0, 0), -- Emblem Restructuring Solution
		(0, 40067,  2, 20, 0, 0, 0, 0), -- 15th-Order Weapon Fortification
		(0, 40532,  3, 20, 0, 0, 0, 0), -- Bouquet of Dreams
		(0, 40073,  3, 20, 0, 0, 0, 0), -- 15th-Order Armor Fortification

		-- Second Row
		(0, 41514,  2, 20, 0, 0, 0, 0), -- Nekomata's Key Fragment
		(0, 46032, 18, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 20728,  1, 20, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 16534,  5, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 41412,  2, 20, 0, 0, 0, 0), -- Orochi's Key Fragment
		(0, 41409,  2, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment

		-- Third Row
		(0, 62713,  3, 20, 0, 0, 0, 0), -- Cat Lady Lucky Pack (Eidolon)
		(0, 40199,  2, 20, 0, 0, 0, 0), -- 20th-Order Armor Fortification
		(0, 40953, 30, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40574,  2, 20, 0, 0, 0, 0), -- Lv.20 Accessory Blessing Scroll
		(0, 16534,  5, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40197,  1, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification

		-- Fourth Row
		(0, 40645,  1, 20, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 46032, 23, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40653,  2, 20, 0, 0, 0, 0), -- 25th-Order Armor Fortification
		(0, 40953, 35, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40661,  2, 20, 0, 0, 0, 0), -- 25th-Order Accessory Fortification
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm

		-- Fifth Row
		(0, 41530,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Queen of Hearts in Arms
		(0, 20728,  2, 20, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 40499,  5, 20, 0, 1, 0, 0), -- Premium Treasure Charm
		(0, 16534, 10, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 46032, 40, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 62470,  3, 20, 0, 0, 0, 0), -- Serpent God Lucky Pack (Eidolon)

		-- Sixth Row
		(0, 41409,  4, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 20727,  1, 20, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 40663,  1, 20, 0, 0, 0, 0), -- 30th-Order Accessory Fortification
		(0, 40655,  1, 20, 0, 0, 0, 0), -- 30th-Order Armor Fortification
		(0, 16534, 26, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40953, 45, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Seventh Row
		(0, 40647,  1, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 45102,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (7 Days)
		(0, 16534, 30, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40953, 50, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40645,  1, 20, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 41034, 10, 20, 0, 0, 0, 0)  -- Costume Attribution Potion
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
