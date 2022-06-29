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
		(0, 20726,  1,  5, 0, 0, 1, 0), -- Gorgeous Eidolons XP Crystal
		(0, 41492,  1,  5, 0, 0, 1, 0), -- Abe no Seimei's Key Fragment
		(0, 41013,  3, 25, 0, 0, 1, 0), -- Advanced Mastery XP Book
		(0, 40501,  1, 30, 0, 0, 1, 0), -- Super Treasure Charm
		(0, 54763,  1, 10, 0, 0, 1, 0), -- Summer Dream - Japanese Water Lantern
		(0, 45592,  3, 25, 0, 0, 1, 0), -- Fantasy Gift Voucher: 1 Point

		-- Second Row
		(0, 21760,  1, 20, 0, 0, 1, 0), -- Unidentified Premium Weapon Fusion Enchantment Card
		(0, 40565,  1, 20, 0, 0, 1, 0), -- Premium Weapon Enchantment - DMG
		(0, 53284,  1,  5, 0, 0, 1, 0), -- Weapon: Brightfeathered Star Katar
		(0, 53285,  1,  5, 0, 0, 1, 0), -- Weapon: Darkfeathered Star Katar
		(0, 40569,  1, 25, 0, 0, 1, 0), -- Premium Weapon Enchantment - ACC
		(0, 41409,  1, 25, 0, 0, 1, 0), -- Super Costume Enchantment Card Fragment

		-- Third Row
		(0, 41094,  3, 45, 0, 0, 1, 0), -- Holy Spirit Stat Shuffle Stone I
		(0, 54767,  1,  5, 0, 0, 1, 0), -- Spring Wool Traveling Mouse
		(0, 21408, 65, 10, 0, 0, 1, 0), -- Mana Starstone (Non-Tradable)
		(0, 41105,  1, 10, 0, 0, 1, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 40215,  1, 10, 0, 0, 1, 0), -- 300 Loyalty Points
		(0, 61206,  1, 20, 0, 0, 1, 0), -- Unidentified Mount Stat Shuffle Stone

		-- Fourth Row
		(0, 20726,  2,  5, 0, 0, 1, 0), -- Gorgeous Eidolons XP Crystal
		(0, 41492,  2,  5, 0, 0, 1, 0), -- Abe no Seimei's Key Fragment
		(0, 41013,  6, 20, 0, 0, 1, 0), -- Advanced Mastery XP Book
		(0, 40501,  2, 30, 0, 0, 1, 0), -- Super Treasure Charm
		(0, 54764,  1, 10, 0, 0, 1, 0), -- Crimson Summer - Japanese Water Lantern
		(0, 45592,  6, 30, 0, 0, 1, 0), -- Fantasy Gift Voucher: 1 Point

		-- Fifth Row
		(0, 41096,  3, 45, 0, 0, 1, 0), -- Holy Spirit Restructuring Solution
		(0, 54769,  1,  5, 0, 0, 1, 0), -- Winter Star Traveling Mouse
		(0, 21408, 65, 10, 0, 0, 1, 0), -- Mana Starstone (Non-Tradable)
		(0, 41105,  1, 10, 0, 0, 1, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 40215,  1, 10, 0, 0, 1, 0), -- 300 Loyalty Points
		(0, 61206,  1, 20, 0, 0, 1, 0), -- Unidentified Mount Stat Shuffle Stone

		-- Sixth Row
		(0, 62461,  1, 20, 0, 0, 1, 0), -- Unidentified Super Weapon Enchantment Card
		(0, 40567,  1, 25, 0, 0, 1, 0), -- Premium Weapon Enchantment - CRIT
		(0, 53291,  1,  5, 0, 0, 1, 0), -- Weapon: Sapphire Starblades
		(0, 53292,  1,  5, 0, 0, 1, 0), -- Weapon: Classic Starblades
		(0, 40565,  1, 20, 0, 0, 1, 0), -- Premium Weapon Enchantment - DMG
		(0, 41409,  1, 25, 0, 0, 1, 0), -- Super Costume Enchantment Card Fragment

		-- Seventh Row
		(0, 20726,  3,  5, 0, 0, 1, 0), -- Gorgeous Eidolons XP Crystal
		(0, 41492,  3,  5, 0, 0, 1, 0), -- Abe no Seimei's Key Fragment
		(0, 41013, 10, 30, 0, 0, 1, 0), -- Advanced Mastery XP Book
		(0, 40501,  3, 30, 0, 0, 1, 0), -- Super Treasure Charm
		(0, 54765,  1,  5, 0, 0, 1, 0), -- Colourful Summer - Japanese Water Lantern
		(0, 45593,  1, 25, 0, 0, 1, 0)  -- Fantasy Gift Voucher: 10 Points
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
