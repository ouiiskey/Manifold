-- Rebellion, see also rebellion.toml
SMODS.Joker {
    key = "rebellion",
    rarity = 3,
    atlas = "jokers",
    pos = {x = 2, y = 3},
    cost = 2
}

function Blind:get_type()
    if self.config.blind.boss then
        return "Boss"
    elseif self.config.blind.big then
        return "Big"
    elseif self.config.blind.small then
        return "Small"
    end
    return ""
end