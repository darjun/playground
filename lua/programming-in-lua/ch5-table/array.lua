-- 读取10行，然后保存在一个表中
a = {}
for i = 1, 10 do
    a[i] = io.read()
end

-- 输出行，从1到#a
for i = 1, #a do
    print(a[i])
end
