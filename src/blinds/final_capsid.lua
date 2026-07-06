-- Sallow Capsid
SMODS.Blind {
    key = "final_capsid",
    atlas = "blinds",
    pos = {y = 1},
    dollars = 8,
    boss = {showdown = true},
    boss_colour = HEX("fbd6a7"),
    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        local total = 0
        local count = 0
        for k, v in pairs(G.GAME.hands) do
            if v.visible then
                total = total + v.level
                count = count + 1
            end
        end
        local avg = math.floor(total / count)
        if G.GAME.hands[text].level > avg then
            update_hand_text({sound = "button", volume = 0.7, pitch = 0.9, delay = 0}, {level = avg})
            return G.GAME.hands[text].s_mult + G.GAME.hands[text].l_mult * (avg - 1), G.GAME.hands[text].s_chips + G.GAME.hands[text].l_chips * (avg - 1), true
        end
        return mult, hand_chips, false
    end
}