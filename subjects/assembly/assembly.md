# x64 Assembly
[Resources](README.md)

## Compiling with NASM

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
>
> ```make
> sample: sample.o
>     gcc -Wall -g3 -Og -no-pie sample.o -o sample
> sample.o: sample.asm
>     nasm -f elf64 -g -F dwarf sample.asm -l sample.lst
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3

> **References**
> - https://www.nasm.us - https://www.nasm.us/doc/
> - https://gcc.gnu.org - https://gcc.gnu.org/onlinedocs/
> - https://www.gnu.org - https://www.gnu.org/software/make/manual/html_node/
---
</details>

## Debugging with GNU Debugger

<details>
<summary>Debug a compiled program with gdb?</summary>

> ```sh
> gdb --quiet executable
> ``````

> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3

> **References**
> - https://sourceware.org - https://sourceware.org/gdb/current/onlinedocs/gdb/
> ---
</details>

<details>
<summary>List source lines in debugging?</summary>

> ```gdb
> list
> list 10
> `help list` or `h l`
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Change the line number of source listing?</summary>

> **Description**
>
> ```gdb
> show listsize
> set listsize 20
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Set disassembly flavor in gdb?</summary>

> ```gdb
> show disassembly-flavor
> set disassembly-flavor intel
> set disassembly-flavor att
> help set disassembly-flavor
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Store gdb configurations in file for future use?</summary>

> ```sh
> echo 'set disassembly-flavor intel' >> $HOME/.gdbinit
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Disassemble a function or line of source in gdb?</summary>

> ```gdb
> disassemble main
> disassemble 'path/to/source.cpp'::func
> help disassemble
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Set breakpoints in gdb?</summary>

> **Description**
>
> ```gdb
> break main
> help break
> ``````
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Start execution of the debugging program in gdb?</summary>

> ```gdb
> run
> help run
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Inspect registers in gdb?</summary>

> **Description**
>
> ```gdb
> info registers
> info all-registers
> help info registers
> help info all-registers
> ``````
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Manipulate breakpoints in gdb?</summary>

> **Description**
>
> ```gdb
> disable breakpoint 1
> enable breakpoint 1
> delete breakpoint 1
> help disable breakpoint
> help enable breakpoint
> help delete breakpoint
> ``````
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
> ---
> **References**
> ---
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
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Print variables through debugging session?</summary>

> **Description**
>
> ```gdb
> print
> help print
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Enable TUI in gdb:</summary>

> ```gdb
> tui enable
> help tui
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 3
>
> ---
> **References**
> ---
</details>

## Analyzing Binary Objects

<details>
<summary>Read the ELF header of an executable object?</summary>

> **Description**
>
> ```sh
> readelf --file-header ./program
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 8
> ---
> **References**
> ---
</details>

<details>
<summary>Read symbols of an executable object?</summary>

> **Description**
>
> ```sh
> readelf --symbols ./program | grep -E 'main|start|Num:.*' --color
> ``````
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 8
> ---
> **References**
> ---
</details>

<details>
<summary>Sort executable object symbols based on its memory locations?</summary>

> ```sh
> readelf --symbols ./program | sort -k 2 -r
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 8
>
> ---
> **References**
> ---
</details>

## Numeric Representations

<details>
<summary>Convert decimal, binary, and hexadecimal representations of integral and floating point numbers?</summary>

>
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 2
>
> ---
> **References**
> - https://www.geeksforgeeks.org - https://www.geeksforgeeks.org/ieee-standard-754-floating-point-numbers/
> ---
</details>

<details>
<summary>Indicate that a literal number is in octal base in x64 assembly?</summary>

> By appending `q` to the number.
>
> ```nasm
> section .data
>     O_CREATE equ 00000100q
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Indicate that a literal number is in hexadecimal base in x64 assembly?</summary>

> By appending an `h` at the end of a number:
>
> ```nasm
> 2000000h
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 25
>
> ---
> **References**
> ---
</details>

## Registers

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
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What is the name of <b>Instruction Pointer</b> register?</summary>

> `rip`
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Name the flag registers?</summary>

> **Description**
>
> Name|Symbol|Bit|Content
> ---|---|---|---
> Carry|CF|0|Previous instruction had a carry
> Parityp|F|2|Last byte has even number of 1s
> Adjust|AF|4|BCD operations
> Zero|ZF|6|Previous instruction resulted a zero
> Sign|SF|8|Previous instruction resulted in most significant bit equal to 1
> Direction|DF|10|Direction of string operations (increment or decrement)
> Overflow|OF|11|Previous instruction resulted in overflow
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Name SIMD registers?</summary>

> **Description**
>
> `xmm`
> `ymm`
> `zmm`
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 2
> ---
> **References**
> ---
</details>

## Invoking System Calls

<details>
<summary>What header contains Linux system calls?</summary>

> `/usr/include/asm/unistd_64.h`
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Write exit procedure in x64 Assembly?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Exit program without directly writing the exit syscall?</summary>

> **Description**
>
> ```nasm
> section .text
>     global main
>
> main:
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 4
>
> ---
> **References**
> ---
</details>

## Memory Sections

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
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 4
> ---
> **References**
> ---
</details>

<details>
<summary>Consecutively store a sequence of data into read-only memory section?</summary>

> ```nasm
> section .data
>     word_array times 5 dw 0 ; array of 5 words containing 0
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 8
> ---
> **References**
> ---
</details>

<details>
<summary>Preserve uninitialized variables in a writable memory section?</summary>

> **Description**
>
> ```nasm
> section .bss
>     bvar resb 10
>     wvar resw 5
>     dvar resd 1
>     qvar resq 100
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 8
> ---
> **References**
> ---
</details>

## External Functions

<details>
<summary>Use external functions from C in x64 assembly code?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 4
> ---
> **References**
> ---
</details>

## Integral Arithmetic Operations

<details>
<summary>Add and subtract two integral integers?</summary>

> **Description**
>
> ```nasm
> section .data
>     number1 dq 36
>     number2 dq 3
>
> section .bss
>     result resq 1
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; addition
>     mov rax, [number1]
>     add rax, [number2]
>     mov [result], rax ; 39
>
>     ; subtration
>     mov rax, [number1]
>     sub rax, [number2]
>     mov [result], rax ; 33
>
>     mov rsp, rbp
>     pop rbp
>
>     xor rax, rax
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 9
> ---
> **References**
> ---
</details>

<details>
<summary>Increment and decrement a value stored on a writable variable?</summary>

> ```nasm
> section .data
>     number1 dq 36
>     number2 dq 3
>
> section .bss
>     result resq 1
>     modulo resq 1
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; increment
>     mov rax, [number1]
>     inc rax
>     mov [result], rax
>
>     ; decrement
>     mov rax, [number1]
>     dec rax
>     mov [result], rax
>
>     mov rsp, rbp
>     pop rbp
>
>     xor rax, rax
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 9
>
> ---
> **References**
> ---
</details>

<details>
<summary>Shift arithmetic values stored in writable variables?</summary>

> ```nasm
> section .data
>     number1 dq 36
>     number2 dq 3
>
> section .bss
>     result resq 1
>     modulo resq 1
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; shift arithmetic left
>     mov rax, [number1]
>     sal rax, 2 ; multiply by 4
>     mov [result], rax
>
>     ; shift arithmetic right
>     mov rax, [number1]
>     sar rax, 2 ; divide by 4
>     mov [result], rax
>
>     mov rsp, rbp
>     pop rbp
>
>     xor rax, rax
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 9
> ---
> **References**
> ---
</details>

<details>
<summary>Multiply and divide two integral integers?</summary>

> **Description**
>
> * `mul` multiplies unsigned integers
> * `imul` multiplies signed integers
> * `imul` will store the lower 64 bits of the resulting product in rax and the
>   upper 64 bits in rdx.
> * `idiv` will divide the dividen in rdx:rax by the divisor in the source
>   operand and store the integer result in rax.
>
> ```nasm
> section .data
>     number1 dq 36
>     number2 dq 3
>
> section .bss
>     result resq 1
>     modulo resq 1
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; multiply
>     mov rax, [number2]
>     imul qword[number2] ; multiplly rax with number2
>     mov [result], rax
>
>     ; divide
>     mov rax, [number1]
>     mov rdx, 0 ; division uses rdx:rax convention
>     idiv qword[number2]
>     mov [result], rax
>     mov [modulo], rdx
>
>     mov rsp, rbp
>     pop rbp
>
>     xor rax, rax
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 9
> ---
> **References**
> ---
</details>

## Floating Point Arithmetic Operations

<details>
<summary>Specify how many bits each floating point number occupies for exponent and fraction?</summary>

> A single-precision number is 32 bits, 1 sign bit, 8 exponent bits, and 23
> fraction bits.
>
> ```txt
> S   EEEEEEEE        FFFFFFFFFFFFFFFFFFFFFFF
> 0   1      8        9                     31
> ``````
>
> A double-precision number is 64 bits, 1 sign bit, 11 exponent bits, and 52
> fraction bits.
>
> ```txt
> S   EEEEEEEEEEE     FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
> 0   1         11    12                                                 63
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 11
> ---
> **References**
> ---
</details>

<details>
<summary>Add and subtract two floating point numbers?</summary>

> * Single precision floating point arithmetic instructions are postfixed with ss
> * Double precision floating point arithmetic instructions are postfixed with sd
>
> ```nasm
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; sum floating-point numbers
>     movsd xmm0, [number1]
>     addsd xmm0, [number2]
>
>     ; difference
>     movsd xmm0, [number1]
>     subsd xmm0, [number2]
>
>     mov rsp, rbp
>     pop rbp
>
>     xor rax, rax
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 11
>
> ---
> **References**
> ---
</details>

<details>
<summary>Multiply and divide two floating point numbers?</summary>

> **Description**
>
> * Single precision floating point arithmetic instructions are postfixed with ss
> * Double precision floating point arithmetic instructions are postfixed with sd
>
> ```nasm
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; multiplication
>     movsd xmm0, [number1]
>     mulsd xmm0, [number2]
>
>     ; division
>     movsd xmm0, [number1]
>     divsd xmm0, [number2]
>
>     mov rsp, rbp
>     pop rbp
>
>     xor rax, rax
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 11
> ---
> **References**
> ---
</details>

<details>
<summary>Calculate the square root of a floating point number?</summary>

> * Single precision floating point arithmetic instructions are postfixed with ss
> * Double precision floating point arithmetic instructions are postfixed with sd
>
> ```nasm
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; square root
>     sqrtsd xmm0, [number1]
>
>     mov rsp, rbp
>     pop rbp
>
>     xor rax, rax
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 11
> ---
> **References**
> ---
</details>

## Bitwise Operations

<details>
<summary>Evaluate bit-wise operations?</summary>

> * `shl` and `sal` shift left but `sal` has sign extension.
> * `shr` and `sar` shift right but `sar` has sign extension.
>
> ```nasm
> section .data
>     number1 db 6        ; 00000110
>     number2 db 10       ; 00001010
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, number1
>     xor rax, number2    ; 00001100
>
>     mov rax, number1
>     or  rax, number2    ; 00001110
>
>     mov rax, number1
>     and rax, number2    ; 00000010
>
>     mov rax, number1
>     not rax             ; 11111001
>
>     mov rax, number1
>     shl rax, 5          ; 11000000
>
>     mov rax, number1
>     shr rax, 3          ; 00000001
>
>     mov rax, number1
>     sal rax, 2          ; 00001100
>
>     mov rax, number1
>     sar rax, 2          ; 00000011
>
>     mov rax, number1
>     rol rax, 3          ; 00011000
>
>     mov rax, number1
>     ror rax, 3          ; 10000001
>
>     mov rsp, rbp
>     pop rbp
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 16
>
> ---
> **References**
> ---
</details>

<details>
 <summary>Set and reset specific bits of numeric variable?</summary>

> ```nasm
> section .data
>    variable dq 0
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; set bit 4
>     bts qword [variable], 4
>
>     ; set bit 7
>     bts qword [variable], 7
>
>     ; set bit 8
>     bts qword [variable], 8
>
>     ; reset bit 7
>     btr qword [variable], 7
>
>     xor rax, rax
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 17
> ---
> **References**
> ---
</details>

<details>
<summary>Check if its 8th bit of a quadword variable is set?</summary>

> ```nasm
> section .data
>     variable dq 0
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; reset higher memory to use lower memory for comparison
>     xor rdi, rdi
>     mov rax, 8
>
>     ; check if 8th bit is set by checking carry flag
>     ; 1 if bit is set and 0 otherwise
>     bt [variable], rax
>     setc dil
>
>     xor rax, rax
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 17
> ---
> **References**
> ---
</details>

## Execution Flow Control

<details>
<summary>Conditionally change the execution flow?</summary>

> **Description**
>
> * je: jump if equal
> * jne: jump if not equal
> * jg: jump if greater
> * jge: jump if greater or equal
> * jl: jump if lower
> * jle: jump if lower or equal
> * ja: jump if above
> * jae: jump if above or equal
> * jb: jump if below
> * jbe: jump if below or equal
>
> ```nasm
> extern printf
>
> section .data
>     numerator dq 5
>     denominator dq 6
>     greater_str db "greater", 10, 0
>     less_str db "less", 10, 0
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, [numerator]
>     mov rbx, [denominator]
>     cmp rax, rbx
>     jge greater
>
>     mov rax, 0
>     mov rdi, greater_str
>     call printf
>     jmp exit
>
> greater:
>     mov rax, 0
>     mov rdi, less_str
>     call printf
>
> exit:
>     xor rax, rax
>     mov rsp, rbp
>     pop rbp
>     ret
> ``````
>
> ```gdb
> break main
> run
> next
> info rflags
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 7
>
> ---
> **References**
> ---
</details>

## Repeating Execution

<details>
<summary>Repeat execution of a code section by manually counting down?</summary>

> ```nasm
> extern printf
>
> section .data
>     counter dq 3
>     fmt db "%d", 10, 0
>
> section .text
>     global main
>
> main:
>     ; make stack frame
>     push rbp
>     mov rbp, rsp
>
>     ; store initial value
>     mov rcx, [counter]
>
>     ; print initial value
>     mov rax, 0
>     mov rdi, fmt
>     mov rsi, rcx
>     call printf
>
> repeat:
>     ; repeat decrementing until value reached zero
>     dec rcx
>     cmp rcx, 0
>     jne repeat
>
>     ; print result
>     mov rax, 0
>     mov rdi, fmt
>     mov rsi, rcx
>     call printf
>
>     ; remove stack frame
>     mov rsp, rbp
>     pop rbp
>
>     ; return zero value
>     xor rax, rax
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 7
> ---
> **References**
> ---
</details>

<details>
<summary>Repeat execution of a code section by automatically counting down?</summary>

> **Description**
>
> ```nasm
> extern printf
>
> section .data
>     fmt db "%i", 10, 0
>     initial dq 3
>
> section .text
>     global main
>
> main:
>     ; make stack frame
>     push rbp
>     mov rbp, rsp
>
>     ; assign initial value
>     mov rcx, [initial]
>
>     ; print initial value
>     xor rax, rax
>     mov rdi, fmt
>     mov rsi, rcx
>     call printf
>
>     ; printf modified rcx
>     mov rcx, [initial]
>
> repeat:
>     ; decrement rcx until reached zero
>     loop repeat
>
>     ; print result
>     xor rax, rax
>     mov rdi, fmt
>     mov rsi, rcx
>     call printf
>
>     ; remove stack frame
>     mov rsp, rbp
>     pop rbp
>
>     ; return value
>     xor rax, rax
>     xor rdi, rdi
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 7
>
> ---
> **References**
> ---
</details>

## Memory Operations

<details>
<summary>Load the address of an array into a register to run operations on?</summary>

> ```nasm
> section .data
>     text db "abc", 0
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; load address of first character
>     lea al, [text]
>
>     ; point of second character
>     inc rax
>
>     ; load address of third character
>     lea al, [text + 2]
>
>     mov rsp, rbp
>     pop rbp
>
>     xor rax, rax
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 8
>
> ---
> **References**
> ---
</details>

## Stack Operations

<details>
<summary>Temporarily store values on memory within the scope of a function?</summary>

> **Description**
>
> ```nasm
> section .data
>     text db "Brian Salehi", 10, 0
>     length equ $ - text - 1
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; print initial sequence
>     mov rax, 1
>     mov rdi, 1
>     mov rsi, text
>     mov rdx, length
>     syscall
>
>     ; prepare for reverse operation
>     xor rax, rax
>     mov rbx, text
>     mov rcx, length
>     xor r12, r12 ; to store index
>
> store_loop:
>     ; push sequence to stack
>     mov al, byte [rbx+r12]
>     push rax
>     inc r12
>     loop store_loop
>
>     xor rax, rax
>     mov rbx, text
>     mov rcx, length
>     xor r12, r12
>
> reverse_loop:
>     ; pop sequence from stack
>     pop rax
>     mov byte [rbx+r12], al
>     inc r12
>     loop reverse_loop
>     mov byte [rbx+r12], 0
>
>     ; print reversed string
>     mov rax, 1
>     mov rdi, 1
>     mov rsi, text
>     mov rdx, length
>     syscall
>
>     mov rsp, rbp
>     pop rbp
>
>     xor rax, rax
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 10
> ---
> **References**
> ---
</details>

## Stack Alignment

<details>
<summary>Write a stack frame for a function?</summary>

> **Description**
>
> ```nasm
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     mov rsp, rbp
>     pop rbp
>
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 12
>
> ---
> **References**
> ---
</details>

<details>
<summary>Align the stack with stack frame after function call?</summary>

> Each function call results in 8 bytes return address being pushed on the
> stack. It is necessary to make sure to restore the stack to the appropriate
> value before we leave a function.
>
> ```nasm
> section .text
>     global main
>
> main:
>     push rbp
>     call func1
>     pop rbp
>     ret
>
> func1:
>     push rbp
>     call func2
>     pop rbp
>     ret
>
> func2:
>     push rbp
>     call func3
>     pop rbp
>     ret
>
> func3:
>     push rbp
>     pop rbp
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 13
> ---
> **References**
> ---
</details>

## Procedures

<details>
<summary>Abbreviate function epilogue?</summary>

> ```nasm
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 12
> ---
> **References**
> ---
</details>

<details>
<summary>Use calling convention to return error code from a function?</summary>

> Use `xmm0` register for floating-point values and `rax` register for other
> values.
>
> ```nasm
> section .data
>     val dq 0
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     call fail_func
>     xor rax, rax
>
>     call success_func
>     xor rax, rax
>
>     leave
>     ret
>
> fail_func:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, 1
>
>     leave
>     ret
>
> success_func:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, 0
>
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 12
> ---
> **References**
> ---
</details>

<details>
<summary>Use calling conventions to transfer variables from callee to caller functions?</summary>

> **Description**
>
> * Following calling conventions are for System V AMD64 ABI:
> * For integral types, registers are `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`
>   respectively, and additional arguments are passed via the stack and in
>   reverse order so that we can pop off in the right order.
> * Function's return address `rip` is pushed on the stack, just after the
>   arguments.
> * In function, then `rbp` is pushed, there maybe another 8 bytes needed to be
>   pushed to align the stack in 16 bytes.
> * For floating point types, registers are `xmm0` to `xmm7`, additional
>   arguments are passed via the stack but not with `push` instruction. Will be
>   discussed later.
>
> ```nasm
> section .text
>     global main
>
> main:
>     section .data
>         .first   dq 1
>         .second  dq 2
>         .third   dq 3
>         .forth   dq 4
>         .fifth   dq 5
>         .sixth   dq 6
>         .seventh dq 7
>         .eighth  dq 8
>         .ninth   dq 9
>         .tenth   dq 10
>
>     section .text
>         push rbp
>         mov rbp, rsp
>
>         mov rdi, .first
>         mov rsi, .second
>         mov rdx, .third
>         mov rcx, .forth
>         mov r8, .fifth
>         mov r9, .sixth
>         push .tenth
>         push .ninth
>         push .eighth
>         push .seventh
>         call func
>
> sum:
>     section .text
>                         ; first value on stack
>                         ; 8 bytes rip pushed onto stack
>         push rbp        ; 8 bytes rbp pushed onto stack
>         mov rbp, rsp
>
>         xor rax, rax
>
>         add rax, rdi
>         add rax, rsi
>         add rax, rdx
>         add rax, rcx
>         add rax, r8
>         add rax, r9
>
>         push rbx        ; preserve callee register
>         xor rbx, rbx
>
>         mov rbx, qword[rbp+16]  ; first value on stack: + rip + rbp
>         add rax, rbx    ; seventh
>
>         mov rbx, qword[rbp+24]
>         add rax, rbx    ; eighth
>
>         mov rbx, qword[rbp+32]
>         add rax, rbx    ; ningth
>
>         mov rbx, qword[rbp+40]
>         add rax, rbx    ; tenth
>
>         pop rbx         ; restore callee register
>
>         mov rsp, rbp
>         pop rbp
>         ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 15
> ---
> **References**
> ---
</details>

## Local Memory Sections

<details>
<summary>Declare function local variables?</summary>

> **Description**
>
> ```nasm
> extern printf
>
> section .data
>     radius dq 10.0
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     call area
>     call print
>
>     xor rax, rax
>     leave
>     ret
>
> area:
> section .data
>     .pi dq 3.141592     ; local to area
>
> section .text
>     push rbp
>     mov rbp, rsp
>
>     movsd xmm0, [.pi]
>     mulsd xmm0, [radius]
>     mulsd xmm0, [radius]
>
>     leave
>     ret
>
> print:
> section .data
>     .fmt db "%f", 10, 0
>
> section .text
>     push rbp
>     mov rbp, rsp
>
>     mov rax, 1
>     mov rdi, .fmt
>     call printf
>
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 12
> ---
> **References**
> ---
</details>

## External Linkage

<details>
<summary>Expose a function to external linkage?</summary>

> *arithmetic.asm*
> ```nasm
> section .text
>     global sum
>     global difference
>     global area
>
> sum:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, rdi
>     add rax, rsi
>
>     mov rsp, rbp
>     pop rbp
>     ret
>
> difference:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, rdi
>     sub rax, rsi
>
>     mov rsp, rbp
>     pop rbp
>     ret
>
> area:
>     section .data
>         .pi dq 3.141592
>
>     section .text
>         push rbp
>         mov rbp, rsp
>
>         movsd xmm1, qword[.pi]
>         mulsd xmm0, xmm0
>         mulsd xmm0, xmm1
>
>         mov rsp, rbp
>         pop rbp
>         ret
> ``````
>
> *main.asm*
> ```nasm
> extern sum
> extern difference
> extern area
>
> section .data
>     format_integral db "%i", 10, 0
>     format_floating db "%f", 10, 0
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     ; use and print the results of sum function
>     mov rdi, 1
>     mov rsi, 3
>     call sum
>
>     mov rdi, format_integral
>     mov rsi, rax
>     xor rax, rax
>     call printf
>
>     ; use and print the results of difference function
>     mov rdi, 7
>     mov rsi, 5
>     call difference
>
>     mov rdi, format_integral
>     mov rsi, rax
>     xor rax, rax
>     call printf
>
>     ; use and print the results of area function
>     mov xmm0, qword[radius]
>     call area
>
>     mov rdi, format_floating
>     mov rax, 1
>     call printf
>
>     mov rsp, rbp
>     pop rbp
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 14
> ---
> **References**
> ---
</details>

<details>
<summary>Expose a variable to external linkage?</summary>

> **Description**
>
> *header.nasm*
> ```nasm
> global pi
>
> section .data
>     pi dq 3.141592
>
> section .text
>     ...
> ``````
>
> *main.nasm*>
> ```nasm
> extern pi
>
> section .text
>     ...
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 14
> ---
> **References**
> ---
</details>

## Inline Functions

<details>
<summary>Use an assembly function in a C source?</summary>

> ```nasm
> section .text
> 	global sum
>
> sum:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, rdi
>     add rax, rsi
>
>     leave
>     ret
> ``````
>
> ```sh
> nasm -f elf64 -g -F dwarf sum.asm
> ``````
>
> ```c
> #include <stdio.h>
>
> extern int sum(int, int);
>
> int main(void)
> {
>     int result = sum(4, 2);
>     printf("%i\n", result);
> }
> ``````
>
> ```sh
> gcc -g -o program main.c sum.o
> ./program
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 22
> ---
> **References**
> ---
</details>

<details>
<summary>How many of inline assembly types are available?</summary>

> There are two types of inline assembly: **basic** and **extended**.
>
> Compilers will not optimize assembly parts of the program, so using inline
> assembly is not advices. There will be no error checking on inline assembly
> code.
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 23
> ---
> **References**
> ---
</details>

<details>
<summary>Write a basic inline assembly in C programs?</summary>

> **Description**
>
> Instructions should be terminated by `;`. `-mintel` compiler option is
> required. Switching to Intel assembly syntax is required as the first
> argument of `__asm__`.
>
> ```c
> int main(void)
> {
>     __asm__(
>         ".intel_syntax noprefix;"
>         "xor rax, rax;"
>     );
> }
> ``````
>
> ```sh
> gcc -o program main.c -masm=intel -no-pie
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 23
> ---
> **References**
> ---
</details>

<details>
<summary>Write extended inline assembly in C programs? (needs work)</summary>

> General syntax of extended inline assembly is as follows:
>
> ```c
> __asm__(
>     assembler code
>     : output operands
>     : input operands
>     : list of clobbered registers
> );
> ``````
>
> * After the assembler code, additional and optional information is used.
> * Instruction orders must be respected.
>
> ```c
> __asm__(
>     ".intel_syntax noprefix;"
>     "mov rbx, rdx;"
>     "imul rbx, rcx;"
>     "mov rax, rbx;"
>     :"=a"(eproduct)
>     :"d"(x), "c"(y)
>     :"rbx"
> );
>
> printf("The extended inline product is %i\n", eproduct);
> ``````
>
> `a`, `d`, `c` are register constraints, and they map to the registers `rax`,
> `rdx`, `rcx`, respectively. `:"=a"(eproduct)` means that the output will be
> in `rax`, and `rax` will refer to the variable `eproduct`. Register `rdx`
> refers to `x`, and `rcx` refers to `y`, which are the input variables. `rbx`
> is considered clobbered in the code and will be restored to its original
> value, because it was declared in the list of clobbering registers.
>
> ```txt
> a -> rax, eax, ax, al
> b -> rbx, ebx, bx, bl
> c -> rcx, ecx, cx, cl
> d -> rdx, edx, dx, dl
> S -> rsi, esi, si
> D -> rdi, edi, di
> r -> any register
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 23
> ---
> **References**
> ---
</details>

## Macros

<details>
<summary>Use inline procedures to avoid runtime overhead of function calls?</summary>

> **Description**
>
> ```nasm
> extern printf
>
> ; multiply value v by shifting it n times
> %define multiply(v, n) sal v, n
>
> ; having two arguments
> %macro print 2
>     section .data
>         %%detail db %1, 0
>         %%format_string db "%s: %i", 10, 0
>     section .text
>         xor rax, rax
>         mov rdi, %%format_string
>         mov rsi, %%detail
>         mov rdx, %2
>         call printf
> %endmacro
>
> section .data
>     number dq 42
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     print "value is", number
>     multiply(number, 2)
>     print "multiplication result", number
>
>     xor rax, rax
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 18
> ---
> **References**
> ---
</details>

<details>
<summary>Conditionally compile a part of x64 assembly program?</summary>

> ```nasm
> section .data
>     CONDITION equ 1
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
> %IF CONDITION
>     xor rdi, rdi
> %ELSE
>     mov rdi, 1
> %ENDIF
>
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 20
>
> ---
> **References**
> ---
</details>

## Input/Output System Calls

<details>
<summary>Write into the standard output stream?</summary>

> **Description**
>
> ```nasm
> section .text
>     global write
>
> ; preconditions:
> ; address of string be set to rsi
> ; length of string be set to rdx
> write:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, 1  ; write system call number
>     mov rdi, 1  ; stdout
>     syscall
>
>     xor rax, rax
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 19
> ---
> **References**
> ---
</details>

<details>
<summary>Read from the standard input stream?</summary>

> ```nasm
> section .text
>     global read
>
> ; preconditions:
> ; address of buffer be set to rsi
> ; length of buffer be set to rdx
> read:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, 0  ; read system call number
>     mov rdi, 0  ; stdin
>
>     xor rax, rax
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 19
> ---
> **References**
> ---
</details>

## Stack Overflow

<details>
<summary>Prevent stack overflow by counting input string before printing it?</summary>

> **Description**
>
> ```nasm
> section .text
>     global read
>
> print:
>     push rbp
>     mov rbp, rsp
>
>     push r12        ; callee saved
>
>     xor rdx, rdx    ; character counter
>     mov r12, rdi    ; string address
>
> .counter:
>     cmp byte[r12], 0
>     je .print
>
>     inc rdx
>     inc r12
>     jmp .counter
>
> .print:
>     cmp rdx, 0
>     je .exit
>
>     mov rsi, rdi    ; string address
>                     ; rdx holds string length
>     mov rax, 1      ; write
>     mov rdi, 1      ; stdout
>     syscall
>
> .exit:
>     pop r12
>     xor rax, rax
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 19
> ---
> **References**
> ---
</details>

<details>
<summary>Prevent stack overflows by limiting the maximum allowed input length from standard input?</summary>

> ```nasm
> section .text
>     global read
>
> ; \pre rdi address of string placeholder
> ; \pre rsi maximum characters to read
> ; \post rax error code
> read:
>     section .data
>         newline db 0xa
>
>     section .bss
>         .buffer resb 1      ; hold 1 character from input
>
>     section .text
>         push rbp
>         mov rbp, rsp
>
>         push r12            ; callee saved
>         push r13            ; callee saved
>         push r14            ; callee saved
>
>         mov r12, rdi        ; input string address
>         mov r13, rsi        ; max count
>         xor r14, r14        ; character counter
>
>     .read:
>         mov rax, 0          ; read
>         mov rdi, 1          ; stdin
>         lea rsi, [.buffer]  ; input address
>         mov rdx, 1          ; characters to read
>         syscall
>
>         mov al, [.buffer]   ; check if reached NL
>         cmp al, byte[newline]
>         je .check_exit
>
>         cmp al, 97          ; check if input character is lower than 'a'
>         jl .read            ; ignore this and read next character
>
>         cmp al, 122         ; check if input character is greater than 'z'
>         jg .read            ; ignore this and read next character
>
>         inc r14             ; increment counter
>
>         cmp r14, r13        ; check if number of characters reached maximum
>         ja .read            ; don't put input charater into buffer
>                             ; but keep reading from stdin to read newline
>
>         mov byte[r12], al   ; put input character into buffer
>         inc r12             ; point to next character placeholder in buffer
>         jmp .read           ; read next input character
>
>     .check_exit
>         cmp r14, 0          ; check if anything was read
>         ja .exit_success
>
>         mov rax, 1          ; return 1 when failed to read anything
>         jmp .exit
>
>     .exit_success
>         xor rax, rax        ; return 0 when read at least 0 character
>
>     .exit
>         inc r12             ; counter null character
>         mov byte[r12], 0    ; close string by putting null at the end
>         pop r14             ; restore for callee
>         pop r13             ; restore for callee
>         pop r12             ; restore for callee
>
>         leave
>         ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 19
> ---
> **References**
> ---
</details>

## Command Line Arguments

<details>
<summary>What registers are used to read command line arguments from an x64 assembly program?</summary>

> * `rdi`: argc or number of arguments
> * `rsi`: argv or address of array each, cell is an 8bytes of address to an argument string
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 21
> ---
> **References**
> ---
</details>

<details>
<summary>Read command line arguments from an x64 assembly program?</summary>

> **Description**
>
> ```nasm
> extern printf
>
> section .data
>     fmt db "%s", 10, 0
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     mov r12, rdi
>     mov r13, rsi
>     xor r14, r14
>
> .arg:
>     mov rdi, fmt
>     mov rsi, qword[r13 + r14 * 8]
>     call printf
>
>     inc r14
>     cmp r14, r12
>     jl .arg
>
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 21
> ---
> **References**
> ---
</details>

<details>
<summary>Inspect the command line arguments stored in registers in a GNU debugger?</summary>

> ```gdb
> info registers rdi rsi rsp
> x/1xg <the pointer in rdi>
> x/s <address where the pointer in rdi points to>
> x/s <address where the pointer in rdi points to + 8>
> x/s <address where the pointer in rdi points to + 16>
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 21
> ---
> **References**
> ---
</details>

## File Operations

<details>
<summary>What header contains file operation constants?</summary>

> `/usr/include/asm-generic/fcntl.h`
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Open and close a file in x64 assembly?</summary>

> **Description**
>
> ```nasm
> section .data
>     CREATE equ 1            ; use for conditional assembly
>     NR_create equ 85        ; create system call
>
> section .text
>     global create
>
> ; \pre rdi address of filename string
> ; \post rax error code
> create:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, NR_create
>     mov rsi, S_IRUSR | S_IWUSR
>     syscall
>
>     leave
>     ret
> ``````
>
> ```nasm
> section .data
>     CREATE equ 1            ; use for conditional assembly
>     NR_create equ 85        ; create system call
>
> section .text
>     global create
>
> ; \pre rdi file descriptor
> ; \post rax error code
> create:
>     push rbp
>     mov rbp, rsp
>
>     mov rax, NR_create
>     mov rsi, S_IRUSR | S_IWUSR
>     syscall
>
>     leave
>     ret
> ``````
>
> ```nasm
> extern create
> extern close
>
> section .text
>     global main
>
> main:
>     section .data
>         fd dq 0                 ; to hold file descriptor
>
>     section .text
>         push rbp
>         mov rbp, rsp
>
>     %IF CREATE
>         mov rdi, filename
>         call create
>         mov qword[fd], rax      ; save file descriptor
>     %ENDIF
>
>     %IF CLOSE
>         mov rdi, qword[fd]      ; file descriptor
>         call close
>     %ENDIF
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Write content to a file in x64 assembly?</summary>

> ```nasm
> section .data
>     CREATE equ 1            ; use for conditional assembly
>
> section .text
>     global create
>
> create:
>     push rbp
>     mov rbp, rsp
>
>     leave
>     ret
> ``````
>
> ```nasm
> extern create
> extern close
> extern write
>
> section .text
>     global main
>
> main:
>     section .data
>         fd dq 0                 ; to hold file descriptor
>
>     section .text
>         push rbp
>         mov rbp, rsp
>
>     %IF CREATE
>         mov rdi, filename
>         call create
>         mov qword[fd], rax      ; save file descriptor
>     %ENDIF
>
>     %IF WRITE
>         mov rdi, qword[fd]      ; file descriptor
>         mov rsi, text           ; address of string
>         mov rdx, qword[length]  ; length of string
>         call write
>     %ENDIF
>
>     %IF CLOSE
>         mov rdi, qword[fd]      ; file descriptor
>         call close
>     %ENDIF
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Truncate a file in x64 assembly?</summary>

> **Description**
>
> ```nasm
> section .data
>     CREATE equ 1            ; use for conditional assembly
>
> section .text
>     global create
>
> create:
>     push rbp
>     mov rbp, rsp
>
>     leave
>     ret
> ``````
>
> ```nasm
> extern create
> extern close
> extern write
>
> section .text
>     global main
>
> main:
>     section .data
>         fd dq 0                 ; to hold file descriptor
>
>     section .text
>         push rbp
>         mov rbp, rsp
>
>     %IF CREATE
>         mov rdi, filename
>         call create
>         mov qword[fd], rax      ; save file descriptor
>     %ENDIF
>
>     %IF WRITE
>         mov rdi, qword[fd]      ; file descriptor
>         mov rsi, text           ; address of string
>         mov rdx, qword[length]  ; length of string
>         call write
>     %ENDIF
>
>     %IF CLOSE
>         mov rdi, qword[fd]      ; file descriptor
>         call close
>     %ENDIF
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 20
> ---
> **References**
> ---
</details>

## Vector Registeres Support

<details>
<summary>Obtain the CPU information of the processor in x64 assembly?</summary>

> **Description**
>
> You first put a specific parameter in `eax`, then execute the instruction
> `cpuid`, and finally check the returned value in `ecx` and `edx`. Indeed,
> `cpuid` uses 32-bit registers.
>
> Based on processor manual, SSE bits are as follows:
>
> * **sse**: edx:25
> * **sse2**: edx:26
> * **sse3**: ecx:1
> * **ssse3**: ecx:1 and ecx:8
> * **sse4.1**: ecx:19
> * **sse4.2**: ecx:20
>
> ```nasm
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     mov eax, 1
>     cpuid
>
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 25
> ---
> **References**
> ---
</details>

<details>
<summary>Check the processors which version of SSE extensions do they support?</summary>

> **Description**
>
> ```nasm
> extern printf
>
> section .data
>     fmt_sse42 db "sse4_2", 10, 0
>     fmt_sse41 db "sse4_1", 10, 0
>     fmt_ssse3 db "ssse3", 10, 0
>     fmt_sse3 db "sse3", 10, 0
>     fmt_sse2 db "sse2", 10, 0
>     fmt_sse db "sse", 10, 0
>     fmt_sep db ",", 10, 0
>
> section .text
>     global main
>
> main:
>     push rbp
>     mov rbp, rsp
>
>     mov eax, 1
>     cpuid
>     mov r12, rcx      ; store the half result of cpuid
>     mov r13, rdx      ; store the half result of cpuid
>
>     call sse
>     call sse2
>     call sse3
>     call ssse3
>     call sse41
>     call sse42
>
>     xor rax, rax
>     leave
>     ret
>
> sse:
>     push rbp
>     mov rbp, rsp
>
>     ; call also be done with bt instruction: bt r13, 25
>     test r13, 2000000h  ; test bit 25
>     jz .sse_unsupported
>
>     xor rax, rax
>     mov rdi, fmt_sse
>     call printf
>
> .sse_unsupported:
>     leave
>     ret
>
> sse2:
>     push rbp
>     mov rbp, rsp
>
>     test r13, 4000000h  ; test bit 26
>     jz .sse2_unsupported
>
>     xor rax, rax
>     mov rdi, fmt_sse2
>     call printf
>
> .sse2_unsupported:
>     leave
>     ret
>
> sse3:
>     push rbp
>     mov rbp, rsp
>
>     test r12, 1         ; test bit 0
>     jz .sse3_unsupported
>
>     xor rax, rax
>     mov rdi, fmt_sse3
>     call printf
>
> .sse3_unsupported:
>     leave
>     ret
>
> ssse3:
>     push rbp
>     mov rbp, rsp
>
>     test r12, 9         ; test bit 0
>     jz .ssse3_unsupported
>
>     xor rax, rax
>     mov rdi, fmt_ssse3
>     call printf
>
> .ssse3_unsupported:
>     leave
>     ret
>
> sse41:
>     push rbp
>     mov rbp, rsp
>
>     test r12, 80000h    ; test bit 19
>     jz .sse41_unsupported
>
>     xor rax, rax
>     mov rdi, fmt_sse41
>     call printf
>
> .sse41_unsupported:
>     leave
>     ret
>
> sse42:
>     push rbp
>     mov rbp, rsp
>     test r12, 100000h   ; test bit 20
>     jz .sse42_unsupported
>
>     xor rax, rax
>     mov rdi, fmt_sse42
>     call printf
>
> .sse42_unsupported:
>     leave
>     ret
> ``````
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 25
>
> ---
> **References**
> ---
</details>

<details>
<summary>How many registers of SSE are available on any processor supporting it?</summary>

> **Description**
>
> 16 additional 128-bit registers of `xmm`:
>
> * xmm0
> * ...
> * xmm15
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 26
>
> ---
> **References**
> - https://en.wikipedia.org - https://en.wikipedia.org/wiki/Flynn's_taxonomy
> ---
</details>

<details>
<summary>What are the two types of data that can be stored on SSE registers?</summary>

> The `xmm` registers can contain **scalar data** or **packed data**.
>
> Scalar data means just one value.
> Packed data means multiple values related to each other.
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 26
> ---
> **References**
> ---
</details>

<details>
<summary>What are AVX registers and how much data can they hold?</summary>

> The **AVX** registers are called `ymm` registers and have 256 bits, double
> the size of `xmm` registers.
>
> There is also **AVX-512** which provides 512 bits registers and are called
> `zmm` registers.
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 26
> ---
> **References**
> ---
</details>

<details>
<summary>How does alignment of data in <code>.data</code> and <code>.bss</code> sections can improve performance of a program?</summary>

> Data in section `.data` and `.bss` should be aligned on a 16-byte border so
> that registers can be filled with data once for each block of data.
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 26
> ---
> **References**
> ---
</details>

<details>
<summary>How can we align data in <code>.data</code> and <code>.bss</code> sections in specific byte sizes?</summary>

> **Description**
>
> In **NASM** the assembly directive `align 16` and `alignb 16` can be used in
> front of the data.
>
> For **AVX**, data should be aligned on a 32 bytes border and for **AVX-512**,
> data needs to be aligned on a 64 bytes border.
>
> ---
> **Resources**
> - Beginning x64 Assembly Programming - Chapter 26
> ---
> **References**
> ---
</details>

