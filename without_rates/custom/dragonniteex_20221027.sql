--
-- Paragon
-- Created by: dragonniteex, rates by TODO
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
		(0, 41554,   1, 20, 0, 0, 0, 0), -- Festival Elizabeth's Key Fragment
		(0, 45592,  10, 20, 0, 0, 0, 0), -- Fantasy Gift Voucher: 1 Point
		(0, 40501,   3, 20, 0, 1, 0, 0), -- Super Treasure Charm
		(0, 41495,   1, 20, 0, 0, 0, 0), -- Crystal Liberation Wheel I
		(0, 21408, 200, 20, 0, 0, 0, 0), -- Mana Starstone (Non-Tradable)
		(0, 62792,   2, 20, 0, 0, 0, 0), -- Bloodthirsty Baroness Lucky Pack (Eidolon)

		-- Second Row
		(0, 21729,   1, 20, 0, 0, 0, 0), -- Unique Halloween Zephyrine
		(0, 41602,   5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 45039,   1, 20, 0, 0, 0, 0), -- 20th-Order Armor Fortification
		(0, 40953,   5, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 46032,  10, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 52901,   1, 20, 0, 0, 0, 0), -- Custom Furniture: Big Halloween Zephyrine Portrait

		-- Third Row
		(0, 41565,   1, 20, 0, 0, 0, 0), -- Little Red Riding Hood's Key Fragment
		(0, 40853,   6, 20, 0, 0, 0, 0), -- Basic Card Breakthrough Device
		(0, 40635,   6, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40457,   6, 20, 0, 0, 0, 0), -- 1-Star Eidolon Purification Scroll
		(0, 46032,  20, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 62839,   2, 20, 0, 0, 0, 0), -- Crescent Maiden Lucky Pack (Eidolon)

		-- Fourth Row
		(0, 31514,   1, 20, 0, 0, 0, 0), -- Zombie Costume Bag
		(0, 41032,   5, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 40574,   1, 20, 0, 0, 0, 0), -- Lv.20 Accessory Blessing Scroll
		(0, 41013,   5, 20, 0, 0, 0, 0), -- Advanced Mastery XP Book
		(0, 46032,  30, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 31710,   1, 20, 0, 0, 0, 0), -- Ten Swell's Handmade Necklace

		-- Fifth Row
		(0, 41634,   1, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 40855,   6, 20, 0, 0, 0, 0), -- Intermediate Card Breakthrough Device
		(0, 40637,   6, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 40459,   6, 20, 0, 0, 0, 0), -- 2-Star Eidolon Purification Scroll
		(0, 46032,  40, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 62896,   2, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)

		-- Sixth Row
		(0, 41440,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Succubus in Arms
		(0, 41034,   5, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 40197,   1, 20, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 41409,   5, 20, 0, 0, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 46032,  50, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 41603,   1, 20, 0, 0, 0, 0), -- Anima Crystal: Little Red Riding Hood in Arms

		-- Seventh Row
		(0, 41628,   1, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 40857,   6, 20, 0, 0, 0, 0), -- Advanced Card Breakthrough Device
		(0, 40633,   6, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 40461,   6, 20, 0, 0, 0, 0), -- 3-Star Eidolon Purification Scroll
		(0, 46032,  60, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 62884,   2, 20, 0, 0, 0, 0)  -- Heart of the Chalice Lucky Pack (Eidolon)
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
