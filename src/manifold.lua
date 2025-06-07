MANIF = {}

-- Mod icon
SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
}

-- Fonts
SMODS.load_file("src/fonts.lua")()

-- Vouchers
SMODS.load_file("src/vouchers.lua")()

-- Seals
SMODS.load_file("src/seals.lua")()

-- Consumables
SMODS.load_file("src/consumables/consumables.lua")()

-- Jokers
SMODS.load_file("src/jokers/jokers.lua")()

-- Backs

-- Challenges

-- Utils
SMODS.load_file("src/utils.lua")()