-- Reverse Hierophant
SMODS.Consumable {
    key = "heirophant", -- Typo is intentional
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_heirophant.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    config = {extra = {max = 2, enhancement = "m_bonus"}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.enhancement]
        return {vars = {card.ability.extra.max}}
    end,
    in_pool = false,
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
            SMODS.destroy_cards(marked, nil, true, nil, function(k, v) return k == #marked end)
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
        return count >= 1 and count <= card.ability.extra.max
    end
}