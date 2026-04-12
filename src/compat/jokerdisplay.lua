-- JokerDisplay
JokerDisplay.Definitions.j_manifold_prosopagnosia = {}
JokerDisplay.Definitions.j_manifold_archwizard = {
    text = {
        {text = "+"},
        {ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult"}
    },
    text_config = {colour = G.C.MULT},
    reminder_text = {
        {text = "("},
        {ref_table = "card.joker_display_values", ref_value = "loyalty_text"},
        {text = ")"}
    },
    calc_function = function(card)
        local archwizard_remaining = card.ability.archwizard_remaining + (next(G.play.cards) and 1 or 0)
        card.joker_display_values.is_active = archwizard_remaining % (card.ability.extra.every + 1) == 0
        card.joker_display_values.loyalty_text = localize {
            type = "variable",
            key = (card.joker_display_values.is_active and "loyalty_active" or "loyalty_inactive"),
            vars = {archwizard_remaining}
        }
        card.joker_display_values.mult = (card.joker_display_values.is_active and card.ability.extra.mult or 0)
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or
                G.C.UI.TEXT_INACTIVE
        end
    end
}
JokerDisplay.Definitions.j_manifold_black_knight = {}
JokerDisplay.Definitions.j_manifold_bob = {
    text = {
        {
            border_nodes = {
                {text = "x"},
                {ref_table = "card.joker_display_values", ref_value = "x_mult"}
            }
        }
    },
    reminder_text = {
        {text = "("},
        {ref_table = "card.joker_display_values", ref_value = "count", colour = G.C.ORANGE},
        {text = "x"},
        {ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.GREEN},
        {text = ")"}
    },
    calc_function = function(card)
        local count = G.consumeables and G.consumeables.cards and #G.consumeables.cards or 0
        card.joker_display_values.count = count
        card.joker_display_values.localized_text = localize("b_stat_consumables")
        card.joker_display_values.x_mult = card.ability.extra.x_mult ^ count
    end
}
JokerDisplay.Definitions.j_manifold_alice = {
    text = {
        {text = "+"},
        {ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult"}
    },
    text_config = {colour = G.C.SECONDARY_SET.Spectral},
    reminder_text = {
        {ref_table = "card.joker_display_values", ref_value = "localized_text"}
    },
    calc_function = function(card)
        local count = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= "Unknown" then
            for _, scoring_card in pairs(scoring_hand) do
                if scoring_card:is_rank(14) then
                    local retriggers = JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    count = count + retriggers
                end
            end
        end
        card.joker_display_values.count = count
        card.joker_display_values.localized_text = "(" .. localize("k_aces") .. ")"
    end
}
JokerDisplay.Definitions.j_manifold_space_patrol = {}
JokerDisplay.Definitions.j_manifold_clay_tablet = {}
JokerDisplay.Definitions.j_manifold_orange_juice = {}
JokerDisplay.Definitions.j_manifold_pudding = {
    text = {
        {text = "+"},
        {ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult"}
    },
    text_config = {colour = G.C.MULT},
    reminder_text = {
        {text = "("},
        {ref_table = "card.ability.extra", ref_value = "count"},
        {text = "/"},
        {ref_table = "card.joker_display_values", ref_value = "start_count"},
        {text = ")"}
    },
    calc_function = function(card)
        local mult = 0
        local triggers = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= "Unknown" then
            for _, scoring_card in pairs(scoring_hand) do
                if SMODS.has_enhancement(scoring_card, "m_bonus") then
                    triggers = triggers + 1
                    mult = mult + card.ability.extra.mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    if triggers >= card.ability.extra.count then
                        break
                    end
                end
            end
        end
        card.joker_display_values.mult = mult
        card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.count
    end
}
JokerDisplay.Definitions.j_manifold_cookie_dough = {
    text = {
        {text = "+"},
        {ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult"}
    },
    text_config = {colour = G.C.MULT},
    calc_function = function(card)
        local mult = G.GAME.current_round.current_hand.chip_text
        if tonumber(mult) or type(mult) == "table" then
            card.joker_display_values.mult = mult
        else
            card.joker_display_values.mult = localize("manifold_unknown")
        end
    end
}