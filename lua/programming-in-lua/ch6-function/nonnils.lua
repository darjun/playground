function nonnils (...)
    local arg = table.pack(...)
    for i = 1, arg.n do
        if arg[i] == nil then return false end
    end
    return true
end

print(nonnils(2, 3, nil))   --> false
print(nonnils(2, 3))        --> true
print(nonnils())            --> true
print(nonnils(nil))         --> false
