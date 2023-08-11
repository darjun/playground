local function integral (f, delta)
    local function eval (x1, x2)
        if x1 > x2 then
            return -eval(x2, x1)
        end

        local cnt = math.floor((x2 - x1)/delta)
        local ret = 0
        for i = 1, cnt do
            ret = ret + f(x1 + (i-1)*delta) * delta
        end
        return ret
    end

    return eval
end

local function square (x)
    return x * x
end

local integralofsquare = integral(square, 0.0001)
print(integralofsquare(1, 3)) -- 8.66626667
print(1/3*(3^3-1^3)) -- 8.6666666666667
