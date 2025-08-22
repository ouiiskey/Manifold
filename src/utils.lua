-- See also is_rank.toml
function Card:is_rank(rank, check_debuff)
    if check_debuff and self.debuff then return false end
    return self:get_id() == rank or next(SMODS.find_card("j_manifold_prosopagnosia")) and (next(SMODS.find_card("j_pareidolia")) or self:is_face() and MANIF.PROSO.is_face[rank])
end

function Card:is_even(check_debuff)
    if check_debuff and self.debuff then return false end
    return self:get_id() <= 10 and self:get_id() >= 0 and self:get_id() % 2 == 0 or next(SMODS.find_card("j_manifold_prosopagnosia")) and next(SMODS.find_card("j_pareidolia"))
end

function Card:is_odd(check_debuff)
    if check_debuff and self.debuff then return false end
    return self:get_id() <= 9 and self:get_id() >= 1 and self:get_id() % 2 == 1 or self:is_rank(14)
end

function Card:get_parity(check_debuff)
    if self:is_even(check_debuff) then
        if self:is_odd(check_debuff) then return "both" end
        return "even"
    elseif self:is_odd(check_debuff) then
        return "odd"
    end
    return "none"
end

function Card:is_number(check_debuff)
    if check_debuff and self.debuff then return false end
    return not SMODS.has_no_rank(self) and not self:is_face() and not self:is_rank(14) or next(SMODS.find_card("j_manifold_prosopagnosia")) and next(SMODS.find_card("j_pareidolia"))
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