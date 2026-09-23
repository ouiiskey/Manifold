-- Deity, see also pips.toml and debuff.toml
SMODS.Atlas {
    key = "deity",
    path = "deity.png",
    px = 71,
    py = 95,
    atlas_table = "ANIMATION_ATLAS",
    frames = 13,
    fps = 6
}

SMODS.Atlas {
    key = "deity_hc",
    path = "deity_hc.png",
    px = 71,
    py = 95,
    atlas_table = "ANIMATION_ATLAS",
    frames = 13,
    fps = 6
}

SMODS.Rank {
    key = "deity",
    card_key = "R",
    pos = {x = 14},
    nominal = 95,
    face = true,
    lc_atlas = "deity",
    hc_atlas = "deity_hc",
    shorthand = "R",
    next = {"manifold_none"},
    straight_edge = true,
    suit_map = {Hearts = 0, Clubs = 1, Diamonds = 2, Spades = 3, manifold_nothing = 4, manifold_wild = 5},
    in_pool = function(self, args) return false end,
    hidden = true
}