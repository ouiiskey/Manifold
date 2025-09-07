-- Servant of Chaos
local x_base = 13

SMODS.Challenge {
    key = "servant_of_chaos",
    rules = {
        modifiers = {
            {id = "gold_stake", value = ""},
            {id = "x_base", value = x_base}
        }
    },
    jokers = {
        {id = "j_manifold_cthugha", edition = "negative"},
        {id = "j_manifold_nyarlathotep", edition = "negative"},
        {id = "j_manifold_hastur", edition = "negative"}
    },
    consumeables = {
        {id = "c_sun"},
        {id = "c_familiar"}
    },
    apply = function(self)
        G.GAME.modifiers.x_base = x_base
    end,
    unlocked = false,
    stake = 8
}