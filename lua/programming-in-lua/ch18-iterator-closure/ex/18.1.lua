local function getnext (m, n)
    if n >= m then
        return nil
    end

    n = n + 1
    return n
end

function fromto (n, m)
    return getnext, m, n-1
end

for i in fromto(2, 10) do
    print(i)
end
