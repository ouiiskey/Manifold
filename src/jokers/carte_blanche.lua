-- Carte Blanche
local get_common = function()
    local counts = {}
    for k, v in ipairs(G.deck and G.deck.cards or {}) do
        for kk, vv in pairs(SMODS.Ranks) do
            if v:is_rank(vv.id) then
                counts[kk] = (counts[kk] or 0) + 1
            end
        end
    end
    local ret = false
    local quant = -1
    for k, v in pairs(counts) do
        if quant < v or quant == v and SMODS.Ranks[ret].id < SMODS.Ranks[k].id then
            ret = k
            quant = v
        end
    end
    return ret and ret or "Ace"
end

SMODS.Joker {
    key = "carte_blanche",
    rarity = 3,
    atlas = "jokers",
    pos = {x = 3, y = 2},
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {vars = {localize(get_common(), "ranks")}}
    end,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint and next(G.hand.cards) then
            local rank = SMODS.Ranks[get_common()].id
            local faces = {}
            for k, v in ipairs(G.deck.cards) do
                if v:is_rank(rank) then
                    table.insert(faces, v)
                end
            end
            for i = 1, #faces do
                draw_card(G.deck, G.hand, i / #faces * 100, nil, nil, faces[i])
            end
            return {
                message = localize("manifold_cashed"),
                colour = G.C.JOKER_GREY
            }
        end
    end,
    eternal_compat = false
}