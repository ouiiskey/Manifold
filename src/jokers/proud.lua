-- Proud Joker
SMODS.Joker {
    key = "proud",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 7, y = 3},
    cost = 5,
    blueprint_compat = true,
    config = {extra = {numerator = 1, denominator = 7}},
    in_pool = function(self, args)
        for k, v in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(v, "m_wild") then
                return true
            end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "wild", set = "Other"}
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, "manifold_proud")
        return {vars = {numerator, denominator, colours = {G.C.SUITS.manifold_wild}}}
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            local wild = false
            local chromed = false
            for k, v in ipairs(context.scoring_hand) do
                if not v.edition and SMODS.has_enhancement(v, "m_wild") then
                    wild = true
                    if SMODS.pseudorandom_probability(card, "manifold_proud", card.ability.extra.numerator, card.ability.extra.denominator) then
                        v:set_edition({polychrome = true}, true, chromed)
                        if chromed then
                            G.E_MANAGER:add_event(Event{trigger = "after", blockable = false, func = function()
                                v:juice_up(1, 0.5)
                                return true end})
                        end
                        chromed = true
                    end
                end
            end
            if wild then
                if chromed then
                    return {
                        message = localize("manifold_polychrome"),
                        colour = {pseudorandom("manifold_proud"), pseudorandom("manifold_proud"), pseudorandom("manifold_proud"), 1}
                    }
                end
                return {
                    message = localize("k_nope_ex"),
                    colour = {pseudorandom("manifold_proud"), pseudorandom("manifold_proud"), pseudorandom("manifold_proud"), 1}
                }
            end
        end
    end
}