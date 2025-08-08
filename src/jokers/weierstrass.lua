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
            return {
                mult = card.ability.extra.mult
            }
        elseif context.post_trigger and not context.blueprint and context.other_card == card then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.ability.extra.mult = mult
                    return true end }))
        end
    end
}