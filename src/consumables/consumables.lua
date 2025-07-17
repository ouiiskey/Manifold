local consumables = {
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