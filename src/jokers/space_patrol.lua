-- Space Patrol
SMODS.Joker {
    key = "space_patrol",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 5, y = 0},
    cost = 4,
    config = {extra = {p_size = 2}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.p_size}}
    end,
    add_to_deck = function(self, card, from_debuff)
        G.planets.config.card_limit = G.planets.config.card_limit + card.ability.extra.p_size
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.planets.config.card_limit = G.planets.config.card_limit - card.ability.extra.p_size
    end
}