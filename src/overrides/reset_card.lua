-- See also reset_card.toml
function reset_idol_card()
    local rank
    local suit
    local id
    local targets = {}
    for k, v in ipairs(G.playing_cards) do
        if not (SMODS.has_no_rank(v) and SMODS.has_no_suit(v) or MANIF.has_any_rank(v) and SMODS.has_any_suit(v)) then
            table.insert(targets, v)
        end
    end
    if next(targets) then
        local idol_card = pseudorandom_element(targets, pseudoseed("idol" .. G.GAME.round_resets.ante))
        if not SMODS.has_no_rank(idol_card) and not MANIF.has_any_rank(idol_card) then
            rank = idol_card.base.value
            id = idol_card.base.id
        end
        if not SMODS.has_no_suit(idol_card) and not SMODS.has_any_suit(idol_card) then
            suit = idol_card.base.suit
        end
        if not rank then
            targets = {}
            for k, v in ipairs(G.playing_cards) do
                if v:is_suit(suit) and not SMODS.has_no_rank(v) and not MANIF.has_any_rank(v) then
                    table.insert(targets, v)
                end
            end
            if next(targets) then
                idol_card = pseudorandom_element(targets, pseudoseed("idol_redo" .. G.GAME.round_resets.ante))
                rank = idol_card.base.value
                id = idol_card.base.id
            end
        elseif not suit then
            targets = {}
            for k, v in ipairs(G.playing_cards) do
                if v:is_rank(id) and not SMODS.has_no_suit(v) and not SMODS.has_any_suit(v) then
                    table.insert(targets, v)
                end
            end
            if next(targets) then
                idol_card = pseudorandom_element(targets, pseudoseed("idol_redo" .. G.GAME.round_resets.ante))
                suit = idol_card.base.suit
            end
        end
    end
    G.GAME.current_round.idol_card.rank = rank or "Ace"
    G.GAME.current_round.idol_card.suit = suit or "Spades"
    G.GAME.current_round.idol_card.id = id
end