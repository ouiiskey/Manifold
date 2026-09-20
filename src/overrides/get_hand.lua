-- See also is_rank.toml
local function quick_merge(a, b)
    for k, v in ipairs(b) do
        table.insert(a, v)
    end
end

function get_straight(hand, min_length, skip, wrap)
    min_length = min_length or 5
    if #hand < min_length then return {} end
    local proso = next(SMODS.find_card("j_manifold_prosopagnosia"))
    local any = {}
    local face = {}
    local rankmap = {}
    for k, v in ipairs(hand) do
        if MANIF.has_any_rank(v) then
            table.insert(any, v)
        elseif proso and v:is_face() then
            table.insert(face, v)
        elseif not SMODS.has_no_rank(v) then
            local id = v:get_id()
            if not rankmap[id] then
                rankmap[id] = {}
            end
            table.insert(rankmap[id], v)
        end
    end
    local order
    if wrap then
        if skip then
            order = {14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 14, 13, 12, 11, 10, 9, 8, 7}
        else
            order = {14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 14, 13, 12, 11}
        end
    else
        order = {14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 14}
    end
    local function recursive_straight(straight, length, face_count, any_count, i)
        local skipped = false
        local valid = false
        while i <= #order do
            if rankmap[order[i]] then
                quick_merge(straight, rankmap[order[i]])
                length = length + 1
                skipped = false
                goto continue
            elseif MANIF.is_face(order[i]) and face_count > 0 then
                local ret, rec_valid = recursive_straight(straight, length + 1, face_count - 1, any_count, i + 1)
                if rec_valid then
                    return ret, true
                end
            end
            if skip and not skipped and length > 0 then
                skipped = true
                goto continue
            end
            if any_count > 0 then
                local ret, rec_valid = recursive_straight(straight, length + 1, face_count, any_count - 1, i + 1)
                if rec_valid then
                    return ret, true
                end
            end
            valid = length >= min_length
            if valid then
                quick_merge(straight, any)
                if face_count < #face then
                    quick_merge(straight, face)
                end
                return {straight}, true
            end
            straight = {}
            length = 0
            face_count = #face
            any_count = #any
            skipped = false
            ::continue::
            i = i + 1
        end
        return {}, false
    end
    return recursive_straight({}, 0, #face, #any, 1)
end

function get_X_same(num, hand)
    if #hand < num then return {} end
    local proso = next(SMODS.find_card("j_manifold_prosopagnosia"))
    local any = {}
    local rankmap = {}
    for k, v in ipairs(hand) do
        if MANIF.has_any_rank(v) then
            table.insert(any, v)
        elseif proso and v:is_face() then
            if not rankmap[13] then
                rankmap[13] = {}
            end
            table.insert(rankmap[13], v)
        elseif not SMODS.has_no_rank(v) then
            local id = v:get_id()
            if not rankmap[id] then
                rankmap[id] = {}
            end
            table.insert(rankmap[id], v)
        end
    end
    local argmax = 14
    if not rankmap[argmax] then
        rankmap[argmax] = {}
    end
    for k, v in pairs(rankmap) do
        if #v > #rankmap[argmax] or #v == #rankmap[argmax] and k > argmax then
            argmax = k
        end
    end
    quick_merge(rankmap[argmax], any)
    return #rankmap[argmax] >= num and {rankmap[argmax]} or {}
end

SMODS.PokerHandPart {
    key = "full_house",
    func = function(hand)
        if #hand < 5 then return {} end
        local proso = next(SMODS.find_card("j_manifold_prosopagnosia"))
        local any = {}
        local face = {}
        local rankmap = {}
        local no_rank = 0
        for k, v in ipairs(hand) do
            if SMODS.has_no_rank(v) then
                no_rank = no_rank + 1
            elseif MANIF.has_any_rank(v) then
                table.insert(any, v)
            elseif proso and v:is_face() then
                table.insert(face, v)
            else
                local id = v:get_id()
                if not rankmap[id] then
                    rankmap[id] = {}
                end
                table.insert(rankmap[id], v)
            end
        end
        if #hand - no_rank < 5 then return {} end
        if #face == 5 then
            return {face}
        elseif #face == 4 then
            rankmap[11] = {face[1], face[2], face[3]}
            rankmap[12] = {face[4]}
        elseif #face >= 1 then
            rankmap[11] = face
        end
        if #any == 5 then
            return {any}
        elseif #any >= 3 then
            for k, v in pairs(rankmap) do
                quick_merge(any, v)
            end
            return {any}
        elseif #any == 2 then
            local two = false
            for k, v in pairs(rankmap) do
                quick_merge(any, v)
                if #v == 3 then
                    return {any}
                elseif #v == 2 then
                    two = true
                end
            end
            if two then return {any} end
        elseif #any == 1 then
            local three = false
            local two = 0
            for k, v in pairs(rankmap) do
                quick_merge(any, v)
                if #v == 3 then
                    three = true
                    break
                elseif #v == 2 then
                    two = two + 1
                end
            end
            if three or two == 2 then return {any} end
        else
            local three = false
            local two = false
            for k, v in pairs(rankmap) do
                if #v == 3 then
                    three = true
                elseif #v == 2 then
                    two = true
                end
                quick_merge(any, v)
            end
            if three and two then return {any} end
        end
        return {}
    end
}

SMODS.PokerHandPart {
    key = "two_pair",
    func = function(hand)
        if #hand < 4 then return {} end
        local proso = next(SMODS.find_card("j_manifold_prosopagnosia"))
        local any = {}
        local face = {}
        local rankmap = {}
        local no_rank = 0
        for k, v in ipairs(hand) do
            if SMODS.has_no_rank(v) then
                no_rank = no_rank + 1
            elseif MANIF.has_any_rank(v) then
                table.insert(any, v)
            elseif proso and v:is_face() then
                table.insert(face, v)
            else
                local id = v:get_id()
                if not rankmap[id] then
                    rankmap[id] = {}
                end
                table.insert(rankmap[id], v)
            end
        end
        if #hand - no_rank < 4 then return {} end
        if #face == 5 then
            return {face}
        elseif #face == 4 then
            rankmap[11] = {face[1], face[2]}
            rankmap[12] = {face[3], face[4]}
        elseif #face == 3 and #any == 1 then
            rankmap[11] = {face[1], face[2]}
            rankmap[12] = {face[3]}
        elseif #face >= 1 then
            rankmap[11] = face
        end
        if #any == 5 then
            return {any}
        elseif #any >= 2 then
            for k, v in pairs(rankmap) do
                quick_merge(any, v)
            end
            return {any}
        elseif #any == 1 then
            local three = false
            local two = false
            for k, v in pairs(rankmap) do
                quick_merge(any, v)
                if #v == 3 then
                    three = true
                elseif #v == 2 then
                    two = true
                end
            end
            if two or three and #hand - no_rank == 5 then return {any} end
        else
            for k, v in pairs(rankmap) do
                if #v >= 2 then
                    quick_merge(any, v)
                end
            end
            if #any >= 4 then
                return {any}
            end
        end
        return {}
    end
}