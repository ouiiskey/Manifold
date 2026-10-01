-- Force Queue, see also force_queue.toml
function MANIF.card_to_flags(card)
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

function MANIF.enqueue_card(card)
    MANIF.enqueue(MANIF.card_to_flags(card))
end

function MANIF.enqueue(flags)
    G.GAME.force_queue.last = G.GAME.force_queue.last + 1
    G.GAME.force_queue[G.GAME.force_queue.last] = flags
end

function MANIF.push_card(card)
    MANIF.push(MANIF.card_to_flags(card))
end

function MANIF.push(flags)
    G.GAME.force_queue.first = G.GAME.force_queue.first - 1
    G.GAME.force_queue[G.GAME.force_queue.first] = flags
end

function MANIF.dequeue()
    if G.GAME.force_queue.first > G.GAME.force_queue.last then return end
    local out = G.GAME.force_queue[G.GAME.force_queue.first]
    G.GAME.force_queue[G.GAME.force_queue.first] = nil
    G.GAME.force_queue.first = G.GAME.force_queue.first + 1
    return out
end