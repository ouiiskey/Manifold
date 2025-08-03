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
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, "manifold_proud")
        return {vars = {numerator, denominator}}
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            local wild = false
            local chromed = false
            for k, v in ipairs(context.scoring_hand) do
                if not v.edition and SMODS.has_enhancement(v, "m_wild") then
                    wild = true
                    if SMODS.pseudorandom_probability(card, "manifold_proud", card.ability.extra.numerator, card.ability.extra.denominator, "manifold_proud") then
                        chromed = true
                        -- Card scores as polychrome but shader doesn't come early
                        v:set_edition({polychrome = true}, true, true)
                        v.edition.polychrome = false
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v.edition.polychrome = true
                                v:juice_up()
                                play_sound("polychrome1", 1.2, 0.35)
                                return true end }))
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