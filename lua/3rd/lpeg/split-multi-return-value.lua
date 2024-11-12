local lpeg = require "lpeg"

function split (s, sep)
    sep = lpeg.P(sep)
    local elem = lpeg.C((1 - sep)^0)
    local p = elem * (sep * elem)^0
    return lpeg.match(p, s)
end

print(split("hello;world;lpeg", ";"))
-- hello world lpeg
