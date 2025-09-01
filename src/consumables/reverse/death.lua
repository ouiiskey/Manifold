-- Reverse Death
SMODS.Consumable {
    key = "death",
    set = "manifold_reverse_tarot",
    atlas = "reverse_tarots",
    pos = {x = 3, y = 1},
    cost = 3,
    config = {max_highlighted = 1},
    in_pool = function(self, args)
        return false
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{func = function()
            G.playing_card = G.playing_card and G.playing_card + 1 or 1
            local copy = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
            copy:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, copy)
            G.hand:emplace(copy)
            copy:start_materialize()
            SMODS.calculate_context{playing_card_added = true, cards = {copy}}
            return true end})
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.2, func = function()
            SMODS.destroy_cards(G.hand.highlighted[1], nil, true)
            return true end})
        delay(0.3)
    end
}