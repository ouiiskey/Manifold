-- Pareto
SMODS.Joker {
    key = "pareto",
    rarity = 4,
    atlas = "jokers",
    pos = {x = 1, y = 4},
    cost = 20,
    soul_pos = {x = 6, y = 4},
    unlocked = false,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                balance = true
            }
        end
    end
}