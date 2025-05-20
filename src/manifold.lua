-- Mod icon
SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
}

-- Vouchers
SMODS.load_file("src/vouchers/vouchers.lua")()

-- Seals

-- Consumables
SMODS.load_file("src/consumables/consumables.lua")()

-- Jokers
SMODS.load_file("src/jokers/jokers.lua")()

-- Backs

-- Challenges
SMODS.get_card_areas()