SMODS.Atlas {
    key = "seals",
    path = "seals.png",
    px = 71,
    py = 95
}

-- Black Seal, see also black_seal.toml
SMODS.Seal {
    key = "black",
    atlas = "seals",
    pos = {x = 0, y = 0},
    badge_colour = G.C.BLACK,
    config = {extra = {spectrals = 2}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.seal.extra.spectrals}}
    end
}