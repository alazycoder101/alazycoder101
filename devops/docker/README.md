```bash
docker build -t test .

docker run --rm -it test tree /tmp/
/tmp
├── 2
│   └── env -> ../../bin/env
├── 3
│   └── bin
│       └── env -> ../../bin/env
├── env -> ../../bin/env
├── no
├── non-exist
├── non-exist-dir
│   └── yes
└── yes
```
