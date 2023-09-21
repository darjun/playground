o = {x = "hi"}
mt = {}
setmetatable(o, mt)
mt.__gc = function (o) return print(o.x) end
o = nil
collectgarbage() --> (prints nothing)