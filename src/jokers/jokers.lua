SMODS.Atlas {
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95
}

MANIF.home = "c_planet_x" -- Aliens' homeworld

local jokers = {
    "prosopagnosia",
    "archwizard",
    "black_knight",
    "bob",
    "alice",
    "space_patrol",
    "clay_tablet",
    "orange_juice",
    "pudding",
    "cookie_dough",
    "cookie",
    "baked_potato",
    "hot_potato",
    "digi_carrot",
    "extraterrestrial",
    "cthugha",
    "nyarlathotep",
    "hastur",
    "squid",
    "monkeys_paw",
    "esper",
    -- Vanilla
    "seance"
}
for k, v in ipairs(jokers) do
    assert(SMODS.load_file("src/jokers/" .. v .. ".lua"), MANIF.install .. "src/jokers/" .. v .. ".lua")()
end