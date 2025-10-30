# Valgrind
# Valgrind User Manual
## website
## https://valgrind.org/docs/manual/manual.html
### page

#### surface
#### Tools

##### Introduction

###### What are the standard tools supplied by valgrind?

* **memcheck**: memory error detection
* **cachegrind**: cache and branch prediction profiler
* **callgrind**: call graph generating cache profiler
* **helgrind**: thread error detection
* **drd**: thread error detection
* **massif**: heap profiler

#### Core Options

##### Compilation Options

###### What compiler option is required for the profiler to work?

Debugging information is required for the profiler to see the program internals.

```sh
gcc -g
```

###### Make inline function call chains in C++ more visible to the profiler?

Disabling inline functions will make it easier to see the function call chain.

```sh
gcc -g -fno-inline
```

###### What compilation options are recommended?

```sh
gcc -g3 -Og -Wall -Wextra
```

##### Valgrind Core

###### Specify which tool you want to use with valgrind?

```sh
valgrind --tool=[tool] <program> <args>...
```

The default tool is `memcheck`. Therefore, this option can be omitted.
