local results = {}
setmetatable(results, {__mode = "v"})
function mem_loadstring (s)
    local res = results[s]
    if res == nil then -- 已有结果么？
        res = assert(load(s)) -- 计算新结果
        results[s] = res -- 保存结果以便后续重用
    end
    return res
end

