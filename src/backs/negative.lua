-- Negative Deck
SMODS.Back {
    key = "negative",
    atlas = "backs",
    pos = {x = 4, y = 0},
    unlocked = false,
    check_for_unlock = function(self, args)
        return args.type == "discover_amount" and (args.amount + 1) / G.DISCOVER_TALLIES.total.of >= 1
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event{func = function()
            local target, key = pseudorandom_element(G.deck.cards, pseudoseed("manifold_negative"))
            target:set_edition({negative = true}, true, true)
            return true end})
    end
}