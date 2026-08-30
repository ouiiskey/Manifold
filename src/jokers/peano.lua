-- Peano
SMODS.Joker {
    key = "peano",
    rarity = 4,
    atlas = "jokers",
    pos = {x = 2, y = 4},
    cost = 20,
    soul_pos = {x = 7, y = 4},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {key = "manifold_legendary_unlock"}
    end,
    config = {extra = {hand_size = 0, increment = 1, poker_hand = "Straight"}},
    loc_vars = function(self, info_queue, card)
        return {vars = {localize(card.ability.extra.poker_hand, "poker_hands"), card.ability.extra.increment, card.ability.extra.hand_size}}
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_played == 0 and next(context.poker_hands[card.ability.extra.poker_hand]) then
            SMODS.scale_card(card, {
                ref_value = "hand_size",
                scalar_value = "increment",
                message_key = "a_handsize",
                operation = function(ref_table, ref_value, value, change)
                    ref_table[ref_value] = value + change
                    G.hand:change_size(change)
                end
            })
        end
    end
}