local function name2node (graph, name)
    local node = graph[name]
    if not node then
        -- 节点不存在，创建一个新节点
        node = {name = name, adj = {}}
        graph[name] = node
    end
    return node
end

function readgraph ()
    local graph = {}
    for line in io.lines() do
        -- 把一行分割为两个名字
        local namefrom, nameto = string.match(line, "(%S+)%s+(%S+)")
        -- 找到对应的节点
        local from = name2node(graph, namefrom)
        local to = name2node(graph, nameto)
        -- 把'to'增加到链接集合'from'中
        from.adj[to] = true
    end
    return graph
end

function findpath (curr, to, path, visited)
    path = path or {}
    visited = visited or {}
    if visited[curr] then   -- 是否节点已被访问？
        return nil          -- 不存在路径
    end
    visited[curr] = true    -- 标记节点已被访问
    path[#path+1] = curr    -- 增加到路径中
    if curr == to then      -- 是否是最后一个节点？
        return path
    end
    -- 尝试所有的邻接节点
    for node in pairs(curr.adj) do
        local p = findpath(node, to, path, visited)
        if p then return p end
    end
    table.remove(path)      -- 从路径中删除节点
end

function printpath (path)
    for i = 1, #path do
        print(path[i].name)
    end
end

g = readgraph()
a = name2node(g, "a")
b = name2node(g, "b")
p = findpath(a, b)
if p then printpath(p) end
