-- Pacific Rim
local x_base = 3

SMODS.Challenge {
    key = "pacific_rim",
    rules = {
        modifiers = {
            {id = "gold_stake", value = ""},
            {id = "x_base", value = x_base}
        }
    },
    jokers = {
        {id = "j_manifold_tsunami", eternal = true},
        {id = "j_manifold_railgun", eternal = true}
    },
    restrictions = {
        banned_other = {
            {id = "bl_hook", type = "blind"}
        }
    },
    apply = function(self)
        G.GAME.modifiers.x_base = x_base
    end,
    unlocked = false,
    stake = 8
}