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
        -- SMODS.last_hand_oneshot is not used because it is not granular enough
        if (context.before or context.main_scoring or context.individual or context.pre_joker or context.joker_main or context.other_joker or context.post_joker or context.final_scoring_step) and not context.blueprint and mult and hand_chips and to_big(mult) * hand_chips >= to_big(G.GAME.blind.chips) and not card.getting_sliced then
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