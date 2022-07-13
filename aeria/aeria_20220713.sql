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
		(0, 40019,  7, 30, 0, 0, 0, 0), -- Intermediate Treasure Charm
		(0, 62383,  3, 10, 0, 0, 0, 0), -- Shiny Crystal Lucky Pack (Eidolon)
		(0, 40023, 10, 20, 0, 0, 0, 0), -- Lucky Card
		(0, 40475,  2, 10, 0, 0, 0, 0), -- World Peace VIP Guardian
		(0, 62422,  3, 10, 0, 0, 0, 0), -- Ocean Goddess Lucky Pack (Eidolon)
		(0, 40084,  1, 20, 0, 0, 0, 0), -- 200 Loyalty Points

		-- Second Row
		(0, 40953,  7, 35, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 45926,  1,  5, 0, 0, 0, 0), -- Summoning contract: Delfonia, the Demon Queen
		(0, 40637,  4, 25, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 40525,  2, 10, 0, 0, 0, 0), -- Lv.15 Accessory Fortification
		(0, 45982,  1,  5, 0, 0, 0, 0), -- Summoning contract: Isai, the Divine Descendant
		(0, 20726,  2, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal

		-- Third Row
		(0, 40021,  5, 30, 0, 0, 0, 0), -- Advanced Treasure Charm
		(0, 53548,  1, 10, 0, 0, 0, 0), -- Back: Blue Cherry Blossom Wings
		(0, 40025, 10, 25, 0, 0, 0, 0), -- Advanced Lucky Card
		(0, 45658,  2, 10, 0, 0, 0, 0), -- World Peace Organization VIP Guardian (Non-tradable)
		(0, 53257,  1, 10, 0, 0, 0, 0), -- Back: Dreamy Draped Sprite Wings
		(0, 40215,  1, 15, 0, 0, 0, 0), -- 300 Loyalty Points

		-- Fourth Row
		(0, 40953, 14, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 53593,  1, 10, 0, 0, 0, 0), -- Weapon: Lucky Kitty Ear Flower Board
		(0, 40635,  5, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40073,  2, 15, 0, 0, 0, 0), -- 15th-Order Armor Fortification
		(0, 53594,  1, 10, 0, 0, 0, 0), -- Weapon: Festive Kitty Ear Flower Board
		(0, 20726,  3, 25, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal

		-- Fifth Row
		(0, 40499,  3, 25, 0, 0, 0, 0), -- Premium Treasure Charm
		(0, 54787,  1, 10, 0, 0, 0, 0), -- Feathered Corgi
		(0, 40027, 10, 25, 0, 0, 0, 0), -- XP Card
		(0, 40987,  2, 10, 0, 0, 0, 0), -- Premium XP Card
		(0, 54786,  1, 10, 0, 0, 0, 0), -- Winged Corgi
		(0, 40289,  5, 20, 0, 1, 0, 0), -- Emerald Shard

		-- Sixth Row
		(0, 40953, 21, 30, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 41565,  2,  5, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 40633,  6, 25, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 40067,  2, 15, 0, 0, 0, 0), -- 15th-Order Weapon Fortification
		(0, 41554,  2,  5, 0, 0, 0, 0), -- Festival Elizabeth's Key Fragment
		(0, 20726,  4, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal

		-- Seventh Row
		(0, 40501,  3, 25, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 62839,  3, 10, 0, 0, 0, 0), -- Crescent Maiden Lucky Pack (Eidolon)
		(0, 40029, 10, 30, 0, 0, 0, 0), -- Advanced XP Card
		(0, 40996,  2, 15, 0, 0, 0, 0), -- Super XP Card
		(0, 62792,  4, 10, 0, 0, 0, 0), -- Bloodthirsty Baroness Lucky Pack (Eidolon)
		(0, 40175,  1, 10, 0, 0, 0, 0)  -- 500 Loyalty Points
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
