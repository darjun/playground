local function iter (t, i)
    i = i + 1
    local v = t[i]
    if v then
        return i, v
    end
end

function ipairs (t)
    return iter, t, 0
end