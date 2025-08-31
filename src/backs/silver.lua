-- Silver Deck
local threshold = 170

SMODS.Back {
    key = "silver",
    atlas = "backs",
    pos = {x = 1, y = 0},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        return {vars = {threshold}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "discover_amount" and args.amount >= threshold
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event{func = function()
            SMODS.add_card{set = "Joker", area = G.jokers, key_append = "manifold_silver"}
            return true end})
    end
}