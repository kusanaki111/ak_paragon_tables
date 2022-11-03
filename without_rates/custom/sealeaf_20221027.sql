--
-- Paragon
-- Created by: SeaLeaf, rates by TODO
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
		(0, 20726,  1, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 41634,  2, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 62896,  3, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 41495,  3, 20, 0, 0, 0, 0), -- Crystal Liberation Wheel I
		(0, 40457,  3, 20, 0, 0, 0, 0), -- 1-Star Eidolon Purification Scroll
		(0, 21408,  4, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)

		-- Second Row
		(0, 40953,  5, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40201,  1, 20, 0, 0, 0, 0), -- Brilliant Evolutionary Beads
		(0, 40661,  1, 20, 0, 0, 0, 0), -- 25th-Order Accessory Fortification
		(0, 40459,  3, 20, 0, 0, 0, 0), -- 2-Star Eidolon Purification Scroll
		(0, 41013,  5, 20, 0, 1, 0, 0), -- Advanced Mastery XP Book
		(0, 53330,  1, 20, 0, 0, 0, 0), -- Custom Body: Star School Uniform (F)

		-- Third Row
		(0, 40194, 10, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 20726,  2, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40461,  3, 20, 0, 0, 0, 0), -- 3-Star Eidolon Purification Scroll
		(0, 21408, 14, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)

		-- Fourth Row
		(0, 41403,  2, 20, 0, 0, 0, 0), -- SLv10 Refined DMG Chisel (Non-tradable)
		(0, 40782,  1, 20, 0, 0, 0, 0), -- Eidolon Oath Ring
		(0, 40653,  1, 20, 0, 0, 0, 0), -- 25th-Order Armor Fortification
		(0, 40463,  3, 20, 0, 0, 0, 0), -- 4-Star Eidolon Purification Scroll
		(0, 40215,  1, 20, 0, 1, 0, 0), -- 300 Loyalty Points
		(0, 20511,  3, 20, 0, 0, 0, 0), -- Heart of the Deep

		-- Fifth Row
		(0, 40532, 10, 20, 0, 0, 0, 0), -- Bouquet of Dreams
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 41032,  7, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 40638,  5, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll (Non-tradable)
		(0, 21408, 24, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)

		-- Sixth Row
		(0, 41396,  2, 20, 0, 0, 0, 0), -- SLv10 Refined DMG EVA Trowel (Non-tradable)
		(0, 41409,  3, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 40645,  1, 20, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 40636,  5, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll (Non-tradable)
		(0, 45593,  3, 20, 0, 1, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 54795,  1, 20, 0, 0, 0, 0), -- Cute Scooter with Stars

		-- Seventh Row
		(0, 46732,  1, 20, 0, 1, 0, 0), -- Summoning Contract: Jack-o-Lantern
		(0, 41628,  1, 20, 0, 1, 0, 0), -- Percival's Key Fragment
		(0, 62884,  2, 20, 0, 1, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 41034,  7, 20, 0, 1, 0, 0), -- Costume Attribution Potion
		(0, 40634,  5, 20, 0, 1, 0, 0), -- Superior Weapon Fortification Scroll (Non-tradable)
		(0, 21408, 44, 20, 0, 1, 0, 0)  -- Mana Starstone (Non-Tradable)
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
