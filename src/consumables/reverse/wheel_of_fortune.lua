-- Reverse Wheel of Fortune
SMODS.Consumable {
    key = "wheel_of_fortune",
    set = "manifold_reverse_tarot",
    pos = G.P_CENTERS.c_wheel_of_fortune.pos,
    set_sprites = function(self, card, front)
        card.children.center.reverse = true
    end,
    cost = 3,
    config = {extra = {numerator = 3, denominator = 4}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, "manifold_wof")
        return {vars = {numerator, denominator}}
    end,
    in_pool = function(self, args)
        return false
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
            if SMODS.pseudorandom_probability(card, "manifold_wof", card.ability.extra.numerator, card.ability.extra.denominator) then
                local pool = SMODS.Edition:get_edition_cards(G.jokers, true)
                local target = pseudorandom_element(pool, pseudoseed("manifold_wof"))
                target:set_edition(poll_edition("manifold_wof", nil, true, true), true)
                check_for_unlock{type = "have_edition"}
            else
                attention_text{text = localize("k_nope_ex"), scale = 1.3, hold = 1.4, major = card, backdrop_colour = G.C.SECONDARY_SET.Tarot, align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and "tm" or "cm", offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0}, silent = true}
                G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.06 * G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound("tarot2", 0.76, 0.4)
                    return true end})
                play_sound("tarot2", 1, 0.4)
            end
            card:juice_up(0.3, 0.5)
            return true end})
        delay(0.6)
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end
}