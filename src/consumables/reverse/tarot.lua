-- Reverse Tarot, see also reverse_tarot.lua
SMODS.Atlas {
    key = "reverse_tarots",
    path = "reverse_tarots.png",
    px = 71,
    py = 95
}

SMODS.ConsumableType {
    key = "manifold_reverse_tarot",
    collection_rows = { 5, 6 },
    primary_colour = G.C.SET.Tarot,
    secondary_colour = G.C.SECONDARY_SET.Tarot,
    default = "c_manifold_strength",
    set_card_type_badge = function(self, obj, card, badges)
        badges[#badges + 1] = create_badge(localize("k_manifold_reverse_tarot"), G.C.SECONDARY_SET.Tarot, nil, 1.2, SMODS.Fonts["manifold_reverse"])
    end,
    reverse = true
}

local reversed = {
    "strength",
}
for k, v in ipairs(reversed) do
    assert(SMODS.load_file("src/consumables/reverse/" .. v .. ".lua"), MANIF.install .. "src/consumables/reverse/" .. v .. ".lua")()
end