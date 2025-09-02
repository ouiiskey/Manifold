-- Orientable Deck, see also orientable.toml
local prev = "b_manifold_polychrome"

function MANIF.reverse_button(card)
    local t
    if card.area == G.consumeables then
        return UIBox{definition = {n = G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes = {
            {n = G.UIT.R, config = {ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 1.25, maxw = 1.25, minh = 0.3 * card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = "reverse_tarot", func = "can_reverse_tarot"}, nodes = {
                {n = G.UIT.T, config = {text = localize("manifold_reverse"), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
            }}
        }}, config = {align = "bm", offset = {x = 0, y = -0.3}, parent = card}}
    else
        return UIBox{definition = {n = G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes = {
            {n = G.UIT.C, config = {padding = 0.15, align = "cr"}, nodes = {
                {n = G.UIT.R, config = {align = "cr"}, nodes = {
                    {n = G.UIT.C, config = {align = "cl"}, nodes = {
                        {n = G.UIT.C, config = {ref_table = card, align = "cl", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = 0.3 * card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = "reverse_tarot", func = "can_reverse_tarot"}, nodes = {
                            {n = G.UIT.T, config = {text = localize("manifold_reverse"), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}},
                            {n = G.UIT.B, config = {w = 0.1, h = 0.6}}
                        }}
                    }}
                }}
            }}
        }}, config = {align = "cl", offset = {x = 0.5, y = 0}, parent = card}}
    end
end

function G.FUNCS.can_reverse_tarot(e)
    if G.play and #G.play.cards > 0 or G.CONTROLLER.locked or G.GAME.STOP_USE and G.GAME.STOP_USE > 0 then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.SECONDARY_SET.Tarot
        e.config.button = "reverse_tarot"
    end
end

function G.FUNCS.reverse_tarot(e)
    G.CONTROLLER.locks.reversing_tarot = true
    stop_use()
    local card = e.config.ref_table
    local area = card.area == G.shop and "shop_jokers" or card.area == G.pack_cards and "pack_cards" or "consumeables"
    G.CONTROLLER:recall_cardarea_focus(area)
    card:highlight(false)
    G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.2, func = function()
        play_sound("card1", 0.8, 0.6)
        card:juice_up(0.3, math.pi)
        return true end})
    G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
        card:set_ability(MANIF.get_reverse_key(card), nil, true)
        G.CONTROLLER.locks.reversing_tarot = nil
        G.CONTROLLER:recall_cardarea_focus(area)
        return true end})
end

SMODS.Back {
    key = "orientable",
    atlas = "backs",
    pos = {x = 9, y = 0},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        if G.P_CENTERS[prev].unlocked then
            return {vars = {localize{type = "name_text", set = "Back", key = prev}}}
        else
            return {vars = {localize("k_unknown")}}
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == "win_deck" and get_deck_win_stake(prev) > 0
    end
}