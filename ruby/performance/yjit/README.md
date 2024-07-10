```bash
ruby --yjit-dump-diasm --yjit-call-threshold=2 \
  --disable-gems -e "def three = 1 + 2; three; three"
```

```bash
$ RUBYOPT=--mjit=pause irb

def a = nil

puts RubyVM::InstructionSequence.disasm(method(:a))
putself = RubyVM::MJIT.const_get(:INSNS).values.find { |i| i.name ==
:putself }

C = RubyVM::MJIT.const_get(:C)}

iseq = C.rb_iseqw_to_iseq(RUBYOPT::InstructionSequence.of(method(:a)))
iseq.body.iseq_encoded[0] = C.rb_vm_insn_encode(putself.bin)
a
```

Own JIT instructions
```bash
--mjit=pause

# define
RubyVM::MJIT.compile
# hack RubyVM
RubyVM::MJIT.const_get(:C)
# start JIT
RubyVM::MJIT.resume
```

Monkey-patch RubyVM::MJIT.compile

```ruby
class << RubyVM::MJIT
  def compile(iseq)
    buf = Fisk::Helpers.jitbuffer(4096)
    Fisk.new.asm(buf) do
      # pop stack frames
      add rsi, imm32(0x40)
      mov m64(rdi, 0x10), rsi
      # return true
      mov rax, imm64(0x14)
      ret
    end
    puts "JIT compile: #{iseq.body.location.label}"
    return buf.memory.to_i
  end
end
RubyVM::MJIT.resume
```

```ruby
# a.rb
def test = false
p test
p test
```

```bash
ruby --mjit=pause --mjit-wait --mjit-min-calls=2 /tmp/a.rb 
```

```ruby
class << RubyVM::MJIT.const_get(:Compiler)
  def compile(f, _iseq, funcname, _id)
    c = RubyVM::MJIT.const_get(:C)
    c.fprintf(f, "VALUE #{funcnae}(rb_execution_context_t *ec,
    rb_control_frame_t *cfp)\n"\n")
    c.fprintf(f, "    ec-cfp = RUBY_VM_PREVIOUS_CONTROL_FRAME(cfp);\n")
    c.fprintf(f, "    return Qtrue;\n")
    c.fprintf(f, "}\n")
    return true
  end
end
RubyVM::MJIT.resume

def test = false
p test
p test
```

```bash
ruby --mjit=pause --mjit-min-calls=2 --mjit-verbose=1 --mjit-wait /tmp/b.rb 
```





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
