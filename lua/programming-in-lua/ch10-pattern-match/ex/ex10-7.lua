function reverse (s)
    local cs = {}
    string.gsub(s, utf8.charpattern, function (c)
        cs[#cs+1] = c
    end)

    i = 1
    j = #cs
    while i < j do
        cs[i], cs[j] = cs[j], cs[i]
        i = i + 1
        j = j - 1
    end

    return table.concat(cs)
end

print(reverse("Hello 中国"))
