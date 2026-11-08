-- Silver Deck
local threshold = 170

SMODS.Back {
    key = "silver",
    atlas = "backs",
    pos = {x = 1, y = 0},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        return {vars = {threshold}}
    end,
    check_for_unlock = function(self, args)
        return args.type == "discover_amount" and args.amount >= threshold
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event{func = function()
            local key = nil
            if G.GAME.stake >= 8 then
                local g = 0
                local r = {{}, {}, {}}
                for i = 1, 3 do
                    for k, v in ipairs(G.P_JOKER_RARITY_POOLS[i]) do
                        if not v.enhancement_gate and not v.yes_pool_flag and SMODS.add_to_pool(v) and not G.GAME.banned_keys[v.key] then
                            if get_joker_win_sticker(v, true) < 8 then
                                table.insert(r[i], v.key)
                            else
                                g = g + 1
                            end
                        end
                    end
                end
                if #r[1] + #r[2] + #r[3] > 0 and g > 0 then
                    local roll = pseudorandom("manifold_silver")
                    local total = 0
                    if #r[1] > 0 then
                        total = 0.7
                    end
                    if #r[2] > 0 then
                        total = total + 0.25
                    end
                    if #r[3] > 0 then
                        total = total + 0.05
                    end
                    roll = roll * total
                    local rarity = 3
                    if roll < 0.7 and #r[1] > 0 then
                        rarity = 1
                    elseif roll < 0.95 and #r[2] > 0 then
                        rarity = 2
                    end
                    key = pseudorandom_element(r[rarity], pseudoseed("manifold_silver"))
                end
            end
            SMODS.add_card{set = "Joker", area = G.jokers, key = key, key_append = "manifold_silver"}
            return true end})
    end
}