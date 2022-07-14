--
-- Paragon
-- Created by: Haruka Kasugano
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
		(0, 40289,  1,  5, 0, 1, 0, 0), -- Emerald Shard
		(0, 40953, 10, 30, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 50705,  1,  5, 0, 0, 1, 0), -- Cesela Swimwear Costume
		(0, 41034,  3, 25, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 50672,  1, 10, 0, 0, 1, 0), -- Custom Body: Swim Trunks (M)
		(0, 40925,  2, 25, 0, 0, 0, 0), -- Innocent Mount Stat Shuffle Stone

		-- Second Row
		(0, 52711,  1, 10, 0, 0, 1, 0), -- Custom Body: Colorful Summer Swimsuit (F)
		(0, 45095,  1, 10, 0, 0, 1, 0), -- Intermediate Treasure Charm (3 Days)
		(0, 16534, 20, 30, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 50703,  1, 10, 0, 0, 1, 0), -- Serena Swimwear Costume
		(0, 40289,  1, 10, 0, 1, 0, 0), -- Emerald Shard
		(0, 40740,  5, 30, 0, 0, 0, 0), -- Advanced Pet Improving Potion

		-- Third Row
		(0, 40501,  3, 30, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 40197,  1, 10, 0, 0, 1, 0), -- 20th-Order Weapon Fortification
		(0, 40289,  2, 15, 0, 1, 0, 0), -- Emerald Shard
		(0, 53276,  1, 15, 0, 0, 1, 0), -- Custom Body: Summer Breeze Swimsuit (C)
		(0, 40199,  1, 10, 0, 0, 1, 0), -- 20th-Order Armor Fortification
		(0, 40457,  2, 20, 0, 0, 1, 0), -- 1-Star Eidolon Purification Scroll

		-- Fourth Row
		(0, 40783,  5, 25, 0, 0, 0, 0), -- Advanced Mysterious Stone Remixed Potion
		(0, 40459,  2, 20, 0, 0, 1, 0), -- 2-Star Eidolon Purification Scroll
		(0, 40574,  1, 15, 0, 0, 1, 0), -- Lv.20 Accessory Blessing Scroll
		(0, 40289,  2, 10, 0, 1, 0, 0), -- Emerald Shard
		(0, 46032, 20, 25, 0, 0, 0, 0), -- Mana Starstone
		(0, 40934,  2,  5, 1, 0, 1, 0), -- Summer Alucard's Key Fragment

		-- Fifth Row
		(0, 40532,  5, 30, 0, 0, 0, 0), -- Bouquet of Dreams
		(0, 40289,  3, 10, 0, 1, 0, 0), -- Emerald Shard
		(0, 40936,  2,  5, 1, 0, 1, 0), -- Summer Nidhogg's Key Fragment
		(0, 20726,  5, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 45096,  1, 10, 0, 0, 1, 0), -- Advanced Treasure Charm (3 Days)
		(0, 40461,  2, 25, 0, 0, 1, 0), -- 3-Star Eidolon Purification Scroll

		-- Sixth Row
		(0, 50701,  1, 10, 1, 0, 1, 0), -- Kotonoha Swimwear Costume
		(0, 46032, 40, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41096,  3, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 40463,  2, 20, 0, 0, 1, 0), -- 4-Star Eidolon Purification Scroll
		(0, 41061,  1, 10, 1, 0, 1, 0), -- Summer Michaela's Key Fragment
		(0, 40289,  3, 20, 0, 1, 0, 0), -- Emerald Shard

		-- Seventh Row
		(0, 00000,  1,  5, 1, 0, 1, 1), -- Fantasy Lucky Star!
		(0, 41483,  1, 10, 1, 0, 1, 0), -- Summer Persephone's Key Fragment
		(0, 40756,  1, 10, 1, 0, 1, 0), -- Character Boost Card
		(0, 41105,  1, 40, 0, 0, 1, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 50713,  1, 15, 1, 0, 1, 0), -- Astraea Swimwear Costume
		(0, 40210,  1, 20, 0, 0, 1, 0)  -- 20-Slot Backpack
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
