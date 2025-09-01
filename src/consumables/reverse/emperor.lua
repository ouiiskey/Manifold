-- Reverse Emperor
SMODS.Consumable {
    key = "emperor",
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_emperor.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    config = {extra = {payout = 10}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.payout}}
    end,
    in_pool = function(self, args)
        return false
    end,
    use = function(self, card, area, copier)
        local pool = {}
        for k, v in ipairs(G.consumeables.cards) do
            if v.ability.set == "Tarot" or v ~= card and v.ability.set == "manifold_reverse_tarot" then
                table.insert(pool, v)
            end
        end
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
            play_sound("tarot1")
            card:juice_up(0.3, 0.5)
            return true end})
        SMODS.destroy_cards(pseudorandom_element(pool, pseudoseed("manifold_emperor")))
        delay(0.5)
        ease_dollars(card.ability.extra.payout)
        delay(0.3)
    end,
    can_use = function(self, card)
        for k, v in ipairs(G.consumeables.cards) do
            if v.ability.set == "Tarot" or v ~= card and v.ability.set == "manifold_reverse_tarot" then return true end
        end
        return false
    end
}