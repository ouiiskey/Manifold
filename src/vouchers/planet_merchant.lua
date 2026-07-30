-- Planet Merchant
local base_num = 1
local base_denom = 3

SMODS.Voucher:take_ownership("planet_merchant", {
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, base_num, base_denom, "planet_voucher")
        return {vars = {numerator, denominator}}
    end,
    redeem = function(self, card)
        G.GAME.celestial_num = base_num
    end,
    calculate = function(self, card, context)
        -- Accounts for Planet Tycoon too
        if context.starting_shop and SMODS.pseudorandom_probability(card, "planet_voucher", G.GAME.celestial_num, base_denom) then
            SMODS.add_booster_to_shop(get_pack("planet_voucher", "Celestial").key)
        end
    end
}, true)