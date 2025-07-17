-- Hastur
local sacrifice = "j_stuntman"

SMODS.Joker {
    key = "hastur",
    rarity = 3,
    atlas = "jokers",
    pos = {x = 7, y = 1},
    cost = 6,
    blueprint_compat = true,
    config = {extra = {chips = 333}},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        if G.P_CENTERS.j_ceremonial.discovered then info_queue[#info_queue + 1] = G.P_CENTERS.j_ceremonial end
        if G.P_CENTERS[sacrifice].discovered then info_queue[#info_queue + 1] = G.P_CENTERS[sacrifice] end
        return {vars = {localize{type = "name_text", set = "Joker", key = sacrifice}}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "sacrifice" and args.name == G.P_CENTERS[sacrifice].name
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
        if context.stay_flipped then
            return {
                stay_flipped = true
            }
        elseif context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}