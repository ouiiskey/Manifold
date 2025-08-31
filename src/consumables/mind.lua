-- The Mind, see also mind.toml
-- Note: the SMODS hidden feature is not used because its randomness is flawed and legendary seed sifting is easier this way
SMODS.Atlas {
    key = "mind",
    path = "mind.png",
    px = 71,
    py = 95
}

SMODS.Consumable {
    key = "mind",
    set = "Spectral",
    atlas = "spectrals",
    pos = {x = 0, y = 0},
    cost = 4,
    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            card.children.floating_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["manifold_mind"], {x = 0, y = 0})
            card.children.floating_sprite.role.draw_major = card
            card.children.floating_sprite.states.hover.can = false
            card.children.floating_sprite.states.click.can = false
        end
    end,
    soul_pos = {
        x = 0,
        y = 0,
        draw = function(card, scale_mod, rotate_mod)
            local shake = -0.1 + 0.15 * math.sin((G.TIMERS.REAL / 3 - math.floor(G.TIMERS.REAL / 3)) * math.pi * 4) * (1 - G.TIMERS.REAL / 3 + math.floor(G.TIMERS.REAL / 3))^3
            rotate_mod = (rotate_mod or 0 ) + G.TIMERS.REAL / 2 + 0.15 * math.sin(1.219 * G.TIMERS.REAL)
            scale_mod = (scale_mod or 0) - 0.1 + 0.005 * math.sin(1.219 * G.TIMERS.REAL / 2)

            card.children.floating_sprite:draw_shader("dissolve", 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, shake, nil, 0.6)
            card.children.floating_sprite:draw_shader("dissolve", nil, nil, nil, card.children.center, scale_mod, rotate_mod, nil, shake)
        end
    },
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
        return #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers
    end
}