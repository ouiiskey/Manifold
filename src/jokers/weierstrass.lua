-- Weierstrass
SMODS.Joker {
    key = "weierstrass",
    rarity = 4,
    atlas = "jokers",
    pos = {x = 0, y = 4},
    cost = 20,
    soul_pos = {x = 5, y = 4},
    unlocked = false,
    blueprint_compat = true,
    config = {extra = {mult = 0}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if context.blueprint then
                return {
                    mult = card.ability.extra.mult
                }
            else
                return {
                    mult = card.ability.extra.mult,
                    func = function()
                        card.ability.extra.mult = mult
                    end
                }
            end
        end
    end
}