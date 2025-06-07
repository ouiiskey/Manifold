-- Bob
MANIF.BOB = {keys = {"j_manifold_alice", "j_sixth_sense", "j_seance",
}}

SMODS.Joker {
    key = "bob",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 3, y = 0},
    cost = 4,
    config = {extra = {Xmult = 3, id = 0}},
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
        for k, v in ipairs(MANIF.BOB.keys) do
            if next(SMODS.find_card(v)) then
                return true
            end
        end
        return false
    end,
    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            card.ability.extra.id = G.GAME.bob_count or 0
            G.GAME.bob_count = card.ability.extra.id + 1
        end
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.before and not G.GAME.main_bob then
                G.GAME.main_bob = card.ability.extra.id
            elseif context.other_consumeable and G.GAME.main_bob == card.ability.extra.id and context.other_consumeable.ability.set == "Spectral" then
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
            elseif context.after then
                G.GAME.main_bob = false
            end
        end
    end
}