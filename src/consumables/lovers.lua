-- The Lovers
SMODS.Consumable:take_ownership("lovers", {
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "wild", set = "Other"}
        return {vars = {card.ability.max_highlighted, localize("manifold_wild", "suits_plural"), colours = {G.C.SUITS.manifold_wild}}}
    end
}, true)