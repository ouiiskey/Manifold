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

local pips = {
    -- Ranks
    "none",
    -- Suits
    "nothing",
    "wild"
}
for k, v in ipairs(pips) do
    assert(SMODS.load_file("src/pips/" .. v .. ".lua"), MANIF.install .. "src/pips/" .. v .. ".lua")()
end

Shpcp_ref = SMODS.has_playing_card_property
function SMODS.has_playing_card_property(card, key)
    if key == "no_suit" and card.base.suit == "manifold_nothing"
    or key == "no_rank" and card.base.value == "manifold_none"
    or key == "always_scores" and card.base.suit == "manifold_nothing" and card.base.value == "manifold_none"
    or key == "any_suit" and card.base.suit == "manifold_wild" then
        return true
    end
    return Shpcp_ref(card, key)
end