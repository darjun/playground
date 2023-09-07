function mult (a, b)
    local c = {} -- 结果矩阵
    for i = 1, #a do
        local resultline = {}           -- 即'c[i]'
        for k, va in pairs(a[i]) do     -- 'va'即a[i][k]
            for j, vb in pairs(b[k]) do -- 'vb'即b[k][j]
                local res = (resultline[j] or 0) + va * vb
                resultline[j] = (res ~= 0) and res or nil
            end
        end
        c[i] = resultline
    end
    return c
end
