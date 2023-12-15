# Valgrind

## Memcheck

<details>
<summary>Check for memory leaks of a program?</summary>

> Valgrind is capable of checking for memory leaks on a binary file.
>
> ```sh
> gcc -o program main.c
> valgrind ./program
> ``````
>
> To have a better output from Valgrind, compile with debug info:
>
> ```sh
> gcc -o program main.c -g3
> valgrind ./program
> ``````

> Origins:
> - YouTube: C++ Weekly - Ep 86 - Valgrind

> References:
---
</details>

<details>
<summary>Trace the origin of variables causing memory leaks?</summary>

> ```sh
> valgrind --track-origins ./program
> ``````

> Origins:
> - YouTube: C++ Weekly - Ep 86 - Valgrind

> References:
---
</details>

<details>
<summary>Fully check for memory leak of a program?</summary>

> ```sh
> valgrind --leak-check full ./program
> ``````

> Origins:
> - YouTube: Detecting Memory Leaks With Valgrind

> References:
---
</details>

## Helgrind

## Callgrind

<details>
<summary>Count the number of instructions used in a program?</summary>

> ```sh
> valgrind --tool callgrind ./program
> ``````

> Origins:
> - YouTube: C++ Weekly - Ep 86 - Valgrind

> References:
---
</details>

<details>
<summary>Use interactive control to use callgrind dump file?</summary>

> ```sh
> ``````

> Origins:
> - YouTube: C++ Weekly - Ep 86 - Valgrind

> References:
---
</details>

<details>
<summary>Use a user interface to interactively control the use of callgrind dump file?</summary>

> ```sh
> kcachegrind callgrind-dump.out.123
> ``````

> Origins:
> - YouTube: C++ Weekly - Ep 86 - Valgrind

> References:
---
</details>

## Running with GDB

<details>
<summary>Attach gdb remote session to valgrind?</summary>

> ```sh
> gdb ./program
> (gdb) set remote exec-file ./program
> (gdb) set sysroot /
> (gdb) target extended-remote | vgdb --multi --vargs -q
> (gdb) start
> (gdb) help valgrind
> (gdb) help memcheck
> (gdb) help helgrind
> ``````

> Origins:
> - YouTube: Debugging memory issues with Valgrind and GDB - DevConf.CZ 2023
</details>
