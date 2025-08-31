-- The High Priestess, see also planet.toml
SMODS.Consumable:take_ownership("high_priestess", {
    loc_vars = function(self, info_queue, center)
        local priest_c = G.GAME.last_planet and G.P_CENTERS[G.GAME.last_planet] or nil
        local last_planet = priest_c and localize{ type = "name_text", key = priest_c.key, set = priest_c.set} or localize("k_none")
        if priest_c then
            info_queue[#info_queue+1] = priest_c
        end
        return {main_end = {
            {n = G.UIT.C, config = {align = "bm", padding = 0.02}, nodes = {
                { n = G.UIT.C, config = { align = "m", colour = not priest_c and G.C.RED or G.C.GREEN, r = 0.05, padding = 0.05}, nodes = {
                    {n = G.UIT.T, config = { text = " " .. last_planet .. " ", colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                }}
            }}
        }}
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
            if G.planets.config.card_limit > #G.planets.cards or G.GAME.selected_back_key.key == "b_manifold_syzygy" then
                play_sound("timpani")
                SMODS.add_card{set = "Planet", area = G.planets, key = G.GAME.last_planet, key_append = "priest"}
                card:juice_up(0.3, 0.5)
            end
            return true end})
        delay(0.6)
    end,
    can_use = function(self, card)
        return (#G.planets.cards < G.planets.config.card_limit or G.GAME.selected_back_key.key == "b_manifold_syzygy") and G.GAME.last_planet
    end
}, true)