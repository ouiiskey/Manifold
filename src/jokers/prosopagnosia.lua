-- Prosopagnosia, see also prosopagnosia.toml
MANIF.PROSO = {
    faces = {},
    after_face = {},
    next = {},
    rank = -1,
    is_face = {}
}

-- For compatibility purposes, we hook Game.main_menu
local old = Game.main_menu
Game.main_menu = function(change_context)
    if MANIF.PROSO.rank == -1 then
        for k, v in pairs(SMODS.Ranks) do
            if v.face then
                if MANIF.PROSO.rank < v.id then
                    MANIF.PROSO.rank = v.id
                end
                table.insert(MANIF.PROSO.faces, k)
                MANIF.PROSO.is_face[v.id] = true
                for _, key in ipairs(v.next) do
                    if not SMODS.Ranks[key].face then
                        table.insert(MANIF.PROSO.after_face, key)
                    end
                end
            end
        end

        for k, v in pairs(SMODS.Ranks) do
            if v.face then
                MANIF.PROSO.next[k] = MANIF.PROSO.after_face
            else
                local before_face = false
                for _, key in ipairs(v.next) do
                    if SMODS.Ranks[key].face then
                        before_face = true
                        break
                    end
                end
                if before_face then
                    MANIF.PROSO.next[k] = SMODS.shallow_copy(MANIF.PROSO.faces)
                    for _, key in ipairs(v.next) do
                        if not SMODS.Ranks[key].face then
                            table.insert(MANIF.PROSO.next[k], key)
                        end
                    end
                else
                    MANIF.PROSO.next[k] = v.next
                end
            end
        end
    end
    old(change_context)
end

SMODS.Joker {
    key = "prosopagnosia",
    rarity = 2,
    atlas = "jokers",
    pos = {x = 0, y = 0},
    cost = 5
}

