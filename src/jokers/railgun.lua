-- Railgun
SMODS.Joker {
    key = "railgun",
    rarity = 3,
    atlas = "jokers",
    pos = {x = 1, y = 3},
    cost = 8,
    blueprint_compat = true,
    config = {extra = {mult = 0, modifier = 1, parity = "none"}},
    loc_vars = function(self, info_queue, card)
        local parity
        if card.ability.extra.parity == "none" or card.ability.extra.parity == "both" then
            parity = localize("manifold_parity_any")
        else
            parity = localize("manifold_opposite_" .. card.ability.extra.parity)
        end
        return {vars = {card.ability.extra.modifier, card.ability.extra.mult, parity}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        elseif context.individual and context.cardarea == G.play and not context.blueprint then
            local prev = card.ability.extra.parity
            card.ability.extra.parity = context.other_card:get_parity()
            if card.ability.extra.parity == "none" then
                if prev ~= "none" then
                    card.ability.extra.mult = 0
                    return {
                        message = localize("k_reset"),
                        message_card = card
                    }
                end
            elseif prev == card.ability.extra.parity and prev ~= "both" then
                card.ability.extra.mult = card.ability.extra.modifier
                return {
                    message = localize("k_reset"),
                    message_card = card
                }
            else
                SMODS.scale_card(card, {ref_value = "mult", scalar_value = "modifier", no_message = true})
            end
        end
    end,
    perishable_compat = false
}