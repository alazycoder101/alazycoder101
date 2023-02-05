```bash
$go mod init example/hello
go: creating new go.mod: module example/hello

$go run .


go get rsc.io/quote
```

```bash
$go mod init example.com/greetings
go: creating new go.mod: module example.com/greetings

$go mod init example.com/hello
go: creating new go.mod: module example.com/hello



go run .
hello.go:6:5: no required module provides package example.com/greetings; to add it:
	go get example.com/greetings
$go mod edit -replace example.com/greetings=../greetings

go mod tidy
go: found example.com/greetings in example.com/greetings v0.0.0-00010101000000-000000000000
```

### Test

```bash
go test
go test -v
```

Reference
---
https://go.dev/doc/tutorial/getting-started
