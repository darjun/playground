package parser

import (
	. "github.com/darjun/luago/ch17/compiler/ast"
	. "github.com/darjun/luago/ch17/compiler/lexer"
)

func parseStat(lexer *Lexer) Stat {
	switch lexer.LookAhead() {
	case TOKEN_SEP_SEMI:
		return parseEmptyStat(lexer)
	case TOKEN_KW_BREAK:
		return parseBreakStat(lexer)
	case TOKEN_SEP_LABEL:
		return parseLabelStat(lexer)
	case TOKEN_KW_GOTO:
		return parseGotoStat(lexer)
	case TOKEN_KW_DO:
		return parseDoStat(lexer)
	case TOKEN_KW_WHILE:
		return parseWhileStat(lexer)
	case TOKEN_KW_REPEAT:
		return parseRepeatStat(lexer)
	case TOKEN_KW_IF:
		return parseIfStat(lexer)
	case TOKEN_KW_FOR:
		return parseForStat(lexer)
	case TOKEN_KW_FUNCTION:
		return parseFuncDefStat(lexer)
	case TOKEN_KW_LOCAL:
		return parseLocalAssignOrFuncDefStat(lexer)
	default:
		return parseAssignOrFuncCallStat(lexer)
	}
}

func parseEmptyStat(lexer *Lexer) *EmptyStat {
	lexer.NextTokenOfKind(TOKEN_SEP_SEMI) // ;
	return &EmptyStat{}
}

func parseBreakStat(lexer *Lexer) *BreakStat {
	lexer.NextTokenOfKind(TOKEN_KW_BREAK) // break
	return &BreakStat{lexer.Line()}
}

func parseLabelStat(lexer *Lexer) *LabelStat {
	lexer.NextTokenOfKind(TOKEN_SEP_LABEL) // ::
	_, name := lexer.NextIdentifier()      // Name
	lexer.NextTokenOfKind(TOKEN_SEP_LABEL) // ::
	return &LabelStat{name}
}

func parseGotoStat(lexer *Lexer) *GotoStat {
	lexer.NextTokenOfKind(TOKEN_KW_GOTO) // goto
	_, name := lexer.NextIdentifier()    // Name
	return &GotoStat{name}
}

func parseDoStat(lexer *Lexer) *DoStat {
	lexer.NextTokenOfKind(TOKEN_KW_DO)  // do
	block := parseBlock(lexer)          // block
	lexer.NextTokenOfKind(TOKEN_KW_END) // end
	return &DoStat{block}
}

func parseWhileStat(lexer *Lexer) *WhileStat {
	lexer.NextTokenOfKind(TOKEN_KW_WHILE) // while
	exp := parseExp(lexer)                // exp
	lexer.NextTokenOfKind(TOKEN_KW_DO)    // do
	block := parseBlock(lexer)            // block
	lexer.NextTokenOfKind(TOKEN_KW_END)   // end
	return &WhileStat{exp, block}
}

func parseRepeatStat(lexer *Lexer) *RepeatStat {
	lexer.NextTokenOfKind(TOKEN_KW_REPEAT) // repeat
	block := parseBlock(lexer)             // block
	lexer.NextTokenOfKind(TOKEN_KW_UNTIL)  // until
	exp := parseExp(lexer)                 // exp
	return &RepeatStat{exp, block}
}

func parseIfStat(lexer *Lexer) *IfStat {
	exps := make([]Exp, 0, 4)
	blocks := make([]*Block, 0, 4)

	lexer.NextTokenOfKind(TOKEN_KW_IF)         // if
	exps = append(exps, parseExp(lexer))       // exp
	lexer.NextTokenOfKind(TOKEN_KW_THEN)       // then
	blocks = append(blocks, parseBlock(lexer)) // block

	for lexer.LookAhead() == TOKEN_KW_ELSEIF { // elseif
		lexer.NextToken()

		exps = append(exps, parseExp(lexer))       // exp
		lexer.NextTokenOfKind(TOKEN_KW_THEN)       // then
		blocks = append(blocks, parseBlock(lexer)) // block
	} // }

	// else block => elseif true then block
	if lexer.LookAhead() == TOKEN_KW_ELSE { // [
		lexer.NextToken()                           // else
		exps = append(exps, &TrueExp{lexer.Line()}) //
		blocks = append(blocks, parseBlock(lexer))  // block
	} // ]

	lexer.NextTokenOfKind(TOKEN_KW_END) // end
	return &IfStat{exps, blocks}
}

func parseForStat(lexer *Lexer) Stat {
	lineOfFor, _ := lexer.NextTokenOfKind(TOKEN_KW_FOR)
	_, name := lexer.NextIdentifier()
	if lexer.LookAhead() == TOKEN_OP_ASSIGN {
		return finishForNumStat(lexer, lineOfFor, name)
	} else {
		return finishForInStat(lexer, name)
	}
}

func finishForNumStat(lexer *Lexer, lineOfFor int, varName string) *ForNumStat {
	lexer.NextTokenOfKind(TOKEN_OP_ASSIGN) // for name '='
	initExp := parseExp(lexer)             // exp
	lexer.NextTokenOfKind(TOKEN_SEP_COMMA) // ', '
	limitExp := parseExp(lexer)            // exp
	var stepExp Exp
	if lexer.LookAhead() == TOKEN_SEP_COMMA { // [
		lexer.NextToken()         // ','
		stepExp = parseExp(lexer) // exp
	} else { // ]
		stepExp = &IntegerExp{lexer.Line(), 1}
	}
	lineOfDo, _ := lexer.NextTokenOfKind(TOKEN_KW_DO) // do
	block := parseBlock(lexer)                        // block
	lexer.NextTokenOfKind(TOKEN_KW_END)               // end
	return &ForNumStat{
		lineOfFor, lineOfDo, varName, initExp, limitExp, stepExp, block,
	}
}

func finishForInStat(lexer *Lexer, name0 string) *ForInStat {
	nameList := finishNameList(lexer, name0)          // for namelist
	lexer.NextTokenOfKind(TOKEN_KW_IN)                // in
	expList := parseExpList(lexer)                    // explist
	lineOfDo, _ := lexer.NextTokenOfKind(TOKEN_KW_DO) // do
	block := parseBlock(lexer)                        // block
	lexer.NextTokenOfKind(TOKEN_KW_END)               // end
	return &ForInStat{lineOfDo, nameList, expList, block}
}

func finishNameList(lexer *Lexer, name0 string) []string {
	names := []string{name0}                   // Name
	for lexer.LookAhead() == TOKEN_SEP_COMMA { // {
		lexer.NextToken()                 // ','
		_, name := lexer.NextIdentifier() // Name
		names = append(names, name)       //
	} // }
	return names
}

func parseLocalAssignOrFuncDefStat(lexer *Lexer) Stat {
	lexer.NextTokenOfKind(TOKEN_KW_LOCAL) // local
	if lexer.LookAhead() == TOKEN_KW_FUNCTION {
		return finishLocalFuncDefStat(lexer)
	} else {
		return finishLocalVarDeclStat(lexer)
	}
}

func finishLocalFuncDefStat(lexer *Lexer) *LocalFuncDefStat {
	lexer.NextTokenOfKind(TOKEN_KW_FUNCTION) // function
	_, name := lexer.NextIdentifier()        // Name
	fdExp := parseFuncDefExp(lexer)          // funcbody
	return &LocalFuncDefStat{name, fdExp}
}

func finishLocalVarDeclStat(lexer *Lexer) *LocalVarDeclStat {
	_, name0 := lexer.NextIdentifier()       // name
	nameList := finishNameList(lexer, name0) // {',' Name}
	var expList []Exp
	if lexer.LookAhead() == TOKEN_OP_ASSIGN { // [
		lexer.NextToken()             // '='
		expList = parseExpList(lexer) // explist
	} // ]
	lastLine := lexer.Line()
	return &LocalVarDeclStat{lastLine, nameList, expList}
}

func parseAssignOrFuncCallStat(lexer *Lexer) Stat {
	prefixExp := parsePrefixExp(lexer)
	if fc, ok := prefixExp.(*FuncCallExp); ok {
		return fc
	} else {
		return parseAssignStat(lexer, prefixExp)
	}
}

func parseAssignStat(lexer *Lexer, var0 Exp) *AssignStat {
	varList := finishVarList(lexer, var0)  // varlist
	lexer.NextTokenOfKind(TOKEN_OP_ASSIGN) // '='
	expList := parseExpList(lexer)         // explist
	lastLine := lexer.Line()
	return &AssignStat{lastLine, varList, expList}
}

func finishVarList(lexer *Lexer, var0 Exp) []Exp {
	vars := []Exp{checkVar(lexer, var0)}       // var
	for lexer.LookAhead() == TOKEN_SEP_COMMA { // {
		lexer.NextToken()                         // ','
		exp := parsePrefixExp(lexer)              // var
		vars = append(vars, checkVar(lexer, exp)) //
	}
	return vars
}

// var ::= Name | prefixexp '[' exp ']' | prefixexp '.' Name
func checkVar(lexer *Lexer, exp Exp) Exp {
	switch exp.(type) {
	case *NameExp, *TableAccessExp:
		return exp
	}
	lexer.NextTokenOfKind(-1) // trigger error
	panic("unreachable!")
}

func parseFuncDefStat(lexer *Lexer) *AssignStat {
	lexer.NextTokenOfKind(TOKEN_KW_FUNCTION) // function
	fnExp, hasColon := parseFuncName(lexer)  // funcname
	fdExp := parseFuncDefExp(lexer)          // funcbody
	if hasColon {
		fdExp.ParList = append(fdExp.ParList, "")
		copy(fdExp.ParList[1:], fdExp.ParList)
		fdExp.ParList[0] = "self"
	}

	return &AssignStat{
		LastLine: fdExp.Line,
		VarList:  []Exp{fnExp},
		ExpList:  []Exp{fdExp},
	}
}

// funcname ::= Name {'.' Name} [':' Name]
func parseFuncName(lexer *Lexer) (exp Exp, hasColon bool) {
	line, name := lexer.NextIdentifier()
	exp = &NameExp{line, name}
	for lexer.LookAhead() == TOKEN_SEP_DOT {
		lexer.NextToken()
		line, name = lexer.NextIdentifier()
		idx := &StringExp{line, name}
		exp = &TableAccessExp{line, exp, idx}
	}
	if lexer.LookAhead() == TOKEN_SEP_COLON {
		lexer.NextToken()
		line, name = lexer.NextIdentifier()
		idx := &StringExp{line, name}
		exp = &TableAccessExp{line, exp, idx}
		hasColon = true
	}
	return
}
