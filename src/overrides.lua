-- Escher Ordered Deck View
local ordered = function()
    local deck_tables = {}
    remove_nils(G.deck.cards)
    G.VIEWING_DECK = true
    for i = 4, 1, -1 do
        local view_deck = CardArea(
                G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
                6.5 * G.CARD_W,
                (0.6) * G.CARD_H,
                {card_limit = #G.deck.cards / 4, type = "title", view_deck = true, highlight_limit = 0, card_w = G.CARD_W * 0.7, draw_layers = {"card"}})
        table.insert(deck_tables, {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {{n = G.UIT.O, config = {object = view_deck}}}})
        for j = math.min(math.ceil(i * #G.deck.cards / 4), #G.deck.cards), math.ceil((i - 1) * #G.deck.cards / 4 + 1), -1  do
            local copy = copy_card(G.deck.cards[j], nil, 0.7)
            copy:hard_set_T()
            view_deck:emplace(copy)
        end
    end

    local flip_col = G.C.WHITE
    local suit_tallies = {}
    local mod_suit_tallies = {}
    local suit_map = {}
    for i = #SMODS.Suit.obj_buffer, 1, -1 do
        suit_map[#suit_map + 1] = SMODS.Suit.obj_buffer[i]
    end
    for k, v in ipairs(suit_map) do
        suit_tallies[v] = 0
        mod_suit_tallies[v] = 0
    end
    local rank_tallies = {}
    local mod_rank_tallies = {}
    local rank_name_mapping = SMODS.Rank.obj_buffer
    for k, v in ipairs(rank_name_mapping) do
        rank_tallies[v] = 0
        mod_rank_tallies[v] = 0
    end
    local face_tally = 0
    local mod_face_tally = 0
    local num_tally = 0
    local mod_num_tally = 0
    local ace_tally = 0
    local mod_ace_tally = 0

    for k, v in ipairs(G.deck.cards) do
        if v.ability.name ~= "Stone Card" then
            local v_nr, v_ns = SMODS.has_no_rank(v), SMODS.has_no_suit(v)
            --For the suits
            if v.base.suit and not v_ns then suit_tallies[v.base.suit] = (suit_tallies[v.base.suit] or 0) + 1 end
            for kk, vv in pairs(mod_suit_tallies) do
                mod_suit_tallies[kk] = (vv or 0) + (v:is_suit(kk) and 1 or 0)
            end

            --for face cards/numbered cards/aces
            local card_id = v:get_id()
            if v.base.value and not v_nr and SMODS.Ranks[v.base.value].face then face_tally = face_tally + 1 end
            if v:is_face() then mod_face_tally = mod_face_tally + 1 end
            if v.base.value and not v_nr and not SMODS.Ranks[v.base.value].face and card_id ~= 14 then num_tally = num_tally + 1 end
            if v:is_number(true) then mod_num_tally = mod_num_tally + 1 end
            if card_id == 14 then ace_tally = ace_tally + 1 end
            if v:is_rank(14, true) then mod_ace_tally = mod_ace_tally + 1 end

            --ranks
            for kk, vv in ipairs(rank_name_mapping) do
                if card_id == SMODS.Ranks[vv].id then rank_tallies[vv] = rank_tallies[vv] + 1 end
                if v:is_rank(SMODS.Ranks[vv].id, true) then mod_rank_tallies[vv] = mod_rank_tallies[vv] + 1 end
            end
        end
    end
    local modded = face_tally ~= mod_face_tally
    for kk, vv in pairs(mod_suit_tallies) do
        modded = modded or (vv ~= suit_tallies[kk])
        if modded then break end
    end

    local rank_cols = {}
    for i = #rank_name_mapping, 1, -1 do
        if rank_tallies[rank_name_mapping[i]] ~= 0 or not SMODS.Ranks[rank_name_mapping[i]].in_pool or SMODS.Ranks[rank_name_mapping[i]]:in_pool({suit = ""}) then
            local mod_delta = mod_rank_tallies[rank_name_mapping[i]] ~= rank_tallies[rank_name_mapping[i]]
            rank_cols[#rank_cols + 1] = {n = G.UIT.R, config = {align = "cm", padding = 0.07}, nodes = {
                {n = G.UIT.C, config = {align = "cm", r = 0.1, padding = 0.04, emboss = 0.04, minw = 0.5, colour = G.C.L_BLACK}, nodes = {
                    {n = G.UIT.T, config = {text = SMODS.Ranks[rank_name_mapping[i]].shorthand, colour = G.C.JOKER_GREY, scale = 0.35, shadow = true}}}},
                {n = G.UIT.C, config = {align = "cr", minw = 0.4}, nodes = {
                    mod_delta and {n = G.UIT.O, config = {
                        object = DynaText({
                            string = { { string = "" .. rank_tallies[rank_name_mapping[i]], colour = flip_col }, { string = "" .. mod_rank_tallies[rank_name_mapping[i]], colour = G.C.BLUE } },
                            colours = { G.C.RED }, scale = 0.4, y_offset = -2, silent = true, shadow = true, pop_in_rate = 10, pop_delay = 4
                        })}}
                            or {n = G.UIT.T, config = {text = rank_tallies[rank_name_mapping[i]], colour = flip_col, scale = 0.45, shadow = true}}}}}}
        end
    end

    local tally_ui = {
        -- base cards
        {n = G.UIT.R, config = {align = "cm", minh = 0.05, padding = 0.07}, nodes = {
            {n = G.UIT.O, config = {
                object = DynaText({
                    string = {
                        { string = localize("k_base_cards"), colour = G.C.RED },
                        modded and { string = localize("k_effective"), colour = G.C.BLUE } or nil
                    },
                    colours = { G.C.RED }, silent = true, scale = 0.4, pop_in_rate = 10, pop_delay = 4
                })
            }}}},
        -- aces, faces and numbered cards
        {n = G.UIT.R, config = {align = "cm", minh = 0.05, padding = 0.1}, nodes = {
            tally_sprite(
                    { x = 1, y = 0 },
                    { { string = "" .. ace_tally, colour = flip_col }, { string = "" .. mod_ace_tally, colour = G.C.BLUE } },
                    { localize("k_aces") }
            ), --Aces
            tally_sprite(
                    { x = 2, y = 0 },
                    { { string = "" .. face_tally, colour = flip_col }, { string = "" .. mod_face_tally, colour = G.C.BLUE } },
                    { localize("k_face_cards") }
            ), --Face
            tally_sprite(
                    { x = 3, y = 0 },
                    { { string = "" .. num_tally, colour = flip_col }, { string = "" .. mod_num_tally, colour = G.C.BLUE } },
                    { localize("k_numbered_cards") }
            ), --Numbers
        }},
    }
    -- add suit tallies
    local suits_per_row = 2
    local n_nodes = {}
    local temp_list = {}
    for k, v in pairs(suit_map) do
        table.insert(n_nodes, tally_sprite(
                SMODS.Suits[v].ui_pos,
                {
                    { string = "" .. suit_tallies[v], colour = flip_col },
                    { string = "" .. mod_suit_tallies[v], colour = G.C.BLUE }
                },
                { localize(v, "suits_plural") }, v))
        if #n_nodes == suits_per_row then
            table.insert(temp_list, n_nodes)
            n_nodes = {}
        end
    end
    if #n_nodes > 0 then
        table.insert(temp_list, n_nodes)
    end

    for k, v in ipairs(temp_list) do
        local n = {n = G.UIT.R, config = {align = "cm", minh = 0.05, padding = 0.05}, nodes = v}
        table.insert(tally_ui, n)
    end

    local object = {n = G.UIT.ROOT, config = {align = "cm", colour = G.C.CLEAR}, nodes = {
        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {}},
        {n = G.UIT.R, config = {align = "cm"}, nodes = {
            {n = G.UIT.C, config = {align = "cm", minw = 1.5, minh = 2, r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes = {
                {n = G.UIT.C, config = {align = "tm", padding = 0.1}, nodes = {
                    {n = G.UIT.R, config = {align = "cm", r = 0.1, colour = G.C.L_BLACK, emboss = 0.05, padding = 0.15}, nodes = {
                        {n = G.UIT.R, config = {align = "cm"}, nodes = {
                            {n = G.UIT.O, config = {
                                object = DynaText({ string = G.GAME.selected_back.loc_name, colours = {G.C.WHITE}, bump = true, rotate = true, shadow = true, scale = 0.6 - string.len(G.GAME.selected_back.loc_name) * 0.01 })
                            }},
                        }},
                        {n = G.UIT.R, config = {align = "cm", r = 0.1, padding = 0.1, minw = 2.5, minh = 1.3, colour = G.C.WHITE, emboss = 0.05}, nodes = {
                            {n = G.UIT.O, config = {
                                object = UIBox {
                                    definition = G.GAME.selected_back:generate_UI(nil, 0.7, 0.5, G.GAME.challenge), config = {offset = { x = 0, y = 0 } }
                                }
                            }}
                        }}
                    }},
                    {n = G.UIT.R, config = {align = "cm", r = 0.1, outline_colour = G.C.L_BLACK, line_emboss = 0.05, outline = 1.5}, nodes = tally_ui}
                }},
                {n = G.UIT.C, config = {align = "cm"}, nodes = rank_cols},
                {n = G.UIT.B, config = {w = 0.1, h = 0.1}},
            }},
            {n = G.UIT.B, config = {w = 0.2, h = 0.1}},
            {n = G.UIT.C, config = {align = "cm", padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes = deck_tables}
        }},
        {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
            modded and {n = G.UIT.R, config = {align = "cm"}, nodes = {
                {n = G.UIT.C, config = {padding = 0.3, r = 0.1, colour = mix_colours(G.C.BLUE, G.C.WHITE, 0.7)}, nodes = {}},
                {n = G.UIT.T, config = {text = " " .. localize("ph_deck_preview_effective"), colour = G.C.WHITE, scale = 0.3}}}}
                    or nil}}}}
    return {n = G.UIT.ROOT, config = {align = "cm", minw = 3, padding = 0.1, r = 0.1, colour = G.C.CLEAR}, nodes = {
        {n = G.UIT.O, config = {
            id = "suit_list",
            object = UIBox {
                definition = object, config = {offset = { x = 0, y = 0 }, align = "cm"}
            }}}}}
end

G.UIDEF.deck_info = function(show_remaining)
    local views = {{label = localize("b_full_deck"), tab_definition_function = G.UIDEF.view_deck}}
    if show_remaining then
        table.insert(views, 1, {label = localize("b_remaining"), tab_definition_function = G.UIDEF.view_deck, tab_definition_function_args = true})
    end
    if next(SMODS.find_card("j_manifold_escher")) then
        table.insert(views, 1, {label = localize("manifold_ordered"), tab_definition_function = ordered})
    end
    views[1].chosen = true
    return create_UIBox_generic_options({contents = {create_tabs{tabs = views, tab_h = 8, snap_to_nav = true}}})
end

-- Negative Planet Card
local SEgclk_ref = SMODS.Edition.get_card_limit_key
function SMODS.Edition:get_card_limit_key()
    if self.ability.set == "Planet" then return "negative_planet_SMODS_INTERNAL" end
    return SEgclk_ref(self)
end