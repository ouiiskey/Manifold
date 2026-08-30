-- Weierstrass
SMODS.Joker {
    key = "weierstrass",
    rarity = 4,
    atlas = "jokers",
    pos = {x = 0, y = 4},
    cost = 20,
    soul_pos = {x = 5, y = 4},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {key = "manifold_legendary_unlock"}
    end,
    blueprint_compat = true,
    config = {extra = {mult = 0}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if not context.blueprint and card.ability.extra.mult < mult then
                card.ability.extra.mult = mult
            end
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}