-- Archwizard
SMODS.Joker {
    key = "archwizard",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 1, y = 0},
    cost = 5,
    blueprint_compat = true,
    config = {extra = {mult = 999999, every = 13}},
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.archwizard_remaining = card.ability.extra.every - 1
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.mult,
            card.ability.extra.every,
            localize{
                type = "variable",
                key = card.ability.archwizard_remaining == 0 and "loyalty_active" or "loyalty_inactive",
                vars = {card.ability.archwizard_remaining}
            }
        }}
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            card.ability.archwizard_remaining = (card.ability.extra.every - 2 - G.GAME.hands_played + card.ability.hands_played_at_create) % card.ability.extra.every
            if card.ability.archwizard_remaining == 0 then
                juice_card_until(card, function(archwizard) return (archwizard.ability.archwizard_remaining == 0) end)
            end
        elseif context.joker_main then
            if card.ability.archwizard_remaining == 0 then
                return {
                    message = localize("manifold_boom"),
                    mult_mod = card.ability.extra.mult
                }
            end
        end
    end
}