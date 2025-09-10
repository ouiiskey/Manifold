-- Monkey's Paw, see also monkeys_paw.toml
local threshold = 200
local sources = {"jud", "manifold_lib",
} -- Hook: Monkey's Paw banned pools

SMODS.Atlas {
    key = "monkeys_paw",
    path = "monkeys_paw.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "monkeys_paw",
    rarity = 3,
    atlas = "jokers",
    pos = {x = 9, y = 1},
    cost = 4,
    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            card.children.floating_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["manifold_monkeys_paw"], {x = G.GAME.fingers or 0, y = 0})
            card.children.floating_sprite.role.draw_major = card
            card.children.floating_sprite.states.hover.can = false
            card.children.floating_sprite.states.click.can = false
        end
    end,
    soul_pos = {
        x = 0,
        y = 0,
        draw = function(card, scale_mod, rotate_mod)
            local per = 3 - (G.GAME.fingers or 0)
            local y_jerk = 0.05 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 6) * (1 - G.TIMERS.REAL / per + math.floor(G.TIMERS.REAL / per))^3
            local jerk = 0.5 * 71 / 95 * y_jerk
            scale_mod = (scale_mod or 0) + 0.5 * jerk
            rotate_mod = -0.5 * jerk

            card.children.floating_sprite:draw_shader("dissolve", 0, nil, nil, card.children.center, scale_mod, rotate_mod, jerk + 0.08, y_jerk + 0.08, nil, 0.6)
            card.children.floating_sprite:draw_shader("dissolve", nil, nil, nil, card.children.center, scale_mod, rotate_mod, jerk, y_jerk)
        end
    },
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {vars = {threshold}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "lose" and G.GAME.dollars >= threshold
    end,
    blueprint_compat = true,
    no_pool_flag = "ceased",
    config = {extra = {mult = 35, chips = 1, demult = -20, hands = 10}},
    loc_vars = function(self, info_queue, card)
        if G.GAME.fingers == 2 then
            return {vars = {card.ability.extra.demult, card.ability.extra.hands}, key = self.key .. "_two"}
        elseif G.GAME.fingers == 1 then
            return {vars = {card.ability.extra.chips}, key = self.key .. "_one"}
        end
        return {vars = {card.ability.extra.mult}}
    end,
    in_pool = function(self, args)
        if not args then return true end
        for k, v in ipairs(sources) do
            if args.source == v then return false end
        end
        return true
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.fingers == 1 then
                return {
                    chips = card.ability.extra.chips
                }
            end
            return {
                mult = G.GAME.fingers == 2 and card.ability.extra.demult or card.ability.extra.mult
            }
        elseif not context.blueprint then
            if context.cardarea == G.jokers and context.after and G.GAME.fingers == 2 then
                card.ability.extra.hands = card.ability.extra.hands - 1
                if card.ability.extra.hands <= 0 then
                    G.GAME.pool_flags.ceased = true
                    G.GAME.fingers = false
                    return {
                        message = localize("manifold_ceased"),
                        colour = G.C.SECONDARY_SET.Spectral,
                        func = function() card:eat() end
                    }
                end
                return {
                    message = tostring(card.ability.extra.hands),
                    colour = G.C.SECONDARY_SET.Spectral
                }
            elseif context.selling_self then
                G.GAME.fingers = math.min((G.GAME.fingers or 0) + 1, 2)
            end
        end
    end,
    eternal_compat = false
}