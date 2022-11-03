--
-- Paragon
-- Created by: Osiba, rates by TODO
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
		(0, 40501,  3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 46243,  1, 20, 0, 0, 0, 0), -- Summoning contract: Aqua-Dragon Queen Lianne Riverwalker
		(0, 46338,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Sprite Princess Haltin
		(0, 21408, 10, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 40197,  1, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification

		-- Second Row
		(0, 46731,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine Panel
		(0, 40199,  1, 20, 0, 1, 0, 0), -- 20th-Order Armor Fortification
		(0, 41032,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 45090,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (3 Days) (Non-tradable)
		(0, 21408, 10, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 41116,  2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment

		-- Third Row
		(0, 40985,  2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 40439,  1, 20, 0, 0, 0, 0), -- Profession Guardian Sprite (1 Day)
		(0, 46263,  1, 20, 0, 0, 0, 0), -- Summoning contract: Thunder-Dragon King Taloc
		(0, 41034,  6, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 41032,  6, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 46730,  1, 20, 0, 0, 0, 0), -- Halloween Zashi Panel

		-- Fourth Row
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 53363,  1, 20, 0, 0, 0, 0), -- Back: Halloween Black Kitty Claw
		(0, 53364,  1, 20, 0, 0, 0, 0), -- Back: Halloween White Kitty Claw
		(0, 54744,  1, 20, 0, 0, 0, 0), -- Halloween Ghost King
		(0, 53396,  1, 20, 0, 0, 0, 0), -- Weapon: Halloween Demonic Cat Sword
		(0, 41034,  5, 20, 0, 1, 0, 0), -- Costume Attribution Potion

		-- Fifth Row
		(0, 41484,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Persephone in Arms
		(0, 40636,  3, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll (Non-tradable)
		(0, 45094,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm (7 Days) (Non-tradable)
		(0, 45593,  1, 20, 0, 1, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 22616,  1, 20, 0, 0, 0, 0), -- Unique Percival
		(0, 40953, 15, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Sixth Row
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 62884,  2, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 41032,  6, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 62884,  1, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 41530,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Queen of Hearts in Arms

		-- Seventh Row
		(0, 40501,  3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 46315,  1, 20, 0, 0, 0, 0), -- Summoning contract: Winged Revelation, Ace Tyr
		(0, 41419,  2, 20, 0, 0, 0, 0), -- Eidolon's Token Stat Shuffle Stone I
		(0, 41034,  5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 41628,  1, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 46352,  1, 20, 0, 0, 0, 0)  -- Summoning Contract: Demon Glutton Gainey
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
