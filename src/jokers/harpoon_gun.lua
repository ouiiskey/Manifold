-- Harpoon Gun, see also harpoon_gun.toml
SMODS.Joker {
    key = "harpoon_gun",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 4, y = 2},
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local target = false
            for k, v in ipairs(G.deck.cards) do
                if not target or (target.ability.era or 0) < (v.ability.era or 0) then
                    target = v
                end
            end
            if target then
                draw_card(G.deck, G.hand, nil, nil, nil, target)
                return {
                    message = localize("manifold_hit"),
                    colour = G.C.L_BLACK,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                save_run()
                                return true end }))
                    end
                }
            else
                return {
                    message = localize("k_nope_ex"),
                    colour = G.C.L_BLACK
                }
            end
        end
    end
}