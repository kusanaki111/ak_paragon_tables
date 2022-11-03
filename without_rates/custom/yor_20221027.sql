--
-- Paragon
-- Created by: Yor, rates by TODO
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
		(0, 16018,   1, 20, 0, 1, 0, 0), -- Wise Man Nanook
		(0, 40635,   5, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 41105,   4, 20, 0, 1, 0, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 40788,   1, 20, 0, 0, 0, 0), -- Swifty Stars (Non-tradable)
		(0, 40953,   6, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 16014,   1, 20, 0, 1, 0, 0), -- Master of Fear Alfred

		-- Second Row
		(0, 41013,   9, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book
		(0, 22766,   4, 20, 0, 1, 0, 0), -- ＴＲＩＣＫ
		(0, 45594,   1, 20, 0, 0, 0, 0), -- Fantasy Gift Voucher: 100 Points
		(0, 40531,   3, 20, 0, 1, 0, 0), -- Bouquet of Roses (Non-tradable)
		(0, 45067,   1, 20, 0, 0, 0, 0), -- 500 Ruby Coins
		(0, 52356,   1, 20, 0, 0, 0, 0), -- Back: Tricky Spirit

		-- Third Row
		(0, 41116,   1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 40637,   5, 20, 0, 1, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 41557,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Elizabeth in Arms
		(0, 15087,   3, 20, 0, 1, 0, 0), -- Poseidon's Crystal
		(0, 45102,   1, 20, 0, 0, 0, 0), -- Super Treasure Charm (7 Days)
		(0, 62896,   2, 20, 0, 1, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)

		-- Fourth Row
		(0, 46032, 100, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40081,   1, 20, 0, 0, 0, 0), -- Seven Day XP Crystal
		(0, 40743,   3, 20, 0, 1, 0, 0), -- Mount Upgrade Stone
		(0, 22766,   3, 20, 0, 1, 0, 0), -- ＴＲＩＣＫ
		(0, 41495,   6, 20, 0, 1, 0, 0), -- Crystal Liberation Wheel I
		(0, 53330,   1, 20, 0, 0, 0, 0), -- Custom Body: Star School Uniform (F)

		-- Fifth Row
		(0, 41034,  10, 20, 0, 1, 0, 0), -- Costume Attribution Potion
		(0, 40633,   5, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 45925,   1, 20, 0, 0, 0, 0), -- Summoning contract: Yahrune, the Western Knight Leader
		(0, 40532,  25, 20, 0, 1, 0, 0), -- Bouquet of Dreams
		(0, 45098,   1, 20, 0, 0, 0, 0), -- Super Treasure Charm (3 Days)
		(0, 41094,   5, 20, 0, 1, 0, 0), -- Holy Spirit Stat Shuffle Stone I

		-- Sixth Row
		(0, 40985,   1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 41497,   4, 20, 0, 0, 0, 0), -- Crystal Purification Scroll I (Non-Tradable)
		(0, 45658,   2, 20, 0, 1, 0, 0), -- World Peace Organization VIP Guardian (Non-tradable)
		(0, 20511,   5, 20, 0, 1, 0, 0), -- Heart of the Deep
		(0, 22766,   3, 20, 0, 1, 0, 0), -- ＴＲＩＣＫ
		(0, 62896,   3, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)

		-- Seventh Row
		(0, 24037,   1, 20, 0, 0, 0, 0), -- Custom: Luxurious Halloween Table
		(0, 40996,   2, 20, 0, 1, 0, 0), -- Super XP Card
		(0, 46730,   1, 20, 0, 0, 0, 0), -- Halloween Zashi Panel
		(0, 40501,   5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 46729,   1, 20, 0, 0, 0, 0), -- Halloween Panel 5
		(0, 55902,   1, 20, 0, 1, 0, 0)  -- Head: Halloween Pumpkin Cat
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
