SMODS.Atlas {
    key = "spectrals",
    path = "spectrals.png",
    px = 71,
    py = 95
}

local consumables = {
    -- Spectrals
    "ascend",
    "mind",
    -- Reverse Tarots
    "reverse/tarot",
    -- Vanilla Tarots
    "high_priestess",
    "lovers",
    -- Vanilla Spectrals
    "incantation",
    "familiar",
    "grim"
}
for k, v in ipairs(consumables) do
    assert(SMODS.load_file("src/consumables/" .. v .. ".lua"), MANIF.install .. "src/consumables/" .. v .. ".lua")()
end

-- We roll this separately to help legendary sifting
local function soul_or_mind()
    if pseudorandom("soul_or_mind") > 0.5 then
        if not G.GAME.used_jokers.c_soul or SMODS.showman("c_soul") then
            return "c_soul"
        end
    elseif not G.GAME.used_jokers.c_manifold_mind or SMODS.showman("c_manifold_mind") then
        return "c_manifold_mind"
    end
end

local function black_hole()
    if not G.GAME.used_jokers.c_black_hole or SMODS.showman("c_black_hole") then
        return "c_black_hole"
    end
end

local function ascend()
    if not G.GAME.used_jokers.c_manifold_ascend or SMODS.showman("c_manifold_ascend") then
        return "c_manifold_ascend"
    end
end

function MANIF.forced_key(_type)
    if _type == "Spectral" then
        local roll = pseudorandom("soul_Spectral" .. G.GAME.round_resets.ante)
        if roll > 0.994 then
            return soul_or_mind()
        elseif roll > 0.991 then
            return black_hole()
        elseif roll > 0.988 then
            return ascend()
        end
    elseif _type == "Tarot" then
        local roll = pseudorandom("soul_Tarot" .. G.GAME.round_resets.ante)
        if roll > 0.994 then
            return soul_or_mind()
        end
    elseif _type == "Planet" then
        local roll = pseudorandom("soul_Planet" .. G.GAME.round_resets.ante)
        if roll > 0.997 then
            return black_hole()
        end
    elseif _type == "Base" then
        local roll = pseudorandom("soul_Base" .. G.GAME.round_resets.ante)
        if roll > 0.995 then -- 0.6 * 0.005 = 0.003
            return ascend()
        end
    end
end