-- Manifold Deck, see also manifold.toml
SMODS.Back {
    key = "manifold",
    atlas = "backs",
    pos = {x = 5, y = 0},
    loc_vars = function(self, info_queue, back)
        return {vars = {colours = {HEX("f96932")}}}
    end
}