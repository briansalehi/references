# Software Security

## Binary Analysis

<details>
<summary>What are the main phases of compiling a C code?</summary>

> 1. Preprocessing
> 2. Compilation
> 3. Assembly
> 4. Linking

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>Stop compiler processing source after preprocessing phase?</summary>

> ```c
> #include <stdio.h>
>
> int main()
> {
>     fprintf(stdout, "Preprocessing\n");
> }
> ``````
>
> For gcc, this can be done sing the following command:
>
> ```sh
> gcc -E -P -o main.cc main.c
> ``````
>
> Where `-E` tells gcc to stop after preprocessing and `-P` causes the compiler
> to omit debugging information so that the output is a bit cleaner.

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>Specify the assembly flavor for gcc?</summary>

> ```sh
> gcc -masm intel
> gcc -masm att
> ``````

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>Stop compiler processing source after compilation phase?</summary>

> ```sh
> gcc -g -O0 -S -masm=intel -o main.s main.c
> ``````

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>Stop compiler processing source after assembly phase?</summary>

> ```cpp
> gcc -g -O0 -c -o main.o main.c
> file main.o
> ``````

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>How many relocatable files exist?</summary>

> There are position-independent (relocatable) object files which can be
> combined to form a complete binary executable. On the other hand there are
> position-independent (relocatable) executables, which you can call them apart
> from ordinary shared libraries because they have an entry point address.

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>View the symbolic information of an executable?</summary>

> ```sh
> readelf --syms a.out
> ``````

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>What formats are used to represent debugging symbols for executables?</summary>

> For ELF binaries, debugging symbols are typically generated in the DWARF
> format, while PE binaries usually use the proprietary PDB format. DWARF
> information is usually embedded within the binary, while PDB comes in the
> form of a separate symbol file.

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>What library can be used to programmatically parse debugging symbols?</summary>

> `libbfd` & `libdwarf`.

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>Strip all the debugging symbols of an executable?</summary>

> ```sh
> strip --strip-all a.out
> readelf --syms a.out
> ``````

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>Specify the assembly flavor for objdump utility?</summary>

> ```sh
> objdump -M intel
> objdump -M att
> ``````

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>Inspect the rodata section of an object file?</summary>

> The `.rodata` section contains all constants.
>
> ```sh
> objdump -sj .rodata example.o
> ``````

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>Disassembly an object file?</summary>

> ```sh
> objdump -M intel -d example.o
> ``````

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>List all the relocation symbols present in an object file?</summary>

> ```sh
> readelf --relocs example.o
> ``````

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>What address do relocation offsets are pointing to in relocation table of an object file?</summary>

> The leftmost column of each line in the `readelf --relocs` output is the
> offset in the object file where the resolved reference must be filled in. The
> offset equals to the offset of the instruction that needs to be fixed, plus
> 1. This is because you only want to overwrite the operand of the instruction,
> not the opcode of the instruction which happens to be only 1 byte. So to
> point to the instruction's operand, the relocation symbol needs to skip past
> the opcode byte.
>
> ```sh
> readelf --relocs example.o
> ``````

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

<details>
<summary>List all the available sections in an object file?</summary>

> ```sh
> readelf --sections example.o
> ``````

> Origins:
> - Practical Binary Analysis - Chapter 1

> References:
---
</details>

