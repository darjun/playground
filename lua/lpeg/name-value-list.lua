local lpeg = require "lpeg"

lpeg.locale(lpeg) -- adds locale entries into 'lpeg' table

local space = lpeg.space^0
local name = lpeg.C(lpeg.alpha^1) * space
local sep = lpeg.S(",;") * space
local pair = name * "=" * space * name * sep^-1
local list = lpeg.Ct("") * (pair % rawset)^0
t = list:match("a=b, c = hi; next = pi")
for k, v in pairs(t) do
    print(k, v)
end