-- Rorschach
local limit = 4

SMODS.Joker {
    key = "rorschach",
    rarity = 3,
    atlas = "jokers",
    pos = {x = 9, y = 2},
    cost = 8,
    unlocked = false,
    locked_loc_vars = function(self, info_queue, card)
        return {vars = {limit}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "win_custom" and G.GAME.max_jokers <= limit
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "manifold_perishable", set = "Other", vars = {G.GAME.perishable_rounds or 1}}
    end,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            local targets = {}
            for k, v in ipairs(G.jokers.cards) do
                if v ~= card then
                    table.insert(targets, v)
                end
            end
            if #targets > 0 then
                if #G.jokers.cards <= G.jokers.config.card_limit then
                    local chosen_joker = pseudorandom_element(targets, pseudoseed("manifold_rorschach"))
                    local copy = copy_card(chosen_joker)
                    if copy.ability.invis_rounds then copy.ability.invis_rounds = 0 end
                    copy:set_eternal(false)
                    copy:add_sticker("perishable", true)
                    copy:add_to_deck()
                    G.jokers:emplace(copy)
                    return {
                        message = localize("k_duplicated_ex")
                    }
                else
                    return {
                        message = localize("k_no_room_ex")
                    }
                end
            else
                return {
                    message = localize("k_no_other_jokers")
                }
            end
        end
    end,
    eternal_compat = false
}