--
-- Paragon
-- Created by: StrayNeko, rates by Haruka Kasugano
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
		(0, 40208, 1, 10, 0, 0, 0, 0), -- 10-Slot Backpack
		(0, 40053, 4, 15, 0, 0, 0, 0), -- Advanced Weapon Fortification Scroll
		(0, 45063, 1, 20, 0, 0, 0, 0), -- 100 Ruby Coins
		(0, 45063, 1, 20, 0, 0, 0, 0), -- 100 Ruby Coins
		(0, 40055, 4, 15, 0, 0, 0, 0), -- Advanced Armor Fortification Scroll
		(0, 40925, 1, 20, 0, 0, 0, 0), -- Innocent Mount Stat Shuffle Stone

		-- Second Row
		(0, 40922, 1,  5, 0, 0, 0, 0), -- Aoandon's Key of Gaia Fragment
		(0, 40065, 1, 20, 0, 0, 0, 0), -- 10th-Order Weapon Fortification
		(0, 40743, 1, 25, 0, 0, 0, 0), -- Mount Upgrade Stone
		(0, 40517, 2, 30, 0, 0, 0, 0), -- Accessory Fortification Scroll
		(0, 40559, 1, 10, 0, 0, 0, 0), -- Premium Facemask Enchantment - DMG
		(0, 62206, 1, 10, 0, 0, 0, 0), -- Summer Dragon Tyrant Lucky Pack (Eidolon)

		-- Third Row
		(0, 62079, 1, 10, 0, 0, 0, 0), -- Hell Hound Lucky Pack (Eidolon)
		(0, 40545, 1, 10, 0, 0, 0, 0), -- Premium Headgear Enchantment - HP
		(0, 40671, 1, 35, 0, 0, 0, 0), -- 1,000 Fragment Scrolls
		(0, 40175, 1, 10, 0, 0, 0, 0), -- 500 Loyalty Points
		(0, 40197, 1, 10, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 40633, 2, 25, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll

		-- Fourth Row
		(0, 40852, 1,  5, 0, 0, 0, 0), -- Cerberus' Key Fragment
		(0, 53189, 1, 10, 0, 0, 0, 0), -- Custom Body: Punk Rebel Outfit (F)
		(0, 45592, 3, 40, 0, 1, 0, 0), -- Fantasy Gift Voucher: 1 Point
		(0, 40857, 1, 25, 0, 0, 0, 0), -- Advanced Card Breakthrough Device
		(0, 40400, 1, 10, 0, 0, 0, 0), -- 3-Star Armor Fusion Stone
		(0, 60442, 1, 10, 0, 0, 0, 0), -- Luminous Beauty Lucky Pack (Eidolon)

		-- Fifth Row
		(0, 62121, 1, 10, 0, 0, 0, 0), -- Wings of Happiness Lucky Pack (Eidolon)
		(0, 40366, 1, 10, 0, 0, 0, 0), -- 4-Star Equipment Fusion Stone
		(0, 16701, 1, 10, 0, 0, 0, 0), -- Blueprint: Floral Rocking Chair
		(0, 40695, 1, 20, 0, 1, 0, 0), -- 150 Loyalty Points
		(0, 50172, 1, 10, 0, 0, 0, 0), -- Custom Body: Aura Knight's Armor (M)
		(0, 40463, 1, 40, 0, 0, 0, 0), -- 4-Star Eidolon Purification Scroll

		-- Sixth Row
		(0, 40637, 3, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 51847, 1, 10, 0, 0, 0, 0), -- Weapon: Sakura Shuriken
		(0, 40671, 1, 15, 0, 1, 0, 0), -- 1,000 Fragment Scrolls
		(0, 40863, 1, 15, 0, 0, 0, 0), -- Advanced Card Breakthrough Device DMG
		(0, 40574, 1, 10, 0, 0, 0, 0), -- Lv.20 Accessory Blessing Scroll
		(0, 40214, 1, 30, 0, 0, 0, 0), -- 100 Loyalty Points

		-- Seventh Row
		(0, 45593, 1, 60, 0, 0, 0, 0), -- Fantasy Gift Voucher: 10 Points
		(0, 40661, 1,  5, 0, 0, 0, 0), -- 25th-Order Accessory Fortification
		(0, 40238, 1,  5, 0, 0, 0, 0), -- 1000 Loyalty Points
		(0, 15360, 1, 10, 0, 0, 0, 0), -- Lava Secret Stone Lucky Pack
		(0, 40397, 1,  5, 0, 0, 0, 0), -- 5-Star Weapon Fusion Stone
		(0, 16711, 1, 15, 0, 0, 0, 0)  -- Blueprint: Baroque Crystal Light
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
