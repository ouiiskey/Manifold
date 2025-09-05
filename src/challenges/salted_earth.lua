-- Salted Earth
SMODS.Challenge {
    key = "salted_earth",
    rules = {
        custom = {
            {id = "debuff_cards"}
        },
        modifiers = {
            {id = "gold_stake", value = ""}
        }
    },
    apply = function(self)
        G.GAME.modifiers.debuff_cards = true
        G.E_MANAGER:add_event(Event{func = function()
            for k, v in ipairs(G.deck.cards) do
                v:set_debuff(true)
            end
            return true end})
    end,
    calculate = function(self, context)
        if context.playing_card_added then
            for k, v in ipairs(context.cards) do
                v:set_debuff(true)
            end
        end
    end,
    stake = 8
}