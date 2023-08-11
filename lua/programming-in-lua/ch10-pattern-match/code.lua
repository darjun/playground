function code (s)
    return (string.gsub(s, "\\(.)", function (x)
        return string.format("\\%03d", string.byte(x))
    end))
end

function decode (s)
    return string.gsub(s, "\\(%d%d%d)", function (d)
        return "\\" .. string.char(tonumber(d))
    end)
end

s = [[follows a typical string: "This is \"great\"!".]]
s = code(s)
s = string.gsub(s, '".-"', string.upper)
s = decode(s)
print(s) --> follows a typical string: "THIS IS \"GREAT\"!".

print(decode(string.gsub(code(s), '".-"', string.upper)))
