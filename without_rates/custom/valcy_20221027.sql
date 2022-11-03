--
-- Paragon
-- Created by: Valcy, rates by TODO
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
		(0, 41634,  1, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 40475,  1, 20, 0, 0, 0, 0), -- World Peace VIP Guardian
		(0, 40574,  2, 20, 0, 0, 0, 0), -- Lv.20 Accessory Blessing Scroll
		(0, 62896,  3, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 40953, 30, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 20511, 10, 20, 0, 0, 0, 0), -- Heart of the Deep

		-- Second Row
		(0, 41470,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Inaba in Arms
		(0, 41034, 10, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 40663,  1, 20, 0, 0, 0, 0), -- 30th-Order Accessory Fortification
		(0, 46032, 50, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40367,  1, 20, 0, 0, 0, 0), -- 5-Star Equipment Fusion Stone
		(0, 41505, 10, 20, 0, 0, 0, 0), -- Holy Spirit Stat Shuffle Stone II

		-- Third Row
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40194, 15, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 40199,  2, 20, 0, 0, 0, 0), -- 20th-Order Armor Fortification
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40953, 45, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40987,  5, 20, 0, 0, 0, 0), -- Premium XP Card

		-- Fourth Row
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern
		(0, 41409, 15, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 40655,  1, 20, 0, 0, 0, 0), -- 30th-Order Armor Fortification
		(0, 40201,  1, 20, 0, 0, 0, 0), -- Brilliant Evolutionary Beads
		(0, 20731,  1, 20, 0, 0, 0, 0), -- Eidolon XP Stone (Non-tradable)
		(0, 40081,  1, 20, 0, 0, 0, 0), -- Seven Day XP Crystal

		-- Fifth Row
		(0, 41116,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 40501, 10, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 40197,  2, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 40953, 60, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40996,  3, 20, 0, 0, 0, 0), -- Super XP Card

		-- Sixth Row
		(0, 62841,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer Lucky Pack (Non-tradable)
		(0, 40782,  1, 20, 0, 0, 0, 0), -- Eidolon Oath Ring
		(0, 40647,  1, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 41409, 20, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 40366,  1, 20, 0, 0, 0, 0), -- 4-Star Equipment Fusion Stone
		(0, 40210,  1, 20, 0, 0, 0, 0), -- 20-Slot Backpack

		-- Seventh Row
		(0, 41628,  1, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 40194, 25, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 46729,  1, 20, 0, 0, 0, 0), -- Halloween Panel 5
		(0, 62884,  3, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 40953, 80, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 22766,  1, 20, 0, 0, 0, 0)  -- ＴＲＩＣＫ
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
