-- E-Paper Deck, see also e_paper.toml and sell_cost.toml
local prev = "b_manifold_white"

SMODS.Shader {
    key = "e_paper",
    path = "e_paper.fs"
}

local should_update = function(side, template)
    return not side or side.atlas.name ~= template.atlas.name or side.sprite_pos.x ~= template.sprite_pos.x or side.sprite_pos.y ~= template.sprite_pos.y
end

SMODS.DrawStep {
    key = "e_paper",
    order = 70,
    func = function(card, layer)
        if G.deck and card == G.deck.cards[1] then
            if G.e_paper and #G.e_paper.cards > 0 then
                local target = G.e_paper.cards[1]
                if should_update(card.children.e_paper, target.children.center) then
                    if card.children.e_paper then
                        card.children.e_paper:remove()
                    end
                    card.children.e_paper = SMODS.create_sprite(card.T.x, card.T.y, card.T.w, card.T.h, target.children.center.atlas, target.children.center.sprite_pos)
                    card.children.e_paper.states.hover = card.states.hover
                    card.children.e_paper.states.click = card.states.click
                    card.children.e_paper.states.drag = card.states.drag
                    card.children.e_paper.states.collide.can = false
                    card.children.e_paper:set_role({major = card, role_type = "Glued", draw_major = card})
                    card.children.e_paper.custom_draw = true
                end
                card.children.e_paper:draw_shader("manifold_e_paper", nil, {{name = "floating", val = 0}, {name = "aspects", val = {target.children.center.atlas.image:getDimensions()}}}, nil, nil, nil, nil, nil, nil, true)
                if target.children.floating_sprite then
                    if should_update(card.children.floating_sprite, target.children.floating_sprite) then
                        if card.children.floating_sprite then
                            card.children.floating_sprite:remove()
                        end
                        card.children.floating_sprite = SMODS.create_sprite(card.T.x, card.T.y, card.T.w, card.T.h, target.children.floating_sprite.atlas, target.children.floating_sprite.sprite_pos)
                        card.children.floating_sprite.role.draw_major = card
                        card.children.floating_sprite.states.hover.can = false
                        card.children.floating_sprite.states.click.can = false
                    end
                    card.children.floating_sprite:draw_shader("manifold_e_paper", nil, {{name = "floating", val = 1}, {name = "aspects", val = {target.children.floating_sprite.atlas.image:getDimensions()}}}, true, card.children.back, nil, nil, nil, nil, true)
                elseif card.children.floating_sprite then
                    card.children.floating_sprite:remove()
                    card.children.floating_sprite = nil
                end
            elseif card.children.e_paper then
                card.children.e_paper:remove()
                card.children.e_paper = nil
            end
        end
    end,
    conditions = {vortex = false, facing = "back"}
}

SMODS.Back {
    key = "e_paper",
    atlas = "backs",
    pos = {x = 5, y = 1},
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        if G.P_CENTERS[prev].unlocked then
            return {vars = {localize{type = "name_text", set = "Back", key = prev}}}
        else
            return {vars = {localize("k_unknown")}}
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == "win_deck" and get_deck_win_stake(prev) > 0
    end,
    calculate = function(self, back, context)
        if context.selling_card and context.card.ability.set == "Joker" then
            if #G.e_paper.cards > 0 then
                local prev = G.e_paper.cards[1]
                G.e_paper:remove_card(prev)
                prev:remove()
                prev = nil
            end
            local copy = copy_card(context.card, nil, nil, nil, true)
            for k, v in ipairs(SMODS.Sticker.obj_buffer) do
                if copy.ability[v] then
                    copy:remove_sticker(v)
                end
            end
            copy:add_to_deck()
            G.e_paper:emplace(copy)
        end
    end
}