function printResult (a)
    print(table.concat(a, ","))
end

function permgen (a, n)
    n = n or #a -- 'n'的默认大小是'a'
    if n <= 1 then -- 只有一种组合
        coroutine.yield(a)
    else
        for i = 1, n do
            -- 把第i个元素当作最后一个
            a[n], a[i] = a[i], a[n]

            -- 生辰其余元素的所有排列
            permgen(a, n-1)

            -- 恢复第i个元素
            a[n], a[i] = a[i], a[n]
        end
    end
end

function permutations (a)
    local co = coroutine.create(function () permgen(a) end)
    return function () -- 迭代函数
        local code, res = coroutine.resume(co)
        return res
    end
end

for p in permutations{"a", "b", "c", "d"} do
    printResult(p)
end