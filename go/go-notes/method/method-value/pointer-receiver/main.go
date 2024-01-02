package main

import "fmt"

type N int

func (n *N) test() {
	fmt.Printf("test.n: %p, %v\n", n, *n)
}

func main() {
	var n N = 100
	p := &n

	n++
	f1 := n.test // 因为test方法的receiver是*N类型，所以复制&n

	n++
	f2 := p.test // 复制p指针

	n++
	fmt.Printf("main.n: %p, %v\n", p, n)
	f1()
	f2()
}
