```sh
# for assembly
rustc loops.rs --emit asm
# for optimized assembly
rustc loops.rs --release --emit asm
rustc loops.rs --target aarch64-apple-ios --emit asm
RUSTFLAGS="--emit asm" rustc loops.rs
```

GDB debug rust
