-- See also is_rank.toml
function MANIF.has_any_rank(card)
    return card.base.value == "manifold_deity" or next(SMODS.find_card("j_pareidolia")) and next(SMODS.find_card("j_manifold_prosopagnosia"))
end

function MANIF.is_face(rank)
    return rank == 11 or rank == 12 or rank == 13
end

function Card:is_rank(rank, check_debuff)
    if check_debuff and self.debuff then return false end
    return self:get_id() == rank or MANIF.has_any_rank(self) or next(SMODS.find_card("j_manifold_prosopagnosia")) and self:is_face() and MANIF.is_face(rank)
end

function Card:is_even(check_debuff)
    if check_debuff and self.debuff then return false end
    local id = self:get_id()
    return id < 11 and id > 1 and id % 2 == 0 or MANIF.has_any_rank(self)
end

function Card:is_odd(check_debuff)
    if check_debuff and self.debuff then return false end
    local id = self:get_id()
    return id < 10 and id > 0 and id % 2 == 1 or self:is_rank(14) or MANIF.has_any_rank(self)
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
    return not SMODS.has_no_rank(self) and not self:is_face() and not self:is_rank(14) or MANIF.has_any_rank(self)
end

function Card:get_lowest_id()
    if MANIF.has_any_rank(self) then
        return 2
    elseif self:is_face() and next(SMODS.find_card("j_manifold_prosopagnosia")) then
        return 11
    end
    return self.base.id
end