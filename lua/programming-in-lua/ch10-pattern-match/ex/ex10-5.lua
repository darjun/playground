function escape (s)
    s = string.gsub(s, "%S", function (c)
        return "\\x" .. string.format("%02X", string.byte(c))
    end)

    return s
end


print(escape("\0\1hello\200"))