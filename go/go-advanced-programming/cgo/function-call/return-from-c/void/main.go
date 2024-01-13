package main

//static void noreturn() {}
import "C"
import "fmt"

func main() {
	v, err := C.noreturn()
	fmt.Printf("%#v %v", v, err)
}
