--
-- Paragon
-- Created by: Nyanu, rates by TODO
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
		(0, 41032,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 46032,  8, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40953, 15, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 62841,  1, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer Lucky Pack (Non-tradable)

		-- Second Row
		(0, 40713,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (1 Day) (Non-tradable)
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 40501,  3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 45064,  2, 20, 0, 0, 0, 0), -- 100 Ruby Coins (Non-tradable)
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 20726,  8, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal

		-- Third Row
		(0, 62896,  1, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 41634,  1, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 41628,  1, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 62884,  1, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)

		-- Fourth Row
		(0, 41634,  1, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 41602, 10, 20, 0, 1, 0, 0), -- Superior Secret Stone Coin
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 41602, 10, 20, 0, 1, 0, 0), -- Superior Secret Stone Coin
		(0, 41628,  1, 20, 0, 0, 0, 0), -- Percival's Key Fragment

		-- Fifth Row
		(0, 62896,  2, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 45599,  1, 20, 0, 0, 0, 0), -- Cleopawtra's Divine Form
		(0, 41409,  3, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 62884,  2, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)

		-- Sixth Row
		(0, 32880,  1, 20, 0, 0, 0, 0), -- Bond - Eternal Sorrow
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 40500,  3, 20, 0, 0, 0, 0), -- Premium Treasure Charm (Non-tradable)
		(0, 46032, 16, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 32881,  1, 20, 0, 0, 0, 0), -- Bond - Flower Garden

		-- Seventh Row
		(0, 41456,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Raphael in Arms
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 40996,  1, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 40079,  1, 20, 0, 0, 0, 0), -- 24 Hour XP Crystal
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 41032, 10, 20, 0, 0, 0, 0)  -- Superior Secret Stone Randomizer
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
