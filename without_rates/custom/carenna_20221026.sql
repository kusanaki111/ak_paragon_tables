--
-- Paragon
-- Created by: carenna, rates by TODO
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
		(0, 41634,  2, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 40081,  1, 20, 0, 0, 0, 0), -- Seven Day XP Crystal
		(0, 53147,  1, 20, 0, 0, 0, 0), -- Back: Sailor Chubby Woof
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 62896,  3, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 41032,  3, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer

		-- Second Row
		(0, 45028,  2, 20, 0, 0, 0, 0), -- 15th-Order Weapon Fortification
		(0, 40633,  3, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 53684,  1, 20, 0, 0, 0, 0), -- Weapon: Playful Kitty Bell Whip
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 46032, 30, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40713,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (1 Day) (Non-tradable)

		-- Third Row
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 40635,  3, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 53614,  1, 20, 0, 0, 0, 0), -- Back: Nostalgic Carp Kite
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 41409,  3, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment

		-- Fourth Row
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40637,  3, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 53001,  1, 20, 0, 0, 0, 0), -- Back: Butler Little Yates
		(0, 40953, 30, 20, 0, 1, 0, 0), -- Eidolon Lucky Pack
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40857,  5, 20, 0, 0, 0, 0), -- Advanced Card Breakthrough Device

		-- Fifth Row
		(0, 41039,  3, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone I
		(0, 40645,  1, 20, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 53740,  1, 20, 0, 0, 0, 0), -- Custom Body: Percival's Dress (F)
		(0, 40691,  1, 20, 0, 0, 0, 0), -- Weapon Appearance Transfer Scroll
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 45098,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (3 Days)

		-- Sixth Row
		(0, 41065,  3, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone II
		(0, 40653,  1, 20, 0, 0, 0, 0), -- 25th-Order Armor Fortification
		(0, 53777,  1, 20, 0, 0, 0, 0), -- Weapon: Summer Captain Shark
		(0, 41013, 10, 20, 0, 1, 0, 0), -- Advanced Mastery XP Book
		(0, 46032, 50, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern

		-- Seventh Row
		(0, 41628,  2, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 53148,  1, 20, 0, 0, 0, 0), -- Back: Hipster Chubby Woof
		(0, 40953, 40, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 62884,  3, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 40857, 10, 20, 0, 0, 0, 0)  -- Advanced Card Breakthrough Device
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
