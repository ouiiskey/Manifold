-- Wallet, see also wallet.toml
SMODS.Joker {
    key = "wallet",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 2, y = 2},
    cost = 1,
    config = {extra = {cards = {}}},
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            local retrieved = false
            for k, v in ipairs(G.wallet.cards) do
                retrieved = true
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                if next(G.hand.cards) then
                    draw_card(G.wallet, G.hand, nil, nil, nil, v)
                else
                    draw_card(G.wallet, G.deck, nil, nil, nil, v)
                end
                v.playing_card = G.playing_card
                playing_card_joker_effects({v})
                v:add_to_deck()
                table.insert(G.playing_cards, v)
            end
            G.wallet.cards = {}
            if retrieved then
                return {
                    message = localize("manifold_emptied"),
                    colour = G.C.L_BLACK
                }
            end
        end
    end,
    eternal_compat = false
}