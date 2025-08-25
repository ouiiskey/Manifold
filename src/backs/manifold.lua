-- Manifold Deck, see also manifold.toml
SMODS.Back {
    key = "manifold",
    atlas = "backs",
    pos = {x = 0, y = 1},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        return {vars = {colours = {G.C.UI.OUTLINE_LIGHT}}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "win_stake" and get_deck_win_stake() >= 1
    end,
    loc_vars = function(self, info_queue, back)
        return {vars = {colours = {HEX("f96932")}}}
    end
}