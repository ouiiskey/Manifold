-- UFO
SMODS.Joker {
    key = "ufo",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 4, y = 3},
    cost = 6,
    blueprint_compat = true,
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {vars = {localize{type = "name_text", set = "Planet", key = MANIF.home}}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "discover_amount" and G.P_CENTERS[MANIF.home].discovered
    end,
    calculate = function(self, card, context)
        if context.joker_main and #G.planets.cards + G.GAME.planet_buffer < G.planets.config.card_limit then
            G.GAME.planet_buffer = G.GAME.planet_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card{set = "Planet", area = G.planets, key_append = "manifold_ufo"}
                    G.GAME.planet_buffer = 0
                    return true end }))
            return {
                message = localize("k_plus_planet"),
                colour = G.C.SECONDARY_SET.Planet
            }
        end
    end
}