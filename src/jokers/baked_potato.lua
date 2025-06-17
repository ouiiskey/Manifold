-- Baked Potato
SMODS.Joker{
    key = "baked_potato",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 1, y = 1},
    cost = 5,
    blueprint_compat = true,
    no_pool_flag = "potato_ate",
    config = {extra = {chips = 30, triggers = 30}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, card.ability.extra.triggers}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if not context.blueprint then
                card.ability.extra.triggers = card.ability.extra.triggers - 1
            end
            return {
                chips = card.ability.extra.chips
            }
        elseif not context.blueprint and context.retrigger_joker_check and context.other_card == card and _G.mult * (_G.hand_chips + card.ability.extra.chips) < G.GAME.blind.chips and card.ability.extra.chips > 0 then
            return {
                message = localize("k_again_ex"),
                repetitions = math.min(math.ceil((G.GAME.blind.chips / _G.mult - _G.hand_chips) / card.ability.extra.chips) - 1, card.ability.extra.triggers),
                card = card
            }
        elseif context.post_trigger and not context.blueprint and card.ability.extra.triggers <= 0 then
            G.GAME.pool_flags.potato_ate = true
            return {
                message = localize("k_eaten_ex"),
                colour = G.C.CHIPS,
                func = function() card:eat() end
            }
        end
    end,
    eternal_compat = false
}