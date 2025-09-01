-- Reverse Hanged Man
SMODS.Consumable {
    key = "hanged_man",
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_hanged_man.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    config = {max_highlighted = 2},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.max_highlighted}}
    end,
    in_pool = function(self, args)
        return false
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{func = function()
            local silent
            local new_cards = {}
            for k, v in ipairs(G.hand.highlighted) do
                G.playing_card = G.playing_card and G.playing_card + 1 or 1
                local copy = copy_card(v, nil, nil, G.playing_card)
                copy:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, copy)
                G.hand:emplace(copy)
                copy:start_materialize(nil, silent)
                silent = true
                table.insert(new_cards, copy)
            end
            SMODS.calculate_context{playing_card_added = true, cards = new_cards}
            return true end})
    end
}