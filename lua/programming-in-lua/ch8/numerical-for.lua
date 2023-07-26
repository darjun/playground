for i = 1, math.huge do
    if (0.3*i^3 - 20*i^2 - 500 >= 0) then
        print(i)
        break
    end
end

-- 在一个列表中寻找一个值
local found = nil
for i = 1, #a do
    if a[i] < 0 then
        found = i   -- 保存'i'的值
        break
    end
end
print(found)
