function split (s, sep)
    local result = {}
    for w in string.gmatch(s, "[^" .. sep .. "]+") do
        result[#result+1] = w
    end
    return result
end

t = split("a whole new world", " ")
for k, v in ipairs(t) do
    print(k ,v)
end
