-- Azure Aether, see also final_aether.toml
SMODS.Blind {
    key = "final_aether",
    atlas = "blinds",
    pos = {y = 2},
    dollars = 8,
    boss = {showdown = true},
    boss_colour = HEX("0080ff"),
    loc_vars = function(self)
        return {vars = {math.max(math.min(5, G.GAME.round_resets.hands), 0)}}
    end,
    collection_loc_vars = function(self)
        return {vars = {5}}
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