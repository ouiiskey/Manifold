-- Digi-Carrot
local hook = true
for k, v in pairs(SMODS.calculation_keys) do
    if v == "e_mult" then
        hook = false
        break
    end
end
if hook then
    table.insert(SMODS.calculation_keys, "e_mult")
    local old = SMODS.calculate_individual_effect
    SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
        if key == "e_mult" and amount ~= 1 then
            mult = mod_mult(mult ^ amount)
            update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            card_eval_status_text(scored_card, "e_mult", amount, percent)
            return true
        end
        return old(effect, scored_card, key, amount, from_edition)
    end
end

SMODS.Joker{
    key = "digi_carrot",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 3, y = 1},
    cost = 4,
    blueprint_compat = true,
    yes_pool_flag = "cavendish_extinct",
    config = {extra = {e_mult = 1.2, increment = 0.1}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.e_mult}}
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff and card.getting_sliced then
            local copy = copy_card(card)
            copy.ability.extra.e_mult = copy.ability.extra.e_mult + copy.ability.extra.increment
            copy:add_to_deck()
            G.jokers:emplace(copy)
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                e_mult = card.ability.extra.e_mult
            }
        end
    end,
    perishable_compat = false
}