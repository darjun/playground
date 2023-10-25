package parser

import (
	. "github.com/darjun/luago/ch17/compiler/ast"
	. "github.com/darjun/luago/ch17/compiler/lexer"
)

/* recursive descent parser */

func Parse(chunk, chunkName string) *Block {
	lexer := NewLexer(chunk, chunkName)
	block := parseBlock(lexer)
	lexer.NextTokenOfKind(TOKEN_EOF)
	return block
}
