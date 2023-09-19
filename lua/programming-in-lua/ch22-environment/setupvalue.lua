f = load("b = 10; return a")
env = {a = 20}
debug.setupvalue(f, 1, env)
print(f())   --> 20
print(env.b) --> 10