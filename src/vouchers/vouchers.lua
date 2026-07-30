local vouchers = {
    -- Vanilla
    -- T1
    "tarot_merchant",
    "planet_merchant",
    -- T2
    "tarot_tycoon",
    "planet_tycoon"
}
for k, v in ipairs(vouchers) do
    assert(SMODS.load_file("src/vouchers/" .. v .. ".lua"), MANIF.install .. "src/vouchers/" .. v .. ".lua")()
end