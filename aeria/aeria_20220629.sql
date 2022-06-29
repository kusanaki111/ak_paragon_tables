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
		(0, 40003,  1, 15, 0, 0, 0, 0), -- 5-Slot Backpack
		(0, 53512,  1, 10, 0, 0, 0, 0), -- Custom Body: Trendy Leather Coat (F)
		(0, 40887,  1,  5, 0, 0, 0, 0), -- Nidhogg's Key Fragment
		(0, 60695,  3, 20, 0, 0, 0, 0), -- Cyberkitty Headphones Lucky Pack (Head)
		(0, 40009,  5, 25, 0, 0, 0, 0), -- Megaphone
		(0, 40001, 20, 25, 0, 0, 0, 0), -- Healing Potion

		-- Second Row
		(0, 52873,  1, 10, 0, 0, 0, 0), -- Custom Body: Genuine Sailor Fantasy (F)
		(0, 45216,  1, 10, 0, 0, 0, 0), -- Guardian Sprite of Gaia (1 Day)
		(0, 40023,  5, 20, 0, 0, 0, 0), -- Lucky Card
		(0, 40027,  5, 20, 0, 0, 0, 0), -- XP Card
		(0, 46243,  6, 20, 0, 0, 0, 0), -- Summoning contract: Aqua-Dragon Queen Lianne Riverwalker
		(0, 41207,  5, 20, 0, 0, 0, 0), -- Lv80 Refined DMG HP Trowel

		-- Third Row
		(0, 50153,  2, 10, 0, 0, 0, 0), -- Back: Pandemonium Cross
		(0, 40025,  5, 30, 0, 0, 0, 0), -- Advanced Lucky Card
		(0, 50873,  2, 10, 0, 0, 0, 0), -- Custom Body: Magic Maiden (F)
		(0, 40029,  5, 30, 0, 0, 0, 0), -- Advanced XP Card
		(0, 40691,  1,  5, 0, 0, 0, 0), -- Weapon Appearance Transfer Scroll
		(0, 16534, 15, 15, 0, 0, 0, 0), -- Dazzling Experience Crystal

		-- Fourth Row
		(0, 62275,  3, 15, 0, 0, 0, 0), -- New Dark Angel Lucky Pack (Eidolon)
		(0, 40439,  2, 10, 0, 0, 0, 0), -- Profession Guardian Sprite (1 Day)
		(0, 41039,  3, 25, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone I
		(0, 14855,  1, 10, 0, 0, 0, 0), -- Lv.70 Legendary Weapon Enchantment Card: Move SPD
		(0, 24937,  4, 25, 0, 0, 0, 0), -- Spa Bath
		(0, 62269,  3, 15, 0, 0, 0, 0), -- New Midnight Witch Lucky Pack (Eidolon)

		-- Fifth Row
		(0, 41028,  2,  5, 0, 0, 0, 0), -- Iwanaga-hime's Key Fragment
		(0, 62792,  2, 15, 0, 0, 0, 0), -- Bloodthirsty Baroness Lucky Pack (Eidolon)
		(0, 40031, 10, 20, 0, 0, 0, 0), -- Quest XP Book
		(0, 52961,  1, 20, 0, 0, 0, 0), -- Back: Choco Strawberry Dessert Rabbit
		(0, 41505,  3, 20, 0, 0, 0, 0), -- Holy Spirit Stat Shuffle Stone II
		(0, 20726,  2, 20, 0, 1, 0, 0), -- Gorgeous Eidolons XP Crystal

		-- Sixth Row
		(0, 40035, 15, 35, 0, 0, 0, 0), -- Feather of Revival
		(0, 45658,  2, 10, 0, 0, 0, 0), -- World Peace Organization VIP Guardian (Non-tradable)
		(0, 40574,  2,  5, 0, 0, 0, 0), -- Lv.20 Accessory Blessing Scroll
		(0, 20511,  3, 35, 0, 0, 0, 0), -- Heart of the Deep
		(0, 53069,  2, 10, 0, 0, 0, 0), -- Custom Body: Sakura Ninja (F)
		(0, 41438,  2,  5, 0, 0, 0, 0), -- Festival Succubus' Key Fragment

		-- Seventh Row
		(0, 40501,  2, 30, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41521,  2,  5, 0, 0, 0, 0), -- Queen of Hearts' Key Fragment
		(0, 41034,  4, 25, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 53420,  3, 10, 0, 0, 0, 0), -- Back: Rachel's Crystal Wings
		(0, 46264,  1,  5, 0, 0, 0, 0), -- Summoning contract: Sky Dragon King Flokja
		(0, 41032,  6, 25, 0, 0, 0, 0)  -- Superior Secret Stone Randomizer
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
