function allwords ()
    local line = io.read()          -- 当前行
    local pos = 1                   -- 当前行的当前位置
    return function ()              -- 迭代函数
        while line do               -- 当还有行时循环
            local w, e = string.match(line, "(%w+[,;.:]?)()", pos)
            if w then               -- 发现一个单词？
                pos = e
                return w            -- 返回该单词
            else
                line = io.read()    -- 没找到单词；尝试下一行
                pos = 1             -- 从第一个位置重新开始
            end
        end
        return nil                  -- 没有行了：迭代结束
    end
end

function prefix (words)
    return table.concat(words, " ")
end

local statetab = {}

function insert (prefix, value)
    local list = statetab[prefix]
    if list == nil then
        statetab[prefix] = {value}
    else
        list[#list+1] = value
    end
end

local MAXGEN = 200
local NOWORD = "\n"

function markovchain (prefxlen)
    -- 创建表
    local words = {}
    for i = 1, prefxlen do
        words[i] = NOWORD
    end
    for nextword in allwords() do
        insert(prefix(words), nextword)
        table.remove(words, 1)
        table.insert(words, nextword)
    end
    insert(prefix(words), NOWORD)

    -- 生成文本
    -- 重新初始化
    for i = 1, prefxlen do
        words[i] = NOWORD
    end
    for i = 1, MAXGEN do
        local list = statetab[prefix(words)]
        -- 从列表中随机选出一个元素
        local r = math.random(#list)
        local nextword = list[r]
        if nextword == NOWORD then return end
        io.write(nextword, " ")
        table.remove(words, 1)
        table.insert(words, nextword)
    end
end