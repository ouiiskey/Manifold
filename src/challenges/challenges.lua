local challenges = {
    "high_roller"
}
for k, v in ipairs(challenges) do
    assert(SMODS.load_file("src/challenges/" .. v .. ".lua"), MANIF.install .. "src/challenges/" .. v .. ".lua")()
end