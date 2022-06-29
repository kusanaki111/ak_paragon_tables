--
-- Paragon
-- Created by: Brathahnchen, rates by Haruka Kasugano
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
		(0, 45593,  2, 10, 0, 0, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 40084,  1, 10, 0, 0, 0, 0), -- 200 Loyalty Points
		(0, 40067,  6,  5, 0, 0, 0, 0), -- 15th-Order Weapon Fortification
		(0, 17805,  1, 30, 0, 0, 0, 0), -- Crispy Cookie
		(0, 19658,  1, 40, 0, 0, 0, 0), -- Silky Mousse Cake
		(0, 20728,  2,  5, 0, 0, 0, 0), -- Eidolon XP Stone

		-- Second Row
		(0, 51376,  1, 10, 0, 1, 0, 0), -- Weapon: Golden Bananas
		(0, 49878,  1, 10, 0, 0, 0, 0), -- Fantasy Head: Maid's Hairband (F)
		(0, 40197,  5,  5, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 40175,  1,  5, 0, 0, 0, 0), -- 500 Loyalty Points
		(0, 21144,  5, 30, 0, 0, 0, 0), -- Intermediate Card Breakthrough Device (Non-Tradable)
		(0, 21841,  1, 40, 0, 0, 0, 0), -- Tropical Style Pear Flowery Tea

		-- Third Row
		(0, 22466,  1, 40, 0, 0, 0, 0), -- Ice Cream Fruit Cake
		(0, 54699,  1, 10, 0, 0, 0, 0), -- Fantasy Crepe Dining Car
		(0, 40645,  4,  5, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 46032, 20, 25, 0, 0, 0, 0), -- Mana Starstone
		(0, 41049,  5,  5, 0, 0, 0, 0), -- Eidolon Wishing Coin
		(0, 40770,  5, 15, 0, 0, 0, 0), -- Advanced Otter Feed

		-- Fourth Row
		(0, 10646,  1, 30, 0, 0, 0, 0), -- Sweet Powder
		(0, 20727,  2,  5, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 40647,  3,  5, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 53249,  1, 10, 0, 0, 0, 0), -- Back: Girly Afternoon Tea Party
		(0, 13807,  1, 40, 0, 0, 0, 0), -- Blizzard Berg Ice Cream
		(0, 21145,  5, 10, 0, 0, 0, 0), -- Advanced Card Breakthrough Device (Non-Tradable)

		-- Fifth Row
		(0, 41049, 10,  5, 0, 1, 0, 0), -- Eidolon Wishing Coin
		(0, 50392,  1, 10, 0, 0, 0, 0), -- Custom Body: Maid's Dress (F)
		(0, 40199,  5,  5, 0, 0, 0, 0), -- 20th-Order Armor Fortification
		(0, 53333,  1, 10, 0, 0, 0, 0), -- Custom Head: Young Butterfly Brooch (F)
		(0, 46032, 25, 40, 0, 0, 0, 0), -- Mana Starstone
		(0, 40711,  1, 30, 0, 0, 0, 0), -- Brilliant Evolutionary Beads Fragment

		-- Sixth Row
		(0, 51729,  1, 10, 0, 1, 0, 0), -- Custom Body: Winged Guard Suit (M)
		(0, 40216,  1,  5, 0, 0, 0, 0), -- 2000 Loyalty Points
		(0, 40653,  4,  5, 0, 0, 0, 0), -- 25th-Order Armor Fortification
		(0, 36066,  1, 40, 0, 0, 0, 0), -- Tanuki's Favorite Biscuit
		(0, 11045, 30, 30, 0, 0, 0, 0), -- Small Experience Crystal
		(0, 51838,  1, 10, 0, 0, 0, 0), -- Custom Head: Hades' Locks (M)

		-- Seventh Row
		(0, 11523,  2, 50, 0, 0, 0, 0), -- Dreamy Roasted Chicken
		(0, 46032, 50, 25, 0, 0, 0, 0), -- Mana Starstone
		(0, 40655,  3,  5, 0, 0, 0, 0), -- 30th-Order Armor Fortification
		(0, 40280,  1,  5, 0, 0, 0, 0), -- 5000 Loyalty Points
		(0, 52314,  1, 10, 0, 0, 0, 0), -- Custom Body: Tea Shop Maid Outfit (F)
		(0, 41049, 15,  5, 0, 0, 0, 0)  -- Eidolon Wishing Coin
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
