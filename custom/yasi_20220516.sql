--
-- Paragon
-- Created by: Yasi, rates by Haruka Kasugano
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
		(0, 54730,   1,  5, 0, 0, 0, 0), -- Hansel and Gretel Fairytale
		(0, 62285,   3, 20, 0, 0, 0, 0), -- New Gruesome Twosome Lucky Pack (Eidolon)
		(0, 46032,  30, 35, 0, 0, 0, 0), -- Mana Starstone
		(0, 16534,  25, 10, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40390,   3,  5, 0, 0, 0, 0), -- Hansel and Gretel's Key Fragment
		(0, 40001,  15, 25, 0, 0, 0, 0), -- Healing Potion

		-- Second Row
		(0, 52798,   1, 10, 0, 0, 0, 0), -- Custom Body: Wonderland Fairy Deer Dress (F)
		(0, 62280,   3, 20, 0, 0, 0, 0), -- New Tea Party Queen Lucky Pack (Eidolon)
		(0, 13519,   1, 20, 0, 0, 0, 0), -- Mastery Gift Box
		(0, 40501,   5, 20, 0, 1, 0, 0), -- Super Treasure Charm
		(0, 40590,   3,  5, 0, 0, 0, 0), -- Alice's Key Fragment
		(0, 41032,   5, 25, 0, 0, 0, 0), -- Superior Secret Stone Randomizer

		-- Third Row
		(0, 52801,   1, 10, 0, 0, 0, 0), -- Custom Head: Wonderland Fairy Deer Veil (F)
		(0, 62271,   3, 20, 0, 0, 0, 0), -- New Snow Princess Lucky Pack (Eidolon)
		(0, 46032,  60, 30, 0, 0, 0, 0), -- Mana Starstone
		(0, 45594,   1,  5, 0, 0, 0, 0), -- Fantasy Gift Voucher: 100 Points
		(0, 40715,   3,  5, 0, 0, 0, 0), -- Lumikki's Key Fragment
		(0, 41096,   5, 30, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution

		-- Fourth Row
		(0, 54729,   1, 10, 0, 0, 0, 0), -- The Little Mermaid Fairytale
		(0, 62267,   2, 20, 0, 0, 0, 0), -- New Azure Secret Stone Sprite Lucky Pack (Eidolon)
		(0, 15359,   1, 30, 0, 0, 0, 0), -- Mastery Gift Box II
		(0, 45098,   1,  5, 0, 0, 0, 0), -- Super Treasure Charm (3 Days)
		(0, 40752,   2,  5, 0, 0, 0, 0), -- Undine's Key Fragment
		(0, 41094,   3, 30, 0, 0, 0, 0), -- Holy Spirit Stat Shuffle Stone I

		-- Fifth Row
		(0, 21953,   1, 20, 0, 0, 0, 0), -- Unique Thumbelina
		(0, 62556,   2, 20, 0, 0, 0, 0), -- Flower Fairy Lucky Pack (Eidolon)
		(0, 46032,  90, 15, 0, 0, 0, 0), -- Mana Starstone
		(0, 16534,  50, 15, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 41447,   2,  5, 0, 0, 0, 0), -- Thumbelina's Key Fragment
		(0, 41505,   3, 25, 0, 0, 0, 0), -- Holy Spirit Stat Shuffle Stone II

		-- Sixt Row
		(0, 53096,   1, 10, 0, 0, 0, 0), -- Custom Furniture: Thumbelina Portrait
		(0, 62839,   2, 20, 0, 0, 0, 0), -- Crescent Maiden Lucky Pack (Eidolon)
		(0, 31473,   1, 20, 0, 0, 0, 0), -- Mastery Gift Box III
		(0, 40501,  10, 20, 0, 1, 0, 0), -- Super Treasure Charm
		(0, 41565,   1,  5, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 41030,   5, 25, 0, 0, 0, 0), -- Superior Pet Improving Potion

		-- Seventh Row
		(0, 45860,   1,  5, 0, 0, 0, 0), -- Summoning contract: Von, the Frozen Sorcerer
		(0, 20728,   1,  5, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 46032, 120, 10, 0, 0, 0, 0), -- Mana Starstone
		(0, 45594,   1,  5, 0, 0, 0, 0), -- Fantasy Gift Voucher: 100 Points
		(0, 20727,   2,  5, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 41034,   5, 70, 0, 0, 0, 0)  -- Costume Attribution Potion
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
