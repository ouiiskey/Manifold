-- Rocky Deck
local prev = "b_zodiac"

SMODS.Back {
    key = "rocky",
    atlas = "backs",
    pos = {x = 3, y = 1},
    config = {extra = {amt = 36}},
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
        return {vars = {self.config.extra.amt}}
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event{func = function()
            for k, v in ipairs(G.deck.cards) do
                if v:is_number() then
                    v:set_ability(G.P_CENTERS["m_stone"])
                end
            end
            return true end})
    end
}