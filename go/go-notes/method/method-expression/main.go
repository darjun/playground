package main

import "fmt"

type N int

func (n N) test() {
	fmt.Printf("test.n: %dp, %d\n", &n, n)
}

func main() {
	var n N = 25
	fmt.Printf("main.n: %p, %d\n", &n, n)

	f1 := N.test // func(n N)
	f1(n)

	f2 := (*N).test // func(n *N)
	f2(&n)          // 按方法集中的签名传递正确类型的参数
}
