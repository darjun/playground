function expandTabs (s, tab)
    tab = tab or 8 -- 制表符的“大小”（默认是8）
    local corr = 0 -- 修正量
    s = string.gsub(s, "()\t", function (p)
        local sp = tab - (p - 1 + corr)%tab
        corr = corr - 1 + sp
        return string.rep(" ", sp)
    end)
end