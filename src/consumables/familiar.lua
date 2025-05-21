-- Familiar, see also familiar.toml
SMODS.Consumable:take_ownership("familiar", {
    loc_vars = function(self, info_queue, center)
        local _fam_c = G.GAME.last_spectral and G.P_CENTERS[G.GAME.last_spectral] or nil
        local _last_spectral = _fam_c and localize{ type = "name_text", key = _fam_c.key, set = _fam_c.set} or localize('k_none')
        if _fam_c and _fam_c.name ~= "Familiar" then
            info_queue[#info_queue+1] = _fam_c
        end
        return {main_end = {
            {n = G.UIT.C, config = {align = "bm", padding = 0.02}, nodes = {
                { n = G.UIT.C, config = { align = "m", colour = (not _fam_c or _fam_c.name == "Familiar") and G.C.RED or G.C.GREEN, r = 0.05, padding = 0.05}, nodes = {
                    {n = G.UIT.T, config = { text = ' '.. _last_spectral ..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                }}
            }}
        }}
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local _card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, G.GAME.last_spectral, 'fam')
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                _card:juice_up(0.3, 0.5)
            end
            return true end }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return (#G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables) and G.GAME.last_spectral and G.GAME.last_spectral ~= "c_familiar"
    end
}, true)