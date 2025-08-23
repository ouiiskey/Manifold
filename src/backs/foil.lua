-- Foil Deck
local threshold = 180

SMODS.Back {
    key = "foil",
    atlas = "backs",
    pos = {x = 2, y = 0},
    config = {extra = {amt = 4}},
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
        G.E_MANAGER:add_event(Event({
            func = function()
                local targets = {}
                for k, v in ipairs(G.deck.cards) do
                    table.insert(targets, v)
                end
                for i = 1, self.config.extra.amt do
                    local target, key = pseudorandom_element(targets, pseudoseed("manifold_foil"))
                    target:set_edition({foil = true}, true, true)
                    table.remove(targets, key)
                end
                return true end }))
    end
}