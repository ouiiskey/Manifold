-- Digi-Carrot, see also digi_carrot.toml and inject.lua
SMODS.Joker {
    key = "digi_carrot",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 3, y = 1},
    cost = 4,
    blueprint_compat = true,
    yes_pool_flag = "cavendish_extinct",
    config = {extra = {e_mult = 1.25, increment = 0.05}},
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