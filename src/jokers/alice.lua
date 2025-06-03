-- Alice
SMODS.Joker{
    key = "alice",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 4, y = 0},
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_hex
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            local _message = ""
            for k, v in ipairs(context.scoring_hand) do
                if v:get_id() == 14 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    _message = _message .. localize("manifold_ace")
                    SMODS.add_card{key = "Spectral", area = G.consumeables, key = "c_hex", key_append = "alice"}
                    -- The card must be added immediately rather than with an event to synergize with Bob
                end
            end
            if _message ~= "" then
                return {
                    message = _message,
                    colour = G.C.SECONDARY_SET.Spectral
                }
            end
        end
    end
}