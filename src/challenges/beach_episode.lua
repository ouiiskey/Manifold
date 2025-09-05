-- Beach Episode
SMODS.Challenge {
    key = "beach_episode",
    rules = {
        custom = {
            {id = "no_reward"},
            {id = "no_extra_hand_money"},
            {id = "no_interest"}
        },
        modifiers = {
            {id = "gold_stake", value = ""},
            {id = "discards", value = 0}
        }
    },
    jokers = {
        {id = "j_manifold_tsunami", eternal = true},
        {id = "j_delayed_grat"},
        {id = "j_manifold_squid", eternal = true},
        {id = "j_manifold_orange_juice"}
    },
    vouchers = {
        {id = "v_grabber"},
        {id = "v_nacho_tong"}
    },
    stake = 8
}