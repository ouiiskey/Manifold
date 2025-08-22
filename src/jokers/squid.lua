-- Squid Joker
SMODS.Joker {
    key = "squid",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 8, y = 1},
    cost = 6,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            for k, v in ipairs(context.scoring_hand) do
                if not v:is_number() then return end
            end
            ease_discard(1)
            return {
                message = localize("manifold_discard"),
                colour = G.C.RED
            }
        end
    end
}