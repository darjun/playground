local lpeg = require "lpeg"

local t = lpeg.locale()

function atwordboundry (p)
    return lpeg.P{
        [1] = p + t.alpha^0 * (1 - t.alpha)^1 * lpeg.V(1)
    }
end
