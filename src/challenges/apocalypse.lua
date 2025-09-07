-- Apocalypse
SMODS.Challenge {
    key = "apocalypse",
    rules = {
        custom = {
            {id = "all_perishable"},
            {id = "x_boss", value = 2},
            {id = "x_non_boss", value = 0.5}
        },
        modifiers = {
            {id = "gold_stake", value = ""}
        }
    },
    jokers = {
        {id = "j_manifold_rebellion", perishable = true}
    },
    restrictions = {
        banned_cards = {
            {id = "j_ceremonial"},
            {id = "j_ride_the_bus"},
            {id = "j_runner"},
            {id = "j_constellation"},
            {id = "j_green_joker"},
            {id = "j_red_card"},
            {id = "j_madness"},
            {id = "j_square"},
            {id = "j_vampire"},
            {id = "j_hologram"},
            {id = "j_rocket"},
            {id = "j_obelisk"},
            {id = "j_lucky_cat"},
            {id = "j_flash"},
            {id = "j_trousers"},
            {id = "j_castle"},
            {id = "j_glass"},
            {id = "j_wee"},
            {id = "j_manifold_digi_carrot"},
            {id = "j_manifold_memory"},
            {id = "j_manifold_railgun"},
        }
    },
    apply = function(self)
        G.GAME.modifiers.all_perishable = true
        G.GAME.modifiers.x_boss = 2
        G.GAME.modifiers.x_non_boss = 0.5
        G.GAME.modifiers.start_rebellion = true
    end,
    stake = 8
}