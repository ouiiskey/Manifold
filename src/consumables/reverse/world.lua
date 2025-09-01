-- Reverse World
SMODS.Consumable {
    key = "world",
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_world.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    config = {extra = {max = 3, suit = "Spades"}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.max, localize(card.ability.extra.suit, "suits_singular"), colours = {G.C.SUITS[card.ability.extra.suit]}}}
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
                if v:is_suit(card.ability.extra.suit) then
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
            if v:is_suit(card.ability.extra.suit) then
                count = count + 1
            end
        end
        return count >= 1 and count <= card.ability.extra.max
    end
}