local lpeg = require "lpeg"

local Cp = lpeg.Cp()
function anywhere (p)
    return lpeg.P{ Cp * p * Cp + 1 * lpeg.V(1) }
end

print(anywhere("world"):match("hello world!")) --> 7 12
