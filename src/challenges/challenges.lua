local challenges = {
    "high_roller",
    "plant_vs_zombie",
    "dark_inferno",
    "pacific_rim",
    "glitter",
    "servant_of_chaos"
}
for k, v in ipairs(challenges) do
    assert(SMODS.load_file("src/challenges/" .. v .. ".lua"), MANIF.install .. "src/challenges/" .. v .. ".lua")()
end