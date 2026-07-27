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
        if context.after and not context.blueprint and SMODS.last_hand_oneshot then
            card.getting_sliced = true
            return {
                message = localize("manifold_burnt"),
                message_card = card,
                colour = G.C.PURPLE,
                func = function() card:eat() end
            }
        elseif context.joker_main then
            return {
                chips = mult
            }
        end
    end,
    eternal_compat = false
}