--
-- Paragon
-- Created by:
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
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --

		-- Second Row
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --

		-- Third Row
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --

		-- Fourth Row
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --

		-- Fifth Row
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --

		-- Sixt Row
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --

		-- Seventh Row
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0), --
		(0, 00000, 1, 20, 0, 0, 0, 0)  --
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
