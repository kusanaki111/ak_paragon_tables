--
-- Paragon
-- Created by: SuperBaddieXD, rates by TODO
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
		(0, 41116,   1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 62247,   3, 20, 0, 1, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40102, 100, 20, 0, 1, 0, 0), -- Small Fluorescent Bead (Non-tradable)
		(0, 40002,  10, 20, 0, 0, 0, 0), -- Healing Potion (Non-tradable)
		(0, 62448,   3, 20, 0, 1, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 41116,   1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment

		-- Second Row
		(0, 21655,   1, 20, 0, 0, 0, 0), -- Kurt's Revolver
		(0, 40662,   4, 20, 0, 1, 0, 0), -- 25th-Order Accessory Fortification (Non-tradable)
		(0, 40063,   9, 20, 0, 0, 0, 0), -- 5th-Order Weapon Fortification
		(0, 40069,   9, 20, 0, 0, 0, 0), -- 5th-Order Armor Fortification
		(0, 40664,   2, 20, 0, 1, 0, 0), -- 30th-Order Accessory Fortification (Non-tradable)
		(0, 41425,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Orochi in Arms

		-- Third Row
		(0, 40574,   3, 20, 0, 1, 0, 0), -- Lv.20 Accessory Blessing Scroll
		(0, 21655,   1, 20, 0, 0, 0, 0), -- Kurt's Revolver
		(0, 40071,   6, 20, 0, 0, 0, 0), -- 10th-Order Armor Fortification
		(0, 40065,   6, 20, 0, 0, 0, 0), -- 10th-Order Weapon Fortification
		(0, 41456,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Raphael in Arms
		(0, 40525,   6, 20, 0, 1, 0, 0), -- Lv.15 Accessory Fortification

		-- Fourth Row
		(0, 21408,  69, 20, 0, 1, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 40199,   3, 20, 0, 0, 0, 0), -- 20th-Order Armor Fortification
		(0, 21655,   1, 20, 0, 0, 0, 0), -- Kurt's Revolver
		(0, 41472,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Salome in Arms
		(0, 40197,   3, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 41014,  20, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book (Non-tradable)

		-- Fifth Row
		(0, 40654,   4, 20, 0, 0, 0, 0), -- 25th-Order Armor Fortification (Non-tradable)
		(0, 40638,  69, 20, 0, 1, 0, 0), -- Superior Accessory Fortification Scroll (Non-tradable)
		(0, 41515,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Nekomata in Arms
		(0, 21655,   1, 20, 0, 0, 0, 0), -- Kurt's Revolver
		(0, 41014,  10, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book (Non-tradable)
		(0, 40646,   4, 20, 0, 0, 0, 0), -- 25th-Order Weapon Fortification (Non-tradable)

		-- Sixth Row
		(0, 40636,  69, 20, 0, 1, 0, 0), -- Superior Armor Fortification Scroll (Non-tradable)
		(0, 41557,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Elizabeth in Arms
		(0, 40648,   2, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification (Non-tradable)
		(0, 40656,   2, 20, 0, 0, 0, 0), -- 30th-Order Armor Fortification (Non-tradable)
		(0, 21655,   1, 20, 0, 0, 0, 0), -- Kurt's Revolver
		(0, 41013,   5, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book

		-- Seventh Row
		(0, 41635,   1, 20, 0, 1, 0, 0), -- Anima Crystal: Siren in Arms
		(0, 40634,  69, 20, 0, 1, 0, 0), -- Superior Weapon Fortification Scroll (Non-tradable)
		(0, 46429,   1, 20, 0, 1, 0, 0), -- Summoning Contract: Evil Paladin Reinhardt
		(0, 40058,   1, 20, 0, 1, 0, 0), -- Superior Ability Transfer Scroll 1-30 (Non-tradable)
		(0, 41013,   1, 20, 0, 1, 0, 0), -- Advanced Mastery XP Book
		(0, 21655,   1, 20, 0, 1, 0, 0)  -- Kurt's Revolver
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
