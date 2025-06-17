-- Cookie Dough
SMODS.Joker{
    key = "cookie_dough",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 9, y = 0},
    cost = 5,
    blueprint_compat = true,
    no_pool_flag = "cookie_baked",
    calculate = function(self, card, context)
        if context.post_trigger and not context.blueprint and _G.mult and _G.hand_chips and _G.mult * _G.hand_chips >= G.GAME.blind.chips then
            G.GAME.pool_flags.cookie_baked = true
            return {
                message = localize("manifold_baked"),
                colour = G.C.PURPLE,
                func = function() card:eat() end
            }
        elseif context.joker_main then
            return {
                mult = _G.hand_chips
            }
        end
    end,
    eternal_compat = false
}