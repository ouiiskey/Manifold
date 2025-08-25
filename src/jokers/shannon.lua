-- Shannon
SMODS.Joker {
    key = "shannon",
    rarity = 4,
    atlas = "jokers",
    pos = {x = 4, y = 4},
    cost = 20,
    soul_pos = {x = 9, y = 4},
    unlocked = false,
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers and not card.debuff then
            local nodes = {}
            for i = 1, #G.jokers.cards do
                local bg_color, txt_color
                if G.jokers.cards[i] == card then
                    bg_color = G.C.GREY
                    txt_color = G.C.UI.TEXT_LIGHT
                elseif G.jokers.cards[i].config.center.blueprint_compat then
                    bg_color = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
                    txt_color = bg_color
                else
                    bg_color = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
                    txt_color = G.C.UI.TEXT_LIGHT
                end
                if G.jokers.cards[i].debuff then
                    txt_color = G.C.UI.TEXT_LIGHT
                end
                table.insert(nodes, {n = G.UIT.C, config = {ref_table = card, align = "m", colour = bg_color, r = 5, padding = 0.06}, nodes = {{n = G.UIT.T, config = {text = "X", colour = txt_color, scale = 0.32 * 0.8}}}})
                if i < #G.jokers.cards then
                    table.insert(nodes, {n = G.UIT.C, config = {ref_table = card, align = "m", colour = G.C.BACKGROUND_WHITE, r = 0.5, padding = 0.06}, nodes = {{n = G.UIT.T, config = {text = "|", colour = G.C.BACKGROUND_WHITE, scale = 0.32 * 0.8}}}})
                end
            end
            return {main_end = {{n = G.UIT.C, config = {align = "bm", minh = 0.4}, nodes = nodes}}}
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            delay = 0.1,
            func = function()
                local targets = {}
                local recent = 0
                for k, v in ipairs(G.jokers.cards) do
                    if v.debuff and v.ability.shannon_recent then
                        recent = recent + 1
                        if v ~= card then table.insert(targets, v) end
                    end
                end
                if recent > #SMODS.find_card("j_manifold_shannon") then
                    local target = pseudorandom_element(targets, pseudoseed("manifold_shannon_remove"))
                    if target then
                        target:set_debuff(false)
                        target.ability.shannon_recent = false
                    end
                end
                return true end }))
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.setting_blind then
                for k, v in ipairs(G.jokers.cards) do
                    v.ability.shannon_recent = false
                end
            end
            if context.setting_blind or context.after and context.cardarea == G.jokers then
                -- Nested events required in case of more than one Shannon
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local jokers = {}
                        for k, v in ipairs(G.jokers.cards) do
                            if v ~= card and (not v.debuff and not v.ability.shannon_recent or #G.jokers.cards - #SMODS.find_card("j_manifold_shannon") < 2) then table.insert(jokers, v) end
                            if v.ability.shannon_recent then
                                v:set_debuff(false)
                                v.ability.shannon_recent = false
                            end
                        end
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                if not card.debuff then
                                    local targets = {}
                                    for k, v in ipairs(jokers) do
                                        if not v.debuff then table.insert(targets, v) end
                                    end
                                    local target = pseudorandom_element(targets, pseudoseed("manifold_shannon"))
                                    if target then
                                        target:set_debuff(true)
                                        target.ability.shannon_recent = true
                                        target:juice_up()
                                    end
                                end
                                return true end }))
                        return true end }))
            end
            local effects = {}
            for k, v in ipairs(G.jokers.cards) do
                local effect = SMODS.blueprint_effect(card, v, context)
                if effect then table.insert(effects, effect) end
            end
            return SMODS.merge_effects(effects)
        end
    end
}