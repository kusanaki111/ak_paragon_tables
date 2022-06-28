--
-- Paragon
-- Created by: Katzenfuchs, rates by Haruka Kasugano
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
		(0, 45063,  1, 20, 0, 0, 0, 0), -- 100 Ruby Coins
		(0, 11048, 10, 20, 0, 0, 0, 0), -- Pure Experience Crystal
		(0, 41048,  2,  5, 0, 0, 0, 0), -- Skuld's Key Fragment
		(0, 40324,  1, 15, 0, 1, 0, 0), -- 50 Loyalty Points
		(0, 40501,  1, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 45063,  1, 20, 0, 0, 0, 0), -- 100 Ruby Coins

		-- Second Row
		(0, 40953,  6, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40499,  3, 30, 0, 0, 0, 0), -- Premium Treasure Charm
		(0, 40324,  1, 15, 0, 0, 0, 0), -- 50 Loyalty Points
		(0, 40479,  2,  5, 0, 0, 0, 0), -- Diao Chan's Key Fragment
		(0, 24955,  1, 10, 0, 0, 0, 0), -- Eidolon Pillow - Harmonia
		(0, 11048, 15, 20, 0, 0, 0, 0), -- Pure Experience Crystal

		-- Third Row
		(0, 53413,  1, 10, 0, 0, 0, 0), -- Custom Head: Demonic Horn Hat (F)
		(0, 24953,  1, 10, 0, 0, 0, 0), -- Eidolon Pillow - Serena
		(0, 40775,  2,  5, 0, 0, 0, 0), -- Muramasa's Key Fragment
		(0, 40194,  5, 25, 0, 1, 0, 0), -- Fluorescent Bead
		(0, 16534,  5, 45, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40782,  1,  5, 0, 0, 0, 0), -- Eidolon Oath Ring

		-- Fourth Row
		(0, 16534, 10, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 40501,  2, 25, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 40194,  5, 20, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 41028,  2,  5, 0, 0, 0, 0), -- Iwanaga-hime's Key Fragment
		(0, 40499,  5, 20, 0, 0, 0, 0), -- Premium Treasure Charm
		(0, 52866,  1, 10, 0, 0, 0, 0), -- Back: Sunrise Wings

		-- Fifth Row
		(0, 51854,  1, 10, 0, 0, 0, 0), -- Azure Cat Balloons
		(0, 40461,  1, 10, 0, 0, 0, 0), -- 3-Star Eidolon Purification Scroll
		(0, 41002,  2,  5, 0, 0, 0, 0), -- Sakuya-hime's Key Fragment
		(0, 45593,  1, 10, 0, 0, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 24952,  1, 10, 0, 0, 0, 0), -- Eidolon Pillow - Muse
		(0, 46032, 35, 55, 0, 0, 0, 0), -- Mana Starstone

		-- Sixt Row
		(0, 46032, 50, 15, 0, 0, 0, 0), -- Mana Starstone
		(0, 40499,  8, 25, 0, 0, 0, 0), -- Premium Treasure Charm
		(0, 45593,  1, 10, 0, 0, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 41046,  2,  5, 0, 0, 0, 0), -- Urd's Key Fragment
		(0, 40953, 15, 30, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 40463,  1, 15, 0, 0, 0, 0), -- 4-Star Eidolon Purification Scroll

		-- Seventh Row
		(0, 45067,  1,  5, 0, 0, 0, 0), -- 500 Ruby Coins
		(0, 24951,  1, 10, 0, 0, 0, 0), -- Eidolon Pillow - Ayako
		(0, 41477,  2,  5, 0, 0, 0, 0), -- Salome's Key Fragment
		(0, 40201,  1, 10, 0, 0, 0, 0), -- Brilliant Evolutionary Beads
		(0, 40501,  3, 30, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 11048, 10, 40, 0, 0, 0, 0)  -- Pure Experience Crystal
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
