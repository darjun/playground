package main

type tester interface {
	test()
	string() string
}

type data struct{}

func (*data) test() {}
func (data) string() string {
	return ""
}

func main() {
	var d data

	// var t tester = d
	// 错误：data does not implement tester
	// (test method has pointer receiver)

	var t tester = &d
	t.test()
	println(t.string())
}
