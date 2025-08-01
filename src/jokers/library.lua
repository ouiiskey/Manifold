-- Library Card
SMODS.Joker {
    key = "library",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 5, y = 2},
    cost = 6,
    blueprint_compat = true,
    config = {extra = {amount = 2}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "rental", set = "Other", vars = {G.GAME.rental_rate or 1}}
        return {vars = {card.ability.extra.amount}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not (context.blueprint_card or card).getting_sliced and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.amount, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for i = 1, jokers_to_create do
                        local lent = SMODS.add_card{set = "Joker", area = G.jokers, key_append = "manifold_lib", stickers = {"rental"}}
                        lent:start_materialize()
                        G.GAME.joker_buffer = 0
                    end
                    return true end }))
            return {
                message = localize("k_plus_joker"),
                colour = G.C.BLUE
            }
        end
    end
}