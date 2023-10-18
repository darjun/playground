package parser

import (
	. "github.com/darjun/luago/ch16/compiler/ast"
	. "github.com/darjun/luago/ch16/compiler/lexer"
)

func Parse(chunk, chunkName string) *Block {
	lexer := NewLexer(chunk, chunkName)
	block := parseBlock(lexer)
	lexer.NextTokenOfKind(TOKEN_EOF)
	return block
}
