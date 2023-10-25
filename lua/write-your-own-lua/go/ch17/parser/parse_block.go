package parser

import (
	. "github.com/darjun/luago/ch17/compiler/ast"
	. "github.com/darjun/luago/ch17/compiler/lexer"
)

// block ::= {stat} [retstat]
func parseBlock(lexer *Lexer) *Block {
	return &Block{
		Stats:    parseStats(lexer),
		RetExps:  parseRetExps(lexer),
		LastLine: lexer.Line(),
	}
}

func parseStats(lexer *Lexer) []Stat { // {stat}
	stats := make([]Stat, 0, 8)
	for !isReturnOrBlockEnd(lexer.LookAhead()) {
		stat := parseStat(lexer)
		if _, ok := stat.(*EmptyStat); !ok {
			stats = append(stats, stat)
		}
	}
	return stats
}

func isReturnOrBlockEnd(tokenKind int) bool {
	switch tokenKind {
	case TOKEN_KW_RETURN, TOKEN_EOF, TOKEN_KW_END, TOKEN_KW_ELSE, TOKEN_KW_ELSEIF, TOKEN_KW_UNTIL:
		return true
	}
	return false
}

// retstat ::= return [explist] [';]
func parseRetExps(lexer *Lexer) []Exp {
	if lexer.LookAhead() != TOKEN_KW_RETURN {
		return nil
	}

	lexer.NextToken()
	switch lexer.LookAhead() {
	case TOKEN_EOF, TOKEN_KW_END,
		TOKEN_KW_ELSE, TOKEN_KW_ELSEIF, TOKEN_KW_UNTIL:
		return []Exp{}
	case TOKEN_SEP_SEMI:
		lexer.NextToken()
		return []Exp{}
	default:
		exps := parseExpList(lexer)
		if lexer.LookAhead() == TOKEN_SEP_SEMI {
			lexer.NextToken()
		}
		return exps
	}
}
