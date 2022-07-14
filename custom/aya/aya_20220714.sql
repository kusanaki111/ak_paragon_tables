--
-- Paragon
-- Created by: Aya, rates by Haruka Kasugano
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
		(0, 16534, 10, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 41470,  1,  5, 0, 0, 0, 0), -- Anima Crystal: Inaba in Arms
		(0, 40501,  3, 30, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 21989,  1, 10, 0, 0, 0, 0), -- Unidentified SLV15 Legendary Awakening Accessory Box
		(0, 40197,  1, 10, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 40953,  5, 25, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Second Row
		(0, 40953,  5, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 46032, 10, 25, 0, 0, 0, 0), -- Mana Starstone
		(0, 28016,  1,  5, 0, 0, 0, 0), -- Lecture on Zeal
		(0, 40635,  3, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40194, 10, 25, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 20727,  2,  5, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal

		-- Third Row
		(0, 16534, 10, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 41565,  1,  5, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 40501,  5, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 46032, 15, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 62839,  2, 15, 0, 0, 0, 0), -- Crescent Maiden Lucky Pack (Eidolon)
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Fourth Row
		(0, 40953, 10, 25, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 46032, 30, 20, 0, 1, 0, 0), -- Mana Starstone
		(0, 28056,  1,  5, 0, 0, 0, 0), -- Lecture on Break Defense
		(0, 40637,  3, 25, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 40199,  1, 20, 0, 0, 0, 0), -- 20th-Order Armor Fortification
		(0, 20727,  3,  5, 0, 0, 0, 0), -- Eidolon XP Rainbow Crystal

		-- Fifth Row
		(0, 16534, 20, 20, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 62839,  3, 15, 0, 0, 0, 0), -- Crescent Maiden Lucky Pack (Eidolon)
		(0, 40501,  3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 46032, 10, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41565,  1,  5, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack

		-- Sixth Row
		(0, 40953, 20, 20, 0, 1, 0, 0), -- Eidolon Lucky Pack
		(0, 46032, 15, 25, 0, 0, 0, 0), -- Mana Starstone
		(0, 28048,  1,  5, 0, 0, 0, 0), -- Lecture on Extreme Speed
		(0, 40633,  3, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 40194, 10, 25, 0, 0, 0, 0), -- Fluorescent Bead
		(0, 20728,  1,  5, 0, 0, 0, 0), -- Eidolon XP Stone

		-- Seventh Row
		(0, 16534, 15, 15, 0, 0, 0, 0), -- Dazzling Experience Crystal
		(0, 41484,  1,  5, 0, 0, 0, 0), -- Anima Crystal: Persephone in Arms
		(0, 40501,  3, 20, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 21989,  1, 15, 0, 0, 0, 0), -- Unidentified SLV15 Legendary Awakening Accessory Box
		(0, 40574,  1, 20, 0, 0, 0, 0), -- Lv.20 Accessory Blessing Scroll
		(0, 40953, 15, 25, 0, 0, 0, 0)  -- Eidolon Lucky Pack
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
