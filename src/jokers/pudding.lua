-- Pudding
SMODS.Joker {
    key = "pudding",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 8, y = 0},
    cost = 4,
    blueprint_compat = true,
    config = {extra = {mult = 40, count = 5}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        return {vars = {card.ability.extra.mult, card.ability.extra.count}}
    end,
    in_pool = function(self, args)
        for k, v in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(v, "m_bonus") then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if not context.repetition and not context.blueprint and card.ability.extra.count <= 0 then
            return {
                message = localize("k_eaten_ex"),
                message_card = card,
                colour = G.C.PURPLE,
                func = function() card:eat() end
            }
        elseif context.individual and context.cardarea == G.play and card.ability.extra.count > 0 and SMODS.has_enhancement(context.other_card, "m_bonus") then
            if not context.blueprint then
                card.ability.extra.count = card.ability.extra.count - 1
            end
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    eternal_compat = false
}