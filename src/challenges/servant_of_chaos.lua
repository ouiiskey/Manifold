-- Servant of Chaos
local x_base = 20

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
    apply = function(self)
        G.GAME.modifiers.x_base = x_base
    end,
    stake = 8
}