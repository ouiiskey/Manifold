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

-- See also premake_card.toml
function MANIF.premake_card(t)
    t.skip_materialize = true
    local card = SMODS.add_card(t)
    card.states.visible = false
    t.area.premade_count = (t.area.premade_count or 0) + 1
    G.E_MANAGER:add_event(Event{func = function()
        card:start_materialize()
        t.area.premade_count = t.area.premade_count - 1
        return true end})
end