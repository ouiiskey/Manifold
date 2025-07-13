-- Nyarlathotep
local sacrifice = "j_cavendish"

SMODS.Joker {
    key = "nyarlathotep",
    rarity = 3,
    atlas = "jokers",
    pos = {x = 6, y = 1},
    cost = 6,
    blueprint_compat = true,
    config = {extra = {x_mult = 3}},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        if G.P_CENTERS.j_ceremonial.discovered then info_queue[#info_queue + 1] = G.P_CENTERS.j_ceremonial end
        if G.P_CENTERS[sacrifice].discovered then info_queue[#info_queue + 1] = G.P_CENTERS[sacrifice] end
        return {vars = {localize{type = "name_text", set = "Joker", key = sacrifice}}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "sacrifice" and args.name == G.P_CENTERS[sacrifice].name
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.x_mult}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.jokers:unhighlight_all()
            for k, v in ipairs(G.jokers.cards) do
                v:flip()
            end
            if #G.jokers.cards > 1 then
                G.E_MANAGER:add_event(Event({ trigger = "after", delay = 0.2, func = function()
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle("nyar"); play_sound("cardSlide1", 0.85);return true end }))
                    delay(0.15)
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle("nyar"); play_sound("cardSlide1", 1.15);return true end }))
                    delay(0.15)
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle("nyar"); play_sound("cardSlide1", 1);return true end }))
                    delay(0.5)
                    return true end }))
            end
        elseif context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end
}