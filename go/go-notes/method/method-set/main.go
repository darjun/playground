package main

import (
	"fmt"
	"reflect"
)

type S struct{}

type T struct {
	S // 匿名嵌入字段
}

func (S) SVal()  {}
func (*S) SPtr() {}
func (T) TVal()  {}
func (*T) TPtr() {}

func methodSet(a interface{}) {
	// 显示方法集里所有方法名字
	t := reflect.TypeOf(a)

	for i := 0; i < t.NumMethod(); i++ {
		m := t.Method(i)
		fmt.Println(m.Name, m.Type)
	}
}

func main() {
	var t T

	methodSet(t) // 显示T方法集
	println("---------")
	methodSet(&t) // 显示*T方法集
}
