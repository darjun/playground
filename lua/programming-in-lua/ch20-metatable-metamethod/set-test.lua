local Set = require "set"

local s1 = Set.new{10, 20, 30, 50}
local s2 = Set.new{30, 1}
local s3 = s1 + s2
print(Set.tostring(s3)) --> {1, 10, 20, 30, 50}
print(Set.tostring((s1 + s2)*s1)) --> {10, 20, 30, 50}

s1 = Set.new{2, 4}
s2 = Set.new{4, 10, 2}
print(s1 <= s2)      --> true
print(s1 < s2)       --> true
print(s1 >= s1)      --> true
print(s1 > s1)       --> false
print(s2 == s2 * s1) --> false

print(s1)

s1 = Set.new{}
print(getmetatable(s1))
setmetatable(s1, {})