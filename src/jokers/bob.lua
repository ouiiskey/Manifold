-- Bob
SMODS.Joker {
    key = "bob",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 3, y = 0},
    cost = 4,
    config = {extra = {Xmult = 4}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,
    in_pool = function(self, args)
        for k, v in ipairs(G.consumeables.cards) do
            if v.config.center.set == "Spectral" then
                return true
            end
        end
        for k, v in ipairs(G.playing_cards) do
            if v.seal == "manifold_black" then
                return true
            end
        end
        return next(SMODS.find_card("j_manifold_alice"))
    end,
    calculate = function(self, card, context)
        if context.other_consumeable and not context.blueprint and context.other_consumeable.ability.set == "Spectral" then
            return {
                x_mult = card.ability.extra.Xmult,
                message_card = context.other_consumeable,
                func = function()
                    G.E_MANAGER:add_event(Event({func = function()
                        if SMODS.shatters(context.other_consumeable) then
                            context.other_consumeable:shatter()
                        else
                            context.other_consumeable:start_dissolve()
                        end
                        return true end }))
                end
            }
        end
    end
}