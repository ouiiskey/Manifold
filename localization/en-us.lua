return {
    descriptions = {
        Joker = {
            j_manifold_prosopagnosia = {
                name = "Prosopagnosia",
                text = {
                    "{C:attention}Face{} cards count",
                    "as the same rank."
                }
            },
            j_manifold_archwizard = {
                name = "Archwizard",
                text = {
                    "{C:mult}+#1#{} Mult every",
                    "{C:attention}#2#{} hands played",
                    "{C:inactive}#3#",
                }
            }
        },
        Other = {
            manifold_black_seal = {
                name = "Black Seal",
                text = {
                    "Creates up to {C:attention}#1#",
                    "random {C:spectral}Spectral{} cards",
                    "when destroyed",
                    "{C:inactive}(Must have room)"
                }
            }
        },
        Spectral = {
            c_incantation = {
                text = {
                    "Add {C:dark_edition}Negative{} to",
                    "{C:attention}1{} random card",
                    "in your hand"
                }
            },
            c_familiar = {
                text = {
                    "Creates the last",
                    "{C:spectral}Spectral{} card used",
                    "during this run",
                    "{s:0.8,C:spectral}Familiar{s:0.8} excluded"
                }
            },
            c_grim = {
                text = {
                    "Add a {C:black}Black Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand"
                }
            }
        },
        Tarot = {
            c_fool = {
                text = {
                    "Creates the last",
                    "{C:tarot}Tarot{} card used",
                    "during this run",
                    "{s:0.8,C:tarot}The Fool{s:0.8} excluded"
                }
            },
            c_high_priestess = {
                text = {
                    "Creates the last",
                    "{C:planet}Planet{} card used",
                    "during this run"
                }
            }
        },
        Voucher = {
            v_tarot_tycoon = {
                text = {
                    "{C:attention}+2{} consumable slots"
                }
            },
            v_planet_tycoon = {
                text = {
                    "{C:attention}+2{} {C:planet}Planet{} slots"
                }
            },
            v_observatory = {
                text = {
                    "{C:planet}Planet{} cards in your",
                    "{C:planet}Planet{} area give",
                    "{X:red,C:white} X#1# {} Mult for their",
                    "specified {C:attention}poker hand"
                }
            }
        },
        Edition = {
            e_negative_planet = {
                name = "Negative",
                text = {
                    "{C:dark_edition}+#1#{} {C:planet}Planet{} slot",
                }
            }
        }
    },
    misc = {
        labels = {
            manifold_black_seal = "Black Seal"
        }
    }
}