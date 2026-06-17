-- Plant vs. Zombie
SMODS.Challenge {
    key = "plant_vs_zombie",
    rules = {
        custom = {
            {id = "plant"},
            {id = "leaf"}
        },
        modifiers = {
            {id = "gold_stake", value = ""}
        }
    },
    jokers = {
        {id = "j_pareidolia", eternal = true},
        {id = "j_manifold_zombie", eternal = true}
    },
    apply = function(self)
        G.GAME.perscribed_bosses = {
            "bl_plant",
            "bl_plant",
            "bl_plant",
            "bl_plant",
            "bl_plant",
            "bl_plant",
            "bl_plant",
            "bl_final_leaf"
        }
    end,
    unlocked = false,
    stake = 8
}