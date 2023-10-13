package state

import (
	"github.com/darjun/luago/ch08/binchunk"
)

type closure struct {
	proto *binchunk.Prototype
}

func newLuaClosure(proto *binchunk.Prototype) *closure {
	return &closure{proto: proto}
}