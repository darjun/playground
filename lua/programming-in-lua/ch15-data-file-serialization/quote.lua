function quote (s)
    -- 寻找最长等号序列的长度
    local n = -1
    for w in string.gmatch(s, "]=*") do
        n = math.max(n , #w - 1) -- -1 用于移除']'
    end

    -- 生成一个具有'n'+1个等号的字符串
    local eq = string.rep("=", n+1)

    -- 创建被引起来的字符串
    return string.format(" [%s[\n%s]%s]", eq, s, eq)
end
