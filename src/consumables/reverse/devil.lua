-- Reverse Devil
SMODS.Consumable {
    key = "devil",
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_devil.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    config = {extra = {enhancement = "m_gold"}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.enhancement]
    end,
    in_pool = false,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
            play_sound("tarot1")
            card:juice_up(0.3, 0.5)
            return true end})
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.2, func = function()
            local target
            for k, v in ipairs(G.hand.highlighted) do
                if SMODS.has_enhancement(v, card.ability.extra.enhancement) then
                    target = v
                    break
                end
            end
            SMODS.destroy_cards(target, nil, true)
            return true end})
        delay(0.3)
    end,
    can_use = function(self, card)
        local count = 0
        for k, v in ipairs(G.hand.highlighted) do
            if SMODS.has_enhancement(v, card.ability.extra.enhancement) then
                count = count + 1
            end
        end
        return count == 1
    end
}