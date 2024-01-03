package main

import "fmt"

func main() {
	r := ColorText{
		TextColor: Red,
		Text:      "I'm red!",
	}

	fmt.Println(r.String())

	r.TextColor = Green
	r.Text = "I'm green!"

	fmt.Println(r.String())

	r.TextColor = ColorNone
	r.Text = "Back to normal..."

	fmt.Println(r.String())
}
