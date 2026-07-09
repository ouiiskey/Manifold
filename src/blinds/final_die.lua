-- Ochre Die
local base_num = 1
local base_denom = 3

local idemrandom = function(id)
    local hash = pseudohash("manifold_final_die_" .. id .. "_" .. G.GAME.round .. (G.GAME.pseudorandom.seed or ""))
    local seed = (hash + (G.GAME.pseudorandom.hashed_seed or 0)) / 2
    math.randomseed(seed)
    return math.random()
end

local idemrandom_check = function(id)
    local numerator, denominator = SMODS.get_probability_vars(G.GAME.blind, base_num, base_denom, "manifold_final_die")
    local result = idemrandom(id) < numerator / denominator
    SMODS.post_prob = SMODS.post_prob or {}
    SMODS.post_prob[#SMODS.post_prob + 1] = {pseudorandom_result = true, result = result, trigger_obj = G.GAME.blind, numerator = numerator, denominator = denominator, identifier = "manifold_final_die"}
    return result
end

SMODS.Blind {
    key = "final_die",
    atlas = "blinds",
    pos = {y = 4},
    dollars = 8,
    boss = {showdown = true},
    boss_colour = HEX("e29849"),
    loc_vars = function(self)
        local numerator, denominator = SMODS.get_probability_vars(G.GAME.blind, base_num, base_denom, "manifold_final_die")
        return {vars = {numerator, denominator}}
    end,
    collection_loc_vars = function(self)
        return {vars = {base_num, base_denom}}
    end,
    recalc_debuff = function(self, card, from_blind)
        return SMODS.is_playing_card(card) and idemrandom_check(card.ID)
    end
}