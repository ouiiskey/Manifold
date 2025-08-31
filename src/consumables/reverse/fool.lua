-- Reverse Fool
SMODS.Consumable {
    key = "fool",
    set = "manifold_reverse_tarot",
    atlas = "reverse_tarots",
    pos = {x = 0, y = 0},
    cost = 3,
    in_pool = function(self, args)
        return false
    end,
    can_use = function()
        return true
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.4, func = function()
            play_sound("timpani")
            G.GAME.next_tarot = (G.GAME.next_tarot or 0) + 1
            card:juice_up(0.3, 0.5)
            return true end }))
        delay(0.6)
    end
}