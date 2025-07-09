-- Cthugha, see also cthugha.toml
local sacrifice = "j_misprint"

SMODS.Joker {
    key = "cthugha",
    rarity = 3,
    atlas = "jokers",
    pos = {x = 5, y = 1},
    cost = 6,
    blueprint_compat = true,
    config = {extra = {mult = 33}},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        if G.P_CENTERS.j_ceremonial.discovered then info_queue[#info_queue + 1] = G.P_CENTERS.j_ceremonial end
        if G.P_CENTERS[sacrifice].discovered then info_queue[#info_queue + 1] = G.P_CENTERS[sacrifice] end
        return {vars = {localize{type = "name_text", set = "Joker", key = sacrifice}}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "sacrifice" and args.name == G.P_CENTERS[sacrifice].name
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.chips_text = localize("manifold_unknown_total")
        G.GAME.current_round.current_hand.mult_text = localize("manifold_unknown")
        G.GAME.current_round.current_hand.chip_text = localize("manifold_unknown")
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}