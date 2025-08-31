-- Memory Card
SMODS.Joker {
    key = "memory",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 0, y = 3},
    cost = 6,
    blueprint_compat = true,
    config = {extra = {chips = 0}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        elseif context.ending_shop and not context.blueprint then
            local sell_cost = 0
            for k, v in ipairs(G.jokers.cards) do
                sell_cost = sell_cost + v.sell_cost
            end
            SMODS.scale_card(card, {ref_value = "chips", scalar_table = {sell_cost = sell_cost}, scalar_value = "sell_cost", message_colour = G.C.CHIPS})
        end
    end,
    perishable_compat = false
}