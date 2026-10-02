-- Blank Joker
local boost = 100 -- +100 weight => 10% boost

SMODS.Joker {
    key = "blank",
    rarity = 1,
    atlas = "secret",
    pos = {x = 0, y = 0},
    cost = 1,
    blueprint_compat = false,
    in_pool = function(self, args) return false end,
    no_collection = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.negative_boost = (G.GAME.negative_boost or 0 ) + boost
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.negative_boost = G.GAME.negative_boost - boost
    end
}