package main

import "fmt"

type N int

func (n N) test() {
	fmt.Printf("test.n: %p, %v\n", &n, n)
}

func call(m func()) {
	m()
}

func main() {
	var n N = 100
	p := &n

	fmt.Printf("main.n: %p, %v\n", p, n)

	n++
	call(n.test)

	n++
	call(n.test)
}
