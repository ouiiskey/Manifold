local vouchers = {
    -- Vanilla
    -- T1
    "planet_merchant",
    -- T2
    "planet_tycoon"
}
for k, v in ipairs(vouchers) do
    assert(SMODS.load_file("src/vouchers/" .. v .. ".lua"), MANIF.install .. "src/vouchers/" .. v .. ".lua")()
end