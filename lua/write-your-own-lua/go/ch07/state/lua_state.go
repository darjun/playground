package state

import (
	"github.com/darjun/luago/ch07/binchunk"
)

type luaState struct {
	stack *luaStack
	proto *binchunk.Prototype
	pc int
}

func New(maxStackSize int, proto *binchunk.Prototype) *luaState {
	return &luaState {
		stack: newLuaStack(maxStackSize),
		proto: proto,
		pc: 0,
	}
}