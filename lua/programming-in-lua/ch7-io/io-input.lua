local temp = io.input() -- 保存当前输入流
io.input("newinput")    -- 打开一个新的当前输入流
io.input():close()      -- 关闭当前输入流
io.input(temp)          -- 恢复此前的当前输入流