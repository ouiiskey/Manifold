-- Rusty Caltrop
local blind_mult = 1.5

SMODS.Blind {
    key = "final_caltrop",
    atlas = "blinds",
    pos = {y = 3},
    dollars = 8,
    mult = blind_mult,
    boss = {showdown = true},
    boss_colour = HEX("b87333"),
    config = {extra = {times = 0}},
    calculate = function(self, blind, context)
        if context.after and not blind.disabled then
            blind.effect.extra.times = blind.effect.extra.times + 1
            G.E_MANAGER:add_event(Event{func = function()
                blind.chips = blind.chips * blind_mult
                return true end})
            return {
                message = localize("manifold_size_up")
            }
        end
    end,
    disable = function(self)
        G.GAME.blind.chips = G.GAME.blind.chips / (blind_mult ^ G.GAME.blind.effect.extra.times)
    end
}