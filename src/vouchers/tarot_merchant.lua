-- Tarot Merchant
local base_num = 1
local base_denom = 3

SMODS.Voucher:take_ownership("tarot_merchant", {
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, base_num, base_denom, "tarot_voucher")
        return {vars = {numerator, denominator}}
    end,
    redeem = function(self, card)
        G.GAME.arcana_num = base_num
    end,
    calculate = function(self, card, context)
        -- Accounts for Tarot Tycoon too
        if context.starting_shop and SMODS.pseudorandom_probability(card, "tarot_voucher", G.GAME.arcana_num, base_denom) then
            SMODS.add_booster_to_shop(get_pack("tarot_voucher", "Arcana").key)
        end
    end
}, true)