function track (t)
    local proxy = {} -- 't'的代理表

    -- 为代理创建元表
    local mt = {
        __index = function (_, k)
            print("*access to element " .. tostring(k))
            return t[k] -- 访问原来的表
        end,

        __newindex = function (_, k, v)
            print("*update of element " .. tostring(k) .. " to " .. tostring(v))
            t[k] = v -- 更新原来的表
        end,

        __pairs = function ()
            return function (_, k) -- 迭代函数
                local nextkey, nextvalue = next(t, k)
                if nextkey ~= nil then -- 避免最后一个值
                    print("*traversing element " .. tostring(nextkey))
                end
                return nextkey, nextvalue
            end
        end,

        __len = function () return #t end
    }

    setmetatable(proxy, mt)

    return proxy
end

t = {}
t = track(t)
t[2] = "hello"
print(t[2])