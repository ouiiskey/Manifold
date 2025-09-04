-- Reverse Fool
SMODS.Consumable {
    key = "fool",
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_fool.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    in_pool = false,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
            attention_text{text = localize("manifold_foreseen"), hold = 1.4, major = card, backdrop_colour = G.C.SECONDARY_SET.Tarot, align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and "tm" or "cm", offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0}, silent = true}
            play_sound("timpani")
            G.GAME.next_tarot = (G.GAME.next_tarot or 0) + 1
            card:juice_up(0.3, 0.5)
            return true end})
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}