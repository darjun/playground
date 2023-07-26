function maximum (a)
    local mi = 1            -- 最大值的索引
    local m = a[mi]         -- 最大值
    for i = 1, #a do
        if a[i] > m then
            mi = i; m = a[i]
        end
    end
    return m, mi            -- 返回最大值及其索引
end

print(maximum({8, 10, 23, 12, 5}))  --> 23 3
