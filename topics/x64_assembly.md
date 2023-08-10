# x64 Assembly

<details>
<summary>Compile an x64 assembly program?</summary>

> ```nasm
> section .data
>     message db "sample assembly program", 10, 0
>     length equ $ - message
>
> section .bss
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, 1
>     mov rdi, 1
>     mov rsi, message
>     mov rdx, length
>     syscall
>
>     mov rsp, rbp
>     pop rbp
>
>     mov rax, 60
>     mov rdi, 0
>     syscall
> ``````

> ```make
> sample: sample.o
>     gcc -Wall -g3 -Og -no-pie sample.o -o sample
> sample.o: sample.asm
>     nasm -f elf64 -g -F dwarf sample.asm -l sample.lst
> ``````

> References:
> - [nasm reference manual](https://www.nasm.us/doc/)
> - [gcc reference manual](https://gcc.gnu.org/onlinedocs/)
> - [make reference manual](https://www.gnu.org/software/make/manual/html_node/)
---
</details>

<details>
<summary>Write exit procedure in x64 Assembly?</summary>

> ```nasm
> section .data
> section .bss
> section .text
>     global main
>
> main:
>     mov rax, 60
>     mov rdi, 0
>     syscall
> ``````

> Origin: 1

> References:
---
</details>

<details>
<summary>Convert decimal, binary, and hexadecimal representations of integral and floating point numbers?</summary>

>

> Origin: 2

> References:
> - [IEEE-754](https://www.geeksforgeeks.org/ieee-standard-754-floating-point-numbers/)
---
</details>

<details>
<summary>Name x64 registers?</summary>

> * rax
> * rbx
> * rcx
> * rdx
> * rsi
> * rdi
> * rbp
> * rsp
> * r8
> * r9
> * r10
> * r11
> * r12
> * r13
> * r14
> * r15

> Origin: 2

> References:
---
</details>

<details>
<summary>What is the name of <b>Instruction Pointer</b> register?</summary>

> `rip`

> Origin: 2

> References:
---
</details>

<details>
<summary>Name the flag registers?</summary>

> Name|Symbol|Bit|Content
> ---|---|---|---
> Carry|CF|0|Previous instruction had a carry
> Parityp|F|2|Last byte has even number of 1s
> Adjust|AF|4|BCD operations
> Zero|ZF|6|Previous instruction resulted a zero
> Sign|SF|8|Previous instruction resulted in most significant bit equal to 1
> Direction|DF|10|Direction of string operations (increment or decrement)
> Overflow|OF|11|Previous instruction resulted in overflow

> Origin: 2

> References:
---
</details>

<details>
<summary>Name SIMD registers?</summary>

> `xmm`
> `ymm`
> `zmm`

> Origin: 2

> References:
---
</details>

<details>
<summary>Debug a compiled program with gdb?</summary>

> ```sh
> gdb --quiet executable
> ``````

> Origin: 3

> References:
> - [GDB User Manual](https://sourceware.org/gdb/current/onlinedocs/gdb/)
---
</details>

<details>
<summary>List source lines in debugging?</summary>

> ```gdb
> list
> list 10
> `help list` or `h l`
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Change the line number of source listing?</summary>

> ```gdb
> show listsize
> set listsize 20
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Set disassembly flavor in gdb?</summary>

> ```gdb
> show disassembly-flavor
> set disassembly-flavor intel
> set disassembly-flavor att
> help set disassembly-flavor
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Store gdb configurations in file for future use?</summary>

> ```sh
> echo 'set disassembly-flavor intel' >> $HOME/.gdbinit
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Disassemble a function or line of source in gdb?</summary>

> ```gdb
> disassemble main
> disassemble 'path/to/source.cpp'::func
> help disassemble
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Examine an address in memory in gdb?</summary>

> ```gdb
> x/s 0x654321
> x/s &message
> x/d 0x654321
> x/x $rip
> help x
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Set breakpoints in gdb?</summary>

> ```gdb
> break main
> help break
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Start execution of the debugging program in gdb?</summary>

> ```gdb
> run
> help run
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Inspect registers in gdb?</summary>

> ```gdb
> info registers
> info all-registers
> help info registers
> help info all-registers
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Inspect the breakpoint, stack, threads and other resources of the debugging program in gdb?</summary>

> ```gdb
> info breakpoints
> info stack
> info threads
> info source
> help info breakpoints
> help info stack
> help info threads
> help info source
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Manipulate breakpoints in gdb?</summary>

> ```gdb
> disable breakpoint 1
> enable breakpoint 1
> delete breakpoint 1
> help disable breakpoint
> help enable breakpoint
> help delete breakpoint
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Change executation of the debugging program in gdb?</summary>

> ```gdb
> continue
> next
> step
> help continue
> help next
> help step
> help finish
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Print variables through debugging session?</summary>

> ```gdb
> print
> help print
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Enable TUI in gdb:</summary>

> ```gdb
> tui enable
> help tui
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Create values in data section of memory?</summary>

> ```nasm
> section .data
>     message db "sample program", 10, 0
>     message_length equ $ - message - 1
>     pi dq 3.14
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; write
>     mov rax, 1
>     mov rdi, 1
>     mov rsi, message
>     mov rdx, message_length
>     syscall
>
>     mov rsp, rbp
>     pop rbp
>
>     ; exit
>     mov rax, 60
>     mov rdi, 0
>     syscall
> ``````

> Origin: 4

> References:
---
</details>

<details>
<summary>Use external functions from C in x64 assembly code?</summary>

> ```nasm
> extern printf
>
> section .data
>     string_fmtstr db "%s", 10, 0
>     string db "sample program", 0
>
>     integer_fmtstr db "%d", 10, 0
>     number dd 37
>
>     float_fmtstr db "%2.6f", 10, 0
>     pi dq 3.141592
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; printf
>     mov rax, 0 ; do not use xmm registers
>     mov rdi, string_fmtstr
>     mov rsi, string
>     call printf
>
>     ; printf
>     mov rax, 0 ; do not use xmm registers
>     mov rdi, integer_fmtstr
>     mov rsi, [number]
>     call printf
>
>     ; printf
>     mov rax, 1 ; use xmm registers
>     movq xmm0, [pi]
>     mov rdi, float_fmtstr
>     call printf
>
>     ; exit
>     mov rax, 60
>     mov rdi, 0
>     syscall
> ``````

> Origin: 4

> References:
---
</details>

<details>
<summary>Exit program without directly writing the exit syscall?</summary>

> ```nasm
> section .text
>     global main
>
> main:
>     ret
> ``````

> Origin: 4

> References:
---
</details>

