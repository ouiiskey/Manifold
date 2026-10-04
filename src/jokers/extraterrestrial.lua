-- Extraterrestrial
SMODS.Joker {
    key = "extraterrestrial",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 4, y = 1},
    cost = 4,
    blueprint_compat = true,
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {vars = {localize{type = "name_text", set = "Planet", key = MANIF.home}}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "discover_amount" and G.P_CENTERS[MANIF.home].discovered
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = G.GAME.hands[context.scoring_name].s_chips,
                mult = G.GAME.hands[context.scoring_name].s_mult
            }
        end
    end
}