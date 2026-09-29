-- Ascend
-- Note: see mind.lua for why I do not use the SMODS hidden feature
SMODS.Consumable {
    key = "ascend",
    set = "Spectral",
    atlas = "spectrals",
    pos = {x = 2, y = 0},
    cost = 4,
    config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "deity", set = "Other"}
        return {vars = {card.ability.max_highlighted, localize("manifold_deity", "ranks")}}
    end,
    in_pool = function(self, args) return false end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true end})
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.15, func = function()
                G.hand.highlighted[1]:flip()
                play_sound("card1")
                G.hand.highlighted[1]:juice_up(0.3, 0.3)
                return true end})
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.3, func = function()
                assert(SMODS.change_base(G.hand.highlighted[1], nil, "manifold_deity"))
                return true end})
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.15, func = function()
                G.hand.highlighted[1]:flip()
                play_sound("tarot2", 1, 0.6)
                G.hand.highlighted[1]:juice_up(0.3, 0.3)
                return true end})
        G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.2, func = function()
                G.hand:unhighlight_all()
                return true end})
        delay(0.5)
    end,
    select_card = function(self, card, pack)
        ---@diagnostic disable-next-line: return-type-mismatch
        return pack.kind == "Standard" and "consumeables"
    end
}