--
-- Paragon
-- Created by: Bruji Chan, rates by TODO
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
		(0, 40475,  1, 20, 0, 0, 0, 0), -- World Peace VIP Guardian
		(0, 45102,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (7 Days)
		(0, 55902,  1, 20, 0, 0, 0, 0), -- Head: Halloween Pumpkin Cat
		(0, 40996,  1, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 52902,  1, 20, 0, 0, 0, 0), -- Custom Furniture: Halloween Zephyrine Portrait
		(0, 46032, 15, 20, 0, 0, 0, 0), -- Mana Starstone

		-- Second Row
		(0, 46032, 15, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40633,  3, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 16534,  5, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40210,  1, 20, 0, 0, 0, 0), -- 20-Slot Backpack
		(0, 41521,  2, 20, 0, 0, 0, 0), -- Queen of Hearts' Key Fragment
		(0, 40782,  1, 20, 0, 0, 0, 0), -- Eidolon Oath Ring

		-- Third Row
		(0, 41470,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Inaba in Arms
		(0, 16534,  5, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 24037,  1, 20, 0, 0, 0, 0), -- Custom: Luxurious Halloween Table
		(0, 20726,  2, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40025,  1, 20, 0, 0, 0, 0), -- Advanced Lucky Card
		(0, 46032, 20, 20, 0, 0, 0, 0), -- Mana Starstone

		-- Fourth Row
		(0, 46032, 20, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40635,  3, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 16534,  5, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 62739,  3, 20, 0, 0, 0, 0), -- Queen of Wonderland Lucky Pack (Eidolon)
		(0, 40501,  2, 20, 0, 1, 0, 0), -- Super Treasure Charm
		(0, 53363,  1, 20, 0, 0, 0, 0), -- Back: Halloween Black Kitty Claw

		-- Fifth Row
		(0, 41634,  2, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 40081,  1, 20, 0, 0, 0, 0), -- Seven Day XP Crystal
		(0, 16534,  5, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 20726,  2, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 24039,  1, 20, 0, 0, 0, 0), -- Custom: Cute Bat Halloween Chair
		(0, 46032, 30, 20, 0, 0, 0, 0), -- Mana Starstone

		-- Sixth Row
		(0, 40475,  2, 20, 0, 0, 0, 0), -- World Peace VIP Guardian
		(0, 40637,  3, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 40501,  3, 20, 0, 1, 0, 0), -- Super Treasure Charm
		(0, 40029,  1, 20, 0, 0, 0, 0), -- Advanced XP Card
		(0, 62896,  2, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 20728,  1, 20, 0, 0, 0, 0), -- Eidolon XP Stone

		-- Seventh Row
		(0, 20728,  1, 20, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 41530,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Queen of Hearts in Arms
		(0, 40025,  1, 20, 0, 0, 0, 0), -- Advanced Lucky Card
		(0, 20726,  2, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40210,  1, 20, 0, 0, 0, 0), -- 20-Slot Backpack
		(0, 40079,  1, 20, 0, 0, 0, 0)  -- 24 Hour XP Crystal
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
