Go Playgournd
https://play.golang.org/
https://code.sololearn.com/go

# debugger

```bash
# Install the latest release:
$ go install github.com/go-delve/delve/cmd/dlv@latest

# install the command line developer tools
xcode-select --install

# enable developer mode
sudo /usr/sbin/DevToolsSecurity -enable

```

# IDE
## lightide
http://liteide.org/

```bash
# GOROOT GOBIN GOOS GOARCH GOARM CGO_ENABLED
go env GOROOT

> set GOARCH=amd64
> set GOOS=linux
> set CGO_ENABLED=0
> go build std

# cross compile
GOARCH=386 GOOS=window CGO_ENABLED=0 go build std
```

### Gocode
https://github.com/nsf/gocode

### Debugging
LITEIDE_GDB

### Keybord Mapping
Ctrl+B
Ctrl+Shift+B
Ctrl+K,Ctrl+U
Ctrl+Y;Ctrl+Shift+Z

https://github.com/visualfc/liteide/releases/tag/x38.1


## Atom


Reference
---
https://github.com/go-delve/delve

