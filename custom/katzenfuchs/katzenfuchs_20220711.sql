--
-- Paragon
-- Created by: Katzenfuchs, rates by Haruka Kasugano
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
		(0, 40275,  1,  5, 0, 0, 0, 0), -- 1000 Loyalty Points
		(0, 11048,  5, 10, 0, 1, 0, 0), -- Pure Experience Crystal
		(0, 18563,  1, 20, 0, 0, 0, 0), -- Unique Civet Pet
		(0, 40953, 35, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40027,  1, 20, 0, 0, 0, 0), -- XP Card
		(0, 45063,  1, 25, 0, 0, 0, 0), -- 100 Ruby Coins

		-- Second Row
		(0, 40021,  1, 25, 0, 0, 0, 0), -- Advanced Treasure Charm
		(0, 41508,  2,  5, 0, 0, 0, 0), -- Rachel's Key Fragment
		(0, 40539, 10, 20, 0, 0, 0, 0), -- Bouquet of Dreams (Non-tradable)
		(0, 40101,  5, 20, 0, 0, 0, 0), -- Small Fluorescent Bead
		(0, 21662,  1, 20, 0, 0, 0, 0), -- Intermediate Eidolon Accessory Box (Holy Light)
		(0, 40475,  1, 10, 0, 0, 0, 0), -- World Peace VIP Guardian

		-- Third Row
		(0, 53504,  1, 15, 0, 0, 0, 0), -- Weapon: Military Officer Hansel Doll
		(0, 40737,  3, 25, 0, 0, 0, 0), -- Advanced Pet Improving Potion (Non-tradable)
		(0, 41521,  2,  5, 0, 0, 0, 0), -- Queen of Hearts' Key Fragment
		(0, 21661,  1, 20, 0, 0, 0, 0), -- Intermediate Eidolon Accessory Box (Lightning)
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 50664,  1, 15, 0, 0, 0, 0), -- Weapon: Black and White Kitty Claws

		-- Fourth Row
		(0, 40499,  1, 30, 0, 0, 0, 0), -- Premium Treasure Charm
		(0, 11048, 10, 15, 0, 1, 0, 0), -- Pure Experience Crystal
		(0, 21660,  1, 20, 0, 0, 0, 0), -- Intermediate Eidolon Accessory Box (Storm)
		(0, 41565,  2,  5, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 40029,  1, 20, 0, 0, 0, 0), -- Advanced XP Card
		(0, 40439,  1, 10, 0, 0, 0, 0), -- Profession Guardian Sprite (1 Day)

		-- Fifth Row
		(0, 46242,  1,  5, 0, 0, 0, 0), -- Fast-paced Stars (Non-tradable)
		(0, 21659,  1, 25, 0, 0, 0, 0), -- Intermediate Eidolon Accessory Box (Ice)
		(0, 40539, 10, 25, 0, 0, 0, 0), -- Bouquet of Dreams (Non-tradable)
		(0, 40737,  3, 30, 0, 0, 0, 0), -- Advanced Pet Improving Potion (Non-tradable)
		(0, 40773,  2,  5, 0, 0, 0, 0), -- Michaela's Key Fragment
		(0, 40292,  3, 10, 0, 0, 0, 0), -- Superior Monster XP Book

		-- Sixth Row
		(0, 21658,  1, 20, 0, 0, 0, 0), -- Intermediate Eidolon Accessory Box (Flame)
		(0, 41034,  5, 25, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 46032, 35, 25, 0, 0, 0, 0), -- Mana Starstone
		(0, 18560,  1, 20, 0, 0, 0, 0), -- Unique Pet Guardian Sprite
		(0, 20705,  1,  5, 0, 0, 0, 0), -- Godly Paced Flash (Non-Tradable)
		(0, 41100,  2,  5, 0, 0, 0, 0), -- Bastet's Key Fragment

		-- Seventh Row
		(0, 45067,  1,  5, 0, 0, 0, 0), -- 500 Ruby Coins
		(0, 11048, 15, 20, 0, 0, 0, 0), -- Pure Experience Crystal
		(0, 40194, 10, 30, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 40953, 35, 30, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40996,  1,  5, 0, 0, 0, 0), -- Super XP Card
		(0, 40084,  1, 10, 0, 0, 0, 0)  -- 200 Loyalty Points
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
