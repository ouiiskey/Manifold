-- Blue Stake
SMODS.Stake:take_ownership("blue", {
    modifiers = function()
        G.GAME.modifiers.enable_perishables_in_shop = true
    end
}, true)

-- Orange Stake
SMODS.Stake:take_ownership("orange", {
    modifiers = function()
        G.GAME.modifiers.enable_manifold_premium = true
    end
}, true)