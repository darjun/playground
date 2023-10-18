package main

import (
	"encoding/json"
	"os"

	"github.com/darjun/luago/ch16/parser"
)

func main() {
	if len(os.Args) > 1 {
		data, err := os.ReadFile(os.Args[1])
		if err != nil {
			panic(err)
		}
		testParser(string(data), os.Args[1])
	}
}

func testParser(chunk, chunkName string) {
	for {
		ast := parser.Parse(chunk, chunkName)
		b, err := json.Marshal(ast)
		if err != nil {
			panic(err)
		}
		println(string(b))
	}
}
