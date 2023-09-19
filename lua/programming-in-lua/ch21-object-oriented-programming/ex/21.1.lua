local Stack = {}
Stack.__index = Stack

function Stack:new (o)
    o = o or {}
    setmetatable(o, Stack)
    return o
end

function Stack:push (v)
    self[#self+1] = v
end

function Stack:pop (v)
    self[#self] = nil
end

function Stack:top ()
    return self[#self]
end

function Stack:isempty()
    return #self == 0
end

local s1 = Stack:new()
s1.push(1)
print(s1.top())
print(s1.isempty())
s1.pop()
print(s1.top())
print(s1.isempty())