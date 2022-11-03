--
-- Paragon
-- Created by: Aya, rates by TODO
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
		(0, 52889,   1, 20, 0, 0, 0, 0), -- Spectral Cat
		(0, 16534,   5, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40985,   2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 20726,   3, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 62247,   3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 40194,  20, 20, 0, 0, 0, 0), -- Fluorescent Bead

		-- Second Row
		(0, 40501,   2, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 46732,   1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern
		(0, 46032,  30, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 22012,   1, 20, 0, 0, 0, 0), -- Unique Summer Alucard
		(0, 41032,   5, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 40953, 100, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Third Row
		(0, 52890,   1, 20, 0, 0, 0, 0), -- Spectral Dapper Bear
		(0, 16534,  10, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 41116,   2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 20727,   3, 20, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal
		(0, 62448,   3, 20, 0, 0, 0, 0), -- Guardian of the Temple Lucky Pack (Eidolon)
		(0, 40194,  15, 20, 0, 0, 0, 0), -- Fluorescent Bead

		-- Fourth Row
		(0, 40501,   3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 22766,   1, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ
		(0, 46032,  50, 20, 0, 1, 0, 0), -- Mana Starstone
		(0, 41470,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Inaba in Arms
		(0, 41030,   5, 20, 0, 0, 0, 0), -- Superior Pet Improving Potion
		(0, 40953,  50, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Fifth Row
		(0, 54779,   1, 20, 0, 0, 0, 0), -- Magic Star Pumpkin Train
		(0, 16534,  20, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 41634,   1, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 20726,  10, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 62896,   2, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 40194,  10, 20, 0, 0, 0, 0), -- Fluorescent Bead

		-- Sixth Row
		(0, 40501,   5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 46403,   1, 20, 0, 0, 0, 0), -- Summoning Contract: Lightning Baroness Fatima
		(0, 46032,  40, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41484,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Persephone in Arms
		(0, 41034,   5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 40953, 100, 20, 0, 1, 0, 0), -- Eidolon Lucky Pack

		-- Seventh Row
		(0, 54778,   1, 20, 0, 0, 0, 0), -- Demonic Pumpkin Train
		(0, 16534,  15, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 41628,   1, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 20726,   5, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 62884,   2, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 40194,  10, 20, 0, 0, 0, 0)  -- Fluorescent Bead
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
