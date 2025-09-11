-- Escher, see also escher.toml
SMODS.Joker {
    key = "escher",
    rarity = 4,
    atlas = "jokers",
    pos = {x = 3, y = 4},
    cost = 20,
    soul_pos = {x = 8, y = 4},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {key = "manifold_legendary_unlock"}
    end,
    add_to_deck = function(self, card, from_debuff)
        G.FUNCS.draw_from_discard_to_deck()
    end
}