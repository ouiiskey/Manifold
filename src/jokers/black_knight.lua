-- Black Knight
SMODS.Joker {
    key = "black_knight",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 2, y = 0},
    cost = 7,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = SMODS.Seals["manifold_black"]
    end,
    in_pool = function(self, args)
        for k, v in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(v, "m_steel") then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and not context.blueprint then
            local _sealed = false
            for k, v in ipairs(context.scoring_hand) do
                if not v.seal and SMODS.has_enhancement(v, "m_steel") then
                    _sealed = true
                    v:set_seal("manifold_black", nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
            if _sealed then
                return {
                    message = localize("manifold_black"),
                    colour = G.C.BLACK
                }
            end
        end
    end
}