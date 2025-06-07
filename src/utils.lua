function Card:is_rank(rank)
    if next(SMODS.find_card("j_manifold_prosopagnosia")) then
        return next(SMODS.find_card("j_pareidolia")) or self:is_face() and MANIF.PROSO.is_face[rank]
    end
    return self:get_id() == rank
end