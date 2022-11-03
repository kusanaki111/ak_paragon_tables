--
-- Paragon
-- Created by: yana, rates by TODO
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
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 53147,  1, 20, 0, 0, 0, 0), -- Back: Sailor Chubby Woof
		(0, 46032, 25, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41634,  2, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 40633,  3, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll

		-- Second Row
		(0, 62896,  3, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 41013,  5, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern
		(0, 46730,  1, 20, 0, 0, 0, 0), -- Halloween Zashi Panel
		(0, 22766,  2, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ
		(0, 41409,  2, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment

		-- Third Row
		(0, 41116,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 40197,  3, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 40953, 30, 20, 0, 1, 0, 0), -- Eidolon Lucky Pack
		(0, 24037,  1, 20, 0, 0, 0, 0), -- Custom: Luxurious Halloween Table
		(0, 41039,  5, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone I
		(0, 41484,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Persephone in Arms

		-- Fourth Row
		(0, 45064,  3, 20, 0, 0, 0, 0), -- 100 Ruby Coins (Non-tradable)
		(0, 40857, 10, 20, 0, 0, 0, 0), -- Advanced Card Breakthrough Device
		(0, 53614,  1, 20, 0, 0, 0, 0), -- Back: Nostalgic Carp Kite
		(0, 41096,  5, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 20726,  2, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal

		-- Fifth Row
		(0, 41522,  5, 20, 0, 0, 0, 0), -- Emblem Restructuring Solution
		(0, 40985,  1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 20511,  4, 20, 0, 0, 0, 0), -- Heart of the Deep
		(0, 40633, 10, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 46032, 55, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40855, 12, 20, 0, 0, 0, 0), -- Intermediate Card Breakthrough Device

		-- Sixth Row
		(0, 62448,  2, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 40953, 40, 20, 0, 1, 0, 0), -- Eidolon Lucky Pack
		(0, 40647,  1, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 46731,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine Panel
		(0, 53017,  1, 20, 0, 0, 0, 0), -- Back: Festive Tanuki
		(0, 40210,  1, 20, 0, 0, 0, 0), -- 20-Slot Backpack

		-- Seventh Row
		(0, 46032, 65, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 40475,  1, 20, 0, 0, 0, 0), -- World Peace VIP Guardian
		(0, 53410,  1, 20, 0, 0, 0, 0), -- Custom Body: Demonic Horn Costume (F)
		(0, 41034, 10, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 41628,  1, 20, 0, 0, 0, 0)  -- Percival's Key Fragment
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
