-- Propaganda, see also propaganda.toml
SMODS.Joker {
    key = "propaganda",
    rarity = 3,
    atlas = "jokers",
    pos = {x = 3, y = 3},
    cost = 6,
    blueprint_compat = true,
    config = {extra = {x_mult = 3}},
    unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == "win_custom" then
            for k, v in ipairs(G.jokers.cards) do
                if v.config.center.rarity ~= 1 and v.config.center.rarity ~= "Common" then
                    return false
                end
            end
            return true
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.x_mult}}
    end,
    add_to_deck = function(self, card, from_debuff)
        for k, v in ipairs(G.jokers.cards) do
            if v ~= card and v.config.center.rarity ~= 1 and v.config.center.rarity ~= "Common" then
                v:set_debuff(true)
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in ipairs(G.jokers.cards) do
            if v ~= card then
                G.GAME.blind:debuff_card(v)
            end
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        elseif context.card_added and not context.blueprint then
            if context.card.ability.set == "Joker" and context.card.config.center.rarity ~= 1 and context.card.config.center.rarity ~= "Common" then
                context.card:set_debuff(true)
            end
        end
    end
}