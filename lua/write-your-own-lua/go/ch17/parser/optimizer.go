package parser

import (
	. "github.com/darjun/luago/ch17/compiler/ast"
	. "github.com/darjun/luago/ch17/compiler/lexer"
	"github.com/darjun/luago/ch17/number"
)

func optimizeUnaryOp(exp *UnopExp) Exp {
	switch exp.Op {
	case TOKEN_OP_UNM:
		return optimizeUnm(exp)
	case TOKEN_OP_NOT:
		return optimizeNot(exp)
	case TOKEN_OP_BNOT:
		return optimizeBnot(exp)
	default:
		return exp
	}
}

func optimizeUnm(exp *UnopExp) Exp {
	switch x := exp.Exp.(type) {
	case *IntegerExp:
		x.Val = -x.Val
		return x
	case *FloatExp:
		x.Val = -x.Val
		return x
	default:
		return exp
	}
}

func optimizeNot(exp *UnopExp) Exp {
	switch exp.Exp.(type) {
	case *NilExp, *FalseExp: // false
		return &TrueExp{exp.Line}
	case *TrueExp, *IntegerExp, *FloatExp, *StringExp: // true
		return &FalseExp{exp.Line}
	default:
		return exp
	}
}

func optimizeBnot(exp *UnopExp) Exp {
	switch x := exp.Exp.(type) {
	case *IntegerExp:
		x.Val = ^x.Val
		return x
	case *FloatExp:
		if i, ok := number.FloatToInteger(x.Val); ok {
			return &IntegerExp{x.Line, ^i}
		}
	}
	return exp
}
