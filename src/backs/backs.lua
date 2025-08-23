SMODS.Atlas {
    key = "backs",
    path = "backs.png",
    px = 71,
    py = 95
}

local backs = {
    -- Re-added
    "braided",
    "silver"
}
for k, v in ipairs(backs) do
    assert(SMODS.load_file("src/backs/" .. v .. ".lua"), MANIF.install .. "src/backs/" .. v .. ".lua")()
end