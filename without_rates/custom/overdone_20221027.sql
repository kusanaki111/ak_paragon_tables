--
-- Paragon
-- Created by: Overdone, rates by TODO
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
		(0, 63195,   1, 20, 0, 0, 0, 0), -- DEF Mastery Box
		(0, 46032,  10, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40663,   1, 20, 0, 0, 0, 0), -- 30th-Order Accessory Fortification
		(0, 41096,   3, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 41470,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Inaba in Arms
		(0, 45098,   1, 20, 0, 0, 0, 0), -- Super Treasure Charm (3 Days)

		-- Second Row
		(0, 62896,   3, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 46315,   1, 20, 0, 0, 0, 0), -- Summoning contract: Winged Revelation, Ace Tyr
		(0, 41522,   3, 20, 0, 0, 0, 0), -- Emblem Restructuring Solution
		(0, 40661,   1, 20, 0, 0, 0, 0), -- 25th-Order Accessory Fortification
		(0, 41039,   3, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone I
		(0, 41634,   2, 20, 0, 0, 0, 0), -- Siren's Key Fragment

		-- Third Row
		(0, 63194,   1, 20, 0, 0, 0, 0), -- ATK Mastery Box
		(0, 46032,  25, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40645,   1, 20, 0, 0, 0, 0), -- 25th-Order Weapon Fortification
		(0, 40501,   3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41530,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Queen of Hearts in Arms
		(0, 40653,   1, 20, 0, 0, 0, 0), -- 25th-Order Armor Fortification

		-- Fourth Row
		(0, 62247,   3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 46429,   1, 20, 0, 0, 0, 0), -- Summoning Contract: Evil Paladin Reinhardt
		(0, 16534,   5, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40647,   1, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 41094,   3, 20, 0, 0, 0, 0), -- Holy Spirit Stat Shuffle Stone I
		(0, 40985,   2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment

		-- Fifth Row
		(0, 63196,   1, 20, 0, 0, 0, 0), -- Special Mastery Box
		(0, 46032,  50, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 51797,   1, 20, 0, 0, 0, 0), -- Princess' Fluffy Rabbit Mount
		(0, 32044,   3, 20, 0, 1, 0, 0), -- Santa Claus' Mischievous Ball
		(0, 41603,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Little Red Riding Hood in Arms
		(0, 40655,   1, 20, 0, 0, 0, 0), -- 30th-Order Armor Fortification

		-- Sixth Row
		(0, 62448,   3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 46732,   1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern
		(0, 40857,   5, 20, 0, 0, 0, 0), -- Advanced Card Breakthrough Device
		(0, 20728,   1, 20, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 41602,   5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 41116,   2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment

		-- Seventh Row
		(0, 40855,   5, 20, 0, 0, 0, 0), -- Intermediate Card Breakthrough Device
		(0, 46032, 100, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41032,   3, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 40633,  10, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 41440,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Succubus in Arms
		(0, 45102,   1, 20, 0, 0, 0, 0)  -- Super Treasure Charm (7 Days)
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
