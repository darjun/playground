function fromto (n, m, step)
    local i = n - step
    return function ()
        i = i + step
        if i > m then
            return nil
        end

        return i
    end
end

for i in fromto(2, 10, 2) do
    print(i)
end
