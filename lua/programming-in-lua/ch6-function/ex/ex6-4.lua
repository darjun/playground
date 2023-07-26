function f (a)
    for i = 1, #a do
        local j = math.random(1, #a)
        a[i], a[j] = a[j], a[i]
    end
end

function print_array (a)
    for i, v in ipairs(a) do
        print(i, v)
    end
end

math.randomseed(os.time())
t = {1, 2, 3}
f(t)
print_array(t)
