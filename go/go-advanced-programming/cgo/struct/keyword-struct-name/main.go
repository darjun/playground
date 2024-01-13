package main

/*
struct A {
	int type;	// type是Go语言的关键字
};
*/
import "C"
import "fmt"

func main() {
	var a C.struct_A
	fmt.Println(a._type) // _type对应type
}
