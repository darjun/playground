local a = {} -- 新数组
for i = 1, 1000 do
    a[i] = 0
end

print(#a)

-- 创建一个索引范围为-5~5的数组
a = {}
for i = -5, 5 do
    a[i] = 0
end
