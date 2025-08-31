-- Peano
SMODS.Joker {
    key = "peano",
    rarity = 4,
    atlas = "jokers",
    pos = {x = 2, y = 4},
    cost = 20,
    soul_pos = {x = 7, y = 4},
    unlocked = false,
    config = {extra = {hand_size = 0, increment = 1}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.increment, card.ability.extra.hand_size}}
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and not context.blueprint and G.GAME.current_round.hands_played == 0 and next(context.poker_hands["Straight"]) then
            SMODS.scale_card(card, {ref_value = "hand_size", scalar_value = "increment", block_overrides = {value = true, scalar = true}})
        end
    end,
    calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
        if other_card.config.center == self then
            return {
                post = {
                    func = function()
                        if scalar_value ~= 0 then
                            G.hand:change_size(scalar_value)
                        end
                    end
                }
            }
        end
    end
}