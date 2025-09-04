local challenges = {
    "high_roller",
    "plant_vs_zombie"
}
for k, v in ipairs(challenges) do
    assert(SMODS.load_file("src/challenges/" .. v .. ".lua"), MANIF.install .. "src/challenges/" .. v .. ".lua")()
end