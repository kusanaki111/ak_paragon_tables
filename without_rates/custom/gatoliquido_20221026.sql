--
-- Paragon
-- Created by: GatoLiquido, rates by TODO
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
		(0, 40501,   3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41514,   2, 20, 0, 0, 0, 0), -- Nekomata's Key Fragment
		(0, 20726,   1, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40210,   1, 20, 0, 0, 0, 0), -- 20-Slot Backpack
		(0, 41096,   2, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 40788,   1, 20, 0, 0, 0, 0), -- Swifty Stars (Non-tradable)

		-- Second Row
		(0, 20707,   1, 20, 0, 0, 0, 0), -- Breezy Step (Non-Tradable)
		(0, 40194,   2, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 40574,   2, 20, 0, 0, 0, 0), -- Lv.20 Accessory Blessing Scroll
		(0, 41522,   2, 20, 0, 0, 0, 0), -- Emblem Restructuring Solution
		(0, 41412,   2, 20, 0, 0, 0, 0), -- Orochi's Key Fragment
		(0, 40040,  10, 20, 0, 0, 0, 0), -- Auction Card (Non-tradable)

		-- Third Row
		(0, 45098,   1, 20, 0, 0, 0, 0), -- Super Treasure Charm (3 Days)
		(0, 50675,   1, 20, 0, 0, 0, 0), -- Custom Body: Beach Gear (F)
		(0, 20726,   2, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 50672,   1, 20, 0, 0, 0, 0), -- Custom Body: Swim Trunks (M)
		(0, 41065,   2, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone II
		(0, 21408,  90, 20, 0, 1, 0, 0), -- Mana Starstone (Non-Tradable)

		-- Fourth Row
		(0, 20706,   1, 20, 0, 0, 0, 0), -- Zephyr Step (Non-Tradable)
		(0, 40194,   4, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 40661,   1, 20, 0, 0, 0, 0), -- 25th-Order Accessory Fortification
		(0, 41522,   3, 20, 0, 0, 0, 0), -- Emblem Restructuring Solution
		(0, 45068,   1, 20, 0, 0, 0, 0), -- 500 Ruby Coins (Non-tradable)
		(0, 40040,  15, 20, 0, 0, 0, 0), -- Auction Card (Non-tradable)

		-- Fifth Row
		(0, 45102,   1, 20, 0, 0, 0, 0), -- Super Treasure Charm (7 Days)
		(0, 62713,   3, 20, 0, 0, 0, 0), -- Cat Lady Lucky Pack (Eidolon)
		(0, 20726,   3, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 54753,   1, 20, 0, 0, 0, 0), -- Alice in Wonderland Fairytale
		(0, 41065,   3, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone II
		(0, 21408, 150, 20, 0, 1, 0, 0), -- Mana Starstone (Non-Tradable)

		-- Sixth Row
		(0, 20705,   1, 20, 0, 0, 0, 0), -- Godly Paced Flash (Non-Tradable)
		(0, 40194,   6, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 40663,   1, 20, 0, 0, 0, 0), -- 30th-Order Accessory Fortification
		(0, 41096,   3, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 62470,   3, 20, 0, 0, 0, 0), -- Serpent God Lucky Pack (Eidolon)
		(0, 20726,   4, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal

		-- Seventh Row
		(0, 46032,  50, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40788,   1, 20, 0, 0, 0, 0), -- Swifty Stars (Non-tradable)
		(0, 41425,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Orochi in Arms
		(0, 41034,   7, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 46339,   1, 20, 0, 0, 0, 0), -- Summoning Contract: Winged Duke Awaydas
		(0, 16534,  30, 20, 0, 0, 0, 0)  -- Dazzling Experience Crystal
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
