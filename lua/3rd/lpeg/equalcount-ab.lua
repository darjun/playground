local lpeg = require "lpeg"

local equalcount = lpeg.P {
    "S"; -- initial rule name
    S = "a" * lpeg.V"B" + "b" * lpeg.V"A" + "",
    A = "a" * lpeg.V"S" + "b" * lpeg.V"A" * lpeg.V"A",
    B = "b" * lpeg.V"S" + "a" * lpeg.V"B" * lpeg.V"B",
} * -1

print(equalcount:match("aabbcc"))
print(equalcount:match("abab"))