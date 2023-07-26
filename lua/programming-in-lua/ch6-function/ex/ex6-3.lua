function f (...)
    local t = table.pack(...)
    if t.n <= 1 then
        return
    end

    t[t.n] = nil
    t.n = t.n - 1
    return table.unpack(t)
end

print(f(1, 2, 3))
print(f(1, 2, nil))
print(f(1, nil, 3))
print(f(1, 2))
print(f(1, nil))
print(f(nil, 2))
print(f(1))
print(f(nil))
print(f())
