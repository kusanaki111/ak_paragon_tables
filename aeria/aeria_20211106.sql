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
		(0, 40275,  1,  5, 0, 0, 1, 0), -- 1000 Loyalty Points
		(0, 62193,  2, 20, 0, 0, 1, 0), -- Brutal God of War Lucky Pack (Eidolon)
		(0, 41455,  1,  5, 0, 0, 1, 0), -- Raphael's Key Fragment
		(0, 40663,  1,  5, 0, 0, 1, 0), -- 30th-Order Accessory Fortification
		(0, 40081,  1, 20, 0, 0, 1, 0), -- Seven Day XP Crystal
		(0, 45592,  3, 45, 0, 0, 1, 0), -- Fantasy Gift Voucher: 1 Point

		-- Second Row
		(0, 40948,  2,  5, 0, 0, 1, 0), -- Tsukuyomi's Key Fragment
		(0, 62223,  2, 20, 0, 0, 1, 0), -- Nightland Lord Lucky Pack (Eidolon)
		(0, 52545,  1, 20, 0, 0, 1, 0), -- Custom Body: Andrea's Dress (F)
		(0, 41013, 10, 15, 0, 0, 1, 0), -- Advanced Mastery XP Book
		(0, 40027,  7, 35, 0, 0, 1, 0), -- XP Card
		(0, 20727,  1,  5, 0, 0, 1, 0), -- Eidolon XP Rainbow Crystal

		-- Third Row
		(0, 40653,  1,  5, 0, 0, 1, 0), -- 25th-Order Armor Fortification
		(0, 62397,  2, 20, 0, 0, 1, 0), -- Queen of the Underworld Lucky Pack (Eidolon)
		(0, 41057,  1,  5, 0, 0, 1, 0), -- Persephone's Key Fragment
		(0, 41034,  3, 35, 0, 0, 1, 0), -- Costume Attribution Potion
		(0, 40079,  1, 30, 0, 0, 1, 0), -- 24 Hour XP Crystal
		(0, 40645,  1,  5, 0, 0, 1, 0), -- 25th-Order Weapon Fortification

		-- Fourth Row
		(0, 40039, 10, 20, 0, 0, 1, 0), -- Auction Card
		(0, 18576,  1, 10, 0, 0, 1, 0), -- Unique Cheshire Cat
		(0, 40501,  3, 20, 0, 0, 1, 0), -- Super Treasure Charm
		(0, 40194, 10, 30, 0, 0, 1, 0), -- Fluorescent Bead
		(0, 20727,  3,  5, 0, 0, 1, 0), -- Eidolon XP Rainbow Crystal
		(0, 21664,  1, 15, 0, 0, 1, 0), -- Lv.80 Eidolon Accessory Collection Chest

		-- Fifth Row
		(0, 41034,  4, 25, 0, 0, 1, 0), -- Costume Attribution Potion
		(0, 31473,  1, 15, 0, 0, 1, 0), -- Mastery Gift Box III
		(0, 40029,  5, 25, 0, 0, 1, 0), -- Advanced XP Card
		(0, 62556,  2, 15, 0, 0, 1, 0), -- Flower Fairy Lucky Pack (Eidolon)
		(0, 41447,  1,  5, 0, 0, 1, 0), -- Thumbelina's Key Fragment
		(0, 52542,  1, 15, 0, 0, 1, 0), -- Custom Head: Andrea's Hairdo (F)

		-- Sixth Row
		(0, 45592,  3, 40, 0, 0, 1, 0), -- Fantasy Gift Voucher: 1 Point
		(0, 40655,  1,  5, 0, 0, 1, 0), -- 30th-Order Armor Fortification
		(0, 41412,  2,  5, 0, 0, 1, 0), -- Orochi's Key Fragment
		(0, 62470,  2, 20, 0, 0, 1, 0), -- Serpent God Lucky Pack (Eidolon)
		(0, 40647,  1,  5, 0, 0, 1, 0), -- 30th-Order Weapon Fortification
		(0, 41032,  7, 25, 0, 0, 1, 0), -- Superior Secret Stone Randomizer

		-- Seventh Row
		(0, 40194, 15, 20, 0, 0, 1, 0), -- Fluorescent Bead
		(0, 40574,  2,  5, 0, 0, 1, 0), -- Lv.20 Accessory Blessing Scroll
		(0, 41030,  5, 30, 0, 0, 1, 0), -- Superior Pet Improving Potion
		(0, 62438,  2, 20, 0, 0, 1, 0), -- Cat Protector Lucky Pack (Eidolon)
		(0, 41100,  1,  5, 0, 0, 1, 0), -- Bastet's Key Fragment
		(0, 41013, 15, 20, 0, 0, 1, 0)  -- Advanced Mastery XP Book
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
