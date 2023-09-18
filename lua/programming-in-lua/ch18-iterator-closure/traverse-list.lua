local function getnext (list, node)
    if not node then
        return list
    end

    return node.next
end

function traverse (list)
    return getnext, nil, list
end
