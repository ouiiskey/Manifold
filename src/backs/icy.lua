-- Icy Deck, see also force_queue.toml and buttons.toml
local prev = "b_zodiac"

function MANIF.freeze_button(card)
    return UIBox{definition = {n = G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes = {
        {n = G.UIT.C, config = {padding = 0.15, align = "cr"}, nodes = {
            {n = G.UIT.R, config = {align = "cl"}, nodes = {
                {n = G.UIT.C, config = {align = "cr"}, nodes = {
                    {n = G.UIT.C, config = {ref_table = card, r = 0.08, padding = 0.1, align = "cr", minw = 1.25, maxw = 1.25, minh = 0.3 * card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = "freeze_card", func = "can_freeze_card"}, nodes = {
                        {n = G.UIT.B, config = {w = 0.1, h = 0.6}},
                        {n = G.UIT.T, config = {text = card.frozen and localize("manifold_thaw") or localize("manifold_freeze"), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
                    }}
                }}
            }}
        }}
    }}, config = {align = "cr", offset = {x = -0.5, y = card.children.buy_and_use_button and card.children.buy_and_use_button.definition.config.button and 0.5 or 0}, parent = card}}
end

function G.FUNCS.can_freeze_card(e)
    if G.play and #G.play.cards > 0 or G.CONTROLLER.locked or G.GAME.STOP_USE and G.GAME.STOP_USE > 0 then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.BLUE
        e.config.button = "freeze_card"
    end
end

function G.FUNCS.freeze_card(e)
    G.CONTROLLER.locks.freezing_card = true
    stop_use()
    local card = e.config.ref_table
    local area = card.area == G.shop_jokers and "shop_jokers" or "pack_cards"
    G.CONTROLLER:recall_cardarea_focus(area)
    card:highlight(false)
    G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.2, func = function()
        card.frozen = not card.frozen
        card:juice_up(1, 0.5)
        play_sound("manifold_ice", 1.2, 1.15)
        return true end})
    G.E_MANAGER:add_event(Event{trigger = "after", func = function()
        G.CONTROLLER.locks.freezing_card = nil
        G.CONTROLLER:recall_cardarea_focus(area)
        if area == "shop_jokers" then
            create_shop_card_ui(card, "Joker", G.shop_jokers)
        end
        return true end})
end

SMODS.Shader {
    key = "frozen",
    path = "frozen.fs"
}

SMODS.DrawStep {
    key = "frozen",
    order = 70,
    func = function(card, layer)
        if card.frozen then
            card.children.center:draw_shader("manifold_frozen", nil, {math.min(card.VT.r * 3, 1) + G.TIMERS.REAL / 28 + (card.juice and card.juice.r * 20 or 0) + card.tilt_var.amt, pseudohash(card.config.center.name)})
        end
    end,
    conditions = {vortex = false, facing = "front"}
}

SMODS.Sound {
    key = "ice",
    path = "ice.ogg"
}

SMODS.Back {
    key = "icy",
    atlas = "backs",
    pos = {x = 7, y = 1},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        if G.P_CENTERS[prev].unlocked then
            return {vars = {localize{type = "name_text", set = "Back", key = prev}}}
        else
            return {vars = {localize("k_unknown")}}
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == "win_deck" and get_deck_win_stake(prev) >= 5
    end,
    calculate = function(self, back, context)
        if context.playing_card_added then
            for k, v in ipairs(context.cards) do
                if v.frozen then
                    v.frozen = false
                end
            end
        elseif context.card_added and context.card.frozen then
            context.card.frozen = false
        end
    end
}