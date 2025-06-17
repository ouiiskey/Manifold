MANIF = {}

SMODS.current_mod.optional_features = {
    post_trigger = true,
    retrigger_joker = true
}

-- Mod icon
SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
}

-- Utils
SMODS.load_file("src/utils.lua")()

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