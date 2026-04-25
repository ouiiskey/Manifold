SMODS.Atlas {
    key = "pips",
    path = "pips.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "pips_hc",
    path = "pips_hc.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ui",
    path = "ui.png",
    px = 18,
    py = 18
}

SMODS.Atlas {
    key = "ui_hc",
    path = "ui_hc.png",
    px = 18,
    py = 18
}

-- Ranks
-- None, see also none.toml
SMODS.Rank {
    key = "none",
    card_key = "0",
    pos = {x = 13},
    nominal = 0,
    lc_atlas = "pips",
    hc_atlas = "pips_hc",
    shorthand = "0",
    next = {"Ace"},
    straight_edge = true,
    in_pool = function(self, args) return false end,
    hidden = true
}

local Shnr_ref = SMODS.has_no_rank
function SMODS.has_no_rank(card)
    if card.base.value == "manifold_none" then return true end
    return Shnr_ref(card)
end

-- Suits
-- Nothing, see also none.toml
SMODS.Suit {
    key = "nothing",
    card_key = "0",
    pos = {y = 4},
    ui_pos = {x = 0, y = 0},
    lc_atlas = "pips",
    hc_atlas = "pips_hc",
    lc_ui_atlas = "ui",
    hc_ui_atlas = "ui_hc",
    lc_colour = G.C.UI.TEXT_DARK,
    hc_colour = G.C.UI.TEXT_DARK,
    in_pool = function(self, args) return false end,
    hidden = true
}