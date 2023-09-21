do
    local mt = {__gc = function (o)
        -- 要做的工作
        print("new cycle")
        -- 为下一次垃圾收集创建新对象
        setmetatable({}, getmetatable(o))
    end}
    -- 创建第一个对象
    setmetatable({}, mt)
end

collectgarbage() --> 一次垃圾收集
collectgarbage() --> 一次垃圾收集
collectgarbage() --> 一次垃圾收集