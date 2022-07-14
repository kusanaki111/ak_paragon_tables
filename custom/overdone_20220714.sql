--
-- Paragon
-- Created by: Overdone, rates by Haruka Kasugano
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
		(0, 46032,  25, 35, 0, 0, 0, 0), -- Mana Starstone
		(0, 62636,   3, 10, 0, 0, 0, 0), -- Summer Queen of the Underworld Lucky Pack (Eidolon)
		(0, 20726,  10, 20, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 41530,   1,  5, 0, 0, 0, 0), -- Anima Crystal: Queen of Hearts in Arms
		(0, 32044,  20, 25, 0, 0, 0, 0), -- Santa Claus' Mischievous Ball
		(0, 41483,   2,  5, 0, 0, 0, 0), -- Summer Persephone's Key Fragment

		-- Second Row
		(0, 40501,   5, 65, 0, 0, 0, 0), -- Super Treasure Charm
		(0, 62409,   3, 10, 0, 0, 0, 0), -- Summer Guardian Angel Lucky Pack (Eidolon)
		(0, 20728,   2, 10, 0, 0, 0, 0), -- Eidolon XP Stone
		(0, 45102,   1,  5, 0, 0, 0, 0), -- Super Treasure Charm (7 Days)
		(0, 46315,   1,  5, 0, 0, 0, 0), -- Summoning contract: Winged Revelation, Ace Tyr
		(0, 41061,   2,  5, 0, 0, 0, 0), -- Summer Michaela's Key Fragment

		-- Third Row
		(0, 45594,   1,  5, 0, 0, 0, 0), -- Fantasy Gift Voucher: 100 Points
		(0, 62207,   3, 20, 0, 0, 0, 0), -- Summer Calamity Dragon Lucky Pack (Eidolon)
		(0, 46032,  50, 40, 0, 0, 0, 0), -- Mana Starstone
		(0, 40663,   3,  5, 0, 0, 0, 0), -- 30th-Order Accessory Fortification
		(0, 40637,   7, 25, 0, 0, 0, 0), -- Superior Accessory Fortification Scroll
		(0, 40936,   2,  5, 0, 0, 0, 0), -- Summer Nidhogg's Key Fragment

		-- Fourth Row
		(0, 41034,   7, 25, 0, 0, 0, 0), -- Costume Attribution Potion
		(0, 62206,   3, 15, 0, 0, 0, 0), -- Summer Dragon Tyrant Lucky Pack (Eidolon)
		(0, 20726,  10, 25, 0, 0, 0, 0), -- Gorgeous Eidolons XP Crystal
		(0, 40655,   3,  5, 0, 0, 0, 0), -- 30th-Order Armor Fortification
		(0, 40635,   7, 25, 0, 0, 0, 0), -- Superior Armor Fortification Scroll
		(0, 40934,   2,  5, 0, 0, 0, 0), -- Summer Alucard's Key Fragment

		-- Fifth Row
		(0, 40197,   2, 10, 0, 0, 0, 0), -- 20th-Order Weapon Fortification
		(0, 61213,   3, 15, 0, 0, 0, 0), -- Lady of Styx Wish Lucky Pack
		(0, 46032,  75, 40, 0, 0, 0, 0), -- Mana Starstone
		(0, 40647,   3,  5, 0, 0, 0, 0), -- 30th-Order Weapon Fortification
		(0, 40633,   7, 25, 0, 0, 0, 0), -- Superior Weapon Fortification Scroll
		(0, 40779,   2,  5, 0, 0, 0, 0), -- Izanami's Key Fragment

		-- Sixth Row
		(0, 40855,  10, 55, 0, 0, 0, 0), -- Intermediate Card Breakthrough Device
		(0, 62919,   3,  5, 0, 0, 0, 0), -- Goddess of Eternal Blessings Lucky Pack (Eidolon)
		(0, 20705,   1,  5, 0, 0, 0, 0), -- Godly Paced Flash (Non-Tradable)
		(0, 45098,   1, 10, 0, 0, 0, 0), -- Super Treasure Charm (3 Days)
		(0, 40857,  10, 20, 0, 1, 0, 0), -- Advanced Card Breakthrough Device
		(0, 41028,   2,  5, 0, 0, 0, 0), -- Iwanaga-hime's Key Fragment

		-- Seventh Row
		(0, 46032, 100, 35, 0, 0, 0, 0), -- Mana Starstone
		(0, 62602,   3, 10, 0, 0, 0, 0), -- Soulbonder Lucky Pack (Eidolon)
		(0, 45068,   5,  5, 0, 0, 0, 0), -- 500 Ruby Coins (Non-tradable)
		(0, 28048,   1,  5, 0, 0, 0, 0), -- Lecture on Extreme Speed
		(0, 32044,  20, 40, 0, 0, 0, 0), -- Santa Claus' Mischievous Ball
		(0, 41468,   2,  5, 0, 0, 0, 0)  -- Inaba's Key Fragment
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
