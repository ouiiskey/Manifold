-- Reverse Temperance
SMODS.Consumable {
    key = "temperance",
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_temperance.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    config = {extra = {dollars = 2}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars}}
    end,
    in_pool = function(self, args)
        return false
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
            play_sound("timpani")
            card:juice_up(0.3, 0.5)
            local empty = true
            for k, v in ipairs(G.jokers.cards) do
                if v.set_cost then
                    empty = false
                    v.ability.extra_value = (v.ability.extra_value or 0) + card.ability.extra.dollars
                    v:set_cost()
                end
            end
            local text = localize("k_val_up")
            local scale
            if empty then
                text = localize("k_nope_ex")
                scale = 1.3
            end
            attention_text{text = text, scale = scale, hold = 1.4, major = card, backdrop_colour = G.C.SECONDARY_SET.Tarot, align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and "tm" or "cm", offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0}, silent = true}
            return true end})
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}