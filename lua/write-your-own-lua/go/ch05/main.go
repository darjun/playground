package main

import (
	"fmt"
	. "github.com/darjun/luago/ch05/api"
	"github.com/darjun/luago/ch05/state"
)

func main() {
	ls := state.New()
	ls.PushInteger(1)
	ls.PushString("2.0")
	ls.PushString("3.0")
	ls.PushNumber(4.0)
	printStack(ls)

	ls.Arith(LUA_OPADD)
	printStack(ls)

	ls.Arith(LUA_OPBNOT)
	printStack(ls)

	ls.Len(2)
	printStack(ls)

	ls.Concat(3)
	printStack(ls)

	ls.PushBoolean(ls.Compare(1, 2, LUA_OPEQ))
	printStack(ls)
}

func printStack(ls LuaState) {
	top := ls.GetTop()
	for i := 1; i <= top; i++ {
		t := ls.Type(i)
		switch t {
		case LUA_TBOOLEAN: fmt.Printf("[%t]", ls.ToBoolean(i))
		case LUA_TNUMBER: fmt.Printf("[%g]", ls.ToNumber(i))
		case LUA_TSTRING: fmt.Printf("[%s]", ls.ToString(i))
		default: fmt.Printf("[%s]", ls.TypeName(t))
		}
	}
	fmt.Println()
}