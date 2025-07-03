-- Hot Potato
SMODS.current_mod.reset_game_globals = function()
    G.GAME.current_round.hot_card = {rank = "Ace"}
    local heatable_cards = {}
    for k, v in ipairs(G.playing_cards) do
        if v.ability.effect ~= 'Stone Card' then
            heatable_cards[#heatable_cards +1] = v
        end
    end
    if heatable_cards[1] then
        local hot_card = pseudorandom_element(heatable_cards, pseudoseed("manif_hot" .. G.GAME.round_resets.ante))
        G.GAME.current_round.hot_card.rank = hot_card.base.value
        G.GAME.current_round.hot_card.id = hot_card.base.id
    end
end

SMODS.Joker{
    key = "hot_potato",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 2, y = 1},
    cost = 6,
    blueprint_compat = true,
    yes_pool_flag = "potato_ate",
    config = {extra = {chips = 300}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, localize(G.GAME.current_round.hot_card and G.GAME.current_round.hot_card.rank or "Ace", "ranks")}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        elseif context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint and context.other_card:is_rank(G.GAME.current_round.hot_card.id) then
            local bones = SMODS.find_card("j_mr_bones")
            if next(bones) and (to_big(G.GAME.chips) + _G.mult * _G.hand_chips) / G.GAME.blind.chips >= to_big(0.25) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound("tarot1")
                        bones[1]:start_dissolve()
                        return true
                    end
                }))
                return {
                    message = localize("k_saved_ex"),
                    message_card = bones[1],
                    colour = G.C.RED
                }
            else
                return {
                    message = localize("manifold_boom"),
                    colour = G.C.RED,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.STATE = G.STATES.GAME_OVER
                                G.STATE_COMPLETE = false
                                return true end }))
                    end
                }
            end
        end
    end
}