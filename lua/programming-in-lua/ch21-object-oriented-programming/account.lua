Account = {
    balance = 0,
}

function Account:new (o)
    o = o or {}
    self.__index = self
    setmetatable(o, self)
    return o
end

function Account:deposit (v)
    self.balance = self.balance + v
end

function Account:withdraw (v)
    if v > self.balance then error "insufficient funds" end
    self.balance = self.balance - v
end

b = Account:new()
print(b.balance)

SpecialAccount = Account:new()

function SpecialAccount:withdraw (v)
    if v - self.balance >= self:getLimit() then
        error "insufficient funds"
    end
    self.balance = self.balance - v
end

function SpecialAccount:getLimit ()
    return self.limit or 0
end

s = SpecialAccount:new{limit = 1000.00}