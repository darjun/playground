a = {}
mt = {__mode = "k"}
setmetatable(a, mt) -- 现在'a'的键是弱引用的了
key = {} -- 创建第一个键
a[key] = 1
key = {} -- 创建第二个键
a[key] = 2
collectgarbage() -- 强制进行垃圾回收
for k, v in pairs(a) do print(v) end
    --> 2