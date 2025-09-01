-- Reverse Strength
SMODS.Consumable {
    key = "strength",
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_strength.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    config = {max_highlighted = 2},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.max_highlighted}}
    end,
    in_pool = function(self, args)
        return false
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
            play_sound("tarot1")
            card:juice_up(0.3, 0.5)
            return true end})
        for k, v in ipairs(G.hand.highlighted) do
            local percent = 1.15 - (k - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.15, func = function()
                v:flip()
                play_sound("card1", percent)
                v:juice_up(0.3, 0.3)
                return true end})
        end
        delay(0.2)
        for k, v in ipairs(G.hand.highlighted) do
            G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.1, func = function()
                assert(SMODS.modify_rank(v, -1))
                return true end})
        end
        for k, v in ipairs(G.hand.highlighted) do
            local percent = 0.85 + (k - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.15, func = function()
                v:flip()
                play_sound("tarot2", percent, 0.6)
                v:juice_up(0.3, 0.3)
                return true end})
        end
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.2, func = function()
            G.hand:unhighlight_all()
            return true end})
        delay(0.5)
    end
}