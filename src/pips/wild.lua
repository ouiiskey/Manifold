-- Wild, see also pips.toml
SMODS.Gradient {
    key = "lc_wild",
    colours = {G.C.SO_1.Spades, G.C.SO_1.Hearts, G.C.SO_1.Clubs, G.C.SO_1.Diamonds},
    cycle = 4,
    interpolation = "linear"
}

SMODS.Gradient {
    key = "hc_wild",
    colours = {G.C.SO_2.Spades, G.C.SO_2.Hearts, G.C.SO_2.Clubs, G.C.SO_2.Diamonds},
    cycle = 4,
    interpolation = "linear"
}

SMODS.Shader {
    key = "wild",
    path = "wild.fs"
}

SMODS.Atlas {
    key = "wild",
    path = "wild.png",
    px = 71,
    py = 95
}

SMODS.DrawStep {
    key = "wild_edition",
    order = 21, -- Prevent editions from covering
    func = function(card, layer)
        if card.base.suit == "manifold_wild" and (card.ability.delayed or not card:should_hide_front()) then
            if not card.children.wild or card.children.wild.sprite_pos.x ~= SMODS.Ranks[card.base.value].pos.x then
                if card.children.wild then
                    card.children.wild:remove()
                end
                card.children.wild = SMODS.create_sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS.manifold_wild, {x = SMODS.Ranks[card.base.value].pos.x, y = 0})
                card.children.wild.states.hover = card.states.hover
                card.children.wild.states.click = card.states.click
                card.children.wild.states.drag = card.states.drag
                card.children.wild.states.collide.can = false
                card.children.wild:set_role{major = card, role_type = "Glued", draw_major = card}
                card.children.wild.custom_draw = true
            end
            local offset = G.SETTINGS.colour_palettes.manifold_wild == "hc" and 4 or 0
            local edition = card.delay_edition or card.edition
            if edition and edition.negative then
                offset = offset + 8
            end
            card.children.wild:draw_shader("manifold_wild", nil, {G.TIMERS.REAL, offset, edition and edition.polychrome and 1 or 0})
        elseif card.children.wild then
            card.children.wild:remove()
            card.children.wild = nil
        end
    end,
    conditions = {vortex = false, facing = "front"},
}

local Shas_ref = SMODS.has_any_suit
function SMODS.has_any_suit(card)
    return card.base.suit == "manifold_wild" or Shas_ref(card)
end

SMODS.Suit {
    key = "wild",
    card_key = "?",
    pos = {y = 5},
    ui_pos = {x = 1, y = 0},
    lc_atlas = "pips",
    hc_atlas = "pips_hc", -- Only to display the option
    lc_ui_atlas = "ui",
    hc_ui_atlas = "ui_hc",
    lc_colour = SMODS.Gradients.manifold_lc_wild,
    hc_colour = SMODS.Gradients.manifold_hc_wild,
    in_pool = function(self, args)
        if args then
            if args.initial_deck then
                return false
            end
            return not args.rank == ""
        end
        return true
    end
}

-- Compatibility overrides
local She_ref = SMODS.has_enhancement
function SMODS.has_enhancement(card, key)
    return key == "m_wild" and card.base.suit == "manifold_wild" or She_ref(card, key)
end

local Csa_ref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    if center == G.P_CENTERS.m_wild then
        self:change_suit("manifold_wild")
    else
        Csa_ref(self, center, initial, delay_sprites)
    end
end

-- Disable vanilla Wild
SMODS.Enhancement:take_ownership("wild", {
    pools = {},
    in_pool = function(self, args)
        return false
    end
}, true)