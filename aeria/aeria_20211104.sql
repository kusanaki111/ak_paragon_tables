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
		(0, 45592,  1, 20, 0, 0, 1, 0), -- Fantasy Gift Voucher: 1 Point
		(0, 41052,  1,  5, 1, 0, 1, 0), -- Kingyo-hime's Key Fragment
		(0, 40768,  5, 45, 0, 0, 1, 0), -- Otter Feed
		(0, 53104,  1,  5, 0, 0, 1, 0), -- Custom Body: Kingyo-hime Outfit (C)
		(0, 40953,  7, 20, 0, 0, 1, 0), -- Eidolon Lucky Pack
		(0, 53107,  1,  5, 0, 0, 1, 0), -- Custom Head: Kingyo-hime Hairstyle (C)

		-- Second Row
		(0, 52934,  1, 15, 0, 0, 1, 0), -- Back: Romantic Chrono Wings
		(0, 40918,  1,  5, 1, 0, 1, 0), -- Seiryuu's Key Fragment
		(0, 40019,  4, 35, 0, 0, 1, 0), -- Intermediate Treasure Charm
		(0, 40021,  2, 25, 0, 0, 1, 0), -- Advanced Treasure Charm
		(0, 62465,  1, 10, 0, 0, 1, 0), -- Romantic Dye Lucky Pack (Custom)
		(0, 41034,  2, 10, 0, 0, 1, 0), -- Costume Attribution Potion

		-- Third Row
		(0, 52991,  1, 10, 0, 0, 1, 0), -- Back: Pink Dazzling Butterfly Wings
		(0, 41451,  1,  5, 0, 0, 1, 0), -- Genbu's Key Fragment
		(0, 40009, 10, 25, 0, 0, 1, 0), -- Megaphone
		(0, 40035, 10, 25, 0, 0, 1, 0), -- Feather of Revival
		(0, 46032,  7, 20, 0, 0, 1, 0), -- Mana Starstone
		(0, 41034,  4, 15, 0, 0, 1, 0), -- Costume Attribution Potion

		-- Fourth Row
		(0, 45631,  1, 15, 0, 0, 1, 0), -- Stuffed Penguin
		(0, 40839,  1,  5, 1, 0, 1, 0), -- Succubus' Key Fragment
		(0, 40289,  3, 20, 0, 1, 1, 0), -- Emerald Shard
		(0, 40633,  2, 20, 0, 0, 1, 0), -- Superior Weapon Fortification Scroll
		(0, 40635,  3, 20, 0, 0, 1, 0), -- Superior Armor Fortification Scroll
		(0, 40637,  4, 20, 0, 0, 1, 0), -- Superior Accessory Fortification Scroll

		-- Fifth Row
		(0, 45593,  1, 25, 0, 0, 1, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 41455,  1, 10, 1, 0, 1, 0), -- Raphael's Key Fragment
		(0, 40770,  5, 25, 0, 0, 1, 0), -- Advanced Otter Feed
		(0, 53225,  1, 10, 0, 0, 1, 0), -- Custom Body: Raphael Outfit (C)
		(0, 40953, 14, 20, 0, 0, 1, 0), -- Eidolon Lucky Pack
		(0, 53228,  1, 10, 0, 0, 1, 0), -- Custom Head: Raphael Hairstyle (C)

		-- Sixt Row
		(0, 54762,  1, 25, 0, 0, 1, 0), -- Maple Love - Cozy Fox Cushion
		(0, 40775,  1,  5, 1, 0, 1, 0), -- Muramasa's Key Fragment
		(0, 41409,  1, 25, 0, 0, 1, 0), -- Super Costume Enchantment Card Fragment
		(0, 40031, 10, 30, 0, 0, 1, 0), -- Quest XP Book
		(0, 46032, 15, 10, 0, 0, 1, 0), -- Mana Starstone
		(0, 40927,  1,  5, 0, 0, 1, 0), -- Shimmering Mount Stat Shuffle Stone

		-- Seventh Row
		(0, 54768,  1, 20, 0, 0, 1, 0), -- Autumn Mushroom Traveling Mouse
		(0, 41508,  1,  5, 1, 0, 1, 0), -- Rachel's Key Fragment
		(0, 41409,  2, 20, 0, 0, 1, 0), -- Super Costume Enchantment Card Fragment
		(0, 41032, 10, 25, 0, 0, 1, 0), -- Superior Secret Stone Randomizer
		(0, 40927,  3, 10, 0, 0, 1, 0), -- Shimmering Mount Stat Shuffle Stone
		(0, 46032, 10, 20, 0, 0, 1, 0)  -- Mana Starstone
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
