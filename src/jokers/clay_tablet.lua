-- Clay Tablet, see also clay_tablet.toml
local ante = 0

SMODS.Joker {
    key = "clay_tablet",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 6, y = 0},
    cost = 5,
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {vars = {ante}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "ease_ante" and args.ante == ante
    end,
    in_pool = function(self, args)
        for k, v in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(v, "m_stone") then
                return true
            end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
    end,
    calculate = function(self, card, context)
        if context.initial_scoring_step and not context.blueprint then
            local foiled = false
            for i = 2, #context.full_hand do
                if not context.full_hand[i].edition and SMODS.has_enhancement(context.full_hand[i], "m_stone") and context.full_hand[i-1]:is_rank(6) then
                    foiled = true
                    -- Card scores as foil but shader doesn't come early
                    context.full_hand[i]:set_edition({foil = true}, true, true)
                    context.full_hand[i].edition.foil = false
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.full_hand[i].edition.foil = true
                            context.full_hand[i]:juice_up()
                            play_sound("foil1", 1.2, 0.4)
                            return true end }))
                end
            end
            if foiled then
                return {
                    message = localize("manifold_cuneiform_foil"),
                    font = SMODS.Fonts["manifold_cuneiform"],
                    colour = G.C.SECONDARY_SET.Edition
                }
            end
        end
    end
}