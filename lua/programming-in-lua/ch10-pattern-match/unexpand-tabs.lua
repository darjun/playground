function unexpandTabs (s, tab)
    tab = tab or 8
    s = expandTabs(s, tab)
    local pat = string.rep(".", tab) -- 辅助模式
    s = string.gsub(s, pat, "%0\1")  -- 在每8个字符后添加一个标记\1
    s = string.gsub(s, " +\1", "\t") -- 将所有以此标记结尾的空格序列
                                     -- 都替换为制表符'\t'
    s = string.gsub(s, "\1", "")     -- 将剩下的标记\1删除
    return s
end
