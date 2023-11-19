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

## Breakpoints

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

<details>
<summary>Delete a breakpoint from a program?</summary>

> `delete 1`

> Origins:
> - Boost.Asio C++ Network Programming - Chapter 7

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
