-- Mana Gem, see also mana_gem.toml
function MANIF.gem()
    if G.GAME.gem then
        G.GAME.gem = false
        return true
    end
    return false
end

SMODS.Joker {
    key = "mana_gem",
    rarity = 3,
    atlas = "jokers",
    pos = {x = 1, y = 2},
    cost = 9,
    unlocked = false,
    check_for_unlock = function(self, args)
        return args.type == "exit_run"
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.selling_self and G.GAME.blind:get_type() == "Boss" then
                G.GAME.gem = true
                G.E_MANAGER:add_event(Event{func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound("tarot1")
                    return true end})
                G.STATE = G.STATES.HAND_PLAYED
                G.STATE_COMPLETE = true
                end_round()
                return {
                    message = localize("manifold_escaped"),
                    colour = G.C.SECONDARY_SET.Spectral
                }
            end
        end
    end,
    eternal_compat = false
}