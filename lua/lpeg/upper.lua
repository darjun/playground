local lpeg = require "lpeg"

local name = lpeg.C(lpeg.R("az")^1)
local p = name * (lpeg.P("^") % string.upper)^-1
print(p:match("count")) --> count
print(p:match("count^")) --> COUNT