--
-- Paragon
-- Created by: Onisword, rates by TODO
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
		(0, 40953,  5, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 52903,  1, 20, 0, 0, 0, 0), -- Custom Furniture: Small Halloween Zephyrine Portrait
		(0, 40194,  5, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 46032, 15, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 21729,  1, 20, 0, 0, 0, 0), -- Unique Halloween Zephyrine
		(0, 16534, 15, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal

		-- Second Row
		(0, 16534, 25, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 41105,  2, 20, 0, 0, 0, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 40987,  2, 20, 0, 0, 0, 0), -- Premium XP Card
		(0, 41115,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key of Gaia
		(0, 40501,  3, 20, 0, 1, 0, 0), -- Super Treasure Charm

		-- Third Row
		(0, 41409,  2, 20, 0, 1, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 52901,  1, 20, 0, 0, 0, 0), -- Custom Furniture: Big Halloween Zephyrine Portrait
		(0, 41039,  2, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone I
		(0, 24067,  1, 20, 0, 0, 0, 0), -- Custom Halloween Pumpkin Lantern
		(0, 46681,  1, 20, 0, 0, 0, 0), -- Summoning Contract: White Cherry Shiba
		(0, 41602,  3, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin

		-- Fourth Row
		(0, 41065,  2, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone II
		(0, 40201,  1, 20, 0, 0, 0, 0), -- Brilliant Evolutionary Beads
		(0, 45098,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (3 Days)
		(0, 41413,  2, 20, 0, 0, 0, 0), -- Eidolon Accessory Stat Shuffle Stone I
		(0, 20974,  1, 20, 0, 0, 0, 0), -- Unique Halloween Zashi
		(0, 40475,  1, 20, 0, 0, 0, 0), -- World Peace VIP Guardian

		-- Fifth Row
		(0, 24039,  1, 20, 0, 0, 0, 0), -- Custom: Cute Bat Halloween Chair
		(0, 62839,  2, 20, 0, 0, 0, 0), -- Crescent Maiden Lucky Pack (Eidolon)
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern
		(0, 40501,  3, 20, 0, 1, 0, 0), -- Super Treasure Charm
		(0, 41565,  2, 20, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 41065,  2, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone II

		-- Sixth Row
		(0, 46403,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Lightning Baroness Fatima
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40996,  2, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 41094,  2, 20, 0, 0, 0, 0), -- Holy Spirit Stat Shuffle Stone I
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 24037,  1, 20, 0, 0, 0, 0), -- Custom: Luxurious Halloween Table

		-- Seventh Row
		(0, 41419,  2, 20, 0, 0, 0, 0), -- Eidolon's Token Stat Shuffle Stone I
		(0, 46730,  1, 20, 0, 0, 0, 0), -- Halloween Zashi Panel
		(0, 41096,  6, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 41034,  6, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 46731,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine Panel
		(0, 46429,  1, 20, 0, 0, 0, 0)  -- Summoning Contract: Evil Paladin Reinhardt
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
