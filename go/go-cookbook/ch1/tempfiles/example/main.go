package main

import "github.com/darjun/go-cookbook/ch1/tempfiles"

func main() {
	if err := tempfiles.WorkWithTemp(); err != nil {
		panic(err)
	}
}
