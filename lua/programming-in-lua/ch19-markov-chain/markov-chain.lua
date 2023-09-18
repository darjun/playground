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

function prefix (w1, w2)
    return w1 .. " " .. w2
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

-- 创建表
local w1, w2 = NOWORD, NOWORD
for nextword in allwords() do
    insert(prefix(w1, w2), nextword)
    w1 = w2; w2 = nextword;
end
insert(prefix(w1, w2), NOWORD)

-- 生成文本
w1 = NOWORD; w2 = NOWORD    -- 重新初始化
for i = 1, MAXGEN do
    local list = statetab[prefix(w1, w2)]
    -- 从列表中随机选出一个元素
    local r = math.random(#list)
    local nextword = list[r]
    if nextword == NOWORD then return end
    io.write(nextword, " ")
    w1 = w2; w2 = nextword
end