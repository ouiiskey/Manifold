SMODS.Joker{
    key = "alice",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 4, y = 0},
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_hex
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            return {
                message = localize("manifold_a"),
                message_card = context.blueprint and context.blueprint_card or card,
                colour = G.C.SECONDARY_SET.Spectral,
                func = function()
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = "before",
                        delay = 0.0,
                        func = (function()
                            local _hex = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_hex", "alice")
                            _hex:add_to_deck()
                            G.consumeables:emplace(_hex)
                            G.GAME.consumeable_buffer = 0
                            return true end )}))
                end
            }
        end
    end
}