-- Reverse Lovers
SMODS.Consumable {
    key = "lovers",
    set = "manifold_reverse_tarot",
    atlas = "reverse_tarots",
    pos = {x = 6, y = 0},
    cost = 3,
    config = {extra = {enhancement = "m_wild"}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.enhancement]
    end,
    in_pool = function(self, args)
        return false
    end,
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