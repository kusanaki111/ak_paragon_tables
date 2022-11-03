--
-- Paragon
-- Created by: amandaa, rates by TODO
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
		(0, 46337,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Charm Queen Ruth
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 40936,  1, 20, 0, 0, 0, 0), -- Summer Nidhogg's Key Fragment
		(0, 62207,  2, 20, 0, 0, 0, 0), -- Summer Calamity Dragon Lucky Pack (Eidolon)
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 46732,  1, 20, 0, 0, 0, 0), -- Summoning Contract: Jack-o-Lantern

		-- Second Row
		(0, 41116,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment
		(0, 41032, 10, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 46032, 25, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40635,  5, 20, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 41032, 10, 20, 0, 0, 0, 0), -- Superior Secret Stone Randomizer
		(0, 40985,  1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment

		-- Third Row
		(0, 45063,  1, 20, 0, 0, 0, 0), -- 100 Ruby Coins
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 41061,  1, 20, 0, 0, 0, 0), -- Summer Michaela's Key Fragment
		(0, 62409,  2, 20, 0, 0, 0, 0), -- Summer Guardian Angel Lucky Pack (Eidolon)
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 45063,  1, 20, 0, 0, 0, 0), -- 100 Ruby Coins

		-- Fourth Row
		(0, 41425,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Orochi in Arms
		(0, 41034, 10, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 46032, 25, 20, 0, 0, 0, 0), -- Mana Starstone
		(0, 40633,  5, 20, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 41034, 10, 20, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 41470,  1, 20, 0, 0, 0, 0), -- Anima Crystal: Inaba in Arms

		-- Fifth Row
		(0, 45065,  1, 20, 0, 0, 0, 0), -- 200 Ruby Coins
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 41483,  1, 20, 0, 0, 0, 0), -- Summer Persephone's Key Fragment
		(0, 62636,  2, 20, 0, 0, 0, 0), -- Summer Queen of the Underworld Lucky Pack (Eidolon)
		(0, 40953, 10, 20, 0, 0, 0, 0), -- Eidolon Lucky Pack
		(0, 45065,  1, 20, 0, 0, 0, 0), -- 200 Ruby Coins

		-- Sixth Row
		(0, 40985,  1, 20, 0, 0, 0, 0), -- Halloween Zashi's Key Fragment
		(0, 41522, 10, 20, 0, 0, 0, 0), -- Emblem Restructuring Solution
		(0, 46032, 25, 20, 0, 1, 0, 0), -- Mana Starstone
		(0, 40637,  5, 20, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 41522, 10, 20, 0, 0, 0, 0), -- Emblem Restructuring Solution
		(0, 41116,  1, 20, 0, 0, 0, 0), -- Halloween Zephyrine's Key Fragment

		-- Seventh Row
		(0, 46315,  1, 20, 0, 0, 0, 0), -- Summoning contract: Winged Revelation, Ace Tyr
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 40647,  1, 20, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 45594,  1, 20, 0, 0, 0, 0), -- Fantasy Gift Voucher: 100 Points
		(0, 41602,  5, 20, 0, 0, 0, 0), -- Superior Secret Stone Coin
		(0, 45970,  1, 20, 0, 0, 0, 0)  -- Summoning contract: Luciana, the Starwing
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
