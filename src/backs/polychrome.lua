-- Polychrome Deck
local threshold = 200

SMODS.Back {
    key = "polychrome",
    pos = {x = 5, y = 2},
    config = {extra = {amt = 2}},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        return {vars = {threshold}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "discover_amount" and args.amount >= threshold
    end,
    loc_vars = function(self, info_queue, back)
        return {vars = {self.config.extra.amt}}
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event{func = function()
            local targets = {}
            for k, v in ipairs(G.deck.cards) do
                table.insert(targets, v)
            end
            for i = 1, self.config.extra.amt do
                local target, key = pseudorandom_element(targets, pseudoseed("manifold_poly"))
                target:set_edition({polychrome = true}, true, true)
                table.remove(targets, key)
            end
            return true end})
    end
}