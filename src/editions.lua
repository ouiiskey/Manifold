-- Negative
SMODS.Edition:take_ownership("negative", {
    get_weight = function(self)
        return self.weight + (G.GAME.negative_boost or 0)
    end,
}, true)