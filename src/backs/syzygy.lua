-- Syzygy Deck, see also syzygy.toml
local prev = "b_manifold_braided"

SMODS.Back {
    key = "syzygy",
    atlas = "backs",
    pos = {x = 5, y = 0},
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
    end
}