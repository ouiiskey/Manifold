-- Lucky 7s
SMODS.Joker {
    key = "lucky_sevens",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 6, y = 3},
    cost = 7,
    blueprint_compat = true,
    config = {extra = {x_mult = 7, min = 0, max = 7}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.x_mult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                forced = true
            }
        elseif context.after and context.cardarea == G.jokers and not context.blueprint then
            card.ability.extra.x_mult = pseudorandom("manifold_sevens", card.ability.extra.min, card.ability.extra.max)
        end
    end
}