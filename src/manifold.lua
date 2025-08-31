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
    "vouchers",
    "seals",
    "consumables/consumables",
    "jokers/jokers",
    "backs/backs",
    -- Challenges
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
    if context.remove_playing_cards then
        for k, v in ipairs(context.removed) do
            if not v.debuff and v.seal == "manifold_black" then
                for i = 1, math.min(v.ability.seal.extra.spectrals, G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({trigger = "before", delay = 0.0, func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            SMODS.add_card{set = "Spectral", area = G.consumeables, key_append = "manifold_blk"}
                        end
                        return true end }))
                end
            end
        end
    elseif context.ante_change then
        check_for_unlock{type = "ease_ante", ante = G.GAME.round_resets.ante + context.ante_change}
    end
end