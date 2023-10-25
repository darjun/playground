package codegen

import (
	. "github.com/darjun/luago/ch17/binchunk"
	. "github.com/darjun/luago/ch17/compiler/ast"
)

func GenProto(chunk *Block) *Prototype {
	fd := &FuncDefExp{
		IsVararg: true,
		Block:    chunk,
	}

	fi := newFuncInfo(nil, fd)
	fi.addLocVar("_ENV")
	cgFuncDefExp(fi, fd, 0)
	return toProto(fi.subFuncs[0])
}
