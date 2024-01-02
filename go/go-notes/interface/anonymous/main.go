package main

type data struct{}

func (data) string() string {
	return ""
}

type node struct {
	data interface { // 匿名接口类型
		string() string
	}
}

func main() {
	var t interface { // 定义匿名接口变量
		string() string
	} = data{}

	n := node{
		data: t,
	}

	println(n.data.string())
}
