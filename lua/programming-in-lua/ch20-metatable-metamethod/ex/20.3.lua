local mt = {
    __index = function (t, k)
        return t.__data[k]
    end,

    __newindex = function (t, k, v)
        error("attempt to update a read-only table", 2)
    end
}

function readOnly (t)
    local proxy = {
        __data = t,
    }
    return setmetatable(proxy, mt)
end

t = readOnly({10, 20})
print(t[1])
t[2] = 30