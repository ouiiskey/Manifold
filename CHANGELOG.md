With Manifold-1.2.3 the new Deity rank is finally finished. This release also updates the required smods version to 26.1002.0 and lovely version to 0.10.0. Hopefully this version will also be the first to be available on Thunderstore. If I figure that out, I'll add it to the install methods on the README.

## New
<details>
    <summary><b>New Rank</b></summary>

* Deity (Legendary Rank)
    * Counts as all ranks and cannot be debuffed.
    * +95 chips (equal to sum of all other ranks).
    * 6 animated textures (1 for each suit) based on various deities.
    * Only obtainable via Ascend.
* Ascend (Legendary Spectral)
    * 0.3% chance to replace a card in Spectral packs and Standard packs.
    * Is saved to consumable area if selected from Standard pack.
    * Converts 1 selected card to Deity.
</details>
<details>
    <summary><b>Secret Joker</b> (Spoilers)</summary>

* Blank (Joker)
    * Does nothing?
    * Secretly increases negative chance by a flat 10%.
    * Only obtained after copying with Rorschach 25 times, after which Rorschach will no longer be able to copy and will give Blank instead.
        * Therefore Blank is always perishable.
    * Blueprint incompatible.
    * Does not show up in collection and not needed for C++.
</details>

## Changes
<details>
    <summary><b>Balance Changes</b></summary>

* Challenge changes:
    * Tsunami made negative in Pacific Rim.
    * Negative Rorschach added to Apocalypse.
* Buffs:
    * Trick Deck's planet area size penalty removed.
    * Ring Deck gives +1 hand when straight is played.
    * Burning Deck triggers on even ante (was odd).
    * Extraterrestrial price lowered from $6 to $3.
* Nerfs:
    * Extraterrestrial gives lvl.1 base Chips and Mult (was current lvl).
</details>
<details>
    <summary><b>Other</b></summary>

* Poker hand detection reworked to work with Deity rank.
    * Straight detection is especially changed:
        * Compatible with modded hand selection sizes, but not compatible with ranks from other mods.
        * With Prosopagnosia, going from Ace to 10 requires 3 face cards rather than the 1 it used to.
* Joker changes for Deity compatibility:
    * Raised Fist:
        * Counts Deity as a 2 for selection purposes (but gives 190 mult when selected).
        * Counts face cards with Prosopagnosia as a Jack.
        * This means a Deity to the right of a 2, and likewise a King to the right of a Jack with Prosopagnosia, will get the Raised Fist trigger.
    * Jokers that choose a rank/suit from deck will not be griefed by Deity or Wild.
        * Affects Hot Potato, Idol, Castle, Mail-in Rebate.
        * For example, Idol will always choose 7 of Hearts if the deck is Wild 7s + one Heart 7, and it will always choose 7 of Spades if the deck is all Wild 7s.
* Added new blueprint compatibilities:
    * Mana Gem: Selling blueprint activates the Mana Gem ability as normal.
    * Rorschach: Selling blueprint activates the Rorschach ability as normal.
        * New feature added to prevent infinite looping (see **Secret Joker** under **New** for details).
    * Wallet: Selling blueprint retrieves stored cards (remaining Wallet can continue to store more).
* Wild card changes:
    * Wild shader and gradient changed to better match with Deity rank.
        * Period extended from 4 to 13/3 seconds.
        * Interpolation changed from linear to sin.
    * None of Wilds text changed to "No rank but all suits".
    * Wild sinful joker (Proud, Envious, Slothful) textures changed to match Wild suit.
* Allow card generated during joker_main to be available during other_consumeable for scoring.
    * Affects Alice, UFO, 8 Ball, Superposition, Seance, Vagabond.
    * Does not affect Sixth Sense, since it generates during destroy_card rather than joker_main.
    * Seance timing reverted back to joker_main rather than before.
* Reverse Emperor changed to create a meteor tag (was destroy a tarot to gain $10).
* Revert UFO description to omit "each hand".
* Various changes to the README.
* Various code style and organization changes.
</details>

## Bugfixes
<details>
    <summary><b>Manifold</b></summary>

* Remove extra bugged negative editions from collection.
* Prevent Bob from triggering on planets.
* Allow wild cards to show up in Standard packs.
* Correct blueprint incompatible cards falsely appearing to be blueprint compatible.
    * Affects Black Knight, Bob, Carte Blanche, Clay Tablet, Escher, Esper, Orange Juice, Peano, Prosopagnosia, Rebellion, Shannon, Space Patrol, Tsunami, Zombie, Matador.
* Fix Library Card failing to put Rental on created jokers.
* Allow suit-related reverse tarots to detect debuffed cards.
    * Affects Reverse Lovers, Reverse Moon, Reverse Star, Reverse Sun, Reverse World.
* Disallow sinful jokers and enhancement-based jokers from triggering on debuffed cards.
    * Affects Envious Joker, Proud Joker, Slothful Joker, Black Knight, Clay Tablet, Orange Juice, Pudding.
* Add The Mind to Jokerless banlist.
</details>
<details>
    <summary><b>smods</b></summary>

* Fix hand misordering when sorting high nominal cards.
</details>