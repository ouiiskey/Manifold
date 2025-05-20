-- The High Priestess
SMODS.Consumable:take_ownership("high_priestess", {
    loc_vars = function(self, info_queue, center)
        local _priest_c = G.GAME.last_planet and G.P_CENTERS[G.GAME.last_planet] or nil
        local _last_planet = _priest_c and localize{ type = "name_text", key = _priest_c.key, set = _priest_c.set} or localize('k_none')
        if _priest_c then
            info_queue[#info_queue+1] = _priest_c
        end
        return {main_end = {
            {n = G.UIT.C, config = {align = "bm", padding = 0.02}, nodes = {
                { n = G.UIT.C, config = { align = "m", colour = not _priest_c and G.C.RED or G.C.GREEN, r = 0.05, padding = 0.05}, nodes = {
                    {n = G.UIT.T, config = { text = ' '.. _last_planet ..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                }}
            }}
        }}
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.planets.config.card_limit > #G.planets.cards then
                play_sound('timpani')
                local _card = create_card('Planet', G.planets, nil, nil, nil, nil, G.GAME.last_planet, 'fool')
                _card:add_to_deck()
                G.planets:emplace(_card)
                _card:juice_up(0.3, 0.5)
            end
            return true end }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return #G.planets.cards < G.planets.config.card_limit and G.GAME.last_planet
    end
}, true)