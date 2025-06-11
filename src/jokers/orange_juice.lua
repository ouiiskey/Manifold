-- Orange Juice, see also orange_juice.toml
local _mod = 1024

SMODS.Joker{
    key = "orange_juice",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 7, y = 0},
    cost = 6,
    config = {extra = {on_remove = true}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
    end,
    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * _mod
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.on_remove then
            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = v / _mod
            end
        end
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.before and context.main_eval then
                for k, v in ipairs(context.scoring_hand) do
                    if SMODS.has_enhancement(v, "m_lucky") then
                        for kk, vv in pairs(G.GAME.probabilities) do
                            G.GAME.probabilities[kk] = vv / _mod
                        end
                        card.ability.extra.on_remove = false
                        v.guaranteed_mult = true
                        v.guaranteed_money = true
                        break
                    end
                end
            elseif context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_lucky") and not card.getting_sliced then
                context.other_card.guaranteed_mult = false
                context.other_card.guaranteed_money = false
                return {
                    message_card = card,
                    message = localize("k_drank_ex"),
                    colour = G.C.ORANGE,
                    func = function() card:eat() end
                }
            end
        end
    end,
    eternal_compat = false
}