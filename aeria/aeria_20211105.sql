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
		(0, 45592,  2, 30, 0, 0, 1, 0), -- Fantasy Gift Voucher: 1 Point
		(0, 62615,  3, 15, 0, 0, 1, 0), -- Lethal Lover Lucky Pack (Eidolon)
		(0, 41477,  2,  5, 0, 0, 1, 0), -- Salome's Key Fragment
		(0, 40194,  5, 25, 0, 0, 1, 0), -- Fluorescent Bead
		(0, 52375,  1, 10, 0, 0, 1, 0), -- Custom Head: Oiran Shirayuki Hairstyle (F)
		(0, 40633,  5, 15, 0, 0, 1, 0), -- Superior Weapon Fortification Scroll

		-- Second Row
		(0, 40079,  2, 20, 0, 0, 1, 0), -- 24 Hour XP Crystal
		(0, 62556,  3, 10, 0, 0, 1, 0), -- Flower Fairy Lucky Pack (Eidolon)
		(0, 41447,  2,  5, 0, 0, 1, 0), -- Thumbelina's Key Fragment
		(0, 40027,  5, 40, 0, 0, 1, 0), -- XP Card
		(0, 40953, 10, 15, 0, 0, 1, 0), -- Eidolon Lucky Pack
		(0, 52971,  1, 10, 0, 0, 1, 0), -- Custom Head: Classy Fox Ears (M)

		-- Third Row
		(0, 53279,  1, 15, 0, 0, 1, 0), -- Custom Head: Summer Breeze Hairdo (C)
		(0, 62121,  3, 10, 0, 0, 1, 0), -- Wings of Happiness Lucky Pack (Eidolon)
		(0, 40893,  2,  5, 0, 0, 1, 0), -- Qingniao's Key Fragment
		(0, 40194, 10, 30, 0, 0, 1, 0), -- Fluorescent Bead
		(0, 40029,  4, 30, 0, 0, 1, 0), -- Advanced XP Card
		(0, 40635,  5, 10, 0, 0, 1, 0), -- Superior Armor Fortification Scroll

		-- Fourth Row
		(0, 45593,  4, 20, 0, 0, 1, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 62587,  3, 20, 0, 0, 1, 0), -- Healing Angel Lucky Pack (Eidolon)
		(0, 41455,  2,  5, 0, 0, 1, 0), -- Raphael's Key Fragment
		(0, 40439,  1, 10, 0, 0, 1, 0), -- Profession Guardian Sprite (1 Day)
		(0, 40953, 20, 25, 0, 0, 1, 0), -- Eidolon Lucky Pack
		(0, 52782,  1, 20, 0, 0, 1, 0), -- Custom Body: Incomparable Oiran Outfit (F)

		-- Fifth Row
		(0, 40475,  1, 10, 0, 0, 1, 0), -- World Peace VIP Guardian
		(0, 62256,  3, 20, 0, 0, 1, 0), -- New God's Messenger Lucky Pack (Eidolon)
		(0, 40813,  2,  5, 0, 0, 1, 0), -- Hermes' Key Fragment
		(0, 40194, 15, 30, 0, 0, 1, 0), -- Fluorescent Bead
		(0, 52576,  1, 15, 0, 0, 1, 0), -- Custom Body: Iwanaga-hime's Kimono (F)
		(0, 40637,  5, 20, 0, 0, 1, 0), -- Superior Accessory Fortification Scroll

		-- Sixt Row
		(0, 40987,  2, 10, 0, 0, 1, 0), -- Premium XP Card
		(0, 62383,  3, 25, 0, 0, 1, 0), -- Shiny Crystal Lucky Pack (Eidolon)
		(0, 41052,  2,  5, 0, 0, 1, 0), -- Kingyo-hime's Key Fragment
		(0, 40081,  1, 20, 0, 0, 1, 0), -- Seven Day XP Crystal
		(0, 40953, 30, 20, 0, 0, 1, 0), -- Eidolon Lucky Pack
		(0, 52804,  1, 20, 0, 0, 1, 0), -- Angelic Starlight Magic Carriage

		-- Seventh Row
		(0, 45594,  1,  5, 0, 0, 1, 0), -- Fantasy Gift Voucher: 100 Points
		(0, 62696,  2, 25, 0, 0, 1, 0), -- Archangel Lucky Pack (Eidolon)
		(0, 41508,  1,  5, 0, 0, 1, 0), -- Rachel's Key Fragment
		(0, 40194, 20, 35, 0, 0, 1, 0), -- Fluorescent Bead
		(0, 40996,  3, 10, 0, 0, 1, 0), -- Super XP Card
		(0, 46032, 10, 20, 0, 0, 1, 0)  -- Mana Starstone
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
