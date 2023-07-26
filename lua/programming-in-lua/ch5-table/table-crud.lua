w = {x = 0, y = 0, label = "console"}
x = {math.sin(0), math.sin(1), math.sin(2)}
w[1] = "another field"          -- 把键1增加到表'w'中
x.f = w                         -- 把键"f"增加到表'x'中
print(w["x"])                   --> 0
print(w[1])                     --> another field
print(x.f[1])                   --> another field
w.x = nil                       --> 删除字段"x"