--
-- Paragon
-- Created by: Mannenyuki, rates by TODO
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
		(0, 62223,   3, 20, 0, 0, 0, 0), -- Nightland Lord Lucky Pack (Eidolon)
		(0, 40463,   5, 20, 0, 0, 0, 0), -- 4-Star Eidolon Purification Scroll
		(0, 41039,   5, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone I
		(0, 22616,   1, 20, 0, 0, 0, 0), -- Unique Percival
		(0, 40713,   1, 20, 0, 0, 0, 0), -- Super Treasure Charm (1 Day) (Non-tradable)
		(0, 40948,   2, 20, 0, 0, 0, 0), -- Tsukuyomi's Key Fragment

		-- Second Row
		(0, 53683,   1, 20, 0, 0, 0, 0), -- Weapon: Black Kitty Bell Whip
		(0, 62236,   3, 20, 0, 0, 0, 0), -- Ice Sword God Lucky Pack (Eidolon)
		(0, 45068,   1, 20, 0, 0, 0, 0), -- 500 Ruby Coins (Non-tradable)
		(0, 40475,   1, 20, 0, 0, 0, 0), -- World Peace VIP Guardian
		(0, 40956,   2, 20, 0, 0, 0, 0), -- Ullr's Key Fragment
		(0, 46374,   1, 20, 0, 0, 0, 0), -- Summoning Contract: Grand Bishop Imma

		-- Third Row
		(0, 45925,   1, 20, 0, 0, 0, 0), -- Summoning contract: Yahrune, the Western Knight Leader
		(0, 40461,   5, 20, 0, 0, 0, 0), -- 3-Star Eidolon Purification Scroll
		(0, 62339,   3, 20, 0, 0, 0, 0), -- Pruina Lucky Pack (Eidolon)
		(0, 41026,   2, 20, 0, 0, 0, 0), -- Andrea's Key Fragment
		(0, 45594,   1, 20, 0, 1, 0, 0), -- Fantasy Gift Voucher: 100 Points
		(0, 51304,   1, 20, 0, 0, 0, 0), -- Custom Head: Eastern Exorcist Hairstyle (M)

		-- Fourth Row
		(0, 52025,   1, 20, 0, 0, 0, 0), -- Custom Body: Bamboo Forest New Year Kimono (M)
		(0, 41096,   5, 20, 0, 0, 0, 0), -- Holy Spirit Restructuring Solution
		(0, 62884,   3, 20, 0, 0, 0, 0), -- Heart of the Chalice Lucky Pack (Eidolon)
		(0, 41628,   2, 20, 0, 0, 0, 0), -- Percival's Key Fragment
		(0, 41522,   5, 20, 0, 0, 0, 0), -- Emblem Restructuring Solution
		(0, 51755,   1, 20, 0, 0, 0, 0), -- Weapon: Michaela's Chained Greatsword

		-- Fifth Row
		(0, 50729,   1, 20, 0, 0, 0, 0), -- Custom Head: Drifter Hairstyle (M)
		(0, 40459,   5, 20, 0, 0, 0, 0), -- 2-Star Eidolon Purification Scroll
		(0, 41634,   2, 20, 0, 0, 0, 0), -- Siren's Key Fragment
		(0, 62896,   3, 20, 0, 0, 0, 0), -- Deep Sea Diva Lucky Pack (Eidolon)
		(0, 41409,   4, 20, 0, 1, 0, 0), -- Super Costume Enchantment Card Fragment
		(0, 46431,   1, 20, 0, 0, 0, 0), -- Summoning Contract: Mixed Demon Delfonia

		-- Sixth Row
		(0, 46429,   1, 20, 0, 0, 0, 0), -- Summoning Contract: Evil Paladin Reinhardt
		(0, 40985,   2, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 22766,   2, 20, 0, 0, 0, 0), -- ＴＲＩＣＫ
		(0, 41034,  10, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 62247,   3, 20, 0, 0, 0, 0), -- Halloween Sprite Lucky Pack (Eidolon)
		(0, 53684,   1, 20, 0, 0, 0, 0), -- Weapon: Playful Kitty Bell Whip

		-- Seventh Row
		(0, 41116,   2, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 40457,   5, 20, 0, 0, 0, 0), -- 1-Star Eidolon Purification Scroll
		(0, 41065,   5, 20, 0, 0, 0, 0), -- Class Emblem Stat Shuffle Stone II
		(0, 41505,   5, 20, 0, 0, 0, 0), -- Holy Spirit Stat Shuffle Stone II
		(0, 46032, 100, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 62448,   3, 20, 0, 0, 0, 0)  -- Guardian of the Temple Lucky Pack (Eidolon)
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
