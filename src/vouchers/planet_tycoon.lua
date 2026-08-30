-- Planet Tycoon, see also planet_merchant.lua for calculation
local base_num = 2

SMODS.Voucher:take_ownership("planet_tycoon", {
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, base_num, 3, "planet_voucher")
        return {vars = {numerator, denominator}}
    end,
    redeem = function(self, card)
        G.GAME.celestial_num = base_num
    end
}, true)