local consumables = {
    -- Spectrals
    "spectrals/spectrals",
    -- Reverse Tarots
    "reverse/tarot",
    -- Vanilla Tarots
    "high_priestess",
    "lovers"
}
for k, v in ipairs(consumables) do
    assert(SMODS.load_file("src/consumables/" .. v .. ".lua"), MANIF.install .. "src/consumables/" .. v .. ".lua")()
end