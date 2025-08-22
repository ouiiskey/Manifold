-- Run once at end of startup

-- Prosopagnosia
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

-- Digi-Carrot
local hook = true
for k, v in pairs(SMODS.calculation_keys) do
    if v == "e_mult" then
        hook = false
        break
    end
end
if hook then
    table.insert(SMODS.calculation_keys, "e_mult")
    local Scie_ref = SMODS.calculate_individual_effect
    SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
        if key == "e_mult" and amount ~= 1 then
            mult = mod_mult(mult ^ amount)
            update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            card_eval_status_text(scored_card, "e_mult", amount, percent)
            return true
        end
        return Scie_ref(effect, scored_card, key, amount, from_edition)
    end
end

-- The Soul
local soul = {"j_caino", "j_triboulet", "j_yorick", "j_chicot", "j_perkeo",
} -- Hook: Soul jokers
MANIF.sou = {}
for k, v in ipairs(soul) do
    SMODS.insert_pool(MANIF.sou, G.P_CENTERS[v])
end

-- The Mind
local mind = {"j_manifold_weierstrass", "j_manifold_pareto", "j_manifold_peano", "j_manifold_escher", "j_manifold_shannon",
} -- Hook: Mind jokers
MANIF.manifold_mind = {}
for k, v in ipairs(mind) do
    SMODS.insert_pool(MANIF.manifold_mind, G.P_CENTERS[v])
end