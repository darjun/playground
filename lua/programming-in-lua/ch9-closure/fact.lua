local fact = function (n)
    if n == 0 then return 1
    else return n * fact(n-1)
    end
end

local fact
fact = function (n)
    if n == 0 then return 1
    else return n * fact(n-1)
    end
end

print(fact(10))

