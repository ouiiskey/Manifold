-- Zombie Joker
local joker = "j_joker"

SMODS.Joker {
    key = "zombie",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 7, y = 2},
    cost = 5,
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        if G.P_CENTERS[joker].discovered then info_queue[#info_queue + 1] = G.P_CENTERS[joker] end
        return {vars = {localize{type = "name_text", set = "Joker", key = joker}}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "lose" and next(SMODS.find_card("j_joker"))
    end,
    calculate = function(self, card, context)
        if context.hand_drawn and not context.blueprint and G.GAME.current_round.hands_left == 1 and not G.GAME.current_round.final_wave then
            G.GAME.current_round.final_wave = true
            for k, v in ipairs(G.discard.cards) do
                if v:is_face() then
                    draw_card(G.discard, G.hand, nil, nil, nil, v)
                end
            end
            return {
                message = localize("manifold_brains")
            }
        end
    end
}