local lpeg = require "lpeg"

b = lpeg.P{ "(" * ((1 - lpeg.S"()") + lpeg.V(1))^0 * ")"}