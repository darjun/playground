local function poly (an, x)
    local result = 0
    for i = #an, 1, -1 do
        result = result * x + an[i]
    end
    return result
end

local function newpoly(an)
    return function (x)
        return poly(an, x)
    end
end

f = newpoly({3, 0, 1})
print(f(0))     -- 3
print(f(5))     -- 28
print(f(10))    -- 103