-- Chance Deck
local prev = "b_anaglyph"

SMODS.Back {
    key = "chance",
    atlas = "backs",
    pos = {x = 6, y = 1},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        if G.P_CENTERS[prev].unlocked then
            return {vars = {localize{type = "name_text", set = "Back", key = prev}, colours = {G.C.ORANGE}}}
        else
            return {vars = {localize("k_unknown"), colours = {G.C.ORANGE}}}
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == "win_deck" and get_deck_win_stake(prev) >= 7
    end,
    calculate = function(self, back, context)
        if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            G.E_MANAGER:add_event(Event{func = function()
                add_tag(Tag(get_next_tag_key("manifold_chance")))
                play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                return true end})
        end
    end
}