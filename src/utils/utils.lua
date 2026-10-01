local utils = {
    "is_rank",
    "force_queue"
}
for k, v in ipairs(utils) do
    assert(SMODS.load_file("src/utils/" .. v .. ".lua"), MANIF.install .. "src/utils/" .. v .. ".lua")()
end

-- Misc utils
function Card:eat()
    SMODS.destroy_cards(self, {pinch_anim = true})
end