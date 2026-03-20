-- Matador
SMODS.Joker:take_ownership("matador", {
    calculate = function(self, card, context)
        if context.debuffed_hand or context.joker_main then
            return {} -- To remove vanilla trigger
        end
    end,
    calc_dollar_bonus = function(self, card)
        if G.GAME.chips/G.GAME.blind.chips < 1.5 then
            return 6
        end
    end
}, true)