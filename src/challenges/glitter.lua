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
        {id = "j_drunkard", edition = "polychrome"}
    },
    restrictions = {
        banned_other = {
            {id = "bl_psychic", type = "blind"}
        }
    },
    deck = {enhancement = "m_wild"},
    calculate = function(self, context)
        if context.debuff_hand and next(context.poker_hands["Flush"]) then
            return {
                debuff = true
            }
        end
    end,
    unlocked = false,
    stake = 8
}