function fsize (file)
    local current = file:seek()     -- 保存当前位置
    local size = file:seek("end")   -- 获取文件大小
    file:seek("set", current)       -- 恢复当前位置
    return size
end
