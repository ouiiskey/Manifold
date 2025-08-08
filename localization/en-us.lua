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
                    "{C:inactive}#3#"
                }
            },
            j_manifold_black_knight = {
                name = "Black Knight",
                text = {
                    "All played {C:attention}Steel Cards",
                    "gain a {V:1}Black Seal",
                    "when scored"
                }
            },
            j_manifold_bob = {
                name = "Bob",
                text = {
                    "{C:spectral}Spectral{} cards in your",
                    "{C:attention}consumable{} area give",
                    "{X:mult,C:white} X#1# {} Mult and then break"
                }
            },
            j_manifold_alice = {
                name = "Alice",
                text = {
                    "Played {C:attention}Aces{} create a",
                    "{C:spectral,T:c_hex}Hex{} card when scored",
                    "{C:inactive}(Must have room)"
                }
            },
            j_manifold_space_patrol = {
                name = "Space Patrol",
                text = {
                    "{C:attention}+#1#{} {C:planet}Planet{} slots"
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
                    "level {E:1,C:attention}#1#"
                }
            },
            j_manifold_orange_juice = {
                name = "Orange Juice",
                text = {
                    "{X:green,C:white} 100% {} all {C:attention}listed{} {C:green,E:1,S:1.1}probabilities",
                    "until a {C:attention}Lucky{} card is scored",
                    "{C:inactive}(ex: {C:green}1 in 15{C:inactive} -> {C:green}1 in 1{C:inactive})"
                }
            },
            j_manifold_pudding = {
                name = "Pudding",
                text = {
                    "Scored {C:attention}Bonus{} cards",
                    "give {C:mult}+#1#{} Mult",
                    "the next {C:attention}#2#{} times"
                }
            },
            j_manifold_cookie_dough = {
                name = "Cookie Dough",
                text = {
                    "Adds {C:chips}Chips{} to {C:mult}Mult",
                    "Destroy this card",
                    "if {C:attention}flames ignite"
                }
            },
            j_manifold_cookie = {
                name = "Cookie",
                text = {
                    "Adds {C:mult}Mult{} to {C:chips}Chips",
                    "Destroy this card",
                    "if {C:attention}flames ignite"
                }
            },
            j_manifold_baked_potato = {
                name = "Baked Potato",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "Retrigger this card",
                    "until {C:attention}flames ignite",
                    "{C:inactive}({C:attention}#2#{C:inactive} triggers remaining)"
                }
            },
            j_manifold_hot_potato = {
                name = "Hot Potato",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "Die if any {C:attention}#2#{} is",
                    "held in hand, rank",
                    "changes every round"
                }
            },
            j_manifold_digi_carrot = {
                name = "Digi-Carrot",
                text = {
                    "{X:mult,C:white} ^#1# {} Mult"
                }
            },
            j_manifold_extraterrestrial = {
                name = "Extraterrestrial",
                text = {
                    "Retrigger base",
                    "{C:chips}Chips{} and {C:mult}Mult"
                },
                unlock = {
                    "Discover {E:1,C:planet}#1#"
                }
            },
            j_manifold_cthugha = {
                name = "Cthugha",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "Your score",
                    "is hidden"
                },
                unlock = {
                    "Sacrifice {E:1,C:attention}#1#"
                }
            },
            j_manifold_nyarlathotep = {
                name = "Nyarlathotep",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "Flip and shuffle all Jokers",
                    "when {C:attention}Blind{} is selected"
                },
                unlock = {
                    "Sacrifice {E:1,C:attention}#1#"
                }
            },
            j_manifold_hastur = {
                name = "Hastur",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "Your playing cards",
                    "are face-down"
                },
                unlock = {
                    "Sacrifice {E:1,C:attention}#1#"
                }
            },
            j_manifold_squid = {
                name = "Squid Joker",
                text = {
                    "{C:red}+#1#{} discard each hand",
                    "if all played cards",
                    "are number cards"
                }
            },
            j_manifold_monkeys_paw = {
                name = "Monkey's Paw",
                text = {
                    "{C:mult}+#1#{} Mult"
                },
                unlock = {
                    "Lose a run",
                    "with {C:money}$#1#"
                }
            },
            j_manifold_monkeys_paw_one = {
                name = "Monkey's Paw",
                text = {
                    "{C:chips}+#1#{} Chips"
                }
            },
            j_manifold_monkeys_paw_two = {
                name = "Monkey's Paw",
                text = {
                    "{C:mult}#1#{} Mult",
                    "{S:1.1,C:red,E:2}Self destructs{}",
                    "after {C:attention}#2#{} hands"
                }
            },
            j_manifold_esper = {
                name = "Esper",
                text = {
                    "{C:attention}+#1#{} consumable slots"
                }
            },
            j_manifold_mana_gem = {
                name = "Mana Gem",
                text = {
                    "Sell this card to",
                    "escape the current",
                    "{C:attention}Boss Blind"
                },
                unlock = {
                    "Exit an",
                    "incomplete run"
                }
            },
            j_manifold_wallet = {
                name = "Wallet",
                text = {
                    "This card stores",
                    "{C:attention}new{} playing cards",
                    "{C:inactive}(Sell to retrieve)"
                }
            },
            j_manifold_carte_blanche = {
                name = "Carte Blanche",
                text = {
                    "Sell this card to",
                    "draw every card of",
                    "the most common rank",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive})"
                }
            },
            j_manifold_harpoon_gun = {
                name = "Harpoon Gun",
                text = {
                    "Draw the {C:attention}newest",
                    "card in your deck",
                    "when round begins"
                }
            },
            j_manifold_library = {
                name = "Library Card",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "create {C:attention}#1# {C:attention}Rental Jokers",
                    "{C:inactive}(Must have room)"
                }
            },
            j_manifold_tsunami = {
                name = "Tsunami",
                text = {
                    "Every {C:attention}card",
                    "{C:attention}held in hand",
                    "counts in scoring"
                },
                unlock = {
                    "Have {C:attention}#1#{} copies of",
                    "{E:1,C:attention}#2#{} at once"
                }
            },
            j_manifold_zombie = {
                name = "Zombie Joker",
                text = {
                    "Redraw all {C:attention}face cards",
                    "from the {C:red}discard pile",
                    "for {C:attention}final hand{} of round"
                },
                unlock = {
                    "Lose a run",
                    "with {E:1,C:attention}#1#"
                }
            },
            j_manifold_chicken = {
                name = "Chicken",
                text = {
                    "When {C:attention}final hand{} of",
                    "round is played,",
                    "create an {C:attention}#1#",
                    "{C:inactive}(Must have room)"
                }
            },
            j_manifold_rorschach = {
                name = "Rorschach",
                text = {
                    "Sell this card to",
                    "{C:attention}Duplicate{} a random Joker",
                    "{C:inactive,s:0.9}(Adds {C:attention,s:0.9}Perishable{C:inactive,s:0.9} to copy)"
                },
                unlock = {
                    "Win a run without",
                    "ever having more",
                    "than {E:1,C:attention}#1# Jokers"
                }
            },
            j_manifold_memory = {
                name = "Memory Card",
                text = {
                    "This card gains Chips",
                    "equal to the sell value of",
                    "your {C:attention}Jokers{} at end of {C:attention}shop",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_manifold_railgun = {
                name = "Railgun",
                text = {
                    "This card gains {C:mult}+#1#{} Mult",
                    "per {C:attention}consecutive{} card scored",
                    "with {C:attention}opposite{} rank parity",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
                    "{C:inactive}(Score {C:attention}#3#{C:inactive} parity next)"
                }
            },
            j_manifold_rebellion = {
                name = "Rebellion",
                text = {
                    "When {C:attention}Ante{} begins,",
                    "reverse {C:attention}Blind{} order"
                }
            },
            j_manifold_propaganda = {
                name = "Propaganda",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "Debuff your other",
                    "non-{C:blue}Common{} Jokers"
                },
                unlock = {
                    "Win a run with",
                    "only {C:blue}Common{} Jokers"
                }
            },
            j_manifold_ufo = {
                name = "UFO",
                text = {
                    "Create a random",
                    "{C:planet}Planet{} card",
                },
                unlock = {
                    "Discover {E:1,C:planet}#1#"
                }
            },
            j_manifold_left_turns = {
                name = "4 Left Turns",
                text = {
                    "If {C:attention}poker hand{} is",
                    "a {C:attention}#1#{},",
                    "gain {C:blue}+#2#{} Hand"
                }
            },
            j_manifold_lucky_sevens = {
                name = "Lucky 7s",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "Rerolls every hand"
                }
            },
            j_manifold_proud = {
                name = "Proud Joker",
                text = {
                    "{C:green}#1# in #2#{} chance for",
                    "scoring {C:attention}Wild{} cards",
                    "to gain {C:dark_edition}Polychrome"
                }
            },
            j_manifold_envious = {
                name = "Envious Joker",
                text = {
                    "Played cards that",
                    "do not score",
                    "become {C:attention}Wild{} cards"
                }
            },
            j_manifold_slothful = {
                name = "Slothful Joker",
                text = {
                    "Each {C:attention}Wild{} card held",
                    "in hand expends {C:blue}#1#",
                    "Hand to give {X:mult,C:white} X#2# {} Mult"
                }
            },
            j_manifold_weierstrass = {
                name = "Weierstrass",
                text = {
                    "Adds Mult equal to",
                    "the {C:mult}Mult{} you last had",
                    "after this triggered",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                },
                unlock = {
                    "{E:1,s:1.3}?????"
                }
            },
            j_manifold_pareto = {
                name = "Pareto",
                text = {
                    "Balance {C:chips}Chips",
                    "and {C:mult}Mult"
                },
                unlock = {
                    "{E:1,s:1.3}?????"
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
            },
            manifold_perishable = {
                name = "Perishable",
                text = {
                    "Debuffed after",
                    "{C:attention}#1#{} rounds"
                }
            }
        },
        Spectral = {
            c_manifold_mind = {
              name = "The Mind",
              text = {
                  "Creates a",
                  "{C:legendary,E:1}Legendary{} Joker",
                  "{C:inactive}(Must have room)"
              }
            },
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
                    "Add a {V:1}Black Seal",
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
            manifold_baked = "Baked!",
            manifold_black = "Black",
            manifold_boom = "BOOM!",
            manifold_brains = "Brains!",
            manifold_burnt = "Burnt!",
            manifold_cashed = "Cashed!",
            manifold_ceased = "Ceased...",
            manifold_cuneiform_foil = "𒃻𒊏",
            manifold_emptied = "Emptied!",
            manifold_escaped = "Escaped!",
            manifold_hand = "+1 Hand",
            manifold_hand_minus = "-1 Hand",
            manifold_hit = "Hit!",
            manifold_oom = "Out of mana...",
            manifold_opposite_even = "odd",
            manifold_opposite_odd = "even",
            manifold_parity_any = "any",
            manifold_polychrome = "Polychrome!",
            manifold_pop = "Pop!",
            manifold_unknown = "?",
            manifold_unknown_total = "????",
            manifold_wild = "Wild!"
        }
    }
}