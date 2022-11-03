--
-- Paragon
-- Created by: Kaden, rates by TODO
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
		(0, 40019, 10, 20, 0, 0, 0, 0), -- Intermediate Treasure Charm
		(0, 41628,  1, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 20728,  1, 20, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 62884,  2, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 40027,  2, 20, 0, 0, 0, 0), -- XP Card

		-- Second Row
		(0, 40635,  3, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 46264,  1, 20, 0, 0, 0, 0), -- Summoning contract: Sky Dragon King Flokja
		(0, 40705,  1, 20, 0, 0, 0, 0), -- Auction Expansion
		(0, 40037,  5, 20, 0, 0, 0, 0), -- Warehouse Card
		(0, 16534, 25, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40199,  2, 20, 0, 0, 0, 0), -- 20th-Order Armor Fortification

		-- Third Row
		(0, 40021,  5, 20, 0, 0, 0, 0), -- Advanced Treasure Charm
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40041,  5, 20, 0, 0, 0, 0), -- Weapon Shop Card
		(0, 45065,  1, 20, 0, 0, 0, 0), -- 200 Ruby Coins
		(0, 60793,  2, 20, 0, 0, 0, 0), -- Fortune's Flame Lucky Pack (Eidolon)
		(0, 40029,  2, 20, 0, 0, 0, 0), -- Advanced XP Card

		-- Fourth Row
		(0, 40637,  3, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 46032, 30, 20, 0, 1, 0, 0), -- Mana Starstone
		(0, 40057,  1, 20, 0, 0, 0, 0), -- Superior Ability Transfer Scroll 1-30
		(0, 46429,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Evil Paladin Reinhardt
		(0, 40194, 15, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 40574,  2, 20, 0, 0, 0, 0), -- Lv.20 Accessory Blessing Scroll

		-- Fifth Row
		(0, 40499,  5, 20, 0, 0, 0, 0), -- Premium Treasure Charm
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 40045,  5, 20, 0, 0, 0, 0), -- Secret Stone Card
		(0, 45067,  1, 20, 0, 0, 0, 0), -- 500 Ruby Coins
		(0, 62448,  2, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 40987,  2, 20, 0, 0, 0, 0), -- Premium XP Card

		-- Sixth Row
		(0, 40633,  3, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern
		(0, 40259,  1, 20, 0, 0, 0, 0), -- Character Slot Expansion Card
		(0, 40039,  5, 20, 0, 0, 0, 0), -- Auction Card
		(0, 20726,  5, 20, 0, 1, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40197,  2, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification

		-- Seventh Row
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41628,  2, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 41032,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 20727,  3, 20, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 62884,  2, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 40996,  2, 20, 0, 0, 0, 0)  -- Super XP Card
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
