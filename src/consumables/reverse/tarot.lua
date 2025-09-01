-- Reverse Tarot, see also reverse_tarot.lua
SMODS.Atlas {
    key = "reverse_tarots",
    path = "reverse_tarots.png",
    px = 71,
    py = 95
}

MANIF.get_reverse_key = function(card)
    if card.config.center.set == "manifold_reverse_tarot" then
        return "c_" .. string.sub(card.config.center_key, 12)
    elseif card.config.center.set == "Tarot" then
        return "c_manifold_" .. string.sub(card.config.center_key, 3)
    elseif card.config.center_key == "c_soul" then
        return "c_manifold_mind"
    elseif card.config.center_key == "c_manifold_mind" then
        return "c_soul"
    else
        return card.config.center_key
    end
end

SMODS.ConsumableType {
    key = "manifold_reverse_tarot",
    collection_rows = { 5, 6 },
    primary_colour = G.C.SET.Tarot,
    secondary_colour = G.C.SECONDARY_SET.Tarot,
    default = "c_manifold_strength",
    set_card_type_badge = function(self, obj, card, badges)
        badges[#badges + 1] = create_badge(localize("k_manifold_reverse_tarot"), G.C.SECONDARY_SET.Tarot, nil, 1.2, self.font)
    end,
    font = SMODS.Fonts["manifold_reverse"]
}

local reversed = {
    "fool",
    "magician",
    "high_priestess",
    "empress",
    "emperor",
    "heirophant", -- Typo is intentional
    "lovers",
    "strength",
}
for k, v in ipairs(reversed) do
    assert(SMODS.load_file("src/consumables/reverse/" .. v .. ".lua"), MANIF.install .. "src/consumables/reverse/" .. v .. ".lua")()
end