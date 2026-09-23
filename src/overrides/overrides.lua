local overrides = {
    "deck_view",
    "negative_planet",
    "get_hand",
    "reset_card"
}
for k, v in ipairs(overrides) do
    assert(SMODS.load_file("src/overrides/" .. v .. ".lua"), MANIF.install .. "src/overrides/" .. v .. ".lua")()
end