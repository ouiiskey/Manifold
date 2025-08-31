-- Reverse Magician
SMODS.Consumable {
    key = "magician",
    set = "manifold_reverse_tarot",
    atlas = "reverse_tarots",
    pos = {x = 1, y = 0},
    cost = 3,
    config = {extra = {max = 2, enhancement = "m_lucky"}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.enhancement]
        return {vars = {card.ability.extra.max}}
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
            local marked = {}
            for k, v in ipairs(G.hand.highlighted) do
                if SMODS.has_enhancement(v, card.ability.extra.enhancement) then
                    table.insert(marked, v)
                    if #marked == card.ability.extra.max then break end
                end
            end
            SMODS.destroy_cards(marked, nil, true, nil, true, function(k, v) return k == #marked end)
            return true end})
        delay(0.3)
    end,
    can_use = function(self, card)
        if G.hand and #G.hand.highlighted >= 1 then
            local count = 0
            for k, v in ipairs(G.hand.highlighted) do
                if SMODS.has_enhancement(v, card.ability.extra.enhancement) then
                    count = count + 1
                end
            end
            return count >= 1 and count <= card.ability.extra.max
        end
        return false
    end
}