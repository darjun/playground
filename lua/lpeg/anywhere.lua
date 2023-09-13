local lpeg = require "lpeg"

function anywhere (p)
    return lpeg.P{ p + 1 * lpeg.V(1) }
end
