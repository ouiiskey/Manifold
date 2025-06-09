return {
    descriptions = {
        Joker = {
            j_manifold_prosopagnosia = {
                name = "Prosopagnosia",
                text = {
                    "{C:attention}Face{} cards count",
                    "as the same rank"
                }
            },
            j_manifold_archwizard = {
                name = "Archwizard",
                text = {
                    "{C:mult}+#1#{} Mult every",
                    "{C:attention}#2#{} hands played",
                    "{C:inactive}#3#",
                }
            },
            j_manifold_black_knight = {
                name = "Black Knight",
                text = {
                    "All played {C:attention}Steel Cards",
                    "gain a {C:black}Black Seal",
                    "when scored"
                }
            },
            j_manifold_bob = {
                name = "Bob",
                text = {
                    "{C:spectral}Spectral{} cards in your",
                    "{C:attention}consumable{} area give",
                    "{X:red,C:white} X#1# {} Mult and then break"
                }
            },
            j_manifold_alice = {
                name = "Alice",
                text = {
                    "Played {C:attention}Aces{} create",
                    "a {C:spectral,T:c_hex}Hex{} card when scored",
                    "{C:inactive}(Must have room)"
                }
            },
            j_manifold_space_patrol = {
                name = "Space Patrol",
                text = {
                    "{C:attention}+#1#{} {C:planet}Planet{} slots",
                },
            },
            j_manifold_clay_tablet = {
                name = "Clay Tablet",
                text = {
                    "{C:attention}Stone{} cards gain",
                    "{C:dark_edition}Foil{} when played",
                    "to the right of a {C:attention}6"
                },
                unlock = {
                    "Reach Ante",
                    "level {E:1,C:attention}#1#",
                }
            },
            j_manifold_orange_juice = {
                name = "Orange Juice",
                text = {
                    "100% all {C:attention}listed{} {C:green,E:1,S:1.1}probabilities",
                    "until a {C:attention}Lucky{} card is scored",
                    "{C:inactive}(ex: {C:green}1 in 15{C:inactive} -> {C:green}1 in 1{C:inactive})"
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
                    "Add a random",
                    "{C:dark_edition}Negative{} playing card",
                    "to your deck,",
                    "{C:red}-2{} hand size"
                }
            },
            c_familiar = {
                text = {
                    "Fill your consumable",
                    "area with copies of",
                    "a random card in it",
                    "{s:0.8,C:spectral}Familiar{s:0.8} excluded"
                }
            },
            c_grim = {
                text = {
                    "Add a {C:black}Black Seal",
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
        },
        dictionary = {
            manifold_ace = "A",
            manifold_black = "Black",
            manifold_boom = "BOOM!",
            manifold_cuneiform_foil = "𒃻𒊏"
        }
    }
}