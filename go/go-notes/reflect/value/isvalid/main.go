package main

import "reflect"

func main() {
	v := reflect.ValueOf(struct{ name string }{})

	println(v.FieldByName("name").IsValid())
	println(v.FieldByName("xxx").IsValid())
}
