--
-- Paragon
-- Created by: Tript, rates by Haruka Kasugano
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
		(0, 40201,  1,  5, 0, 0, 0, 0), -- Brilliant Evolutionary Beads
		(0, 53493,  1, 15, 0, 0, 0, 0), -- Body: Winter Sports Outfit (M)
		(0, 41105,  1, 10, 0, 0, 0, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 40927,  3,  5, 0, 0, 0, 0), -- Shimmering Mount Stat Shuffle Stone
		(0, 40035,  5, 35, 0, 0, 0, 0), -- Feather of Revival
		(0, 46032, 10, 30, 0, 0, 0, 0), -- Mana Starstone

		-- Second Row
		(0, 40713,  2,  5, 0, 0, 0, 0), -- Super Treasure Charm (1 Day) (Non-tradable)
		(0, 53473,  1, 10, 0, 0, 0, 0), -- Custom Head: Winter Crown (F)
		(0, 41238,  2, 10, 0, 0, 0, 0), -- SLv10 Refined DMG DEF Trowel
		(0, 40653,  1,  5, 0, 0, 0, 0), -- 25th-Order Armor Fortification
		(0, 40655,  1,  5, 0, 0, 0, 0), -- 30th-Order Armor Fortification
		(0, 46032, 10, 65, 0, 0, 0, 0), -- Mana Starstone

		-- Third Row
		(0, 40782,  2,  5, 0, 0, 0, 0), -- Eidolon Oath Ring
		(0, 40645,  1,  5, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 40637,  3, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 40633,  3, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 40635,  3, 25, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 46032, 10, 25, 0, 0, 0, 0), -- Mana Starstone

		-- Fourth Row
		(0, 40637,  5, 25, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 41238,  2, 20, 0, 0, 0, 0), -- SLv10 Refined DMG DEF Trowel
		(0, 40661,  1,  5, 0, 0, 0, 0), -- 25th-Order Accessory Fortification
		(0, 40647,  1,  5, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 40633,  5, 25, 0, 1, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 46032, 10, 20, 0, 0, 0, 0), -- Mana Starstone

		-- Fifth Row
		(0, 41105,  2, 10, 0, 0, 0, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 40663,  1,  5, 0, 0, 0, 0), -- 30th-Order Accessory Fortification
		(0, 21664,  1, 30, 0, 0, 0, 0), -- Lv.80 Eidolon Accessory Collection Chest
		(0, 40035, 10, 20, 0, 0, 0, 0), -- Feather of Revival
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 40927,  2, 15, 0, 0, 0, 0), -- Shimmering Mount Stat Shuffle Stone

		-- Sixth Row
		(0, 40635,  3, 15, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40633,  5, 15, 0, 1, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41105,  1, 10, 0, 0, 0, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 21664,  2, 25, 0, 0, 0, 0), -- Lv.80 Eidolon Accessory Collection Chest
		(0, 40927,  1, 15, 0, 0, 0, 0), -- Shimmering Mount Stat Shuffle Stone

		-- Seventh Row
		(0, 41565,  1,  5, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 40633,  5, 15, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 62839,  2, 15, 0, 0, 0, 0), -- Crescent Maiden Lucky Pack (Eidolon)
		(0, 41246,  3, 30, 0, 0, 0, 0), -- SLv10 Refined DMG Chisel
		(0, 41530,  1,  5, 0, 0, 0, 0), -- Anima Crystal: Queen of Hearts in Arms
		(0, 41239,  3, 30, 0, 0, 0, 0)  -- SLv10 Refined DMG EVA Trowel
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
