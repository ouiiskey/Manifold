-- Boss Rush
SMODS.Challenge {
    key = "boss_rush",
    rules = {
        custom = {
            {id = "boss_rush"}
        },
        modifiers = {
            {id = "gold_stake", value = ""}
        }
    },
    apply = function(self)
        G.GAME.modifiers.boss_rush = true
    end,
    stake = 8
}