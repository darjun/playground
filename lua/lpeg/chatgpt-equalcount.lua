local lpeg = require("lpeg")

local G = lpeg.P{
    "S",
    S = lpeg.V("A") * lpeg.V("B"),
    A = lpeg.P("a") * lpeg.V("S") + lpeg.P(""),
    B = lpeg.P("b") * lpeg.V("S") + lpeg.P(""),
}

local input = "aabb"
local result = lpeg.match(G, input)

if result then
    print("The input matches the grammar.")
else
    print("The input does not match the grammar.")
end
