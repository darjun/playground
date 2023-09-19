local balance = {}

Account = {}

function Account:withdraw (v)
    balance[self] = balance[self] - v
end

function Account:deposit (v)
    balance[self] = balance[self] + v
end

function Account:balance ()
    return balance[self]
end

function Account:new (o)
    o = o or {} -- 如果用户没有提供则创建表
    setmetatable(o, self)
    self.__index = self
    balance[o] = 0 -- 初始余额
    return o
end

a = Account:new{}
a:deposit(100.00)
print(a:balance())