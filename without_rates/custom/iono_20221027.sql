--
-- Paragon
-- Created by: iono, rates by TODO
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
		(0, 46032, 24, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40788,  1, 20, 0, 0, 0, 0), -- Swifty Stars (Non-tradable)
		(0, 40197,  1, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 40021,  4, 20, 0, 0, 0, 0), -- Advanced Treasure Charm
		(0, 40985,  1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment

		-- Second Row
		(0, 22616,  1, 20, 0, 0, 0, 0), -- Unique Percival
		(0, 40853, 10, 20, 0, 0, 0, 0), -- Basic Card Breakthrough Device
		(0, 16534, 15, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 41013, 10, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book
		(0, 31710,  1, 20, 0, 0, 0, 0), -- Ten Swell's Handmade Necklace
		(0, 40987,  2, 20, 0, 0, 0, 0), -- Premium XP Card

		-- Third Row
		(0, 46032, 32, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 62896,  3, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 20707,  1, 20, 0, 0, 0, 0), -- Breezy Step (Non-Tradable)
		(0, 40637,  3, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 45066,  1, 20, 0, 0, 0, 0), -- 200 Ruby Coins (Non-tradable)
		(0, 41634,  1, 20, 0, 0, 0, 0), -- Siren's Key Fragment

		-- Fourth Row
		(0, 53364,  1, 20, 0, 0, 0, 0), -- Back: Halloween White Kitty Claw
		(0, 40855, 10, 20, 0, 0, 0, 0), -- Intermediate Card Breakthrough Device
		(0, 16534, 15, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 41032,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 22766,  2, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ
		(0, 40996,  1, 20, 0, 0, 0, 0), -- Super XP Card

		-- Fifth Row
		(0, 46032, 48, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 20706,  1, 20, 0, 0, 0, 0), -- Zephyr Step (Non-Tradable)
		(0, 40635,  3, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40499,  4, 20, 0, 1, 0, 0), -- Premium Treasure Charm
		(0, 41116,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment

		-- Sixth Row
		(0, 54779,  1, 20, 0, 0, 0, 0), -- Magic Star Pumpkin Train
		(0, 40857, 10, 20, 0, 0, 0, 0), -- Advanced Card Breakthrough Device
		(0, 16534, 15, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 33520,  7, 20, 0, 0, 0, 0), -- Bag full of Prism Shards
		(0, 20511,  3, 20, 0, 0, 0, 0), -- Heart of the Deep

		-- Seventh Row
		(0, 46032, 64, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 62884,  2, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 20705,  1, 20, 0, 0, 0, 0), -- Godly Paced Flash (Non-Tradable)
		(0, 40633,  3, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 40501,  3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41628,  1, 20, 0, 0, 0, 0)  -- Percival's Key Fragment
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
