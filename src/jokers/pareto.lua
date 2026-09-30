-- Pareto
SMODS.Joker {
    key = "pareto",
    rarity = 4,
    atlas = "jokers",
    pos = {x = 1, y = 4},
    cost = 20,
    blueprint_compat = true,
    soul_pos = {x = 6, y = 4},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {key = "manifold_legendary_unlock"}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                balance = true
            }
        end
    end
}