package main

import (
	"fmt"
	"reflect"
	"unsafe"
)

func main() {
	var a interface{} = nil
	var b interface{} = (*int)(nil)

	fmt.Println(a == nil)
	fmt.Println(b == nil, reflect.ValueOf(b).IsNil())

	iface := (*[2]uintptr)(unsafe.Pointer(&b))
	fmt.Println(iface, iface[1] == 0)
}
