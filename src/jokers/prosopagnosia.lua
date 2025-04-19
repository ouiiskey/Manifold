-- Prosopagnosia. See also prosopagnosia.toml
PROSO = {
    faces = {},
    after_face = {},
    next = {}
}

-- For compatibility purposes, we hook Game.main_menu
local old = Game.main_menu
Game.main_menu = function(change_context)
    for k, v in pairs(SMODS.Ranks) do
        if v.face then
            table.insert(PROSO.faces, k)
            for _, key in ipairs(v.next) do
                if not SMODS.Ranks[key].face then
                    table.insert(PROSO.after_face, key)
                end
            end
        end
    end

    for k, v in pairs(SMODS.Ranks) do
        if v.face then
            PROSO.next[k] = PROSO.after_face
        else
            local before_face = false
            for _, key in ipairs(v.next) do
                if SMODS.Ranks[key].face then
                    before_face = true
                    break
                end
            end
            if before_face then
                PROSO.next[k] = SMODS.shallow_copy(PROSO.faces)
                for _, key in ipairs(v.next) do
                    if not SMODS.Ranks[key].face then
                        table.insert(PROSO.next[k], key)
                    end
                end
            else
                PROSO.next[k] = v.next
            end
        end
    end
    old(change_context)
end

SMODS.Joker {
    key = "prosopagnosia",
    rarity = 2,
    atlas = "jokers",
    pos = {
        x = 0,
        y = 0
    },
    cost = 5
}

