-- Esper
SMODS.Joker {
    key = "esper",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 0, y = 2},
    cost = 4,
    config = {extra = {c_size = 2}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.c_size}}
    end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.c_size
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.c_size
    end
}