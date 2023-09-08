function serialize (o)
    local t = type(o)
    if t == "number" or t == "string" or t == "boolean" or
       t == "nil" then
        io.write(string.format("%q", o))
    elseif t == "table" then
        io.write("{\n")
        for k, v in pairs(o) do
            io.write("  ", k, " = ")
            serialize(v)
            io.write(",\n")
        end
        io.write("}\n")
    else
        error("cannot serialize a " .. type(o))
    end
end

serialize{a=12, b='Lua', key='another "one"'}

function basicSerialize (o)
    -- 假设'o'是一个数字或字符串
    return string.format("%q", o)
end

function save (name, value, saved)
    saved = saved or {} -- 初始值
    io.write(name, " = ")
    if type(value) == "number" or type(value) == "string" then
        io.write(basicSerialize(value), "\n")
    elseif type(value) == "table" then
        if saved[value] then -- 值是否已被保存
            io.write(saved[value], "\n") -- 使用之前的名称
        else
            saved[value] = name -- 保存名称供后续使用
            io.write("{}\n") -- 创建新表
            for k,v in pairs(value) do -- 保存表的字段
                k = basicSerialize(k)
                local fname = string.format("%s[%s]", name, k)
                save(fname, v, saved)
            end
        end
    else
        error("cannot save a " .. type(value))
    end
end

a = {x=1, y=2; {3,4,5}}
a[2] = a -- 循环
a.z = a[1] -- 共享子集
save("a", a)

a = {{"one", "two"}, 3}
b = {k = a[1]}
local t = {}
save("a", a)
save("b", b)