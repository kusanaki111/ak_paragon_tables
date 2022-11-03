--
-- Paragon
-- Created by: Rem, rates by TODO
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
		(0, 41116,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 40953, 15, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 41602,  4, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 41530,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Queen of Hearts in Arms
		(0, 24963,  1, 20, 0, 0, 0, 0), -- Halloween Indoor Window Frame
		(0, 62247,  3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)

		-- Second Row
		(0, 20706,  1, 20, 0, 0, 0, 0), -- Zephyr Step (Non-Tradable)
		(0, 20727,  1, 20, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 40782,  1, 20, 0, 0, 0, 0), -- Eidolon Oath Ring
		(0, 54744,  1, 20, 0, 0, 0, 0), -- Halloween Ghost King
		(0, 24964,  1, 20, 0, 0, 0, 0), -- Halloween Indoor beam-column
		(0, 40663,  1, 20, 0, 0, 0, 0), -- 30th-Order Accessory Fortification

		-- Third Row
		(0, 40985,  1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 46032, 46, 20, 0, 1, 0, 0), -- Mana Starstone
		(0, 40637,  5, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 21729,  1, 20, 0, 0, 0, 0), -- Unique Halloween Zephyrine
		(0, 24965,  1, 20, 0, 0, 0, 0), -- Halloween Wallpaper
		(0, 62448,  3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)

		-- Fourth Row
		(0, 20705,  1, 20, 0, 0, 0, 0), -- Godly Paced Flash (Non-Tradable)
		(0, 20728,  1, 20, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 45593,  3, 20, 0, 0, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 22766,  2, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ
		(0, 24966,  1, 20, 0, 0, 0, 0), -- Halloween Ceiling
		(0, 40655,  1, 20, 0, 0, 0, 0), -- 30th-Order Armor Fortification

		-- Fifth Row
		(0, 41634,  1, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 40953, 30, 20, 0, 1, 0, 0), -- Eidolon Lucky Pack
		(0, 40635,  5, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 46431,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Mixed Demon Delfonia
		(0, 24967,  1, 20, 0, 0, 0, 0), -- Halloween Floor
		(0, 62896,  3, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)

		-- Sixth Row
		(0, 20707,  1, 20, 0, 0, 0, 0), -- Breezy Step (Non-Tradable)
		(0, 20726,  5, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40201,  1, 20, 0, 0, 0, 0), -- Brilliant Evolutionary Beads
		(0, 20708,  1, 20, 0, 0, 0, 0), -- Peak Attack Emblem
		(0, 40987,  2, 20, 0, 0, 0, 0), -- Premium XP Card
		(0, 40647,  1, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification

		-- Seventh Row
		(0, 41628,  1, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 46032, 64, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40633,  5, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 41105,  1, 20, 0, 0, 0, 0), -- Dazzling Mount Stat Shuffle Stone
		(0, 40996,  2, 20, 0, 0, 0, 0), -- Super XP Card
		(0, 62884,  3, 20, 0, 0, 0, 0)  -- Heart of the Chalice Lucky Pack (Eidolon)
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
