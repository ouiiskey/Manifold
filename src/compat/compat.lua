-- Talisman
to_big = to_big or function(x) return x end

-- JokerDisplay
if JokerDisplay then
    assert(SMODS.load_file("src/compat/jokerdisplay.lua"), MANIF.install .. "src/compat/jokerdisplay.lua")()
end