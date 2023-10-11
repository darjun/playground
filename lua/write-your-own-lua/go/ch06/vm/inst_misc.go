package vm

import (
	. "github.com/darjun/luago/ch06/api"
)

func move(i Instruction, vm LuaVM) {
	a, b, _ := i.ABC()
	a += 1
	b += 1
	vm.Copy(b, a)
}

func jmp(i Instruction, vm LuaVM) {
	a, sbx := i.AsBx()
	vm.AddPC(sbx)
	if a != 0 {
		panic("todo!")
	}
}