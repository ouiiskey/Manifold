-- Grim
SMODS.Consumable:take_ownership("grim", {
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = SMODS.Seals["manifold_black"]
    end,
    use = function(self, card, area, copier)
        local _conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))

        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            _conv_card:set_seal("manifold_black", nil, true)
            return true end }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted == 1 and G.hand.highlighted[1] and not G.hand.highlighted[1].seal
    end
}, true)