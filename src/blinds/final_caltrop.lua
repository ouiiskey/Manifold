-- Rusty Caltrop
SMODS.Blind {
    key = "final_caltrop",
    atlas = "blinds",
    pos = {y = 3},
    dollars = 8,
    mult = 1.5,
    boss = {showdown = true},
    boss_colour = HEX("b87333"),
    calculate = function(self, blind, context)
        if context.after then
            G.E_MANAGER:add_event(Event{func = function()
                G.GAME.blind.chips = G.GAME.blind.chips * 1.5
                return true end})
            return {
                message = localize("manifold_size_up")
            }
        end
    end
}