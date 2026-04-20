-- Reverse Death
SMODS.Consumable {
    key = "death",
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_death.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    config = {min_highlighted = 2, max_highlighted = 2},
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.4, func = function()
            play_sound("tarot1")
            card:juice_up(0.3, 0.5)
            return true end}))
        for i = 2, 1, -1 do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.15, func = function()
                G.hand.highlighted[i]:flip()
                play_sound("card1", percent)
                G.hand.highlighted[i]:juice_up(0.3, 0.3)
                return true end}))
        end
        delay(0.2)
        for i = 2, 1, -1 do
            G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.1, func = function()
                if i ~= 1 then
                    assert(SMODS.change_base(G.hand.highlighted[2], nil, G.hand.highlighted[1].base.value))
                end
                return true end}))
        end
        for i = 2, 1, -1 do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.15, func = function()
                G.hand.highlighted[i]:flip()
                play_sound("tarot2", percent, 0.6)
                G.hand.highlighted[i]:juice_up(0.3, 0.3)
                return true end}))
        end
        G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.2, func = function()
            G.hand:unhighlight_all()
            return true end}))
        delay(0.5)
    end
}