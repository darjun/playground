local lpeg = require "lpeg"

function split (s, sep)
    sep = lpeg.P(sep)
    local elem = lpeg.C((1 - sep)^0)
    local p = lpeg.Ct(elem * (sep * elem)^0) -- make a table capture
    return lpeg.match(p, s)
end

for k, v in pairs(split("hello;world;lpeg", ";")) do
    print(k, v)
end
