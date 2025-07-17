MANIF = {
    install = "Improper install detected, missing file: "
}

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

-- Load source
local source = {
    "utils",
    "fonts",
    "vouchers",
    "seals",
    "consumables/consumables",
    "jokers/jokers",
    -- Backs
    -- Challenges
    "compat"
}
for k, v in ipairs(source) do
    assert(SMODS.load_file("src/" .. v .. ".lua"), MANIF.install .. "src/" .. v .. ".lua")()
end

-- Final startup
local menu = assert(SMODS.load_file("src/final.lua"), MANIF.install .. "src/final.lua")
local startup = true
local old = Game.main_menu
Game.main_menu = function(change_context)
    if startup then
        menu()
        startup = false
    end
    old(change_context)
end