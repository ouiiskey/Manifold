-- Argent Adamant, see also final_adamant.toml
local blind_mult = 3
local get_min = function()
    return math.floor(get_blind_amount(G.GAME.round_resets.ante) * blind_mult * G.GAME.starting_params.ante_scaling / 2)
end

MANIF.adamant = function()
    if G.GAME.round_resets.blind == G.P_BLINDS.bl_manifold_final_adamant and mult * hand_chips < get_min() then
        mult = mod_mult(0)
        hand_chips = mod_chips(0)
        G.E_MANAGER:add_event(Event{trigger = "immediate", func = function()
            SMODS.juice_up_blind()
            G.E_MANAGER:add_event(Event{trigger = "after", delay = 0.06 * G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                play_sound("tarot2", 0.76, 0.4)
                return true end})
            play_sound("tarot2", 1, 0.4)
            return true end})
        play_area_status_text(localize("k_not_allowed_ex"))
        SMODS.calculate_context({full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, debuffed_hand = true})
    end
end

SMODS.Blind {
    key = "final_adamant",
    atlas = "blinds",
    pos = {y = 0},
    dollars = 8,
    mult = blind_mult,
    boss = {showdown = true},
    boss_colour = HEX("c0c0c8"),
    loc_vars = function(self)
        return {vars = {get_min()}}
    end,
    collection_loc_vars = function(self)
        return {vars = {localize("manifold_adamant_floor")}}
    end
}