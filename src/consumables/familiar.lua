-- Familiar
SMODS.Consumable:take_ownership("familiar", {
    use = function(self, card, area, copier)
        local _pool = {}
        for k, v in ipairs(G.consumeables.cards) do
            if v.config.center_key ~= "c_familiar" then
                table.insert(_pool, v)
            end
        end
        local _target = pseudorandom_element(_pool, pseudoseed("random_consumable"))
        for i = 1, G.consumeables.config.card_limit - #G.consumeables.cards do
            G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound("timpani")
                    local _copy = copy_card(_target, nil, nil, G.playing_card, true)
                    _copy:add_to_deck()
                    G.consumeables:emplace(_copy)
                    card:juice_up(0.3, 0.5)
                end
                return true end }))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
        for k, v in ipairs(G.consumeables.cards) do
            if v.config.center_key ~= "c_familiar" then
                return true
            end
        end
        return false
    end
}, true)