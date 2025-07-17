-- Squid Joker
SMODS.Joker {
    key = "squid",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 8, y = 1},
    cost = 6,
    blueprint_compat = true,
    config = {extra = {discards = 1}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.discards}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for k, v in ipairs(context.full_hand) do
                if v.debuff or v:is_face() or v:is_rank(14) then return end
            end
            ease_discard(card.ability.extra.discards)
            return {
                message = "+" .. card.ability.extra.discards .. " " .. localize("b_discard"),
                colour = G.C.RED
            }
        end
    end
}