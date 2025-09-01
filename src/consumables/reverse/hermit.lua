-- Reverse Hermit
SMODS.Consumable {
    key = "hermit",
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_hermit.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    config = {extra = {dollars = 20}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars}}
    end,
    in_pool = function(self, args)
        return false
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
            card:juice_up(0.3, 0.5)
            ease_dollars(card.ability.extra.dollars - G.GAME.dollars, true)
            return true end})
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}