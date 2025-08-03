-- Slothful Joker
SMODS.Joker {
    key = "slothful",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 9, y = 3},
    cost = 5,
    blueprint_compat = true,
    config = {extra = {hand_cost = 1, x_mult = 2}},
    in_pool = function(self, args)
        for k, v in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(v, "m_wild") then
                return true
            end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return {vars = {card.ability.extra.hand_cost, card.ability.extra.x_mult}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and SMODS.has_enhancement(context.other_card, "m_wild") then
            ease_hands_played(-card.ability.extra.hand_cost)
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize("manifold_hand_minus")
            }
        end
    end
}