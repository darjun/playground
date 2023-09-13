local lpeg = require "lpeg"

function gsub (s, patt, repl)
    patt = lpeg.P(patt)
    patt = lpeg.Cs((patt / repl + 1)^0)
    return lpeg.match(patt, s)
end

print(gsub("hello world", "hello", "hi"))
