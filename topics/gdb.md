# GNU Debugger

## Debug Information Generation

<details>
<summary>Generate DWARF debugging information in an executable?</summary>

> To debug with `gdb`, compile with `-g`.
> This generates *DWARF* information, which is used by the debugger to understand what the program is doing.
>
> ```sh
> gcc -g -o program source.c
> ``````
>
> Use `-O` to compile with optimizations, but this can adversely affect the debug experience i.e. `-O` and `-g` are orthogonal and independent.
> To get a reasonable level of performance and a good debug experience, use `-Og`.
> And to get an even better debug experience, use `-g3` rather than just `-g`.
>
> ```sh
> gcc -g3 -Og -o program source.c
> ``````
>
> You can use the readelf utility to look at the debug info.

> **Resources**
> - GDB Tips by Greg Law - Tip #1
> ---
> **References**
> ---
</details>

## Text User Interface

<details>
<summary>Start the text user interface in gdb?</summary>

> TUI (Text User Interface) mode allows you to see the context of what you’re debugging!
>
> ```sh
> gdb -tui ./executable
> ``````
>
> You can also type `layout src` to switch to the TUI mode.
>
> ```gdb
> layout src
> ``````
>
> The shortcut `ctrl–x a` will also start the TUI.
>
> `ctrl+l` to redraw the screen reset in TUI mode.

> **Resources**
> - GDB Tips by Greg Law - Tip #2

> **References**
> ---
</details>

<details>
<summary>Enter SingleKey mode?</summary>

> Press `ctrl-x s` in TUI mode to enable SingleKey mode. In this mode you can
> use `r` to `run`, `c` to `continue`, `s` for `step`, and `q` to leave
> SingleKey mode, without pressing enter.
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #65
> ---
> **References**
> ---
</details>

<details>
<summary>Cycle through assembly and source code windows in GDB TUI?</summary>

> `ctrl-x 2`
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #3
> ---
> **References**
> ---
</details>

<details>
<summary>Switch focus between GDB TUI windows?</summary>

> ```gdb
> (gdb) focus src
> (gdb) focus cmd
> ``````
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #3
> ---
> **References**
> ---
</details>

## Command History

<details>
<summary>Navigate through command history?</summary>

> - `ctrl-p` for previous commands
> - `ctrl-n` for next commands
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #3
> ---
> **References**
> ---
</details>

## Starting Execution

<details>
<summary>Begin debugging session of an executable?</summary>

> - `start`: starts debugging session by running program line-by-line.
> - `run`: starts debugging session running program as usual.
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 7
> ---
> **References**
> ---
</details>

## Attaching Process

<details>
<summary>Start debugging an already running process?</summary>

> Attaching to a process requires root privileges.
>
> After debugger gets attached to the process, the program will freeze as if it
> is on a breakpoint.
>
> ```sh
> sudo gdb
> (gdb) attach 12345
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Rudz-uSdWHM
> ---
> **References**
> ---
</details>

## Detaching Process

<details>
<summary>Detach debugger from a debugging process?</summary>

> ```gdb
> (gdb) detach
> ``````
>
> After detaching, the program will continue its normal flow as there was no
> debugger attached to it at first place.
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Rudz-uSdWHM
> ---
> **References**
> ---
</details>

## Source Listing

<details>
<summary>Show source code in debugging session?</summary>

> `list` displays 10 lines of source code. To see how many lines of source code
> will be displayed enter `show listsize`. To adjust the lines of source code
> displayed enter `set listsize 20`.
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 7
> ---
> **References**
> ---
</details>

## Breakpoints

<details>
<summary>How many breakpoints does GDB offer?</summary>

> 1. Hardware watchpoints: `watch foo`
> 2. Software watchpoints: `watch $rax`
> 3. Location watchpoints: `watch -l foo`
> 4. Read-only watchpoint: `rwatch foo`
> 5. Access watchpoints: `awatch foo`
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #7

> **References**
> ---
</details>

<details>
<summary>Get information about breakpoints, watchpoints and catchpoints?</summary>

> ```gdb
> (gdb) info breakpoints
> ``````
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #13

> **References**
> ---
</details>

## Breakpoint Creation

<details>
<summary>Set breakpoints on a program?</summary>

> ```gdb
> (gdb) break 50
> (gdb) break *main
> (gdb) break *main+50
> (gdb) break source.cpp:main+50
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 7
> ---
> **References**
> ---
</details>

<details>
<summary>Run program with an immediate stop on main function?</summary>

> Use `start` to put temporary breakpoint on main and then run the program or
> `starti` to stop at the very first instruction of the program.
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #4
> ---
> **References**
> ---
</details>

<details>
<summary>Use regex to select multiple breakpoints for an operation?</summary>

> ```gdb
> (gdb) rbreak std::sto[ifd]
> ``````
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #14
> ---
> **References**
> ---
</details>

## Breakpoint Removal

<details>
<summary>Delete a breakpoint from a program?</summary>

> ```gdb
> (gdb) delete 1
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 7
> ---
> **References**
> ---
</details>

## Breakpoint Conditional

<details>
<summary>Set condition for a breakpoint?</summary>

> ```gdb
> (gdb) condition 3 e == 42
> (gdb) break func(long) if e == 42
> ``````
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #15
> ---
> **References**
> ---
</details>

<details>
<summary>Conditionally break execution only when iteration index has increased to 3?</summary>

> ```gdb
> (gdb) break source.cpp:10 if index == 3
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Rudz-uSdWHM
> ---
> **References**
> ---
</details>

## Breakpoint Skipping

<details>
<summary>Skip over a number of breakpoint hits?</summary>

> To ignore the next 10000000 times that breakpoint 1 is hit.
>
> ```gdb
> (gdb) ignore 1 10000000
> (gdb) info break 1
> ``````
>
> breakpoint already hit 1000 times
>
> ```gdb
> (gdb) ignore 1 999
> (gdb) run
> ``````
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #5
> - GDB Tips by Greg Law - Tip #6
> ---
> **References**
> ---
</details>


## Breakpoint Availability

<details>
<summary>Disable an already existing breakpoint?</summary>

> ```gdb
> (gdb) disable <breakpoint index>
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Rudz-uSdWHM
> ---
> **References**
> ---
</details>

<details>
<summary>Enable an already disabled breakpoint?</summary>

> ```gdb
> (gdb) enable <breakpoint index>
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Rudz-uSdWHM
>
> ---
> **References**
> ---
</details>

## Breakpoint Saving

<details>
<summary>Save breakpoints of a debugging session?</summary>

> ```gdb
> (gdb) save breakpoints program.gdb
> ``````
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #13
> - GDB Tips by Greg Law - Tip #61
> - https://www.youtube.com/watch?v=Rudz-uSdWHM
> ---
> **References**
> ---
</details>

<details>
<summary>Restore saved breakpoints on a debugging session?</summary>

> ```gdb
> (gdb) source program.gdb
> ``````
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #61
> - https://www.youtube.com/watch?v=Rudz-uSdWHM
> ---
> **References**
> ---
</details>

<details>
<summary>Manually write the content of a file in which breakpoints were saved?</summary>

> ```gdb
> (gdb) break source.cpp:8
> (gdb) break source.cpp:22
> ``````
>
> Note that lines might have been changed during sessions.
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Rudz-uSdWHM
> ---
> **References**
> ---
</details>

## Watchpoint Creation

<details>
<summary>Watch changes of a variable only when a criteria is met?</summary>

> `(gdb) watch foo[90].number if bar[90].number == 255`
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #7
> ---
> **References**
> ---
</details>

<details>
<summary>Track a particular location in memory rather than the value of an expression?</summary>

> ```gdb
> (gdb) watch -l expression
> ``````
>
> Convinience variables also work nicely with location watchpoints:
>
> ```gdb
> (gdb) print * __errno_location()
> $2 = 0
> (gdb) watch -l $2
> ``````
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #9
> - GDB Tips by Greg Law - Tip #10
> ---
> **References**
> ---
</details>

## Execution Flow

<details>
<summary>Step through program execution in debugging session?</summary>

> - `continue`: Will resume the execution of the program until it completes.
> - `step`: Executes program one more step. Step might be one line of source
>   code or one machine instruction.
> - `next`: Executes program similar to `step`, but it only continues to the
>   next line in the current stack frame and will not step into functions.
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 7
> ---
> **References**
> ---
</details>

## Memory Examination

<details>
<summary>Examine a memory address or register?</summary>

> Display the memory contents at a given address using `x [address]` short for
> `examine`. You can customise the output with an optional format and length
> argument.
>
> ```gdb
> (gdb) x/[length][format] [address]
> (gdb) x/2x 0x0ffffffff7c544f0
> (gdb) x/2x $rsp
> ``````
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #63
> ---
> **References**
> ---
</details>

## Thread Tracking

<details>
<summary>Get information of threads?</summary>

> To get information about the spawned threads:
>
> ```gdb
> (gdb) info threads
> ``````
>
> This will show thread ID, how the OS sees them, and the name the thread was
> given by the program.
>
> Stepping through a thread that releases other threads, gets all threads out
> of sync. This can be changed with `set scheduler-locking on`, meaning only
> the current thread will run. Beware of deadlock through, the thread you're
> running might block on a lock held by another not running thread.
>
> A middle ground can be found with `set scheduler-locking step`, which has
> scheduler-locking on when using `step`, but disables it when you use
> `continue`, allowing you to travel between breakpoints without having to
> constantly switch between the threads.
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #64
>
> ---
> **References**
> ---
</details>

## Backtrace

<details>
<summary>List the innermost or outermost frames of backtrace?</summary>

> If you want to examine the backtrace of multiple frames but you're very deep
> in the stack, you can use `backtrace n` to show the n innermost frames.
> Similarly, you can use `stacktrace -n` to show the n outermost frames.
>
> ```gdb
> (gdb) bt full
> (gdb) bt 1
> (gdb) bt -1
> ``````
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #59
> ---
> **References**
> ---
</details>

## Core Dump Control

<details>
<summary>Where the coredumps are stored?</summary>

> ```sh
> coredumpctl list
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Rudz-uSdWHM

> **References**
> ---
</details>

<details>
<summary>Store the core dump of your program into a file?</summary>

> ```sh
> coredumpctl dump $PWD/program --output program.core
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Rudz-uSdWHM
> ---
> **References**
> ---
</details>

<details>
<summary>Load the stored coredump into debugging session?</summary>

> ```gdb
> (gdb) target core program.core
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Rudz-uSdWHM

> **References**
> ---
</details>

<details>
<summary>Select a core section to inspect the cause of termination?</summary>

> When frame is selected from a core dump, program will be set to the
> corresponding state.
>
> ```gdb
> (gdb) frame 0
> (gdb) p variable_causing_trouble
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Rudz-uSdWHM
> ---
> **References**
> ---
</details>

## Core Dump Generation

<details>
<summary>Create a core dump from the state of an executable in debugging session?</summary>

> ```gdb
> (gdb) gcore program.core
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Rudz-uSdWHM

> **References**
> ---
</details>

## Memory Inspection

<details>
<summary>Print the value of an object?</summary>

> ```gdb
> (gdb) print bag_size
> ```````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 7
> ---
> **References**
> ---
</details>

<details>
<summary>Inspect the type of a variable?</summary>

> ```gdb
> (gdb) whatis random_number
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 7
>
> ---
> **References**
> ---
</details>

## Memory Modification

<details>
<summary>Modify the value of a variable?</summary>

> ```gdb
> (gdb) set var random_number = 5
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 7
> ---
> **References**
> ---
</details>

## Shell Command Execution

<details>
<summary>Run shell commands in debugging session?</summary>

> ```gdb
> (gdb) shell pwd
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 7
> ---
> **References**
> ---
</details>

## Debugger Configuration

<details>
<summary>Automatically run commands on GDB startup?</summary>

> If you have commands you want to run every time you debug, or if you want to
> definne a function to pretty print a specific data structure, you can put
> them in `.gdbinit` file on the top project directory, or in your home
> directory.
>
> *.gdbinit*
> ```gdb
> set logging enabled on
> ``````
>
> You may need to enable auto-loading for the directory by adding the following line in `~/.config/gdb/gdbinit` file.
>
> ```gdb
> set auto-load-safe-path /path/to/dir
> ``````
>
> You can also enable it for all directories with `set auto-load-safe-path /`.
>
> ---
> **Resources**
> - GDB Tips by Greg Law - Tip #62

> **References**
> ---
</details>
