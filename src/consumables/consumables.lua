SMODS.Atlas {
    key = "spectrals",
    path = "spectrals.png",
    px = 71,
    py = 95
}

local consumables = {
    -- Spectrals
    "mind",
    -- Vanilla Tarots
    "high_priestess",
    -- Vanilla Spectrals
    "incantation",
    "familiar",
    "grim"
}
for k, v in ipairs(consumables) do
    assert(SMODS.load_file("src/consumables/" .. v .. ".lua"), MANIF.install .. "src/consumables/" .. v .. ".lua")()
end