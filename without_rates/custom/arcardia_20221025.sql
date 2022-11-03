--
-- Paragon
-- Created by: Arcardia, rates by TODO
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
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 21729,  1, 20, 0, 0, 0, 0), -- Unique Halloween Zephyrine
		(0, 21408, 15, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 41100,  2, 20, 0, 0, 0, 0), -- Bastet's Key Fragment
		(0, 40197,  2, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 16534, 25, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal

		-- Second Row
		(0, 20726,  3, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40645,  1, 20, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 40194,  5, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 21408, 20, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 22552,  1, 20, 0, 0, 0, 0), -- Unique Hestia
		(0, 40953, 15, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Third Row
		(0, 40457,  5, 20, 0, 0, 0, 0), -- 1-Star Eidolon Purification Scroll
		(0, 50132,  1, 20, 0, 0, 0, 0), -- Head: Enchanted Pumpkin Head
		(0, 40953, 20, 20, 0, 1, 0, 0), -- Eidolon Lucky Pack
		(0, 40194,  5, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 40199,  2, 20, 0, 0, 0, 0), -- 20th-Order Armor Fortification
		(0, 20726,  5, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal

		-- Fourth Row
		(0, 20727,  2, 20, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 40653,  1, 20, 0, 0, 0, 0), -- 25th-Order Armor Fortification
		(0, 40635,  5, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40953, 30, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 53396,  1, 20, 0, 0, 0, 0), -- Weapon: Halloween Demonic Cat Sword
		(0, 40463,  5, 20, 0, 0, 0, 0), -- 4-Star Eidolon Purification Scroll

		-- Fifth Row
		(0, 41530,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Queen of Hearts in Arms
		(0, 62448,  2, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 41034,  3, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 40501,  3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 40771,  5, 20, 0, 0, 0, 0), -- Advanced Otter Feed (Non-tradable)
		(0, 20728,  2, 20, 0, 0, 0, 0), -- Eidolon XP Stone

		-- Sixth Row
		(0, 52901,  1, 20, 0, 0, 0, 0), -- Custom Furniture: Big Halloween Zephyrine Portrait
		(0, 41034,  4, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 46032, 50, 20, 0, 1, 0, 0), -- Mana Starstone
		(0, 41116,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 40501,  4, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern

		-- Seventh Row
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 62247,  2, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40985,  1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 46032, 55, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 46431,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Mixed Demon Delfonia
		(0, 40501,  5, 20, 0, 0, 0, 0)  -- Super Treasure Charm
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
