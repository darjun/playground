function poly(coe, x)
    local result = 0
    for n = #coe, 1, -1 do
        result = result * x + coe[n]
    end

    return result
end

print(poly({1, 2, 3, 4}, 2))

