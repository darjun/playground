package main

import "github.com/darjun/go-cookbook/ch1/templates"

func main() {
	if err := templates.RunTemplate(); err != nil {
		panic(err)
	}

	if err := templates.InitTemplates(); err != nil {
		panic(err)
	}

	if err := templates.HTMLDifference(); err != nil {
		panic(err)
	}
}
