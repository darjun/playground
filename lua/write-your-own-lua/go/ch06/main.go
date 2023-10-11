package main

import (
	"io/ioutil"
	"fmt"
	"os"

	. "github.com/darjun/luago/ch06/api"
	. "github.com/darjun/luago/ch06/vm"
	"github.com/darjun/luago/ch06/state"
	"github.com/darjun/luago/ch06/binchunk"
)

func main() {
	if len(os.Args) > 1{
		data, err := ioutil.ReadFile(os.Args[1])
		if err != nil {
			panic(err)
		}
		proto := binchunk.Undump(data)
		luaMain(proto)
	}
}

func luaMain(proto *binchunk.Prototype) {
	nRegs := int(proto.MaxStackSize)
	ls := state.New(nRegs+8, proto)
	ls.SetTop(nRegs)
	for {
		pc := ls.PC()
		inst := Instruction(ls.Fetch())
		if inst.Opcode() != OP_RETURN {
			fmt.Printf("[%02d] %s", pc+1, inst.OpName())
			inst.Execute(ls)
			printStack(ls)
		} else {
			break
		}
	}
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