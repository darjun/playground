package parser

import (
	. "github.com/darjun/luago/ch17/compiler/ast"
	. "github.com/darjun/luago/ch17/compiler/lexer"
	"github.com/darjun/luago/ch17/number"
)

func parseExpList(lexer *Lexer) []Exp {
	exps := make([]Exp, 0, 4)
	exps = append(exps, parseExp(lexer))       // exp
	for lexer.LookAhead() == TOKEN_SEP_COMMA { // {
		lexer.NextToken()                    // ', '
		exps = append(exps, parseExp(lexer)) // exp
	} // }
	return exps
}

func parseExp(lexer *Lexer) Exp {
	return parseExp12(lexer)
}

// x or y
func parseExp12(lexer *Lexer) Exp { // exp11 {or exp11}
	exp := parseExp11(lexer)
	for lexer.LookAhead() == TOKEN_OP_OR {
		line, op, _ := lexer.NextToken()
		exp = &BinopExp{line, op, exp, parseExp11(lexer)}
	}
	return exp
}

// x and y
func parseExp11(lexer *Lexer) Exp { // exp10 {and exp10}
	exp := parseExp10(lexer)
	for lexer.LookAhead() == TOKEN_OP_AND {
		line, op, _ := lexer.NextToken()
		return &BinopExp{line, op, exp, parseExp10(lexer)}
	}
	return exp
}

// compare
func parseExp10(lexer *Lexer) Exp {
	exp := parseExp9(lexer)
	for {
		switch lexer.LookAhead() {
		case TOKEN_OP_LT, TOKEN_OP_GT, TOKEN_OP_NE,
			TOKEN_OP_LE, TOKEN_OP_GE, TOKEN_OP_EQ:
			line, op, _ := lexer.NextToken()
			exp = &BinopExp{line, op, exp, parseExp10(lexer)}
		default:
			return exp
		}
	}
}

// x | y
func parseExp9(lexer *Lexer) Exp {
	exp := parseExp8(lexer)
	for lexer.LookAhead() == TOKEN_OP_BOR {
		line, op, _ := lexer.NextToken()
		exp = &BinopExp{line, op, exp, parseExp8(lexer)}
	}
	return exp
}

// x ~ y
func parseExp8(lexer *Lexer) Exp {
	exp := parseExp7(lexer)
	for lexer.LookAhead() == TOKEN_OP_BXOR {
		line, op, _ := lexer.NextToken()
		exp = &BinopExp{line, op, exp, parseExp7(lexer)}
	}
	return exp
}

// x & y
func parseExp7(lexer *Lexer) Exp {
	exp := parseExp6(lexer)
	for lexer.LookAhead() == TOKEN_OP_BAND {
		line, op, _ := lexer.NextToken()
		exp = &BinopExp{line, op, exp, parseExp6(lexer)}
	}
	return exp
}

// shift
func parseExp6(lexer *Lexer) Exp {
	exp := parseExp5(lexer)
	for {
		switch lexer.LookAhead() {
		case TOKEN_OP_SHL, TOKEN_OP_SHR:
			line, op, _ := lexer.NextToken()
			exp = &BinopExp{line, op, exp, parseExp5(lexer)}
		default:
			return exp
		}
	}
}

// a .. b
func parseExp5(lexer *Lexer) Exp { // exp4 {'..' exp4}
	exp := parseExp4(lexer)
	if lexer.LookAhead() != TOKEN_OP_CONCAT {
		return exp
	}

	line := 0
	exps := []Exp{exp}
	for lexer.LookAhead() == TOKEN_OP_CONCAT {
		line, _, _ = lexer.NextToken()
		exps = append(exps, parseExp4(lexer))
	}
	return &ConcatExp{line, exps}
}

// x +/- y
func parseExp4(lexer *Lexer) Exp {
	exp := parseExp3(lexer)
	for {
		switch lexer.LookAhead() {
		case TOKEN_OP_ADD, TOKEN_OP_SUB:
			line, op, _ := lexer.NextToken()
			exp = &BinopExp{line, op, exp, parseExp2(lexer)}
		default:
			return exp
		}
	}
}

// *,%,/,//
func parseExp3(lexer *Lexer) Exp {
	exp := parseExp2(lexer)
	for {
		switch lexer.LookAhead() {
		case TOKEN_OP_MUL, TOKEN_OP_MOD, TOKEN_OP_DIV, TOKEN_OP_IDIV:
			line, op, _ := lexer.NextToken()
			exp = &BinopExp{line, op, exp, parseExp2(lexer)}
		default:
			return exp
		}
	}
}

// unary
func parseExp2(lexer *Lexer) Exp { // {('not' | '#' | '-' | '~')} exp1
	switch lexer.LookAhead() {
	case TOKEN_OP_UNM, TOKEN_OP_BNOT, TOKEN_OP_LEN, TOKEN_OP_NOT:
		line, op, _ := lexer.NextToken()
		exp := &UnopExp{line, op, parseExp1(lexer)}
		return optimizeUnaryOp(exp) // 优化
	}
	return parseExp1(lexer)
}

// x ^ y
func parseExp1(lexer *Lexer) Exp { // exp0 {'^' exp2}
	exp := parseExp0(lexer)
	if lexer.LookAhead() == TOKEN_OP_POW {
		line, op, _ := lexer.NextToken()
		exp = &BinopExp{line, op, exp, parseExp2(lexer)}
	}
	return exp
}

func parseExp0(lexer *Lexer) Exp {
	switch lexer.LookAhead() {
	case TOKEN_VARARG: // '...'
		line, _, _ := lexer.NextToken()
		return &VarargExp{line}
	case TOKEN_KW_NIL: // nil
		line, _, _ := lexer.NextToken()
		return &NilExp{line}
	case TOKEN_KW_TRUE: // true
		line, _, _ := lexer.NextToken()
		return &TrueExp{line}
	case TOKEN_KW_FALSE: // false
		line, _, _ := lexer.NextToken()
		return &FalseExp{line}
	case TOKEN_STRING: // LiteralString
		line, _, token := lexer.NextToken()
		return &StringExp{line, token}
	case TOKEN_NUMBER: // Numeral
		return parseNumberExp(lexer)
	case TOKEN_SEP_LCURLY: // tableconstructor
		return parseTableConstructorExp(lexer)
	case TOKEN_KW_FUNCTION: // functiondef
		lexer.NextToken()
		return parseFuncDefExp(lexer)
	default: // prefixexp
		return parsePrefixExp(lexer)
	}
}

func parseNumberExp(lexer *Lexer) Exp {
	line, _, token := lexer.NextToken()
	if i, ok := number.ParseInteger(token); ok {
		return &IntegerExp{line, i}
	} else if f, ok := number.ParseFloat(token); ok {
		return &FloatExp{line, f}
	} else {
		panic("not a number: " + token)
	}
}

func parseFuncDefExp(lexer *Lexer) *FuncDefExp {
	line := lexer.Line()                               // 关键字 function 已经跳过
	lexer.NextTokenOfKind(TOKEN_SEP_LPAREN)            // '('
	parList, isVararg := parseParList(lexer)           // [parList]
	lexer.NextTokenOfKind(TOKEN_SEP_RPAREN)            // ')'
	block := parseBlock(lexer)                         // block
	lastLine, _ := lexer.NextTokenOfKind(TOKEN_KW_END) // end
	return &FuncDefExp{line, lastLine, parList, isVararg, block}
}

func parseParList(lexer *Lexer) (names []string, isVararg bool) {
	switch lexer.LookAhead() {
	case TOKEN_SEP_RPAREN:
		return nil, false
	case TOKEN_VARARG:
		lexer.NextToken()
		return nil, true
	}

	_, name := lexer.NextIdentifier()
	names = append(names, name)
	for lexer.LookAhead() == TOKEN_SEP_COMMA {
		lexer.NextToken()
		if lexer.LookAhead() == TOKEN_IDENTIFIER {
			_, name = lexer.NextIdentifier()
			names = append(names, name)
		} else {
			lexer.NextTokenOfKind(TOKEN_VARARG)
			isVararg = true
			break
		}
	}
	return
}

func parseTableConstructorExp(lexer *Lexer) *TableConstructorExp {
	line := lexer.Line()
	lexer.NextTokenOfKind(TOKEN_SEP_LCURLY)   // {
	keyExps, valExps := parseFieldList(lexer) // [fieldlist]
	lexer.NextTokenOfKind(TOKEN_SEP_RCURLY)   // }
	lastLine := lexer.Line()
	return &TableConstructorExp{line, lastLine, keyExps, valExps}
}

func parseFieldList(lexer *Lexer) (ks, vs []Exp) {
	if lexer.LookAhead() != TOKEN_SEP_RCURLY {
		k, v := parseField(lexer) // field
		ks = append(ks, k)        //
		vs = append(vs, v)
		for isFieldSep(lexer.LookAhead()) { // {
			lexer.NextToken()                          // fieldsep
			if lexer.LookAhead() != TOKEN_SEP_RCURLY { //
				k, v = parseField(lexer) // field
				ks = append(ks, k)
				vs = append(vs, v)
			} else {
				break
			}
		}
	}
	return
}

func isFieldSep(tokenKind int) bool {
	return tokenKind == TOKEN_SEP_COMMA || tokenKind == TOKEN_SEP_SEMI
}

// field ::= '[' exp ']' '=' exp | Name '=' exp | exp
func parseField(lexer *Lexer) (k, v Exp) {
	if lexer.LookAhead() == TOKEN_SEP_LBRACK {
		lexer.NextToken()                       // '['
		k = parseExp(lexer)                     // exp
		lexer.NextTokenOfKind(TOKEN_SEP_RBRACK) // ']'
		lexer.NextTokenOfKind(TOKEN_OP_ASSIGN)  // =
		v = parseExp(lexer)                     // exp
		return
	}

	exp := parseExp(lexer)
	if nameExp, ok := exp.(*NameExp); ok {
		if lexer.LookAhead() == TOKEN_OP_ASSIGN {
			// Name '=' exp => '[' LiteralString ']' = exp
			lexer.NextToken()
			k = &StringExp{nameExp.Line, nameExp.Name}
			v = parseExp(lexer)
			return
		}
	}
	return nil, exp
}

func parsePrefixExp(lexer *Lexer) Exp {
	var exp Exp
	if lexer.LookAhead() == TOKEN_IDENTIFIER {
		line, name := lexer.NextIdentifier() // Name
		exp = &NameExp{line, name}
	} else { // '(' exp  ')'
		exp = parseParensExp(lexer)
	}
	return finishPrefixExp(lexer, exp)
}

func finishPrefixExp(lexer *Lexer, exp Exp) Exp {
	for {
		switch lexer.LookAhead() {
		case TOKEN_SEP_LBRACK:
			lexer.NextToken() // '['
			keyExp := parseExp(lexer)
			lexer.NextTokenOfKind(TOKEN_SEP_RBRACK) // ']'
			exp = &TableAccessExp{lexer.Line(), exp, keyExp}
		case TOKEN_SEP_DOT:
			lexer.NextToken()                    // .
			line, name := lexer.NextIdentifier() // Name
			keyExp := &StringExp{line, name}
			exp = &TableAccessExp{line, exp, keyExp}
		case TOKEN_SEP_COLON,
			TOKEN_SEP_LPAREN, TOKEN_SEP_LCURLY, TOKEN_STRING:
			exp = finishFuncCallExp(lexer, exp) // [':' Name] args
		default:
			return exp
		}
	}
	return exp
}

func parseParensExp(lexer *Lexer) Exp {
	lexer.NextTokenOfKind(TOKEN_SEP_LPAREN) // '('
	exp := parseExp(lexer)                  // exp
	lexer.NextTokenOfKind(TOKEN_SEP_RPAREN) // ')'

	switch exp.(type) {
	case *VarargExp, *FuncCallExp, *NameExp, *TableAccessExp:
		return &ParensExp{exp}
	}
	return exp
}

func finishFuncCallExp(lexer *Lexer, prefixExp Exp) *FuncCallExp {
	nameExp := parseNameExp(lexer) // [':' Name]
	line := lexer.Line()           //
	args := parseArgs(lexer)       // args
	lastLine := lexer.Line()       //
	return &FuncCallExp{line, lastLine, prefixExp, nameExp, args}
}

func parseNameExp(lexer *Lexer) *StringExp {
	if lexer.LookAhead() == TOKEN_SEP_COLON {
		lexer.NextToken()
		line, name := lexer.NextIdentifier()
		return &StringExp{line, name}
	}
	return nil
}

func parseArgs(lexer *Lexer) (args []Exp) {
	switch lexer.LookAhead() {
	case TOKEN_SEP_LPAREN: // '(' [explist] ')'
		lexer.NextToken()
		if lexer.LookAhead() != TOKEN_SEP_RPAREN {
			args = parseExpList(lexer)
		}
		lexer.NextTokenOfKind(TOKEN_SEP_RPAREN)
	case TOKEN_SEP_LCURLY: // '{' [fieldlist] '}'
		args = []Exp{parseTableConstructorExp(lexer)}
	default: // LiteralString
		line, str := lexer.NextTokenOfKind(TOKEN_STRING)
		args = []Exp{&StringExp{line, str}}
	}
	return
}
