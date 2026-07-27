-- Azure Aether, see also final_aether.toml
local max_hands = 5

MANIF.aether_hands = function()
    local out = math.min(G.GAME.round_resets.hands, max_hands)
    return out > 1 and out or 0
end

SMODS.Blind {
    key = "final_aether",
    atlas = "blinds",
    pos = {y = 2},
    dollars = 8,
    boss = {showdown = true},
    boss_colour = HEX("0080ff"),
    loc_vars = function(self)
        return {vars = {MANIF.aether_hands()}}
    end,
    collection_loc_vars = function(self)
        return {vars = {max_hands}}
    end,
    set_blind = function(self, reset, silent)
        if not reset then
            G.GAME.blind.hands = {}
        end
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        if check then
            if G.GAME.blind.hands[handname] then
                G.boss_throw_hand = true -- Only for the warning
            end
        else
            G.GAME.blind.hands[handname] = true
        end
    end
}