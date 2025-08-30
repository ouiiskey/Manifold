-- Orientable Deck, see also orientable.toml
-- if ((card.area == G.consumeables and G.consumeables) or (card.area == G.pack_cards and G.pack_cards)) and
local prev = "b_manifold_polychrome"

local GUcfb_ref = G.UIDEF.card_focus_button
function G.UIDEF.card_focus_button(args)
    if args.type == "reverse" then
        return
    else
        return GUcfb_ref(args)
    end
end

SMODS.Back {
    key = "orientable",
    atlas = "backs",
    pos = {x = 9, y = 0},
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