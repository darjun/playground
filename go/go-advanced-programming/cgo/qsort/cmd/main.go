package main

import "C"
import (
	"fmt"
	"github.com/darjun/go-advanced-programming/cgo/qsort"
)

func main() {
	values := []int32{42, 9, 101, 95, 27, 25}
	qsort.Slice(
		values,
		func(i, j int) bool {
			return values[i] < values[j]
		})
	fmt.Println(values)
}
