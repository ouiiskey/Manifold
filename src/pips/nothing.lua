-- Nothing, see also pips.toml
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
    in_pool = function(self, args) return false end
}