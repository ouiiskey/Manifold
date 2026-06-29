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
    -- Immediate is true for foods that require precise timings
    SMODS.destroy_cards(self, nil, true, true)
end

-- Force Queue, see also force_queue.toml
MANIF.card_to_flags = function(card)
    local stickers = {}
    for k, v in ipairs(SMODS.Sticker.obj_buffer) do
        if card.ability[v] then
            table.insert(stickers, v)
        end
    end
    return {
        set = card.ability.set,
        key = card.ability.set ~= "Enhanced" and card.config.center.key,
        front = SMODS.is_playing_card(card) and SMODS.Suits[card.base.suit].card_key .. "_" .. SMODS.Ranks[card.base.value].card_key,
        enhancement = card.ability.set == "Enhanced" and card.config.center.key,
        edition = card.edition and "e_" .. card.edition.type or false,
        seal = card.seal,
        stickers = stickers,
        frozen = card.frozen,
        couponed = card.ability.couponed
    }
end
MANIF.enqueue_card = function(card)
    MANIF.enqueue(MANIF.card_to_flags(card))
end
MANIF.enqueue = function(flags)
    G.GAME.force_queue.last = G.GAME.force_queue.last + 1
    G.GAME.force_queue[G.GAME.force_queue.last] = flags
end
MANIF.push_card = function(card)
    MANIF.push(MANIF.card_to_flags(card))
end
MANIF.push = function(flags)
    G.GAME.force_queue.first = G.GAME.force_queue.first - 1
    G.GAME.force_queue[G.GAME.force_queue.first] = flags
end
MANIF.dequeue = function()
    if G.GAME.force_queue.first > G.GAME.force_queue.last then return end
    local out = G.GAME.force_queue[G.GAME.force_queue.first]
    G.GAME.force_queue[G.GAME.force_queue.first] = nil
    G.GAME.force_queue.first = G.GAME.force_queue.first + 1
    return out
end