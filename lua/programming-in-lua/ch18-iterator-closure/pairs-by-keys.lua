function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do -- 创建一个包含所有键的表
        a[#a+1] = n
    end
    table.sort(a, f) -- 对列表排序
    local i = 0
    return function () -- 迭代函数
        i = i + 1
        return a[i], t[a[i]] -- 返回键和值
    end
end

lines = {
    ["luaH_set"] = 10,
    ["luaH_get"] = 24,
    ["luaH_presemt"] = 48,
}

for name, line in pairsByKeys(lines) do
    print(name, line)
end