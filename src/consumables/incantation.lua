-- Incantation
SMODS.Consumable:take_ownership("incantation", {
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "e_negative_playing_card", set = "Edition", config = {extra = G.P_CENTERS.e_negative.config.card_limit}}
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.4, func = function()
            local _card = create_playing_card({
                front = pseudorandom_element(G.P_CARDS, pseudoseed("inc_fr")),
                center = G.P_CENTERS.c_base}, G.deck, nil, nil, {G.C.SECONDARY_SET.Edition})
            _card:set_edition({negative = true}, true)
            _card:add_to_deck()
            G.hand:change_size(-2)
            card:juice_up(0.3, 0.5)
            return true end }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}, true)