-- Familiar
SMODS.Consumable:take_ownership("familiar", {
    use = function(self, card, area, copier)
        local pool = {}
        for k, v in ipairs(G.consumeables.cards) do
            if v.config.center_key ~= "c_familiar" then
                table.insert(pool, v)
            end
        end
        local target = pseudorandom_element(pool, pseudoseed("random_consumable"))
        for i = 1, G.consumeables.config.card_limit - #G.consumeables.cards do
            G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound("timpani")
                    local copy = copy_card(target, nil, nil, nil, true)
                    copy:add_to_deck()
                    G.consumeables:emplace(copy)
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