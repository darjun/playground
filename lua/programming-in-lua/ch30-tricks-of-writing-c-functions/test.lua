local counter = require "counter"

newCounter = counter.newCounter

c1 = newCounter()
print(c1(), c1(), c1()) --> 1 2 3
c2 = newCounter()
print(c2(), c2(), c1()) --> 1 2 4

-- local tuple = require "tuple"
-- local x = tuple.new(10, "hi", {}, 3)
-- print(x(1)) --> 10
-- print(x(2)) --> hi
-- print(x()) --> 