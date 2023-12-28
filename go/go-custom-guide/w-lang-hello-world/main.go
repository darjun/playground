package main

import (
	"bytes"
	"fmt"
	"go/ast"
	"go/constant"
	"go/parser"
	"go/token"
	"go/types"
	"log"
	"os"

	"golang.org/x/tools/go/ssa"
)

const src = `
package main

func main() {
	println("Hello, 凹语言！")
}`

func main() {
	fset := token.NewFileSet()
	f, err := parser.ParseFile(fset, "test.go", src, parser.AllErrors)
	if err != nil {
		log.Fatal(err)
	}

	info := &types.Info{
		Types:      make(map[ast.Expr]types.TypeAndValue),
		Defs:       make(map[*ast.Ident]types.Object),
		Uses:       make(map[*ast.Ident]types.Object),
		Implicits:  make(map[ast.Node]types.Object),
		Selections: make(map[*ast.SelectorExpr]*types.Selection),
		Scopes:     make(map[ast.Node]*types.Scope),
	}

	conf := types.Config{Importer: nil}
	pkg, err := conf.Check("test.go", fset, []*ast.File{f}, info)
	if err != nil {
		log.Fatal(err)
	}

	var ssaProg = ssa.NewProgram(fset, ssa.SanityCheckFunctions)
	var ssaPkg = ssaProg.CreatePackage(pkg, []*ast.File{f}, info, true)

	ssaPkg.Build()
	ssaPkg.Func("main").WriteTo(os.Stdout)

	runFunc(ssaPkg.Func("main"))
}

func runFunc(fn *ssa.Function) {
	fmt.Println("--- runFunc begin ---")
	defer fmt.Println("--- runFunc end ---")

	if len(fn.Blocks) > 0 {
		for blk := fn.Blocks[0]; blk != nil; {
			blk = runFuncBlock(fn, blk)
		}
	}
}

func runFuncBlock(fn *ssa.Function, block *ssa.BasicBlock) (nextBlock *ssa.BasicBlock) {
	for _, ins := range block.Instrs {
		switch ins := ins.(type) {
		case *ssa.Call:
			doCall(ins)
			// case *ssa.Return:
			// 	doReturn(ins)
			// default:
			// 	doUnknown(ins)
		}
	}
	return nil
}

func doCall(ins *ssa.Call) {
	switch {
	case ins.Call.Method == nil:
		switch callFn := ins.Call.Value.(type) {
		case *ssa.Builtin:
			callBuiltin(callFn, ins.Call.Args...)
		default:
		}
	default:
	}
}

func callBuiltin(fn *ssa.Builtin, args ...ssa.Value) {
	switch fn.Name() {
	case "println":
		var buf bytes.Buffer
		for i := 0; i < len(args); i++ {
			if i > 0 {
				buf.WriteRune(' ')
			}
			switch arg := args[i].(type) {
			case *ssa.Const:
				if t, ok := arg.Type().Underlying().(*types.Basic); ok {
					switch t.Kind() {
					case types.String:
						fmt.Fprintf(&buf, "%s", constant.StringVal(arg.Value))
					default:
						// 其他类型常量
					}
				}
			default:
				// 暂不支持非常量参数
			}
		}
		buf.WriteRune('\n')
		os.Stdout.Write(buf.Bytes())

	default:
	}
}
