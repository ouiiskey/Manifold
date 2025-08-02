-- Vanilla
-- Planet Tycoon
SMODS.Voucher:take_ownership("planet_tycoon", {
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({func = function()
            G.planets.config.card_limit = G.planets.config.card_limit + 2
            return true end }))
    end
}, true)