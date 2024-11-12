local lpeg = require "lpeg"

local field = '"' * lpeg.Cs(((lpeg.P(1) - '"') + lpeg.P'""' / '"')^0)*'"' +
                    lpeg.C((1 - lpeg.S',\n"')^0)

local record = lpeg.Ct(field * (',' * field)^0 * (lpeg.P'\n' + -1))

function csv (s)
    return lpeg.match(record, s)
end

print(csv("hello,world,lpeg"))