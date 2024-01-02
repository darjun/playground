package main

import (
	"github.com/darjun/go-cookbook/ch1/bytesstrings"
)

func main() {
	err := bytesstrings.WorkWithBuffer()
	if err != nil {
		panic(err)
	}
	bytesstrings.SearchString()
	bytesstrings.ModifyString()
	bytesstrings.StringReader()
}
