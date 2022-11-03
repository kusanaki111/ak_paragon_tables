--
-- Paragon
-- Created by: Vrexus, rates by TODO
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
		(0, 46835,  1, 20, 0, 0, 0, 0), -- Reincarnation: Pit Steed
		(0, 33520,  5, 20, 0, 0, 0, 0), -- Bag full of Prism Shards
		(0, 20726,  5, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 54744,  1, 20, 0, 0, 0, 0), -- Halloween Ghost King
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)

		-- Second Row
		(0, 46836,  1, 20, 0, 0, 0, 0), -- Reincarnation: Motorcycle
		(0, 41602,  7, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 24067,  1, 20, 0, 0, 0, 0), -- Custom Halloween Pumpkin Lantern
		(0, 16534, 15, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 61206,  2, 20, 0, 1, 0, 0), -- Unidentified Mount Stat Shuffle Stone
		(0, 52902,  1, 20, 0, 0, 0, 0), -- Custom Furniture: Halloween Zephyrine Portrait

		-- Third Row
		(0, 46837,  1, 20, 0, 0, 0, 0), -- Reincarnation: Phoenix Wings
		(0, 31731,  1, 20, 0, 0, 0, 0), -- Scary Pumpkin Candy Box
		(0, 20726,  7, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 41628,  1, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 32256,  3, 20, 0, 1, 0, 0), -- Green Halloween Candy
		(0, 62884,  3, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)

		-- Fourth Row
		(0, 46838,  1, 20, 0, 0, 0, 0), -- Reincarnation: Shiba Pup
		(0, 33520,  7, 20, 0, 0, 0, 0), -- Bag full of Prism Shards
		(0, 21729,  1, 20, 0, 0, 0, 0), -- Unique Halloween Zephyrine
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 40927,  1, 20, 0, 0, 0, 0), -- Shimmering Mount Stat Shuffle Stone
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment

		-- Fifth Row
		(0, 46839,  1, 20, 0, 0, 0, 0), -- Reincarnation: Phantom Wolf-Bot
		(0, 41602, 10, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 20726,  7, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 16534, 20, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 32255,  5, 20, 0, 1, 0, 0), -- Blue Halloween Candy
		(0, 22766,  1, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ

		-- Sixth Row
		(0, 46840,  1, 20, 0, 0, 0, 0), -- Reincarnation: Naughty Cute Tiger
		(0, 33520,  5, 20, 0, 0, 0, 0), -- Bag full of Prism Shards
		(0, 20974,  1, 20, 0, 0, 0, 0), -- Unique Halloween Zashi
		(0, 40501,  6, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41105,  2, 20, 0, 0, 0, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment

		-- Seventh Row
		(0, 46841,  1, 20, 0, 0, 0, 0), -- Reincarnation: Short-legged Corgi
		(0, 46032, 40, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 20726,  3, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 41634,  1, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 32254,  5, 20, 0, 0, 0, 0), -- Red Halloween Candy
		(0, 62896,  3, 20, 0, 0, 0, 0)  -- Deep Sea Diva Lucky Pack (Eidolon)
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
