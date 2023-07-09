
* Retained: long lived memory use and object count retained due to the execution of the code block.

* Allocated: All object allocation and memory allocation during code block.

The main benefits of YJIT are:

- Speed up the performance of your application by running the compiled version of your code instead of interpreting it.

- Reduce memory usage by enabling more efficient use of memory, which translates into less garbage collection overhead.

YJIT also adds support for:

* Tail call optimizations (TCO)

* Multi-threaded compilation

* Parallel execution



```bash
== disasm: #<ISeq:get@test.rb:1 (1,0)-(3,3)> (catch: FALSE)
local table (size: 2, argc: 2 [opts: 0, rest: -1, post: 0, block: -1, kw: -1@-1, kwrest: -1])
[ 2] obj@0<Arg> [ 1] idx@1<Arg>
0000 getlocal_WC_0                          obj@0                     (   2)[LiCa]
0002 getlocal_WC_0                          idx@1
0004 opt_aref                               <calldata!mid:[], argc:1, ARGS_SIMPLE>[CcCr]
0006 leave                                                            (   3)[Re]
```


Reference
---

https://www.mintbit.com/blog/ruby-3-dot-1-experiments-with-yjit
https://www.youtube.com/watch?v=PBVLf3yfMs8
