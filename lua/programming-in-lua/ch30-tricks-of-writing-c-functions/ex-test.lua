local ex = require "ex"

local filter = ex.filter

t = filter({1, 3, 20, -4, 5}, function (x) return x < 5 end)
for i, v in ipairs(t) do
	print(i, v)
end