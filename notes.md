# References
## Zig docs
Name | URL
--: | ---
Zig | [https://ziglang.org/](https://ziglang.org/)

## Cross Compile
https://zig.guide/build-system/cross-compilation
https://zig.guide/build-system/zig-build
https://ziglang.org/learn/build-system/#release

https://ziggit.dev/t/build-system-tricks/3531

> zig build -Dtarget=x86_64-windows


## Testing
https://stackoverflow.com/questions/69106290/need-help-using-a-c-library-in-zig


## Zig fetch non-zig dependencies
https://discord.com/channels/605571803288698900/1313160793373540428


# Build commands
```sh
zig build -Dtarget=x86_64-windows
```


# Structure
```
src/
    main.zig   # zig build-exe src/main.zig -lc -I src   => PASSES
    root.zig   # zig build  => FAILS
```

# Questions
build.zig
1. When should I use `getEmittedIncludeTree() instead of b.path("src")` with `exe.addIncludePath()`??


# Notes
WORKS ON MAC OS
```sh
# No Targets
zig build-exe src/main.zig -lc -I src
zig test src/main.zig -lc -I src
zig build
zig build run
zig build test --summary all

# With Targets
zig build-exe -target x86_64-windows src/main.zig -lc -I src
```

FAILS ON MAC OS
```sh
# With Targets
zig build -Dtarget=x86_64-windows
```

# Targets
zig build-exe --help | grep target
zig build --help | grep target 
