-- Bob
SMODS.Joker {
    key = "bob",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 3, y = 0},
    cost = 4,
    config = {extra = {x_mult = 3}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.x_mult}}
    end,
    calculate = function(self, card, context)
        if context.other_consumeable and not context.other_consumeable.getting_sliced and not context.blueprint then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
            SMODS.destroy_cards(context.other_consumeable)
            return {
                x_mult = card.ability.extra.x_mult,
                message_card = context.other_consumeable,
                func = function()
                    G.E_MANAGER:add_event(Event{func = function()
                        G.GAME.consumeable_buffer = 0
                        return true end})
                end
            }
        end
    end
}