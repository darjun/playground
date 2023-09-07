M = 10
N = 10

local mt = {} -- 创建矩阵
for i = 1, N do
    local row = {} -- 创建新的一行
    mt[i] = row
    for j = 1, M do
        row[j] = 0
    end
end
