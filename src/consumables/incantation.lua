-- Incantation
SMODS.Consumable:take_ownership("incantation", {
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'e_negative_playing_card', set = 'Edition', config = {extra = G.P_CENTERS['e_negative'].config.card_limit}}
    end,
    use = function(self, card, area, copier)
        local _pool = {}
        for k, v in ipairs(G.hand.cards) do
            if v.playing_card and not v.edition then
                table.insert(_pool, v)
            end
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local _eligible_card = pseudorandom_element(_pool, pseudoseed("incantation"))
            _eligible_card:set_edition({negative = true}, true)
            card:juice_up(0.3, 0.5)
            return true end }))
        delay(0.6)
    end,
    can_use = function(self, card)
        for k, v in ipairs(G.hand.cards) do
            if v.playing_card and not v.edition then
                return true
            end
        end
        return false
    end
}, true)