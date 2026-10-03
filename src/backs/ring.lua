-- Ring Deck
local prev = "b_manifold_foil"

SMODS.Back {
    key = "ring",
    atlas = "backs",
    pos = {x = 7, y = 0},
    config = {extra = {hand = 1}},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        if G.P_CENTERS[prev].unlocked then
            return {vars = {localize{type = "name_text", set = "Back", key = prev}}}
        else
            return {vars = {localize("k_unknown")}}
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == "win_deck" and get_deck_win_stake(prev) > 0
    end,
    loc_vars = function(self, info_queue, back)
        return {vars = {self.config.extra.hand}}
    end,
    calculate = function(self, back, context)
        if context.main_scoring and next(context.poker_hands["Straight"]) then
            ease_hands_played(self.config.extra.hand)
            return {
                message = localize{type = "variable", key = "a_hands", vars = {self.config.extra.hand}}
            }
        end
    end
}

local Swas_ref = SMODS.wrap_around_straight
function SMODS.wrap_around_straight()
    if G.GAME.selected_back_key.key == "b_manifold_ring" then return true end
    return Swas_ref()
end