“package main

import "testing"

func TestHello(t *testing.T) {
    got := Hello("Chris")
    want := "Hello, Chris"

    if got != want {
        t.Errorf("got %q want %q", got, want)
    }
}”

Excerpt From: 通过测试学习 Go 编程. “通过测试学习 Go 编程”. Apple Books. 