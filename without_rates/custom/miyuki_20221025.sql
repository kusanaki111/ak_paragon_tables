--
-- Paragon
-- Created by: Miyuki, rates by TODO
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
		(0, 16012,  1, 20, 0, 0, 0, 0), -- Flying Pumpkin
		(0, 41034,  1, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 40532,  3, 20, 0, 0, 0, 0), -- Bouquet of Dreams
		(0, 21408, 50, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 41429,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Muse in Arms
		(0, 40713,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (1 Day) (Non-tradable)

		-- Second Row
		(0, 53396,  1, 20, 0, 0, 0, 0), -- Weapon: Halloween Demonic Cat Sword
		(0, 20726, 20, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40953,  3, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40080,  1, 20, 0, 0, 0, 0), -- 24 Hour XP Crystal (Non-tradable)
		(0, 62247,  1, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40501,  1, 20, 0, 1, 0, 0), -- Super Treasure Charm

		-- Third Row
		(0, 40988,  2, 20, 0, 0, 0, 0), -- Premium XP Card (Non-tradable)
		(0, 54744,  1, 20, 0, 0, 0, 0), -- Halloween Ghost King
		(0, 40323,  1, 20, 0, 0, 0, 0), -- Guardian Sprite of Gaia (1 Day)
		(0, 20726, 20, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 41034,  1, 20, 0, 0, 0, 0), -- Costume Attribution Potion

		-- Fourth Row
		(0, 53363,  1, 20, 0, 0, 0, 0), -- Back: Halloween Black Kitty Claw
		(0, 41034,  1, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 41487,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Marceline (Non-tradable)
		(0, 21408, 50, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 41470,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Inaba in Arms
		(0, 40501,  1, 20, 0, 1, 0, 0), -- Super Treasure Charm

		-- Fifth Row
		(0, 40988,  2, 20, 0, 0, 0, 0), -- Premium XP Card (Non-tradable)
		(0, 55902,  1, 20, 0, 0, 0, 0), -- Head: Halloween Pumpkin Cat
		(0, 45658,  1, 20, 0, 0, 0, 0), -- World Peace Organization VIP Guardian (Non-tradable)
		(0, 20726, 20, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 41034,  1, 20, 0, 0, 0, 0), -- Costume Attribution Potion

		-- Sixth Row
		(0, 53364,  1, 20, 0, 0, 0, 0), -- Back: Halloween White Kitty Claw
		(0, 20726, 20, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 41556,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jill (Non-Tradable)
		(0, 40082,  1, 20, 0, 0, 0, 0), -- Seven Day XP Crystal (Non-tradable)
		(0, 62448,  1, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 40501,  1, 20, 0, 1, 0, 0), -- Super Treasure Charm

		-- Seventh Row
		(0, 46730,  1, 20, 0, 0, 0, 0), -- Halloween Zashi Panel
		(0, 20727,  1, 20, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 46731,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine Panel
		(0, 21408, 50, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 41530,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Queen of Hearts in Arms
		(0, 40500,  1, 20, 0, 0, 0, 0)  -- Premium Treasure Charm (Non-tradable)
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
