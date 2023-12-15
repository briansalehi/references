# GNU Debugger

## Starting Execution

<details>
<summary>Begin debugging session of an executable?</summary>

> - `start`: starts debugging session by running program line-by-line.
> - `run`: starts debugging session running program as usual.

> Origins:
> - Boost.Asio C++ Network Programming - Chapter 7

> References:
---
</details>

## Attach Process

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

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

## Detach Process

<details>
<summary>Detach debugger from a debugging process?</summary>

> ```sh
> (gdb) detach
> ``````
>
> After detaching, the program will continue its normal flow as there was no
> debugger attached to it at first place.

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

## Stepping Through Execution

<details>
<summary>Step through program execution in debugging session?</summary>

> - `continue`: Will resume the execution of the program until it completes.
> - `step`: Executes program one more step. Step might be one line of source
>   code or one machine instruction.
> - `next`: Executes program similar to `step`, but it only continues to the
>   next line in the current stack frame and will not step into functions.

> Origins:
> - Boost.Asio C++ Network Programming - Chapter 7

> References:
---
</details>

## Source Listing

<details>
<summary>Show source code in debugging session?</summary>

> `list` displays 10 lines of source code. To see how many lines of source code
> will be displayed enter `show listsize`. To adjust the lines of source code
> displayed enter `set listsize 20`.

> Origins:
> - Boost.Asio C++ Network Programming - Chapter 7

> References:
---
</details>

## Breakpoints Creation

<details>
<summary>Set breakpoints on a program?</summary>

> ```gdb
> break 50`
> break *main
> break *main+50
> break source.cpp:main+50
> ``````

> Origins:
> - Boost.Asio C++ Network Programming - Chapter 7

> References:
---
</details>

## Breakpoints Removal

<details>
<summary>Delete a breakpoint from a program?</summary>

> `delete 1`

> Origins:
> - Boost.Asio C++ Network Programming - Chapter 7

> References:
---
</details>

## Breakpoints Conditional

<details>
<summary>Conditionally break execution only when iteration index has increased to 3?</summary>

> ```sh
> (gdb) break source.cpp:10 if index == 3
> ``````

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

## Breakpoints Availability

<details>
<summary>Disable an already existing breakpoint?</summary>

> ```sh
> (gdb) disable <breakpoint index>
> ``````

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

<details>
<summary>Enable an already disabled breakpoint?</summary>

> ```sh
> (gdb) enable <breakpoint index>
> ``````

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

## Breakpoints Saving

<details>
<summary>Save breakpoints of a debugging session?</summary>

> ```sh
> (gdb) save breakpoints program.gdb
> ``````

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

<details>
<summary>Restore saved breakpoints on a debugging session?</summary>

> ```sh
> source program.gdb
> ``````

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

<details>
<summary>Manually write the content of a file in which breakpoints were saved?</summary>

> ```
> break source.cpp:8
> break source.cpp:22
> ``````
>
> Note that lines might have been changed during sessions.

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

## Core Dump Control

<details>
<summary>Where the coredumps are stored?</summary>

> ```sh
> coredumpctl list
> ``````

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

<details>
<summary>Store the core dump of your program into a file?</summary>

> ```sh
> coredumpctl dump $PWD/program --output program.core
> ``````

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

<details>
<summary>Load the stored coredump into debugging session?</summary>

> ```sh
> (gdb) target core program.core
> ``````

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

<details>
<summary>Select a core section to inspect the cause of termination?</summary>

> When frame is selected from a core dump, program will be set to the
> corresponding state.
>
> ```sh
> (gdb) frame 0
> (gdb) p variable_causing_trouble
> ``````

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

## Core Dump Generation

<details>
<summary>Create a core dump from the state of an executable in debugging session?</summary>

> ```sh
> (gdb) gcore program.core
> ``````

> Origins:
> - YouTube: Advanced Debugging with GDB by Write your own Operating System

> References:
---
</details>

## Memory Inspection

<details>
<summary>Print the value of an object?</summary>

> `print `

> Origins:
> - Boost.Asio C++ Network Programming - Chapter 7

> References:
---
</details>

<details>
<summary>Inspect the type of a variable?</summary>

> `whatis random_number`

> Origins:
> - Boost.Asio C++ Network Programming - Chapter 7

> References:
---
</details>

## Memory Modification

<details>
<summary>Modify the value of a variable?</summary>

> `set var random_number = 5`

> Origins:
> - Boost.Asio C++ Network Programming - Chapter 7

> References:
---
</details>

## Shell Command Execution

<details>
<summary>Run shell commands in debugging session?</summary>

> `shell pwd`

> Origins:
> - Boost.Asio C++ Network Programming - Chapter 7

> References:
---
</details>
