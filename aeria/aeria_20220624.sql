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
		(0, 40001,  15, 20, 0, 0, 1, 0), -- Healing Potion
		(0, 40839,   1,  5, 0, 0, 1, 0), -- Succubus' Key Fragment
		(0, 40003,   1, 20, 0, 0, 1, 0), -- 5-Slot Backpack
		(0, 50305,   1, 10, 0, 0, 1, 0), -- Weapon: Evil Dragon Dark Lock Shield
		(0, 40009,   5, 20, 0, 0, 1, 0), -- Megaphone
		(0, 40017,   5, 25, 0, 0, 1, 0), -- Treasure Charm

		-- Second Row
		(0, 40031,   7, 25, 0, 0, 1, 0), -- Quest XP Book
		(0, 41070,   1,  5, 0, 0, 1, 0), -- Otohime's Key Fragment
		(0, 40029,   4, 25, 0, 0, 1, 0), -- Advanced XP Card
		(0, 53371,   1, 10, 0, 0, 1, 0), -- Pretty Lady Civet
		(0, 21408, 100,  5, 0, 0, 1, 0), -- Mana Starstone (Non-Tradable)
		(0, 40027,   4, 30, 0, 0, 1, 0), -- XP Card

		-- Third Row
		(0, 40025,   4, 25, 0, 0, 1, 0), -- Advanced Lucky Card
		(0, 41052,   1,  5, 0, 0, 1, 0), -- Kingyo-hime's Key Fragment
		(0, 40023,   4, 30, 0, 0, 1, 0), -- Lucky Card
		(0, 53567,   1, 10, 0, 0, 1, 0), -- Custom Head: Shimmering Fox Hairpin (F)
		(0, 40210,   1,  5, 0, 0, 1, 0), -- 20-Slot Backpack
		(0, 40021,   3, 25, 0, 0, 1, 0), -- Advanced Treasure Charm

		-- Fourth Row
		(0, 40035,   6, 20, 0, 0, 1, 0), -- Feather of Revival
		(0, 41048,   1,  5, 0, 0, 1, 0), -- Skuld's Key Fragment
		(0, 40037,  10, 30, 0, 0, 1, 0), -- Warehouse Card
		(0, 53564,   1, 10, 0, 0, 1, 0), -- Custom Body: New Year Fox Outfit (F)
		(0, 21408, 100,  5, 0, 0, 1, 0), -- Mana Starstone (Non-Tradable)
		(0, 40039,  10, 30, 0, 0, 1, 0), -- Auction Card

		-- Fifth Row
		(0, 40043,  10, 30, 0, 0, 1, 0), -- Grocery Store Card
		(0, 41046,   1,  5, 0, 0, 1, 0), -- Urd's Key Fragment
		(0, 40047,  10, 30, 0, 0, 1, 0), -- Portal Card
		(0, 53372,   1, 10, 0, 0, 1, 0), -- Noble Civet
		(0, 40201,   1,  5, 0, 0, 1, 0), -- Brilliant Evolutionary Beads
		(0, 45794,   2, 20, 0, 0, 1, 0), -- 100 Valor Coins

		-- Sixth Row
		(0, 40053,   3, 25, 0, 0, 1, 0), -- Advanced Weapon Fortification Scroll
		(0, 40932,   1,  5, 0, 0, 1, 0), -- Ares' Key Fragment
		(0, 40055,   3, 25, 0, 0, 1, 0), -- Advanced Armor Fortification Scroll
		(0, 52865,   1, 10, 0, 0, 1, 0), -- Back: Tinted Blackink Wings
		(0, 21408, 100, 10, 0, 0, 1, 0), -- Mana Starstone (Non-Tradable)
		(0, 40519,   3, 25, 0, 0, 1, 0), -- Advanced Accessory Fortification Scroll

		-- Seventh Row
		(0, 40021,   2, 30, 0, 0, 1, 0), -- Advanced Treasure Charm
		(0, 40930,   1,  5, 0, 0, 1, 0), -- Sif's Key Fragment
		(0, 40499,   1, 20, 0, 0, 1, 0), -- Premium Treasure Charm
		(0, 53617,   1, 10, 0, 0, 1, 0), -- Dazzling Tanuki in Alucard's Clothes
		(0, 53320,   1, 10, 0, 0, 1, 0), -- Nidhogg's Oath Certificate
		(0, 41034,   3, 25, 0, 0, 1, 0)  -- Costume Attribution Potion
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
