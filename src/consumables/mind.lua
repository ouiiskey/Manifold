-- The Mind, see also mind.toml
-- Note: the SMODS hidden feature is not used because its randomness is flawed and legendary seed sifting is easier this way
SMODS.Atlas {
    key = "mind",
    path = "mind.png",
    px = 71,
    py = 95
}

SMODS.DrawStep {
    key = "mind",
    order = 50,
    func = function(card, layer)
        if card.config.center_key == "c_manifold_mind" and (card.config.center.discovered or card.bypass_discovery_center) then
            local shake = -0.1 + 0.15 * math.sin((G.TIMERS.REAL / 3 - math.floor(G.TIMERS.REAL / 3)) * math.pi * 4) * (1 - G.TIMERS.REAL / 3 + math.floor(G.TIMERS.REAL / 3))^3
            local rotate_mod = (rotate_mod or 0 ) + G.TIMERS.REAL / 2 + 0.15 * math.sin(1.219 * G.TIMERS.REAL)
            local scale_mod = (scale_mod or 0) - 0.1 + 0.005 * math.sin(1.219 * G.TIMERS.REAL / 2)

            G.shared_mind.role.draw_major = card
            G.shared_mind:draw_shader("dissolve", 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, shake, nil, 0.6)
            G.shared_mind:draw_shader("dissolve", nil, nil, nil, card.children.center, scale_mod, rotate_mod, nil, shake)
        end
    end,
    conditions = {vortex = false, facing = "front"}
}

SMODS.Consumable {
    key = "mind",
    set = "Spectral",
    atlas = "spectrals",
    pos = {x = 0, y = 0},
    cost = 4,
    in_pool = function(self, args)
        return false
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
            play_sound("timpani")
            SMODS.add_card{set = "Joker", area = G.jokers, legendary = true, key_append = "manifold_mind"}
            check_for_unlock{type = "spawn_legendary"}
            card:juice_up(0.3, 0.5)
            return true end})
        delay(0.6)
    end,
    can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
    end
}