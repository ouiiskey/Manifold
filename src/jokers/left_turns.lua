-- 4 Left Turns
SMODS.Joker {
    key = "left_turns",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 5, y = 3},
    cost = 8,
    blueprint_compat = true,
    config = {extra = {hands = 2, poker_hand = "Four of a Kind"}},
    loc_vars = function(self, info_queue, card)
        return {vars = {localize(card.ability.extra.poker_hand, "poker_hands"), card.ability.extra.hands}}
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == card.ability.extra.poker_hand then
            ease_hands_played(card.ability.extra.hands)
            return {
                message = localize("manifold_hand")
            }
        end
    end
}