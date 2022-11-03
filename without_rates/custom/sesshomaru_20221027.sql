--
-- Paragon
-- Created by: Sesshomaru, rates by TODO
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
		(0, 24067,  1, 20, 0, 0, 0, 0), -- Custom Halloween Pumpkin Lantern
		(0, 40501,  3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 40438,  1, 20, 0, 0, 0, 0), -- Profession Guardian Sprite
		(0, 40475,  1, 20, 0, 0, 0, 0), -- World Peace VIP Guardian
		(0, 40194, 25, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 21729,  1, 20, 0, 0, 0, 0), -- Unique Halloween Zephyrine

		-- Second Row
		(0, 62587,  3, 20, 0, 0, 0, 0), -- Healing Angel Lucky Pack (Eidolon)
		(0, 61035,  1, 20, 0, 0, 0, 0), -- 15th-Order Fortification Gift Box (Non-tradable)
		(0, 40029,  3, 20, 0, 0, 0, 0), -- Advanced XP Card
		(0, 41455,  2, 20, 0, 0, 0, 0), -- Raphael's Key Fragment
		(0, 16534, 50, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 53199,  1, 20, 0, 0, 0, 0), -- Back: Rafael's Divine Light Wings

		-- Third Row
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 52901,  1, 20, 0, 0, 0, 0), -- Custom Furniture: Big Halloween Zephyrine Portrait
		(0, 24039,  1, 20, 0, 0, 0, 0), -- Custom: Cute Bat Halloween Chair
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 41105,  1, 20, 0, 0, 0, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 54744,  1, 20, 0, 0, 0, 0), -- Halloween Ghost King

		-- Fourth Row
		(0, 62696,  3, 20, 0, 0, 0, 0), -- Archangel Lucky Pack (Eidolon)
		(0, 62548,  1, 20, 0, 0, 0, 0), -- 20th-Order Fortification Lucky Pack (Free choice) (Non-tradable)
		(0, 40987,  2, 20, 0, 0, 0, 0), -- Premium XP Card
		(0, 41508,  2, 20, 0, 0, 0, 0), -- Rachel's Key Fragment
		(0, 41413,  2, 20, 0, 0, 0, 0), -- Eidolon Accessory Stat Shuffle Stone I
		(0, 53419,  1, 20, 0, 0, 0, 0), -- Back: Rachel's Pure Wings

		-- Fifth Row
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 22766,  2, 20, 0, 1, 0, 0), -- ＴＲＩＣＫ
		(0, 24037,  1, 20, 0, 0, 0, 0), -- Custom: Luxurious Halloween Table
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40953, 25, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern

		-- Sixth Row
		(0, 62839,  3, 20, 0, 0, 0, 0), -- Crescent Maiden Lucky Pack (Eidolon)
		(0, 41409,  3, 20, 0, 1, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 40996,  1, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 41565,  2, 20, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 41419,  2, 20, 0, 0, 0, 0), -- Eidolon's Token Stat Shuffle Stone I
		(0, 41603,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Little Red Riding Hood in Arms

		-- Seventh Row
		(0, 46731,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine Panel
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 46384,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Dark Lord Black Knight
		(0, 41522,  5, 20, 0, 0, 0, 0), -- Emblem Restructuring Solution
		(0, 46032, 50, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 46730,  1, 20, 0, 0, 0, 0)  -- Halloween Zashi Panel
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
