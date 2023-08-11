function transliterate (s, t)
    return string.gsub(s, "%a", function (c)
        if t[c] ~= nil then
            return t[c] == false and "" or t[c]
        end

        return c
    end)
end

print(transliterate("hello world", {h="t", d="w", l=false}))
