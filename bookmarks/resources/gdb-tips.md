# GNU Debugger Tips

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
> > You can use the readelf utility to look at the debug info.

> Origin: 1

> References:
---
</details>

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
> The shortcut `ctrl–x+a` will also start the TUI.
>
> `ctrl+l` to redraw the screen reset in TUI mode.

> Origin: 2

> References:
---
</details>

<details>
<summary>Cycle through assembly and source code windows in GDB TUI?</summary>

> `ctrl-x+2`

> Origin: 3

> References:
---
</details>

<details>
<summary>Switch focus between GDB TUI windows?</summary>

> ```gdb
> (gdb) focus src
> (gdb) focus cmd
> ``````

> Origin: 3

> References:
---
</details>

<details>
<summary>Navigate through command history?</summary>

> - `ctrl-p` for previous commands
> - `ctrl-n` for next commands

> Origin: 3

> References:
---
</details>

<details>
<summary>Set breakpoint on main function and run the program in GDB?</summary>

> Use `start` to put temporary breakpoint on main and then run the program or
> `starti` to stop at the very first instruction of the program.

> Origin: 4

> References:
---
</details>

<details>
<summary>Skip over a number of breakpoint hits?</summary>

> To ignore the next 10000000 times that breakpoint 1 is hit.
>
> ```gdb
> (gdb) ignore 1 10000000
> (gdb) info break 1
> breakpoint already hit 1000 times
> (gdb) ignore 1 999
> (gdb) run
> ``````

> Origin:
> - 5
> - 6

> References:
---
</details>

<details>
<summary>Watch changes of a variable only when a criteria is met?</summary>

> `(gdb) watch foo[90].number if bar[90].number == 255`

> Origin: 7

> References:
---
</details>

<details>
<summary>How many breakpoints does GDB offer?</summary>

> 1. Hardware watchpoints: `watch foo`
> 2. Software watchpoints: `watch $rax`
> 3. Location watchpoints: `watch -l foo`
> 4. Read-only watchpoint: `rwatch foo`
> 5. Access watchpoints: `awatch foo`

> Origin: 7

> References:
---
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

> Origins:
> - 9
> - 10

> References:
---
</details>

<details>
<summary>Get information about watchpoints and catchpoints?</summary>

> ```gdb
> (gdb) info breakpoints
> ``````

> Origin: 13

> References:
---
</details>

<details>
<summary>Save breakpoints to a file for future debug sessions?</summary>

> ```gdb
> (gdb) save breakpoints
> ``````

> Origin: 13

> References:
---
</details>

<details>
<summary>Use regex to select multiple breakpoints for an operation?</summary>

> ```gdb
> (gdb) rbreak std::sto[ifd]
> ``````

> Origin: 14

> References:
---
</details>

<details>
<summary>Set condition for a breakpoint?</summary>

> ```gdb
> (gdb) condition 3 e == 42
> (gdb) break func(long) if e == 42
> ``````

> Origin: 15

> References:
---
</details>

