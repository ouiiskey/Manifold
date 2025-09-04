MANIF = {
    install = "Improper install detected, missing file: ",
    tooltips = {}
}

SMODS.current_mod.optional_features = {
    post_trigger = true,
    retrigger_joker = true
}

-- Mod icon
SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
}

-- Load source
local source = {
    "overrides",
    "utils",
    "fonts",
    "seals",
    "consumables/consumables",
    "jokers/jokers",
    "backs/backs",
    "challenges/challenges",
    "stakes",
    "stickers",
    "compat"
}
for k, v in ipairs(source) do
    assert(SMODS.load_file("src/" .. v .. ".lua"), MANIF.install .. "src/" .. v .. ".lua")()
end

-- Final startup
local menu = assert(SMODS.load_file("src/final.lua"), MANIF.install .. "src/final.lua")
local startup = true
local Gmm_ref = Game.main_menu
function Game:main_menu(change_context)
    if startup then
        menu()
        startup = false
    end
    Gmm_ref(self, change_context)
end

-- Mod Object Calculation
SMODS.current_mod.calculate = function(self, context)
    -- Black Seal
    if context.remove_playing_cards then
        for k, v in ipairs(context.removed) do
            if not v.debuff and v.seal == "manifold_black" then
                for i = 1, math.min(v.ability.seal.extra.spectrals, G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event{trigger = "before", delay = 0.0, func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            SMODS.add_card{set = "Spectral", area = G.consumeables, key_append = "manifold_blk"}
                        end
                        return true end})
                end
            end
        end
    -- ease_ante Unlock
    elseif context.ante_change then
        check_for_unlock{type = "ease_ante", ante = G.GAME.round_resets.ante + context.ante_change}
    elseif context.using_consumeable then
        -- Reverse Fool
        if (context.consumeable.ability.set == "Tarot" or context.consumeable.ability.set == "manifold_reverse_tarot") and context.consumeable.config.center_key ~= "c_fool" and context.consumeable.config.center_key ~= "c_manifold_fool" and G.GAME.next_tarot then
            for i = 1, math.min(G.GAME.next_tarot, G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound("timpani")
                        SMODS.add_card{set = "Tarot", area = G.consumeables, key = context.consumeable.ability.set == "manifold_reverse_tarot" and MANIF.get_reverse_key(context.consumeable) or context.consumeable.config.center_key, key_append = "manifold_fool"}
                    end
                    return true end})
            end
            G.GAME.next_tarot = nil
        -- Reverse High Priestess
        elseif context.consumeable.ability.set == "Planet" and G.GAME.next_planet then
            for i = 1, G.GAME.selected_back_key.key == "b_manifold_syzygy" and G.GAME.next_planet or math.min(G.GAME.next_planet, G.planets.config.card_limit - #G.planets.cards) do
                G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.4, func = function()
                    if G.planets.config.card_limit > #G.planets.cards or G.GAME.selected_back_key.key == "b_manifold_syzygy" then
                        play_sound("timpani")
                        SMODS.add_card{set = "Planet", area = G.planets, key = context.consumeable.config.center_key, key_append = "manifold_priest"}
                    end
                    return true end})
            end
            G.GAME.next_planet = nil
        end
    end
end

-- Credits
SMODS.current_mod.extra_tabs = function()
    return {
        label = localize("b_credits"),
        tab_definition_function = function()
            local text_scale = 0.75
            return {n = G.UIT.ROOT, config = {align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, emboss = 0.05, minh = 6, minw = 10}, nodes = {
                -- Noto Sans Cuneiform
                {n = G.UIT.R, config = {align = "cm", padding = 0.1, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes = {
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = 'The font "NotoSansCuneiform-Regular.ttf"', scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = "(", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n = G.UIT.T, config = {text = "notofonts.github.io/cuneiform", scale = text_scale * 0.5, colour = G.C.BLUE, shadow = true}},
                        {n = G.UIT.T, config={text = ")", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = "is licensed under the ", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n = G.UIT.T, config = {text = "SIL Open Font License", scale = text_scale * 0.5, colour = G.C.GOLD, shadow = true}},
                        {n = G.UIT.T, config={text = ".", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = "(", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n = G.UIT.T, config = {text = "openfontlicense.org", scale = text_scale * 0.5, colour = G.C.BLUE, shadow = true}},
                        {n = G.UIT.T, config={text = ")", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }}
                }},
                -- Reverse m6x11
                {n = G.UIT.R, config = {align = "cm", padding = 0.1, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes = {
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = 'The font "reverse_m6x11.ttf" is an edit of', scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = "m6x11 by Daniel Linssen", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = "(", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n = G.UIT.T, config = {text = "managore.itch.io/m6x11", scale = text_scale * 0.5, colour = G.C.BLUE, shadow = true}},
                        {n = G.UIT.T, config={text = ")", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = "which is licensed under an ", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n = G.UIT.T, config = {text = "Attribution License", scale = text_scale * 0.5, colour = G.C.GOLD, shadow = true}},
                        {n = G.UIT.T, config={text = ".", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }}
                }},
                -- Chicken
                {n = G.UIT.R, config = {align = "cm", padding = 0.1, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes = {
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = 'Art for the Joker "Chicken" is based on', scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = '"Rhode Island White Chicken" by Steven Johnson', scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = '(', scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n = G.UIT.T, config = {text = "flickr.com/photos/31295868@N06/5002574766", scale = text_scale * 0.5, colour = G.C.BLUE, shadow = true}},
                        {n = G.UIT.T, config={text = ")", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = "which is licensed under ", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n = G.UIT.T, config = {text = "Attribution 2.0 Generic", scale = text_scale * 0.5, colour = G.C.GOLD, shadow = true}},
                        {n = G.UIT.T, config={text = ".", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = '(', scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                        {n = G.UIT.T, config = {text = "creativecommons.org/licenses/by/2.0", scale = text_scale * 0.5, colour = G.C.BLUE, shadow = true}},
                        {n = G.UIT.T, config={text = ")", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }}
                }},
                -- Decks
                {n = G.UIT.R, config = {align = "cm", padding = 0.1, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes = {
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = "Braided Deck, Silver Deck, Foil Deck,", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = "Holographic Deck, and Polychrome Deck,", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
                        {n = G.UIT.T, config = {text = "are based on LocalThunk's unused concepts.", scale = text_scale * 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }}
                }}
            }}
        end
    }
end