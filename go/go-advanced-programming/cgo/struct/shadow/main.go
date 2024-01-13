package main

/*
struct A {
	int type; // type是Go语言的关键字
	float _type; // 将屏蔽CGO对type成员的访问
};
*/
import "C"
import "fmt"

func main() {
	var a C.struct_A
	fmt.Println(a._type) // _type对应_type
}
