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
        card.joker_display_values.loyalty_text = localize{
            type = "variable",
            key = (card.joker_display_values.is_active and "loyalty_active" or "loyalty_inactive"),
            vars = {archwizard_remaining}
        }
        card.joker_display_values.mult = (card.joker_display_values.is_active and card.ability.extra.mult or 0)
    end,
    style_function = function(card, text, reminder_text, extra)
        reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
    end
}
JokerDisplay.Definitions.j_manifold_black_knight = {}
JokerDisplay.Definitions.j_manifold_bob = {
    text = {{
        border_nodes = {
            {text = "X"},
            {ref_table = "card.joker_display_values", ref_value = "x_mult"}
        }
    }},
    reminder_text = {
        {text = "("},
        {ref_table = "card.joker_display_values", ref_value = "count", colour = G.C.ORANGE},
        {text = "x"},
        {text = localize("b_stat_consumables"), colour = G.C.GREEN},
        {text = ")"}
    },
    calc_function = function(card)
        local count = G.consumeables and G.consumeables.cards and #G.consumeables.cards or 0
        card.joker_display_values.count = count
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
        {text = "(" .. localize("k_aces") .. ")"}
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
    end
}
JokerDisplay.Definitions.j_manifold_space_patrol = {}
JokerDisplay.Definitions.j_manifold_clay_tablet = {
    reminder_text = {
        {text = "("},
        {ref_table = "card.joker_display_values", ref_value = "state"},
        {text = ")"}
    },
    calc_function = function(card)
        card.joker_display_values.is_active = false
        for i = 2, #JokerDisplay.current_hand do
            if not JokerDisplay.current_hand[i].edition and SMODS.has_enhancement(JokerDisplay.current_hand[i], "m_stone") and JokerDisplay.current_hand[i-1]:is_rank(6) then
                card.joker_display_values.is_active = true
                break
            end
        end
        card.joker_display_values.state = card.joker_display_values.is_active and localize("k_active_ex") or localize("jdis_inactive")
    end,
    style_function = function(card, text, reminder_text, extra)
        reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
    end
}
JokerDisplay.Definitions.j_manifold_orange_juice = {
    reminder_text = {
        {text = "("},
        {ref_table = "card.joker_display_values", ref_value = "warning"},
        {text = ")"}
    },
    calc_function = function(card)
        card.joker_display_values.will_drink = false
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        for k, v in ipairs(scoring_hand) do
            if SMODS.has_enhancement(v, "m_lucky") then
                card.joker_display_values.will_drink = true
                break
            end
        end
        card.joker_display_values.warning = card.joker_display_values.will_drink and localize("k_drank_ex") or localize("k_safe_ex")
    end,
    style_function = function(card, text, reminder_text, extra)
        reminder_text.children[2].config.colour = card.joker_display_values.will_drink and G.C.RED or G.C.UI.TEXT_INACTIVE
    end
}
JokerDisplay.Definitions.j_manifold_pudding = {
    text = {
        {text = "+"},
        {ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult"}
    },
    text_config = {colour = G.C.MULT},
    reminder_text = {
        {text = "("},
        {ref_table = "card.ability.extra", ref_value = "count"},
        {text = "/5)"}
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
JokerDisplay.Definitions.j_manifold_cookie = {
    text = {
        {text = "+"},
        {ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult"}
    },
    text_config = {colour = G.C.CHIPS},
    calc_function = function(card)
        local chips = G.GAME.current_round.current_hand.mult_text
        if tonumber(chips) or type(chips) == "table" then
            card.joker_display_values.chips = chips
        else
            card.joker_display_values.chips = localize("manifold_unknown")
        end
    end
}
JokerDisplay.Definitions.j_manifold_baked_potato = {
    text = {
        {text = "+"},
        {ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult"}
    },
    text_config = {colour = G.C.CHIPS},
    reminder_text = {
        {text = "("},
        {ref_table = "card.ability.extra", ref_value = "triggers"},
        {text = "/30)"}
    },
    retrigger_joker_function = function (card, retrigger_joker)
        if card == retrigger_joker then
            local chips = G.GAME.current_round.current_hand.chip_text
            local mult = G.GAME.current_round.current_hand.mult_text
            local triggers = 0
            if (tonumber(chips) or type(chips) == "table") and (tonumber(mult) or type(mult) == "table") then
                triggers = math.min(math.ceil((G.GAME.blind.chips / (mult + (card.edition and card.edition.mult or 0)) - chips - (card.edition and card.edition.chips or 0)) / card.ability.extra.chips) - 1, card.ability.extra.triggers) - 1
            end
            return triggers > 0 and triggers or 0
        end
        return 0
    end
}
JokerDisplay.Definitions.j_manifold_hot_potato = {
    text = {
        {text = "+"},
        {ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult"}
    },
    text_config = {colour = G.C.CHIPS},
    reminder_text = {
        {ref_table = "card.joker_display_values", ref_value = "hot_card"}
    },
    calc_function = function(card)
        card.joker_display_values.hot_card = "(" .. localize(G.GAME.current_round.hot_card and G.GAME.current_round.hot_card.rank or "Ace", "ranks") .. ")"
    end
}
JokerDisplay.Definitions.j_manifold_digi_carrot = {
    text = {{
        border_nodes = {
            {text = "^"},
            {
                ref_table = "card.ability.extra",
                ref_value = "e_mult",
                retrigger_type = function(base_number, triggers)
                    local out = base_number
                    for i = 2, triggers do
                        out = out ^ base_number
                    end
                    return out
                end
            }
        }
    }}
}
JokerDisplay.Definitions.j_manifold_extraterrestrial = {
    text = {
        {text = "+", colour = G.C.CHIPS},
        {ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult"},
        {text = " +", colour = G.C.MULT},
        {ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult"}
    },
    calc_function = function(card)
        local chips = 0
        local mult = 0
        local text = JokerDisplay.evaluate_hand()
        if G.GAME.hands[text] then
            chips = G.GAME.hands[text].chips
            mult = G.GAME.hands[text].mult
        end
        card.joker_display_values.chips = chips
        card.joker_display_values.mult = mult
    end
}
JokerDisplay.Definitions.j_manifold_cthugha = {
    text = {
        {text = "+"},
        {ref_table = "card.ability.extra", ref_value = "mult"}
    },
    text_config = {colour = G.C.MULT}
}
JokerDisplay.Definitions.j_manifold_nyarlathotep = {
    text = {{
        border_nodes = {
            {text = "X"},
            {ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp"}
        }
    }}
}
JokerDisplay.Definitions.j_manifold_hastur = {
    text = {
        {text = "+"},
        {ref_table = "card.ability.extra", ref_value = "chips"}
    },
    text_config = {colour = G.C.CHIPS}
}
JokerDisplay.Definitions.j_manifold_squid = {
    text = {
        {text = "+", colour = G.C.RED},
        {ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult", colour = G.C.RED},
        {
            ref_table = "card.joker_display_values",
            ref_value = "localized_text",
            retrigger_type = function(base_number, triggers)
                if base_number == localize("b_discard") and triggers ~= 1 then return localize("k_hud_discards") end
            end
        }
    },
    calc_function = function(card)
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        local is_active = #scoring_hand > 0
        for k, v in ipairs(scoring_hand) do
            if not v:is_number() then
                is_active = false
                break
            end
        end
        card.joker_display_values.count = is_active and 1 or 0
        card.joker_display_values.localized_text = " " .. (is_active and localize("b_discard") or localize("k_hud_discards"))
    end
}
JokerDisplay.Definitions.j_manifold_monkeys_paw = {
    text = {
        {text = "+"},
        {ref_table = "card.joker_display_values", ref_value = "text", retrigger_type = mult}
    },
    reminder_text = {{text = "", scale = 0}, {text = "", scale = 0}, {text = "", scale = 0}},
    calc_function = function(card)
        if G.GAME.fingers == 2 then
            card.joker_display_values.text = card.ability.extra.demult
        elseif G.GAME.fingers == 1 then
            card.joker_display_values.text = card.ability.extra.chips
        else
            card.joker_display_values.text = card.ability.extra.mult
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        local color = G.GAME.fingers == 1 and G.C.CHIPS or G.C.MULT
        text.children[1].config.colour = color
        text.children[2].config.colour = color
        if G.GAME.fingers == 2 then
            text.children[1].config.text = ""
            reminder_text.children[1].config.text = "("
            reminder_text.children[1].config.scale = 0.3
            reminder_text.children[2].config.text = card.ability.extra.hands
            reminder_text.children[2].config.scale = 0.3
            reminder_text.children[3].config.text = "/10)"
            reminder_text.children[3].config.scale = 0.3
            return true
        end
    end
}
JokerDisplay.Definitions.j_manifold_esper = {}
JokerDisplay.Definitions.j_manifold_mana_gem = {
    reminder_text = {
        {text = "("},
        {ref_table = "card.joker_display_values", ref_value = "active"},
        {text = ")"}
    },
    calc_function = function(card)
        card.joker_display_values.active = G.GAME.blind:get_type() == "Boss" and localize{type = "variable", key = "loyalty_active", vars = {}} or localize("jdis_inactive")
    end,
    style_function = function(card, text, reminder_text, extra)
        reminder_text.children[2].config.colour = G.GAME.blind:get_type() == "Boss" and G.C.GREEN or G.C.UI.TEXT_INACTIVE
    end
}
JokerDisplay.Definitions.j_manifold_wallet = {
    text = {
        {ref_table = "card.joker_display_values", ref_value = "stored"}
    },
    calc_function = function(card)
        card.joker_display_values.stored = #G.wallet.cards
    end,
    style_function = function(card, text, reminder_text, extra)
        text.children[1].config.colour = #G.wallet.cards > 0 and G.C.ORANGE or G.C.UI.TEXT_INACTIVE
    end
}
JokerDisplay.Definitions.j_manifold_carte_blanche = {
    text = {
        {ref_table = "card.joker_display_values", ref_value = "quant"},
        {text = " "},
        {ref_table = "card.joker_display_values", ref_value = "rank", colour = G.C.ORANGE}
    },
    calc_function = function(card)
        local rank, quant = MANIF.get_common(true)
        card.joker_display_values.quant = quant
        card.joker_display_values.rank = localize(rank, "ranks")
    end
}
local could_flip = function(card)
    -- Check for Wheel first to not step RNG
    return G.GAME.blind.name == "The Wheel" or G.GAME.blind:stay_flipped(G.hand, card)
end
JokerDisplay.Definitions.j_manifold_harpoon_gun = {
    text = {
        {ref_table = "card.joker_display_values", ref_value = "name"}
    },
    reminder_text = {
        {ref_table = "card.joker_display_values", ref_value = "base"}
    },
    extra = {
        {{ref_table = "card.joker_display_values", ref_value = "seal", colour = G.C.EDITION}},
        {{ref_table = "card.joker_display_values", ref_value = "edition", colour = G.C.DARK_EDITION}}
    },
    extra_config = {scale = 0.2},
    calc_function = function(card)
        local target = false
        for k, v in ipairs(G.deck.cards) do
            if not target or target.ID < v.ID then
                target = v
            end
        end
        local edition = ""
        local seal = ""
        local name = ""
        local base = ""
        if target then
            if not could_flip(target) then
                if target.edition and target.edition.key then
                    edition = edition .. localize{type = "name_text", set = "Edition", key = target.edition.key}
                end
                if target.seal then
                    seal = seal .. localize(target.seal:lower() .. "_seal", "labels")
                end
                if not SMODS.has_no_suit(target) then
                    name = name .. localize(target.base.suit, "suits_singular")
                    if not SMODS.has_no_rank(target) then
                        name = name .. " "
                    end
                end
                if not SMODS.has_no_rank(target) then
                    name = name .. localize(target.base.value, "ranks")
                end
                if target.config.center.key ~= "c_base" then
                    base = base .. localize{type = "name_text", set = "Enhanced", key = target.config.center.key}
                end
            else
                name = localize("manifold_unknown_total")
            end
        end
        card.joker_display_values.edition = edition
        card.joker_display_values.seal = seal
        card.joker_display_values.name = name
        card.joker_display_values.base = base
    end
}
JokerDisplay.Definitions.j_manifold_library = {}
local JDeh_ref = JokerDisplay.evaluate_hand
JokerDisplay.evaluate_hand = function(cards, count_facedowns)
    local text, poker_hands, scoring_hand = JDeh_ref(cards, count_facedowns)
    if not cards and next(SMODS.find_card("j_manifold_tsunami")) then
        local held_cards = {}
        for k, v in ipairs(G.hand.cards) do
            if not v.highlighted then
                table.insert(held_cards, v)
            end
        end
        scoring_hand = SMODS.merge_lists({scoring_hand, held_cards})
    end
    return text, poker_hands, scoring_hand
end
JokerDisplay.Definitions.j_manifold_tsunami = {}
JokerDisplay.Definitions.j_manifold_zombie = {
    text = {
        {ref_table = "card.joker_display_values", ref_value = "bodies"},
        {text = " " .. localize("k_face_cards")}
    },
    calc_function = function(card)
        local bodies = 0
        for k, v in ipairs(G.discard.cards) do
            if v:is_face() then
                bodies = bodies + 1
            end
        end
        card.joker_display_values.bodies = bodies
    end
}
JokerDisplay.Definitions.j_manifold_chicken = {}
JokerDisplay.Definitions.j_manifold_rorschach = {}
JokerDisplay.Definitions.j_manifold_memory = {
    text = {
        {text = "+"},
        {ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult"}
    },
    text_config = {colour = G.C.CHIPS}
}
JokerDisplay.Definitions.j_manifold_railgun = {
    text = {
        {text = "+"},
        {ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult"}
    },
    text_config = {colour = G.C.MULT}
}
JokerDisplay.Definitions.j_manifold_rebellion = {}
JokerDisplay.Definitions.j_manifold_propaganda = {
    text = {{
        border_nodes = {
            {text = "X"},
            {ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp"}
        }
    }}
}
JokerDisplay.Definitions.j_manifold_ufo = {}
JokerDisplay.Definitions.j_manifold_left_turns = {
    text = {
        {text = "+", colour = G.C.BLUE},
        {ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult", colour = G.C.BLUE},
        {text = " " .. localize("k_hud_hands")}
    },
    reminder_text = {
        {text = "("},
        {ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE},
        {text = ")"}
    },
    calc_function = function(card)
        local text, _, _ = JokerDisplay.evaluate_hand()
        card.joker_display_values.count = text == card.ability.extra.poker_hand and card.ability.extra.hands or 0
        card.joker_display_values.localized_text = localize(card.ability.extra.poker_hand, "poker_hands")
    end
}
JokerDisplay.Definitions.j_manifold_lucky_sevens = {
    text = {{
        border_nodes = {
            {text = "X"},
            {ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp"}
        }
    }}
}
JokerDisplay.Definitions.j_manifold_proud = {
    extra = {{
        {text = "("},
        {ref_table = "card.joker_display_values", ref_value = "odds"},
        {text = ")"}
    }},
    extra_config = {colour = G.C.GREEN, scale = 0.3},
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, "manifold_proud")
        card.joker_display_values.odds = localize{type = "variable", key = "jdis_odds", vars = {numerator, denominator}}
    end
}
JokerDisplay.Definitions.j_manifold_envious = {}
JokerDisplay.Definitions.j_manifold_slothful = {
    text = {{
        border_nodes = {
            {text = "X"},
            {ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp"}
        }
    }},
    reminder_text = {
        {text = "-", colour = G.C.BLUE},
        {ref_table = "card.joker_display_values", ref_value = "hands", retrigger_type = "mult", colour = G.C.BLUE},
        {text = " " .. localize("k_hud_hands")}
    },
    calc_function = function(card)
        local wilds = 0
        for k, v in ipairs(G.hand.cards) do
            if SMODS.has_enhancement(v, "m_wild") then
                wilds = wilds + 1
            end
        end
        card.joker_display_values.x_mult = wilds ^ card.ability.extra.x_mult
        card.joker_display_values.hands = wilds * card.ability.extra.hand_cost
    end
}
JokerDisplay.Definitions.j_manifold_weierstrass = {
    text = {
        {text = "+"},
        {ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult"}
    },
    text_config = {colour = G.C.MULT}
}
JokerDisplay.Definitions.j_manifold_pareto = {
    text = {
        {ref_table = "card.joker_display_values", ref_value = "chips_sign", colour = G.C.CHIPS},
        {ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult"},
        {text = " "},
        {ref_table = "card.joker_display_values", ref_value = "mult_sign", colour = G.C.MULT},
        {ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult"}
    },
    calc_function = function(card)
        local chips = G.GAME.current_round.current_hand.chip_text
        local mult = G.GAME.current_round.current_hand.mult_text
        local chips_mod
        local mult_mod
        local chips_sign = "+"
        local mult_sign = "+"
        if (tonumber(chips) or type(chips) == "table") and (tonumber(mult) or type(mult) == "table") then
            chips_mod = (mult - chips) / 2
            mult_mod = -chips_mod
            if chips_mod < 0 then
                chips_sign = ""
            end
            if mult_mod < 0 then
                mult_sign = ""
            end
        else
            chips_mod = localize("manifold_unknown")
            mult_mod = localize("manifold_unknown")
        end
        card.joker_display_values.chips = chips_mod
        card.joker_display_values.mult = mult_mod
        card.joker_display_values.chips_sign = chips_sign
        card.joker_display_values.mult_sign = mult_sign
    end
}
JokerDisplay.Definitions.j_manifold_peano = {
    reminder_text = {
        {text = "("},
        {ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE},
        {text = ")"}
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = localize(card.ability.extra.poker_hand, "poker_hands")
    end
}
JokerDisplay.Definitions.j_manifold_escher = {}
JokerDisplay.Definitions.j_manifold_shannon = {
    text = {
        {ref_table = "card.joker_display_values", ref_value = "compat", colour = G.C.GREEN}
    },
    calc_function = function(card)
        local compat = ""
        for i = 1, #G.jokers.cards do
            local bg_color, txt_color
            if G.jokers.cards[i].config.center.blueprint_compat and not G.jokers.cards[i].debuff and G.jokers.cards[i] ~= card then
                compat = compat .. "O"
            else
                compat = compat .. "X"
            end
            if i < #G.jokers.cards then
                compat = compat .. " "
            end
        end
        card.joker_display_values.compat = compat
    end
}
-- Vanilla
JokerDisplay.Definitions.j_hanging_chad = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if playing_card == JokerDisplay.sort_cards(scoring_hand)[1] or playing_card == JokerDisplay.sort_cards(scoring_hand)[2] then
            return JokerDisplay.calculate_joker_triggers(joker_card)
        else
            return 0
        end
    end
}
JokerDisplay.Definitions.j_matador = {
    text = {
        {text = "+$"},
        {ref_table = "card.joker_display_values", ref_value = "gold"},
    },
    text_config = {colour = G.C.GOLD},
    reminder_text = {
        {text = "(" .. localize("k_round") .. ")"},
    },
    calc_function = function(card)
        if G.GAME.chips/G.GAME.blind.chips < 1.5 then
            card.joker_display_values.gold = 6
        else
            card.joker_display_values.gold = 0
        end
    end
}