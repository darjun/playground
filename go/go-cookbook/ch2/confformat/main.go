package main

func main() {
	if err := MarshalAll(); err != nil {
		panic(err)
	}

	if err := UnmarshalAll(); err != nil {
		panic(err)
	}

	if err := OtherJSONExamples(); err != nil {
		panic(err)
	}
}
