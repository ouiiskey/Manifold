function Card:is_rank(rank)
    if self:get_id() == rank then return true end
    if next(SMODS.find_card("j_manifold_prosopagnosia")) then
        return next(SMODS.find_card("j_pareidolia")) or self:is_face() and MANIF.PROSO.is_face[rank]
    end
    return false
end

function Card:is_even()
    if self:get_id() <= 10 and self:get_id() >= 0 and self:get_id() % 2 == 0 then return true end
    return next(SMODS.find_card("j_manifold_prosopagnosia")) and next(SMODS.find_card("j_pareidolia"))
end

function Card:is_odd()
    if self:get_id() <= 10 and self:get_id() >= 0 and self:get_id() % 2 == 1 or self:is_rank(14) then return true end
    return next(SMODS.find_card("j_manifold_prosopagnosia")) and next(SMODS.find_card("j_pareidolia"))
end

function Card:eat()
    self.getting_sliced = true
    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound("tarot1")
            self.T.r = -0.2
            self:juice_up(0.3, 0.4)
            self.states.drag.is = true
            self.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.3, blockable = false,
                func = function()
                    G.jokers:remove_card(self)
                    self:remove()
                    self = nil
                    return true end }))
            return true end }))
end