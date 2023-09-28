local mylib = require "mylib"

for _, name in ipairs(mylib.dir(".")) do
    print(name)
end

local ex = require "ex"

local summation = ex.summation
print(summation())
print(summation(2.3, 5.4))
print(summation(2.3, 5.4, -34))
-- print(summation(2.3, 5.4, {}))

local tablepack = ex.tablepack

local p = tablepack(1, 2, 5, 7)
for i, v in ipairs(p) do
    print(i, v)
end
print(p.n)

local reverse = ex.reverse

print(reverse(1, "hello", 20))

local foreach = ex.foreach

foreach({x = 10, y = 20}, print)