SMODS.Atlas {
    key = "jokers",
    path = "jokers.png",
    px = 71,
    py = 95
}

MANIF.home = "c_planet_x" -- Aliens' homeworld

local jokers = {
    "prosopagnosia",
    "archwizard",
    "black_knight",
    "bob",
    "alice",
    "space_patrol",
    "clay_tablet",
    "orange_juice",
    "pudding",
    "cookie_dough",
    "cookie",
    "baked_potato",
    "hot_potato",
    "digi_carrot",
    "extraterrestrial",
    "cthugha",
    "nyarlathotep",
    "hastur",
    "squid",
    "monkeys_paw",
    "esper",
    "mana_gem",
    "wallet",
    "carte_blanche",
    "harpoon_gun",
    "library",
    "tsunami",
    "zombie",
    "chicken",
    "rorschach",
    "memory",
    "railgun",
    "rebellion",
    "propaganda",
    -- Vanilla
    "seance"
}
for k, v in ipairs(jokers) do
    assert(SMODS.load_file("src/jokers/" .. v .. ".lua"), MANIF.install .. "src/jokers/" .. v .. ".lua")()
end

SMODS.current_mod.reset_game_globals = function()
    -- Hot Potato
    G.GAME.current_round.hot_card = {rank = "Ace"}
    local heatable_cards = {}
    for k, v in ipairs(G.playing_cards) do
        if v.ability.effect ~= 'Stone Card' then
            heatable_cards[#heatable_cards +1] = v
        end
    end
    if heatable_cards[1] then
        local hot_card = pseudorandom_element(heatable_cards, pseudoseed("manif_hot" .. G.GAME.round_resets.ante))
        G.GAME.current_round.hot_card.rank = hot_card.base.value
        G.GAME.current_round.hot_card.id = hot_card.base.id
    end
    -- Zombie Joker
    G.GAME.current_round.final_wave = false
end