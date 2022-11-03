--
-- Paragon
-- Created by: Plinkoon, rates by TODO
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
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 46730,  1, 20, 0, 0, 0, 0), -- Halloween Zashi Panel
		(0, 46725,  1, 20, 0, 0, 0, 0), -- Halloween Panel 1
		(0, 46032, 25, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40985,  1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment

		-- Second Row
		(0, 54744,  1, 20, 0, 0, 0, 0), -- Halloween Ghost King
		(0, 46032, 12, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40633,  6, 20, 0, 1, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 46729,  1, 20, 0, 0, 0, 0), -- Halloween Panel 5
		(0, 41034,  3, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 54800,  1, 20, 0, 0, 0, 0), -- Siren's Magnificent Seashell

		-- Third Row
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 41034,  4, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 46731,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine Panel
		(0, 52902,  1, 20, 0, 0, 0, 0), -- Custom Furniture: Halloween Zephyrine Portrait
		(0, 46032, 18, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)

		-- Fourth Row
		(0, 53726,  1, 20, 0, 0, 0, 0), -- Custom Body: Pure Flower Marriage (F)
		(0, 46032, 24, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40633,  6, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 46728,  1, 20, 0, 0, 0, 0), -- Halloween Panel 4
		(0, 41034,  6, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 53729,  1, 20, 0, 0, 0, 0), -- Custom Head: Flower Cotton Hat (F)

		-- Fifth Row
		(0, 62884,  3, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 41034,  8, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 46727,  1, 20, 0, 0, 0, 0), -- Halloween Panel 3
		(0, 25469,  1, 20, 0, 0, 0, 0), -- Duel Card: Odum Ryan
		(0, 46032, 30, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41628,  1, 20, 0, 0, 0, 0), -- Percival's Key Fragment

		-- Sixth Row
		(0, 54795,  1, 20, 0, 0, 0, 0), -- Cute Scooter with Stars
		(0, 46032, 36, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40633,  6, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 46726,  1, 20, 0, 0, 0, 0), -- Halloween Panel 2
		(0, 46032, 36, 20, 0, 1, 0, 0), -- Mana Starstone
		(0, 62886,  3, 20, 0, 0, 0, 0), -- Cute Scooter Lucky Pack (Mount)

		-- Seventh Row
		(0, 41634,  1, 20, 0, 1, 0, 0), -- Siren's Key Fragment
		(0, 20726,  4, 20, 0, 1, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40863,  7, 20, 0, 1, 0, 0), -- Advanced Card Breakthrough Device DMG
		(0, 22766,  1, 20, 0, 1, 0, 0), -- ＴＲＩＣＫ
		(0, 21408, 40, 20, 0, 1, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 62896,  3, 20, 0, 1, 0, 0)  -- Deep Sea Diva Lucky Pack (Eidolon)
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
