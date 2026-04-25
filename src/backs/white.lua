-- White Deck
local threshold = 100

SMODS.Back {
    key = "white",
    atlas = "backs",
    pos = {x = 4, y = 1},
    config = {extra = {joker_mod = 1, amt = 13}},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        return {vars = {threshold}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "discover_amount" and args.amount >= threshold
    end,
    loc_vars = function(self, info_queue, back)
        return {vars = {self.config.extra.joker_mod, self.config.extra.amt}}
    end,
    apply = function(self, back)
        G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 1
        G.E_MANAGER:add_event(Event{func = function()
            for i = 1, self.config.extra.amt do
                card_from_control({s = "manifold_0", r = "manifold_0"})
            end
            return true end})
    end
}