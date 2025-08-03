-- Envious Joker
SMODS.Joker {
    key = "envious",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 8, y = 3},
    cost = 5,
    in_pool = function(self, args)
        for k, v in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(v, "m_wild") then
                return true
            end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            local envy = false
            for k, v in ipairs(context.full_hand) do
                if not SMODS.in_scoring(v, context.scoring_hand) then
                    envy = true
                    v:set_ability(G.P_CENTERS.m_wild, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                        return true end }))
                end
            end
            if envy then
                return {
                    message = localize("manifold_wild"),
                    colour = G.C.GREEN
                }
            end
        end
    end
}