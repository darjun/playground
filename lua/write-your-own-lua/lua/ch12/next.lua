function next(table, key)
    if key == nil then
        nextKey = table.firstKey()
    else
        nextKey = table.nextKey(key)
    end
    if nextKey ~= nil then
        return nextKey, table[nextKey]
    else
        return nil
    end
end