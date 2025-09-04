-- Burning Deck, see also burning.toml
SMODS.Back {
    key = "burning",
    atlas = "backs",
    pos = {x = 2, y = 1},
    unlocked = false,
    config = {extra = {immo = 2, joker_mod = -1}},
    check_for_unlock = function(self, args)
        return args.type == "win_stake" and get_deck_win_stake() >= 8
    end,
    loc_vars = function(self, info_queue, back)
        return {vars = {self.config.extra.immo, self.config.extra.joker_mod}}
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event{func = function()
            for i = 1, self.config.extra.immo do
                SMODS.add_card{set = "Spectral", area = G.consumeables, key = "c_immolate", key_append = "manifold_burning"}
            end
            return true end})
    end,
    calculate = function(self, back, context)
        if context.ante_change and context.ante_end and G.GAME.round_resets.ante % 2 == 1 and G.jokers.config.card_limit > 0 then
            G.jokers.config.card_limit = G.jokers.config.card_limit + self.config.extra.joker_mod
            return {
                message = localize("manifold_burn")
            }
        end
    end
}