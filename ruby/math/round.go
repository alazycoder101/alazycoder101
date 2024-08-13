package main

import (
	"fmt"
	"math"
)

func main() {
	fmt.Printf("round(2.675, 2): %.3f", math.Round(2.675*100)/100)
}
