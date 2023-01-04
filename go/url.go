package main

import (
	"fmt"
	"log"
	"net/url"
)

func decode(encodedValue string) {
	fmt.Println("")
	fmt.Println("encodedValue=", encodedValue)
	decodedValue, err := url.QueryUnescape(encodedValue)
	if err != nil {
		log.Fatal(err)
		return
	}
	fmt.Println("decodedValue=", decodedValue)
}

func main() {
	decode("Hello World")
	decode("Hello+World")
	decode("Hello%20World")
}
