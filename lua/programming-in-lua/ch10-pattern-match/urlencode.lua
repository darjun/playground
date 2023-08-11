function escape (s)
    s = string.gsub(s, "[&=+%%%c]", function (c)
        return string.format("%%%02X", string.byte(c))
    end)
    s = string.gsub(s, " ", "+")
    return s
end

function encode (t)
    local b = {}
    for k, v in pairs(t) do
        b[#b + 1] = (escape(k) .. "=" .. escape(v))
    end
    -- 将'b'中所有的元素连接在一起，使用"&"分隔
    return table.concat(b, "&")
end

t = {name = "al", query = "a+c = c", q = "yes or no"}
print(encode(t)) --> q=yes+or+no&name=al&query=a%2Bc+%3D+c