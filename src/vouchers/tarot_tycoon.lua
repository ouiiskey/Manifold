-- Tarot Tycoon, see also tarot_merchant.lua for calculation
local base_num = 2

SMODS.Voucher:take_ownership("tarot_tycoon", {
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, base_num, 3, "tarot_voucher")
        return {vars = {numerator, denominator}}
    end,
    redeem = function(self, card)
        G.GAME.arcana_num = base_num
    end
}, true)