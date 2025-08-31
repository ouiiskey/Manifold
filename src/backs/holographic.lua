-- Holographic Deck
local threshold = 190

SMODS.Back {
    key = "holographic",
    atlas = "backs",
    pos = {x = 3, y = 0},
    config = {extra = {amt = 3}},
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
                local target, key = pseudorandom_element(targets, pseudoseed("manifold_holo"))
                target:set_edition({holo = true}, true, true)
                table.remove(targets, key)
            end
            return true end})
    end
}