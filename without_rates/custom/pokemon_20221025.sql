--
-- Paragon
-- Created by: Pokemon, rates by TODO
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
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40063,  1, 20, 0, 0, 0, 0), -- 5th-Order Weapon Fortification
		(0, 40954, 10, 20, 0, 1, 0, 0), -- Eidolon Lucky Pack (Non-tradable)
		(0, 40501,  2, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 45926,  1, 20, 0, 0, 0, 0), -- Summoning contract: Delfonia, the Demon Queen
		(0, 40925,  1, 20, 0, 0, 0, 0), -- Innocent Mount Stat Shuffle Stone

		-- Second Row
		(0, 40743,  1, 20, 0, 0, 0, 0), -- Mount Upgrade Stone
		(0, 40101, 10, 20, 0, 0, 0, 0), -- Small Fluorescent Bead
		(0, 21729,  1, 20, 0, 0, 0, 0), -- Unique Halloween Zephyrine
		(0, 20726,  5, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 11048, 50, 20, 0, 0, 0, 0), -- Pure Experience Crystal
		(0, 54742,  1, 20, 0, 0, 0, 0), -- Spectral Cat

		-- Third Row
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40065,  1, 20, 0, 0, 0, 0), -- 10th-Order Weapon Fortification
		(0, 40954, 20, 20, 0, 1, 0, 0), -- Eidolon Lucky Pack (Non-tradable)
		(0, 40194, 10, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 52356,  1, 20, 0, 0, 0, 0), -- Back: Tricky Spirit
		(0, 41030,  5, 20, 0, 0, 0, 0), -- Superior Pet Improving Potion

		-- Fourth Row
		(0, 52355,  1, 20, 0, 0, 0, 0), -- Back: Black Earl Spirit
		(0, 11048, 10, 20, 0, 0, 0, 0), -- Pure Experience Crystal
		(0, 18558,  1, 20, 0, 0, 0, 0), -- Unique White Pumpkin Kitty
		(0, 40240,  5, 20, 0, 1, 0, 0), -- XP Card
		(0, 40501, 10, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 20728,  1, 20, 0, 0, 0, 0), -- Eidolon XP Stone

		-- Fifth Row
		(0, 54742,  1, 20, 0, 0, 0, 0), -- Spectral Cat
		(0, 40197,  1, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 40954, 30, 20, 0, 1, 0, 0), -- Eidolon Lucky Pack (Non-tradable)
		(0, 41030,  5, 20, 0, 0, 0, 0), -- Superior Pet Improving Potion
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern
		(0, 20726,  5, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal

		-- Sixth Row
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 50478,  1, 20, 0, 0, 0, 0), -- Back: Ember Wyvern's Wings
		(0, 11048, 50, 20, 0, 0, 0, 0), -- Pure Experience Crystal
		(0, 41105,  1, 20, 0, 0, 0, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 41602,  3, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment

		-- Seventh Row
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 40194, 10, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 40954, 40, 20, 0, 1, 0, 0), -- Eidolon Lucky Pack (Non-tradable)
		(0, 40996,  1, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 11048, 10, 20, 0, 0, 0, 0), -- Pure Experience Crystal
		(0, 41032,  5, 20, 0, 0, 0, 0)  -- Superior Secret Stone Randomizer
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
