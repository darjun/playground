package main

import "fmt"

type Color int

const (
	ColorNone = iota
	Red
	Green
	Yellow
	Blue
	Magenta
	Cyan
	White
	Black
)

type ColorText struct {
	TextColor Color
	Text      string
}

func (r *ColorText) String() string {
	if r.TextColor == ColorNone {
		return r.Text
	}

	value := 30
	if r.TextColor != Black {
		value += int(r.TextColor)
	}
	return fmt.Sprintf("33[0;%dm%s33[0m", value, r.Text)
}
