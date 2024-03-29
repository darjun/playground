-- 创建具有默认值的原型
prototype = {x = 0, y = 0, width = 100, height = 100}

local mt = {} -- 创建一个元表
-- 声明构造函数
function new (o)
    setmetatable(o, mt)
    return o
end

mt.__index = function (_, key)
    return prototype[key]
end

w = new{x=10, y=20}
print(w.width) --> 100