t = {}; mt = {}
setmetatable(t, mt)
print(getmetatable(t) == mt) --> true
debug.setmetatable(100 ,mt)
print(getmetatable(200) == mt) --> true