--
-- Paragon
-- Created by: Aeria Games, rates by Haruka Kasugano
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
		(0, 62780,  2, 30, 0, 0, 1, 0), -- Goddess of the Home Lucky Pack (Eidolon)
		(0, 40194, 10, 40, 0, 0, 1, 0), -- Fluorescent Bead
		(0, 40201,  1,  5, 0, 0, 1, 0), -- Brilliant Evolutionary Beads
		(0, 40081,  1, 10, 0, 0, 1, 0), -- Seven Day XP Crystal
		(0, 41011, 15, 10, 0, 0, 1, 0), -- Intermediate Mastery XP Book
		(0, 41554,  1,  5, 0, 0, 1, 0), -- Festival Elizabeth's Key Fragment

		-- Second Row
		(0, 45658,  2, 10, 0, 0, 1, 0), -- World Peace Organization VIP Guardian (Non-tradable)
		(0, 40459,  3, 10, 0, 0, 1, 0), -- 2-Star Eidolon Purification Scroll
		(0, 53555,  1, 10, 0, 0, 1, 0), -- Custom Head: Fox Hood (M)
		(0, 40532, 10, 50, 0, 0, 1, 0), -- Bouquet of Dreams
		(0, 40457,  3, 15, 0, 0, 1, 0), -- 1-Star Eidolon Purification Scroll
		(0, 20705,  1,  5, 0, 0, 1, 0), -- Godly Paced Flash (Non-Tradable)

		-- Third Row
		(0, 41094,  3, 40, 0, 0, 1, 0), -- Holy Spirit Stat Shuffle Stone I
		(0, 40647,  1,  5, 0, 0, 1, 0), -- 30th-Order Weapon Fortification
		(0, 41522,  3, 40, 0, 0, 1, 0), -- Emblem Restructuring Solution
		(0, 40397,  1,  5, 0, 0, 1, 0), -- 5-Star Weapon Fusion Stone
		(0, 45926,  2,  5, 0, 0, 1, 0), -- Summoning contract: Delfonia, the Demon Queen
		(0, 40987,  2,  5, 0, 0, 1, 0), -- Premium XP Card

		-- Fourth Row
		(0, 40637,  4, 10, 0, 0, 1, 0), -- Superior Accessory Fortification Scroll
		(0, 41065,  3, 30, 0, 0, 1, 0), -- Class Emblem Stat Shuffle Stone II
		(0, 53558,  1, 10, 0, 0, 1, 0), -- Custom Body: Sakura Witch (C)
		(0, 53564,  1, 10, 0, 0, 1, 0), -- Custom Body: New Year Fox Outfit (F)
		(0, 41039,  3, 30, 0, 0, 1, 0), -- Class Emblem Stat Shuffle Stone I
		(0, 40635,  4, 10, 0, 0, 1, 0), -- Superior Armor Fortification Scroll

		-- Fifth Row
		(0, 40996,  1,  5, 0, 0, 1, 0), -- Super XP Card
		(0, 45970,  1,  5, 0, 0, 1, 0), -- Summoning contract: Luciana, the Starwing
		(0, 40402,  1,  5, 0, 0, 1, 0), -- 5-Star Armor Fusion Stone
		(0, 41030,  5, 40, 0, 0, 1, 0), -- Superior Pet Improving Potion
		(0, 40663,  1,  5, 0, 0, 1, 0), -- 30th-Order Accessory Fortification
		(0, 41505,  3, 40, 0, 0, 1, 0), -- Holy Spirit Stat Shuffle Stone II

		-- Sixth Row
		(0, 46242,  1,  5, 0, 0, 1, 0), -- Fast-paced Stars (Non-tradable)
		(0, 40463,  2, 10, 0, 0, 1, 0), -- 4-Star Eidolon Purification Scroll
		(0, 40532, 10, 60, 0, 0, 1, 0), -- Bouquet of Dreams
		(0, 53552,  1, 10, 0, 0, 1, 0), -- Custom Body: Hooded Fox Robe (M)
		(0, 40461,  2, 10, 0, 0, 1, 0), -- 3-Star Eidolon Purification Scroll
		(0, 40438,  1,  5, 0, 0, 1, 0), -- Profession Guardian Sprite

		-- Seventh Row
		(0, 41550,  1,  5, 0, 0, 1, 0), -- Hestia's Key Fragment
		(0, 41032,  6, 20, 0, 0, 1, 0), -- Superior Secret Stone Randomizer
		(0, 31325,  3, 20, 0, 0, 1, 0), -- Super Rice Dumpling
		(0, 46032, 35, 25, 0, 0, 1, 0), -- Mana Starstone
		(0, 41034,  6, 20, 0, 0, 1, 0), -- Costume Attribution Potion
		(0, 62792,  2, 10, 0, 0, 1, 0)  -- Bloodthirsty Baroness Lucky Pack (Eidolon)
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
