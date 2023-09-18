function values (t)
    local i = 0
    return function () i = i + 1; return t[i] end
end

t = {10, 20, 30}
iter = values (t) -- 创建迭代器
while true do
    local element = iter() -- 调用迭代器
    if element == nil then break end
    print(element)
end

for v in values (t) do
    print(v)
end
