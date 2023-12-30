package main

import (
	"fmt"
	"reflect"
)

type user struct {
	name string `field:"name" type:"varchar(50)"`
	age  int    `field:"age" type:"int"`
}

func main() {
	var u user
	t := reflect.TypeOf(u)

	for i := 0; i < t.NumField(); i++ {
		f := t.Field(i)
		fmt.Printf("%s: %s %s\n", f.Name, f.Tag.Get("field"), f.Tag.Get("type"))
	}
}
