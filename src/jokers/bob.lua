-- Bob
local keys = {"j_manifold_alice", "j_sixth_sense", "j_seance",
} -- Hook: Bob in_pool keys

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
        for k, v in ipairs(keys) do
            if next(SMODS.find_card(v)) then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.other_consumeable and not context.other_consumeable.getting_sliced and not context.blueprint and context.other_consumeable.ability.set == "Spectral" then
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