-- Braided Deck
local threshold = 130

SMODS.Back {
    key = "braided",
    atlas = "backs",
    pos = {x = 0, y = 0},
    config = {extra = {lvl = 3}},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        return {vars = {threshold}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "discover_amount" and args.amount >= threshold
    end,
    loc_vars = function(self, info_queue, back)
        return {vars = {self.config.extra.lvl}}
    end,
    apply = function(self, back)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(nil, k, true, self.config.extra.lvl - 1)
        end
    end
}