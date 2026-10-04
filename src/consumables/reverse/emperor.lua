-- Reverse Emperor
SMODS.Consumable {
    key = "emperor",
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_emperor.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "tag_meteor", set = "Tag"}
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{func = function()
            add_tag(Tag("tag_meteor"))
            play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
            play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
            return true end})
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}