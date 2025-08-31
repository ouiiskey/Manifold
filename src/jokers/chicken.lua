-- Chicken
local egg = "j_egg"

SMODS.Joker {
    key = "chicken",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 8, y = 2},
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        if G.P_CENTERS[egg].discovered then info_queue[#info_queue + 1] = G.P_CENTERS[egg] end
        return {vars = {localize{type = "name_text", set = "Joker", key = egg}}}
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_left == 0 and not (context.blueprint_card or card).getting_sliced and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event{func = function()
                SMODS.add_card{set = "Joker", area = G.jokers, key = egg, key_append = "manifold_chx"}
                G.GAME.joker_buffer = 0
                return true end})
            return {
                message = localize("manifold_pop")
            }
        end
    end
}