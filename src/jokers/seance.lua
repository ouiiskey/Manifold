-- Seance
SMODS.Joker:take_ownership("seance", {
    calculate = function(self, card, context)
        if context.final_scoring_step and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and next(context.poker_hands[card.ability.extra.poker_hand]) then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event{func = function()
                SMODS.add_card{set = "Spectral", area = G.consumeables, key_append = "sea"}
                G.GAME.consumeable_buffer = 0
                return true end})
            return {
                message = localize("k_plus_spectral"),
                colour = G.C.SECONDARY_SET.Spectral
            }
        elseif context.joker_main then
            return {} -- To remove vanilla trigger
        end
    end
}, true)