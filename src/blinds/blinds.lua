SMODS.Atlas {
    key = "blinds",
    path = "blinds.png",
    px = 34,
    py = 34,
    atlas_table = "ANIMATION_ATLAS",
    frames = 21
}

local blinds = {
    "final_adamant",
    "final_capsid"
}
for k, v in ipairs(blinds) do
    assert(SMODS.load_file("src/blinds/" .. v .. ".lua"), MANIF.install .. "src/blinds/" .. v .. ".lua")()
end