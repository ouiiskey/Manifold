-- Wallet, see also wallet.toml
SMODS.Joker {
    key = "wallet",
    rarity = 1,
    atlas = "jokers",
    pos = {x = 2, y = 2},
    cost = 1,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            local retrieved = false
            for i = 1, #G.wallet.cards do
                retrieved = true
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                draw_card(G.wallet, next(G.hand.cards) and G.hand or G.deck, i / #G.wallet.cards * 100, nil, nil, G.wallet.cards[i])
                G.wallet.cards[i].playing_card = G.playing_card
                playing_card_joker_effects({G.wallet.cards[i]})
                G.wallet.cards[i]:add_to_deck()
                table.insert(G.playing_cards, G.wallet.cards[i])
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