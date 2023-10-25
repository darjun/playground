package compiler

import (
	"github.com/darjun/luago/ch17/binchunk"
	"github.com/darjun/luago/ch17/compiler/codegen"
	"github.com/darjun/luago/ch17/compiler/parser"
)

func Compile(chunk, chunkName string) *binchunk.Prototype {
	ast := parser.Parse(chunk, chunkName)
	return codegen.GenProto(ast)
}
