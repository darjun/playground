local lpeg = require "lpeg"

equals = lpeg.P"="^0
open = "[" * lpeg.Cg(equals, "init") * "[" * lpeg.P"\n"^-1
close = "]" * lpeg.C(equals) * "]"
closeeq = lpeg.Cmt(close * lpeg.Cb("init"), function (s, i, a, b) return a == b end)
string = open * lpeg.C((lpeg.P(1) - closeeq)^0) * close / 1