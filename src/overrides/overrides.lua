local overrides = {
    "deck_view",
    "get_hand",
    "reset_card"
}
for k, v in ipairs(overrides) do
    assert(SMODS.load_file("src/overrides/" .. v .. ".lua"), MANIF.install .. "src/overrides/" .. v .. ".lua")()
end

-- Negative Planet Card
local SEgclk_ref = SMODS.Edition.get_card_limit_key
function SMODS.Edition.get_card_limit_key(card)
    if card.ability.set == "Planet" then return "negative_planet_SMODS_INTERNAL" end
    return SEgclk_ref(card)
end