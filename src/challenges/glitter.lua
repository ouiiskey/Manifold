-- Glitter
SMODS.Challenge {
    key = "glitter",
    rules = {
        custom = {
            {id = "no_flush"}
        },
        modifiers = {
            {id = "gold_stake", value = ""}
        }
    },
    jokers = {
        {id = "j_drunkard", edition = "polychrome"},
        {id = "j_manifold_proud", perishable = true}
    },
    restrictions = {
        banned_other = {
            {id = "bl_psychic", type = "blind"},
            {id = "bl_manifold_final_aether", type = "blind"}
        }
    },
    deck = {cards = {
        {s = "manifold_?", r = "A"}, {s = "manifold_?", r = "A"}, {s = "manifold_?", r = "A"}, {s = "manifold_?", r = "A"},
        {s = "manifold_?", r = "K"}, {s = "manifold_?", r = "K"}, {s = "manifold_?", r = "K"}, {s = "manifold_?", r = "K"},
        {s = "manifold_?", r = "Q"}, {s = "manifold_?", r = "Q"}, {s = "manifold_?", r = "Q"}, {s = "manifold_?", r = "Q"},
        {s = "manifold_?", r = "J"}, {s = "manifold_?", r = "J"}, {s = "manifold_?", r = "J"}, {s = "manifold_?", r = "J"},
        {s = "manifold_?", r = "T"}, {s = "manifold_?", r = "T"}, {s = "manifold_?", r = "T"}, {s = "manifold_?", r = "T"},
        {s = "manifold_?", r = "9"}, {s = "manifold_?", r = "9"}, {s = "manifold_?", r = "9"}, {s = "manifold_?", r = "9"},
        {s = "manifold_?", r = "8"}, {s = "manifold_?", r = "8"}, {s = "manifold_?", r = "8"}, {s = "manifold_?", r = "8"},
        {s = "manifold_?", r = "7"}, {s = "manifold_?", r = "7"}, {s = "manifold_?", r = "7"}, {s = "manifold_?", r = "7"},
        {s = "manifold_?", r = "6"}, {s = "manifold_?", r = "6"}, {s = "manifold_?", r = "6"}, {s = "manifold_?", r = "6"},
        {s = "manifold_?", r = "5"}, {s = "manifold_?", r = "5"}, {s = "manifold_?", r = "5"}, {s = "manifold_?", r = "5"},
        {s = "manifold_?", r = "4"}, {s = "manifold_?", r = "4"}, {s = "manifold_?", r = "4"}, {s = "manifold_?", r = "4"},
        {s = "manifold_?", r = "3"}, {s = "manifold_?", r = "3"}, {s = "manifold_?", r = "3"}, {s = "manifold_?", r = "3"},
        {s = "manifold_?", r = "2"}, {s = "manifold_?", r = "2"}, {s = "manifold_?", r = "2"}, {s = "manifold_?", r = "2"}
    }},
    calculate = function(self, context)
        if context.debuff_hand and next(context.poker_hands.Flush) then
            return {
                debuff = true
            }
        end
    end,
    unlocked = false,
    stake = 8
}