SMODS.Atlas {
    key = "stickers",
    path = "stickers.png",
    px = 71,
    py = 95
}

-- Premium Sticker, see also premium.toml
SMODS.Sticker {
    key = "premium",
    atlas = "stickers",
    pos = {x = 0, y = 0},
    badge_colour = HEX("b96050"),
    sets = {Joker = true},
    needs_enable_flag = true,
    apply = function(self, card, val)
        card.ability.manifold_premium = val
        card:set_cost()
    end
}

-- Leftmost Sticker, this code exists only for texture and collection
SMODS.Sticker {
    key = "pinned_left",
    badge_colour = G.C.ORANGE,
    prefix_config = {key = false},
    atlas = "stickers",
    pos = {x = 1, y = 0},
    rate = 0,
    should_apply = false
}

-- Rightmost Sticker, this code exists only for texture and collection
SMODS.Sticker {
    key = "pinned_right",
    badge_colour = G.C.ORANGE,
    prefix_config = {key = false},
    atlas = "stickers",
    pos = {x = 2, y = 0},
    rate = 0,
    should_apply = false
}