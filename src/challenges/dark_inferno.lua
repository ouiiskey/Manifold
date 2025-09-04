-- Dark Inferno
local x_base = 3

SMODS.Challenge {
    key = "dark_inferno",
    rules = {
        custom = {
            {id = "ante_x_base"}
        },
        modifiers = {
            {id = "gold_stake", value = ""}
        }
    },
    jokers = {
        {id = "j_manifold_left_turns", eternal = true},
        {id = "j_burglar"},
        {id = "j_blueprint", perishable = true},
        {id = "j_manifold_archwizard", eternal = true}
    },
    calculate = function(self, context)
        if context.ante_change then
            G.GAME.modifiers.x_base = (G.GAME.modifiers.x_base or 1) + context.ante_change
        end
    end,
    stake = 8
}