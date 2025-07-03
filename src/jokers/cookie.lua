-- Cookie
SMODS.Joker {
    key = "cookie",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 0, y = 1},
    cost = 5,
    blueprint_compat = true,
    yes_pool_flag = "cookie_baked",
    calculate = function(self, card, context)
        if context.post_trigger and not context.blueprint and to_big(_G.mult) * _G.hand_chips >= to_big(G.GAME.blind.chips) then
            return {
                message = localize("manifold_burnt"),
                colour = G.C.PURPLE,
                func = function() card:eat() end
            }
        elseif context.joker_main then
            return {
                chips = _G.mult
            }
        end
    end,
    eternal_compat = false
}