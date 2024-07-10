```bash
rbtrace -p 12345 --firehose
rbtrace -p 12345 -m sleep Dir.chdir
rbtrace -p 12345 -m Kernel#
rbtrace -p 12345 --backtraces
rbtrace -p 12345 --interactive
rbtrace --pid 12345 -e 'puts Rails.env'
```

```bash
ruby server.rb &
```

```bash
rbtrace -p 87854 -m sleep
