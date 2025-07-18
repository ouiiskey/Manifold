-- Orange Juice
SMODS.Joker {
    key = "orange_juice",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 7, y = 0},
    cost = 6,
    config = {extra = {on_remove = true}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_lucky") and not card.getting_sliced then
                return {
                    message_card = card,
                    message = localize("k_drank_ex"),
                    colour = G.C.ORANGE,
                    func = function() card:eat() end
                }
            elseif context.fix_probability then
                return {
                    numerator = 1,
                    denominator = 1
                }
            end
        end
    end,
    eternal_compat = false
}