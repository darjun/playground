// Code generated by cmd/cgo; DO NOT EDIT.

//line /Users/lidajun/workspace/code/playground/go/go-advanced-programming/cgo/internal-mechanism/c-call-go/sum.go:1:1
package main

//int sum(int a, int b);
import _ "unsafe"

//export sum
func sum(a, b  /*line :7:15*/_Ctype_int /*line :7:20*/)  /*line :7:22*/_Ctype_int /*line :7:27*/ {
	return a + b
}

func main() {}