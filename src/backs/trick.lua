-- Trick Deck
SMODS.Back {
    key = "trick",
    atlas = "backs",
    pos = {x = 1, y = 1},
    config = {extra = {c_size = -2, p_size = -1}},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        return {vars = {colours = {G.C.PURPLE}}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "win_stake" and get_deck_win_stake() >= 6
    end,
    loc_vars = function(self, info_queue, back)
        return {vars = {self.config.extra.c_size, self.config.extra.p_size}}
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event{func = function()
            -- Tarots
            local enhance = function(enhancement)
                return function(card)
                    card:set_ability(G.P_CENTERS[enhancement])
                end
            end
            local suit_conv = function(suit)
                return function(card)
                    assert(SMODS.change_base(card, suit))
                end
            end
            local tarots = {
            -- Magician
            enhance("m_lucky"),
            -- Empress
            enhance("m_mult"),
            -- Hierophant
            enhance("m_bonus"),
            -- Lovers
            enhance("m_wild"),
            -- Chariot
            enhance("m_steel"),
            -- Justice
            enhance("m_glass"),
            -- Strength
            function(card)
                assert(SMODS.modify_rank(card, 1))
            end,
            -- Hanged Man
            function(card)
                SMODS.destroy_cards(card, nil, true, true, function() return true end)
            end,
            -- Devil
            enhance("m_gold"),
            -- Tower
            enhance("m_stone"),
            -- Star
            suit_conv("Diamonds"),
            -- Moon
            suit_conv("Clubs"),
            -- Sun
            suit_conv("Hearts"),
            -- World
            suit_conv("Spades")}
            for k, v in ipairs(G.deck.cards) do
                local func = pseudorandom_element(tarots, pseudoseed("manifold_trick"))
                func(v)
            end
            -- Minus slots
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + self.config.extra.c_size
            G.planets.config.card_limit = G.planets.config.card_limit + self.config.extra.p_size
            -- Prevent destroyed cards from reappearing on exit
            G.E_MANAGER:add_event(Event{trigger = "after", func = function()
                G.E_MANAGER:add_event(Event{trigger = "after", func = function()
                    save_run()
                    return true end})
                return true end})
            return true end})
    end
}