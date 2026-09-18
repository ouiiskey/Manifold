-- Negative Planet Card
local SEgclk_ref = SMODS.Edition.get_card_limit_key
function SMODS.Edition.get_card_limit_key(card)
    if card.ability.set == "Planet" then return "negative_planet_SMODS_INTERNAL" end
    return SEgclk_ref(card)
end