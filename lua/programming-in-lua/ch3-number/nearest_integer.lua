x = 2 ^ 52 + 1
print(string.format("%d %d", x, math.floor(x + 0.5)))

function round (x)
    local f = math.floor(x)
    if x == f then return f
    else return math.floor(x + 0.5)
    end
end