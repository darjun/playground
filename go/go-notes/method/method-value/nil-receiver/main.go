package main

type N int

func (N) value()    {}
func (*N) pointer() {}

func main() {
	var p *N

	p.pointer()         // method value
	(*N)(nil).pointer() // method value
	(*N).pointer(nil)   // metho expression

	// p.value()
	// 错误：invalid memory address or nil pointer dereference
}
