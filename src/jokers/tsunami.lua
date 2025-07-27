-- Tsunami, see also tsunami.toml
local splash = "j_splash"
local quantity = 2

SMODS.Joker {
    key = "tsunami",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 6, y = 2},
    cost = 6,
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        if G.P_CENTERS[splash].discovered then info_queue[#info_queue + 1] = G.P_CENTERS[splash] end
        return {vars = {quantity, localize{type = "name_text", set = "Joker", key = splash}}}
    end,
    check_for_unlock = function(self, args)
        return args.type == splash and args.quantity >= quantity
    end
}