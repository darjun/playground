function getfield (f)
    local v = _G -- 从全局表开始
    for w in string.gmatch(f, "[%a_][%w_]*") do
        v = v[w]
    end
    return v
end

function setfield (f, v)
    local t = _G -- 从全局表开始
    for w, d in string.gmatch(f, "([%a_][%w_]*)(%.?)") do
        if d == "." then -- 不是最后一个名字？
            t[w] = t[w] or {} -- 如果不存在则创建表
            t = t[w] -- 获取表
        else -- 最后一个名字
            t[w] = v -- 进行赋值
        end
    end
end

setfield("t.x.y", 10)

print(t.x.y) --> 10
print(getfield("t.x.y")) --> 10