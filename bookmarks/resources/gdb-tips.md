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
> The shortcut `Ctrl–x-a` will also start the TUI.

> Origin: 2

> References:
---
</details>

