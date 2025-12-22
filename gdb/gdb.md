# GNU Debugger
# GDB Tips
## website
## LinkedIn
### post
### Greg Law
#### surface

##### https://www.linkedin.com/posts/gregthelaw_build-for-debug-activity-6965389756427821056-325G/
###### What compiler options should be used for debugging?

To debug with GDB, compile with `-g`. This generates DWARF information, which is used by the debugger to understand what the program is doing. It doesn’t affect generated code at all, just adds debug information to the binary.

Use `-O` to compile with optimizations, but this can adversely affect the debug experience i.e. `-O` and `-g` are orthogonal and independent. To get a reasonable level of performance and a good debug experience, use `-Og`. And to get an even better debug experience, use `-g3` rather than just `-g`.

```sh
gcc -g3 -Og -o program main.cpp
```

You can use the `readelf` utility to look at the debug info:

```sh
readelf --debug-dump program
```

Learn more about build for debugging on https://hubs.ly/Q01k9ZZ_0.

##### https://www.linkedin.com/posts/gregthelaw_gdb-debugging-cplusplus-activity-6965701577579888640-rLGq/
###### Switch to a layout with source view?

TUI (Text User Interface) mode allows you to track the source code.

Start with `gdb -tui`, or type `layout src` to switch to the TUI mode. Or press `Ctrl,X,A` shortcut to switch to this layout.

```sh
gdb -tui
```

```gdb
layout src
```

##### https://www.linkedin.com/posts/gregthelaw_gdb-debugging-cplusplus-activity-6965701577579888640-rLGq/
###### Redraw gdb screen?

Ctrl+l to redraw the screen reset in TUI mode. Ctrl+x2 cycles through assembly and source code windows in TUI.

##### https://www.linkedin.com/posts/gregthelaw_gdb-debugging-cplusplus-activity-6965701577579888640-rLGq/
###### Change focus of the layout?

Use the `focus` command to switch focus between windows in TUI mode.

```gdb
focus src
focus cmd
```

To navigate through command history regardless of which window has the focus, use Crtl-P (prev) and Ctrl-N (next)

Learn more about TUI mode on my gdbWatchPoint resource portal https://hubs.ly/Q01kgjw_0

##### https://www.linkedin.com/posts/gregthelaw_gdb-debugging-cplusplus-activity-6967855364805386242-u_Xj/
###### <Card>

Use the ‘start’ command. This puts a temporary breakpoint on main and then runs the program. Or if you have no symbols, use starti to stop at the very first instruction of the program.
(gdb) starti

Follow me for more GDB debugging tips over the coming weeks!

##### https://www.linkedin.com/posts/gregthelaw_gdb-debugging-cplusplus-activity-6968212853979762690-cnj7/
###### <Card>

💡 Sharing more GDB debugging tips below... 

Use the `ignore` command to skip over a number of breakpoint hits.
(gdb) ignore 1 100000000
To ignore the next 100000000 times that breakpoint 1 is hit.

##### https://www.linkedin.com/posts/gregthelaw_gdb-debugging-cplusplus-activity-6968212853979762690-cnj7/
###### <Card>

Ignore breakpoints for a paupers’ time travel debugging:
(gdb) ignore 1 10000
(gdb) info break 1
…
 breakpoint already hit 1234 times
…
(gdb) ignore 1 1233
(gdb) run
Will stop on the 1234th invocation of foo, which is the one that crashes!

Learn more on my free C++ community resource dedicated to debugging complex C++ code 👉 https://hubs.ly/Q01kPK-t0

##### https://www.linkedin.com/posts/gregthelaw_gdb-debugging-cplusplus-activity-6968939219935199233-e27D/
###### <Card>

💡 Today a little tip about using watchpoints in GDB...

Conditional watchpoints, e.g. `watch foo if bar`: This will stop when foo changes only if bar is non-zero at that time.
(gdb) watch catch[90].number if cache[90].number == 255

GDB offers different types of watchpoints:
hardware watchpoints - e.g. watch foo
software watchpoints - e.g. watch $eax
location watchpoints - e.g. watch -l foo
read-only watchpoints - e.g. rwatch foo
access watchpoints - e.g. awatch foo. 
More on those in my next posts...

Check out my free C++ community resources for more 👉 https://hubs.ly/Q01k_J2k0 

##### https://www.linkedin.com/posts/gregthelaw_debugging-cplusplus-cpp-activity-6973311723613138944-ff6p/
###### <Card>

👉 Hardware watchpoints tracks any changes to a variable. Actually, changes to an expression. e.g. watch 𝚙->𝚊 will stop when 𝚙 changes and/or when 𝚊 changes (unless p->a evaluates to the same thing) 

Learn more at https://hubs.ly/Q01lMb2w0

##### https://www.linkedin.com/posts/gregthelaw_debugging-cplusplus-cpp-activity-6975829520087928832-C3NA/
###### <Card>

💡 GDB debugging tip of the day! 
👉 Location watchpoints: tracks a particular location in memory rather than the value of an expression. Useful to find memory corruption errors e.g. 𝚠𝚊𝚝𝚌𝚑 𝚏𝚘𝚘->𝚊 won’t stop if 𝚏𝚘𝚘 changes, only when the underlying memory does, even if, say, 𝚏𝚘𝚘 is local and goes out of scope.

Learn more on https://hubs.ly/Q01mgTt30

##### https://www.linkedin.com/posts/gregthelaw_debugging-cplusplus-cpp-activity-6976193440367656961-KC0h/
###### <Card>

💡 My GDB debugging tip today builds on yesterday's tip on location watchpoints.

👉 Location watchpoints and $1 style convenience variables work nicely together:
(𝚐𝚍𝚋) 𝚙𝚛𝚒𝚗𝚝 * __𝚎𝚛𝚛𝚗𝚘_𝚕𝚘𝚌𝚊𝚝𝚒𝚘𝚗()
$𝟸 = 𝟶
(𝚐𝚍𝚋) 𝚠𝚊𝚝𝚌𝚑 -𝚕 $𝟸
𝙷𝚊𝚛𝚍𝚠𝚊𝚛𝚎 𝚠𝚊𝚝𝚌𝚑𝚙𝚘𝚒𝚗𝚝 𝟷: -𝚕𝚘𝚌𝚊𝚝𝚒𝚘𝚗 $𝟸

Learn more on what you can do with location watchpoints on my C++ debugging resource portal called gdbWatchPoint: https://hubs.ly/Q01mnVWf0

##### https://www.linkedin.com/posts/gregthelaw_debugging-cplusplus-cpp-activity-6976596093992116224-cPrF/
###### <Card>

💡 GDB debugging tip to end a busy week at @CppCon!
👉 Software watchpoints: If GDB cannot use hardware support for watchpoints (e.g. on x86 a big or misaligned structure) it will fall back to software watchpoints. Beware though: these are very slow as GDB single-steps repeatedly to see when the data changes eg: watch $eax will use software watchpoints.

Learn more on https://hubs.ly/Q01mtHdk0 (free community resource dedicated to debugging C++!)

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6978010642771292160-9zsg/
###### <Card>

💡 My GDB debugging tip challenge continues...

👉 A breakpoint makes a program stop if a certain point in the program is reached. For each breakpoint, add conditions to control whether the program stops. Set breakpoints with the break command. A watchpoint is a special breakpoint that stops your program when the value of an expression changes. 

More on breakpoints on https://hubs.ly/Q01mtRL80

##### https://www.linkedin.com/posts/gregthelaw_debugging-cplusplus-cpp-activity-6978391633893462016-xJDo/
###### <Card>

💡On breakpoint commands in GDB...
👉 Breakpoints: If the program has multiple functions with same name but different argument types, setting a breakpoint on any one of them can be done as 𝚋𝚛𝚎𝚊𝚔 𝚏𝚞𝚗𝚌_𝚗𝚊𝚖𝚎(𝚝𝚢𝚙𝚎)

Use 𝚒𝚗𝚏𝚘 𝚋𝚛𝚎𝚊𝚔𝚙𝚘𝚒𝚗𝚝𝚜 - it gives information about watchpoints and catchpoints too!

Use 𝚜𝚊𝚟𝚎 𝚋𝚛𝚎𝚊𝚔𝚙𝚘𝚒𝚗𝚝𝚜 to save a list of breakpoints to a script for reuse in future debug sessions on the same application.

More about breakpoints at https://hubs.ly/Q01mTbbZ0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6979079204365553664-MSqr/
###### <Card>

💡 Sharing more GDB debugging tips below...

👉 GDB provides the ability to use regex to specify breakpoints using 𝚛𝚋𝚛𝚎𝚊𝚔
For example: Given two functions 𝚖𝚢_𝚏𝚞𝚗𝚌𝟷() and 𝚖𝚢_𝚏𝚞𝚗𝚌𝟸(),
𝚛𝚋𝚛𝚎𝚊𝚔 𝚖𝚢_𝚏𝚞𝚗𝚌[𝟷𝟸] creates two breakpoints, one for 𝚖𝚢_𝚏𝚞𝚗𝚌𝟷 and another for 𝚖𝚢_𝚏𝚞𝚗𝚌𝟸.

Use 𝚌𝚘𝚖𝚖𝚊𝚗𝚍 𝚌𝚖𝚍_𝚗𝚞𝚖𝚋𝚎𝚛 and list of commands to be executed on hitting a breakpoint. 
For example:
𝚌𝚘𝚖𝚖𝚊𝚗𝚍𝚜 𝟹 (bp number)
>𝚛𝚎𝚌𝚘𝚛𝚍
>𝚌𝚘𝚗𝚝𝚒𝚗𝚞𝚎
>𝚎𝚗𝚍

Learn more at https://hubs.ly/Q01m_Z9n0

##### https://www.linkedin.com/posts/gregthelaw_gdb-conditional-breakpoints-activity-6979107492513337344-XEOV/
###### <Card>

💡 One last GDB debugging tip for this week!

👉 Conditional breakpoints - condition x controls when breakpoint x (already set) should be triggered e.g. 𝚌𝚘𝚗𝚍𝚒𝚝𝚒𝚘𝚗 𝟹 𝚕==𝟺𝟷

Or you can create the breakpoint with the condition applied, like this:
𝚋𝚛𝚎𝚊𝚔 𝚖𝚢_𝚏𝚞𝚗𝚌(𝚕𝚘𝚗𝚐) 𝚒𝚏 𝚕 == 𝟺𝟸
(note that breakpoint conditions can include function calls)

Learn more about conditional breakpoints at https://hubs.ly/Q01n3W_H0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6980213773861011456-G2VC/
###### <Card>

💡 My GDB tip series continues...
👉 You can extract a slice of an array in GDB e.g. 
(𝚐𝚍𝚋) 𝚙𝚛𝚒𝚗𝚝 𝚖𝚢_𝚊𝚛𝚛𝚊𝚢[𝟻𝟶]@𝟷𝟶 
will show ten elements starting from element 50 

You can even 𝚠𝚊𝚝𝚌𝚑 a slice of an array (though if it's too big GDB will fall back to horribly slow software watchpoints) e.g. 
(𝚐𝚍𝚋) 𝚠𝚊𝚝𝚌𝚑 𝚖𝚢_𝚊𝚛𝚛𝚊𝚢[𝟷𝟼]@𝟸 
will watch two elements starting from element 16

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6981252272622030849-J-Rf/
###### <Card>

💡 GDB debugging tips and tricks from me below...

👉 When you set a watchpoint (e.g. `watch foo`), GDB will try to use hardware watchpoints: nice and fast. But if you watch something bigger than the hardware supports, you get software watchpoints: these are horribly slow. You have to pay close attention to spot the difference.

Learn more about setting watchpoints in GDB at https://hubs.ly/Q01nxkcF0

P.S: I'm considering making myself available for GDB debugging training days. Would that be of interest to your team do you think? If so, get in touch!

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6981630306004967424-qs6b/
###### <Card>

👉 Usually a watchpoint watches an expression. Use -location (or -l) to watch certain bytes in memory. 
In this example below, watchpoint 2 will use two hardware watchpoints - one on 𝚖𝚢_𝚊𝚛𝚛𝚊𝚢[𝚒] and one on 𝚒.

Learn more about what you can do with watchpoints in GDB at https://hubs.ly/Q01ny-fS0 (where you can sign up to receive these tutorials in your inbox)

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6982762566519250944-x0Z2/
###### <Card>

💡 Did you know you could do this with watchpoints in GDB?

👉 Watching the expression will stop only when the result of the entire expression changes. The example here shows GDB doesn’t stop when line 14 executes because although 𝚒 has changed, 𝚖𝚢_𝚊𝚛𝚛𝚊𝚢[𝚒] still evaluates to 42. It does stop after line 15 executes though. [see image below]

GDB: read watchpoints will stop when any of the elements in an expression are accessed e.g.
(𝚐𝚍𝚋) 𝚛𝚠𝚊𝚝𝚌𝚑 𝚖𝚢_𝚊𝚛𝚛𝚊𝚢[𝚒]
𝙷𝚊𝚛𝚍𝚠𝚊𝚛𝚎 𝚛𝚎𝚊𝚍 𝚠𝚊𝚝𝚌𝚑𝚙𝚘𝚒𝚗𝚝 𝟸: 𝚖𝚢_𝚊𝚛𝚛𝚊𝚢[𝚒]

will stop whenever your program reads 𝚖𝚢_𝚊𝚛𝚛𝚊𝚢[𝚒] or 𝚒.
(Note that 𝚛𝚠𝚊𝚝𝚌𝚑 is very different from 𝚛𝚋𝚛𝚎𝚊𝚔!)

Also, access watchpoints trigger whenever the memory is read or written:
(𝚐𝚍𝚋) 𝚊𝚠𝚊𝚝𝚌𝚑 𝚖𝚢_𝚊𝚛𝚛𝚊𝚢[𝚒]
𝙷𝚊𝚛𝚍𝚠𝚊𝚛𝚎 𝚊𝚌𝚌𝚎𝚜𝚜 (𝚛𝚎𝚊𝚍/𝚠𝚛𝚒𝚝𝚎) 𝚠𝚊𝚝𝚌𝚑𝚙𝚘𝚒𝚗𝚝 𝟹: 𝚖𝚢_𝚊𝚛𝚛𝚊𝚢[𝚒]

Sign up for all my GBD debugging tutorials on https://hubs.ly/Q01nPD050

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6983483089440104448-B75X/
###### <Card>

👉 Use 𝚌𝚘𝚖𝚖𝚊𝚗𝚍𝚜 to give a list of commands to execute whenever a breakpoint is hit. See example in screenshot below.

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6983751540926783488-kBMK/
###### <Card>

👉 Use the 𝚌𝚘𝚖𝚖𝚊𝚗𝚍𝚜 to set a new breakpoint (something Visual Studio calls 'dependent breakpoints') 

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6984166245377921024-5mUo/
###### <Card>

👉 Use the magic silent command in your list of commands to prevent output appearing from the evaluation of your breakpoint commands.

Set a breakpoint on all functions matching a regular expression using 𝚛𝚋𝚛𝚎𝚊𝚔 (note: totally different from 𝚛𝚠𝚊𝚝𝚌𝚑!). See screenshot below.

Conditional breakpoints will stop only when a condition is hit. E.g.
(𝚐𝚍𝚋) 𝚋𝚛𝚎𝚊𝚔 𝚔𝚒𝚕𝚕 𝚒𝚏 𝚙𝚒𝚍 == 𝟷𝟸𝟹𝟺𝟻
or:
(𝚐𝚍𝚋) 𝚋𝚛𝚎𝚊𝚔 𝚔𝚒𝚕𝚕 
𝙱𝚛𝚎𝚊𝚔𝚙𝚘𝚒𝚗𝚝 𝟸 𝚊𝚝 𝟶𝚡𝟽𝚏𝚏𝚏𝚏𝟽𝚍𝚋𝚍𝟽𝟻𝟶: 𝚏𝚒𝚕𝚎 
../𝚜𝚢𝚜𝚍𝚎𝚙𝚜/𝚞𝚗𝚒𝚡/𝚜𝚢𝚜𝚌𝚊𝚕𝚕-𝚝𝚎𝚖𝚙𝚕𝚊𝚝𝚎.𝚂, 𝚕𝚒𝚗𝚎 𝟷𝟸𝟶. 
(𝚐𝚍𝚋) 𝚌𝚘𝚗𝚍𝚒𝚝𝚒𝚘𝚗 𝟸 𝚙𝚒𝚍 == 𝟷𝟸𝟹𝟺𝟻

Remember that you can sign up to receive full C++ debugging tutorials in your inbox at https://hubs.ly/Q01p4XKY0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6985268237500317696-5q2d/
###### <Card>

👉 If you can’t use artificial arrays (e.g. complex data structure), you can update convenience variables inside a print expression and then hit enter multiple times to iterate through. (Note 𝚒 and $𝚒 are different things here).

Don't forget to sign up to receive full C++ debugging tutorials in your inbox at https://hubs.ly/Q01p4NkL0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6985617782889406464-JCaU/
###### <Card>

👉 The forward-search command finds source matching a regex and puts the line number in the convenience variable $_ which you can then use to set a breakpoint.

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6989246448009629696-NYet/
###### <Card>

👉 Turn on pretty print to make data structures much easier to read when inspecting them while debugging

```gdb
set print pretty
```

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6989265825337634816-owJH/
###### <Card>

💡 More goodness on pretty printers in GDB...
👉 Printing can be customised in GDB to change the number of elements shown in strings/arrays, show particular slices of elements, and even change the output format.

More tips on what you can do with pretty printers on https://hubs.ly/Q01qnVx00

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6991398626337914880-h_xx/
###### <Card>

💡 GDB tip
👉 Using "disassemble /s " allows you to view the assembly of a specific function interspersed with the original code of the function in C/C++, allowing you to find instructions more easily.

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6991753217860608000-nSC4/
###### <Card>

💡 One of the most useful things in GDB is TUI mode (Text User Interface)
👉 You can use 𝚝𝚞𝚒 𝚎𝚗𝚊𝚋𝚕𝚎 to view the source code of your program alongside the GDB terminal. You can also use 𝚕𝚊𝚢𝚘𝚞𝚝 𝚜𝚙𝚕𝚒𝚝 to enable a view of the assembly and 𝚝𝚞𝚒 𝚛𝚎𝚐 𝚐𝚎𝚗𝚎𝚛𝚊𝚕 to view the registers in this GUI as well.

Learn more about what you can do in TUI mode on https://hubs.ly/Q01qRl_G0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6992880981409964032-6hJk/
###### <Card>

👉 When debugging a multithreaded program, you can apply the same commands to all threads simultaneously with “thread apply all ”, for example:

(𝚐𝚍𝚋) 𝚝𝚑𝚛𝚎𝚊𝚍 𝚊𝚙𝚙𝚕𝚢 𝚊𝚕𝚕 𝚋𝚝 𝚏𝚞𝚕𝚕

This would make all threads output their backtrace along with a list of local variables, without needing to switch between each thread manually.

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6992880981409964032-6hJk/
###### <Card>

👉 For bugs that scarcely appear, you can use GDB commands to re-run the program until it fails [see screenshot below]

Find a series of GDB tutorials on https://hubs.ly/Q01r29yM0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6995423893272326144-nmQJ/
###### <Card>

💡 GDB tip of the day
👉 Using the default TUI can come with some caveats, like your arrow keys being mapped to the C source file. It can be customised even more with some extra commands, such as 𝚏𝚘𝚌𝚞𝚜 which will change the active window (for example 𝚌𝚖𝚍 to focus on the GDB terminal).

Find a series of GDB tutorials on https://hubs.ly/Q01rFP2Y0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6997936211226935296-3edT/
###### <Card>

💡 My GDB tip of the day
👉 Using the default TUI can come with some caveats, like your arrow keys being mapped to the C source file. You can customise the size of a window using 𝚠𝚒𝚗𝚑𝚎𝚒𝚐𝚑𝚝 + to increase it by lines, or - to reduce the size. Use these extra customisation features to optimise your debugging workflow.

Find a series of GDB tutorials on https://hubs.ly/Q01s9CKg0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-6998330301470932992-8lGL/
###### <Card>

💡 My GDB tip of the day
If you have a program that takes a particularly long time to run, setting a checkpoint when you’re closer to the error can save lots of debugging time if you’re unsure where you should be looking. Restarting from the checkpoint will put GDB back to exactly that state of execution, instead of having to rerun the program from the beginning.

👉 Find a series of GDB tutorials on https://hubs.ly/Q01s9M4N0

##### https://www.linkedin.com/posts/gregthelaw_gdbwatchpoint-resource-portal-how-to-use-activity-7003055677984145408-se7b/
###### <Card>

💡 My GDB tip of the day
As well as inspecting the values of variables with print, you can evaluate expressions while debugging to see how it behaves with different inputs at runtime e.g. “print foo(arg1, arg2)”.

To avoid cluttering output with void values when you aren’t expecting your function to return anything, you can use “call foo(arg1, arg2)” instead to avoid printing the returned void value.

You can also print/call an assignment expression to change the value of a variable at runtime, for example “print var=4”, preventing you from needing to restart the program to make small changes like this. You can also store values in arbitrary memory locations with “set {int}0x29122 = 4” for example.

👉 Check out my free GDB tutorials at https://hubs.ly/Q01tlfPP0

##### https://www.linkedin.com/posts/gregthelaw_gdbwatchpoint-resource-portal-how-to-use-activity-7003590940472786944-LaQv/
###### <Card>

💡 My GDB tip of the day
You can compile and immediately execute code on demand in the context of the current inferior using 𝚌𝚘𝚖𝚙𝚒𝚕𝚎 𝚌𝚘𝚍𝚎 𝚙𝚛𝚒𝚗𝚝𝚏 (“𝚑𝚎𝚕𝚕𝚘 𝚠𝚘𝚛𝚕𝚍\𝚗”); or 𝚌𝚘𝚖𝚙𝚒𝚕𝚎 𝚏𝚒𝚕𝚎 . Once it's finished executing the compiled code is removed and new variables are deleted.

👉 Become a GDB power user. Sign up to my mailing list at https://hubs.ly/Q01tlL5J0

##### https://www.linkedin.com/posts/gregthelaw_gdbwatchpoint-resource-portal-how-to-use-activity-7004520060463501312-v2uf/
###### <Card>

💡 My GDB tip of the day
You can force a function to return prematurely with the return command, or return something in particular with 𝚛𝚎𝚝𝚞𝚛𝚗 . It discards the selected stack frame and any inside it, and the debugger stays in a state as if the function has just returned that expression.

👉 Want to become a GDB power user? Sign up to my mailing list at https://hubs.ly/Q01tR5w30 and receive GDB tutorials straight into your inbox

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7005954522116153344-P_zJ/
###### <Card>

💡 GDB Just found out a nice way of debugging multithreaded applications; after 𝚜𝚎𝚝 𝚜𝚌𝚑𝚎𝚍𝚞𝚕𝚎𝚛-𝚕𝚘𝚌𝚔𝚒𝚗𝚐 𝚘𝚗 you can make threads all progress one step at a time with 𝚝𝚑𝚛𝚎𝚊𝚍 𝚊𝚙𝚙𝚕𝚢 𝚊𝚕𝚕 𝚜𝚝𝚎𝚙, instead of one thread progressing more than another when you do run 𝚜𝚝𝚎𝚙 in one inferior.

👉 Want to become a GDB power user? Sign up to my mailing list at https://hubs.ly/Q01v5znN0 and receive GDB tutorials straight into your inbox

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7008517168673734656-J9QS/
###### <Card>

💡 GDB You can inspect the state of a program after it’s crashed using core dumps. 𝚐𝚍𝚋 will open the program in GDB and let you view the stack frame and the state of variables and registers at the point the program crashed.

One caveat: the program isn’t running, so commands that modify program state like 𝚜𝚝𝚎𝚙/𝚗𝚎𝚡𝚝/𝚌𝚘𝚗𝚝𝚒𝚗𝚞𝚎 and even 𝚌𝚊𝚕𝚕 won’t work. This is purely to inspect the state at the point when it crashed.

You can generate a coredump on the fly while debugging programs too, if you want to come back to analyse it later at a specific point - use the command 𝚐𝚌𝚘𝚛𝚎.


👉 Want to become a GDB power user? Sign up to my mailing list at https://hubs.ly/Q01vMXB20 and receive GDB tutorials straight into your inbox

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7009223580928335872-XMqP/
###### <Card>

💡 GDB If you want to debug a program running on a smaller device with limited space, or are working with a real-time system where the development happens on a different machine, you can use the gdbserver program.

𝚐𝚍𝚋𝚜𝚎𝚛𝚟𝚎𝚛 𝚒𝚙:𝚙𝚘𝚛𝚝 𝚙𝚛𝚘𝚐𝚛𝚊𝚖𝙽𝚊𝚖𝚎

Also useful if you’re debugging on a remote machine where you don’t want to make the source available.

You can then attach to this on a different machine by loading the binary in gdb as normal then using the command 𝚝𝚊𝚛𝚐𝚎𝚝 𝚛𝚎𝚖𝚘𝚝𝚎 𝚒𝚙:𝚙𝚘𝚛𝚝 and you are now controlling the debugging process from the client machine.

👉 Want to become a GDB power user? Sign up to my mailing list at https://hubs.ly/Q01vSGwn0 and receive GDB tutorials straight into your inbox

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7031338052899741697-D8R0/
###### <Card>

After a little break, I'm back with my '100 GDB Debugging Tips' challenge!
💡 GDB You can run and debug Python files! Using 𝚐𝚍𝚋 -𝚊𝚛𝚐𝚜 𝚙𝚢𝚝𝚑𝚘𝚗 𝚖𝚊𝚒𝚗.𝚙𝚢 you can run the Python script and inspect the backtrace when it crashes. Particularly helpful for Python scripts that segfault.

You can also run Python commands inside GDB:
(𝚐𝚍𝚋) 𝚙𝚢𝚝𝚑𝚘𝚗 𝚒𝚖𝚙𝚘𝚛𝚝 𝚘𝚜
(𝚐𝚍𝚋) 𝚙𝚢𝚝𝚑𝚘𝚗 𝚙𝚛𝚒𝚗𝚝(𝚘𝚜.𝚐𝚎𝚝𝚙𝚒𝚍())
𝟼𝟿0𝟹𝟺𝟿
(𝚐𝚍𝚋)

👉 Want to become a GDB power user? Sign up to my mailing list at https://hubs.ly/Q01CfrvQ0 and receive GDB tutorials straight into your inbox

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7032424223159521280-6Chg/
###### <Card>

💡 GDB Did you know you can inspect variables in different output formats, for example binary or hexadecimal, using 𝚙𝚛𝚒𝚗𝚝 / ?

Some examples of identifiers:
/t - binary
/f - floating point
/c - cast to an integer
/a - as an address
/u - as if it were unsigned decimal
More identifiers are outlined here: https://hubs.ly/Q01Cfvt_0


👉 Want to become a GDB power user? Sign up to my mailing list at https://hubs.ly/Q01CfwdL0 and receive GDB tutorials straight into your inbox

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7033511119050665984-MrwQ/
###### <Card>

💡 GDB Skip through loops using the 𝚞𝚗𝚝𝚒𝚕 command! Unlike next at the end of a loop, which loops back to the start, 𝚞𝚗𝚝𝚒𝚕 will continue the program execution until the loop exits.

Another useful command for skipping execution to a specific point is 𝚏𝚒𝚗𝚒𝚜𝚑. This skips to the end of the current function in the current stack frame returns, and prints the returned value.

👉 Want to save time debugging with GDB? I offer a 1 day on-site training course for teams of C++ engineers working on complex codebases. You can learn more at: https://hubs.ly/Q01CfLfv0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7036386025375465473-j69U/
###### <Card>

💡 GDB Alongside existing tools facilitating the practice, GDB even has its own reverse-debugging feature built in! Use record at the start of execution, and you can use reverse-step or reverse-continue to go back to specific points while debugging. It’s limited and slow, but it can still be useful.

👉 Want to save time debugging with GDB? I offer a 1 day on-site training course for teams of C++ engineers working on complex codebases. You can learn more at: https://hubs.ly/Q01DFQQj0

##### https://www.linkedin.com/posts/gregthelaw_debugging-timetraveldebugging-reversedebugging-activity-7038924035094642688-FUNT/
###### <Card>

💡 GDB Adding to my previous tip on GDB's reverse-debugging feature (ref. https://hubs.ly/Q01FzGyV0): To save some time with writing commands you can use 𝚜𝚎𝚝 𝚎𝚡𝚎𝚌-𝚍𝚒𝚛𝚎𝚌𝚝𝚒𝚘𝚗 [𝚏𝚘𝚛𝚠𝚊𝚛𝚍 | 𝚛𝚎𝚟𝚎𝚛𝚜𝚎] and the usual 𝚌𝚘𝚗𝚝𝚒𝚗𝚞𝚎/𝚜𝚝𝚎𝚙 commands will go in that direction instead! (see screenshot below)

If you want to stop the reversible debugging process without killing the program you’re debugging, you can use 𝚛𝚎𝚌𝚘𝚛𝚍 𝚜𝚝𝚘𝚙 to stop the process entirely, or 𝚛𝚎𝚌𝚘𝚛𝚍 𝚍𝚎𝚕𝚎𝚝𝚎 to delete what has been recorded previously but to continue recording.

GDB’s default recording is quite slow, so only appropriate for small sections of code. To go much faster, try 𝚛𝚎𝚌𝚘𝚛𝚍 𝚋𝚝𝚛𝚊𝚌𝚎. It’s limited because you can’t see data, but it shows the code-flow and has very low overhead.

rr (https://hubs.ly/Q01FzGKd0) has performance that works at scale and is full time travel debugging with data. Watchpoints and reverse-continue are a powerful combination. For the ‘Rolls Royce’ experience, check out https://hubs.ly/Q01FzGRx0 ;-)

👉 Want to save time debugging with GDB? I offer a 1 day on-site training course for teams of C++ engineers working on complex codebases. You can learn more at: https://hubs.ly/Q01FzGzS0

##### https://www.linkedin.com/posts/gregthelaw_debugging-timetraveldebugging-reversedebugging-activity-7041427976688664577-IUbl/
###### <Card>

💡 GDB You can get information about the memory mapping of the current process using 𝚒𝚗𝚏𝚘 𝚙𝚛𝚘𝚌 𝚖𝚊𝚙𝚙𝚒𝚗𝚐𝚜 - helpful to understand how the memory is allocated and managed.

𝚒𝚗𝚏𝚘 𝚙𝚛𝚘𝚌 lets you see much more information about the current running process too, for example the command line arguments of the program, or the files opened. Use 
𝚑𝚎𝚕𝚙 𝚒𝚗𝚏𝚘 𝚙𝚛𝚘𝚌 to see all the possible subcommands.

👉 Want to save time debugging with GDB? I offer a 1 day on-site training course for teams of C++ engineers working on complex codebases. You can learn more at: https://hubs.ly/Q01GPhl50

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7043642861161992194-FUkg/
###### <Card>

💡 GDB Set catchpoints using 𝚌𝚊𝚝𝚌𝚑 to catch program events, like specific exceptions, for when you know an error will happen but you don’t know where!

Events include exceptions being thrown or caught, but also things like syscalls, forks, and even specific signals! (𝚌𝚊𝚝𝚌𝚑 𝚜𝚒𝚐𝚗𝚊𝚕 allows conditions and commands to be associated with signals, unlike 𝚑𝚊𝚗𝚍𝚕𝚎).

You can catch an event once with the catchpoint being deleted after using 𝚝𝚌𝚊𝚝𝚌𝚑.

👉 Want to save time debugging with GDB? I offer a 1 day on-site training course for teams of C++ engineers working on complex codebases. You can learn more at: https://hubs.ly/Q01Hw_B40

##### https://www.linkedin.com/posts/gregthelaw_gdb-gnu-debugging-activity-7044676225662877696-37fa/
###### <Card>

💡 GDB To help automate your debugging you can write multiple commands into a command file, and run it with "source ". Any commands that usually require confirmation will proceed automatically. 

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7045092405229842433-usIY/
###### <Card>

💡 GDB If you want to save the output of GDB to a file while debugging as well as printing to console, you can use 𝚜𝚎𝚝 𝚕𝚘𝚐𝚐𝚒𝚗𝚐 𝚎𝚗𝚊𝚋𝚕𝚎𝚍 𝚘𝚗 to store the output persistently!

By default it goes to “gdb.txt” but you can change the path using 𝚜𝚎𝚝 𝚕𝚘𝚐𝚐𝚒𝚗𝚐 𝚏𝚒𝚕𝚎 [𝚏𝚒𝚕𝚎𝚗𝚊𝚖𝚎], and you can use 𝚜𝚎𝚝 𝚕𝚘𝚐𝚐𝚒𝚗𝚐 𝚛𝚎𝚍𝚒𝚛𝚎𝚌𝚝 [𝚘𝚗/𝚘𝚏𝚏] to prevent the output from printing to the console.

👉 Master GDB and save time debugging: I offer a 1 day on-site training course for teams of C++ engineers working on complex codebases. Learn more at: https://hubs.ly/Q01H_mWR0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7046179593568841729-zk39/
###### <Card>

💡 GDB You can pipe the output from commands directly to external shell commands from within GDB! This means you can use grep, wc, awk on the output of a specific GDB output. For example: 𝚙𝚒𝚙𝚎 𝚙 $𝟷 | 𝚠𝚌 -𝚕 (or 𝚛𝚞𝚗 | 𝚌𝚘𝚠𝚜𝚊𝚢)

You can also execute shell commands without a GDB command prior using 𝚜𝚑𝚎𝚕𝚕 [𝚞𝚗𝚒𝚡 𝚌𝚘𝚖𝚖𝚊𝚗𝚍]. It has access to the default shell of the system, such as /𝚋𝚒𝚗/𝚋𝚊𝚜𝚑 on linux and 𝚌𝚖𝚍.𝚎𝚡𝚎 on Windows, but the shell can be configured too using the environment variable SHELL, if it exists.

👉 Want to save time debugging with GDB? I offer a 1 day on-site training course for teams of C++ engineers working on complex codebases. You can learn more at: https://hubs.ly/Q01J4ll80

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7048717045189758976-AOu3/
###### <Card>

💡 GDB Most commands in GDB have an abbreviated form, for example 𝚗 for 𝚗𝚎𝚡𝚝, 𝚋 for 𝚋𝚛𝚎𝚊𝚔, or 𝚜𝚒 for 𝚜𝚝𝚎𝚙𝚒. These can be used in place of typing out the full command. There are even abbreviations for some commands and their arguments, like 𝚝𝚊𝚊 for 𝚝𝚑𝚛𝚎𝚊𝚍 𝚊𝚙𝚙𝚕𝚢 𝚊𝚕𝚕.

You can also just type enough of any command for it to be unambiguous what it would be, such as “𝚝𝚑𝚛” is unambiguously the start of the 𝚝𝚑𝚛𝚎𝚊𝚍 command, compared to “𝚜𝚝𝚊” which could be 𝚜𝚝𝚊𝚌𝚔, 𝚜𝚝𝚊𝚛𝚝, 𝚜𝚝𝚊𝚝𝚞𝚜, etc.

Learn more about this at: https://hubs.ly/Q01J_M4q0

👉 Want to save time debugging with GDB? I offer a 1 day on-site training course for teams of C++ engineers working on complex codebases. You can learn more at: https://hubs.ly/Q01J_Z0_0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7049804205162647552-NWDN/
###### <Card>

💡 GDB You can set multiple breakpoints on functions using regular expressions with the 𝚛𝚋𝚛𝚎𝚊𝚔 command. This can help if you’ve got multiple functions to break on with a consistent naming scheme, for example.

As this creates multiple separate breakpoints they can be assigned commands differently, and if too many are created from the 𝚛𝚋𝚛𝚎𝚊𝚔 command you can delete individual ones too - they’ll all be shown in 𝚒𝚗𝚏𝚘 𝚋𝚛𝚎𝚊𝚔𝚙𝚘𝚒𝚗𝚝𝚜.

Learn more about this at: https://hubs.ly/Q01K06Qr0

👉 Want to save time debugging with GDB? I offer a 1 day on-site training course for teams of C++ engineers working on complex codebases. You can learn more at: https://hubs.ly/Q01K05h70

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7051253758583791617-lnzv/
###### <Card>

💡 GDB As well as running python inside GDB, you can run GDB commands from python! With the 𝚐𝚍𝚋 module you can use python to automate your debugging with more customisation than command files.

You can simply pass commands to gdb with 𝚐𝚍𝚋.𝚎𝚡𝚎𝚌𝚞𝚝𝚎(), or there is more complex integration allowing you to create breakpoints for example, with 𝚐𝚍𝚋.𝙱𝚛𝚎𝚊𝚔𝚙𝚘𝚒𝚗𝚝(), and manipulate its attributes once it’s created. 

Learn more about this at: https://hubs.ly/Q01K055Z0

👉 Want to save time debugging with GDB? I offer a 1 day on-site training course for teams of C++ engineers working on complex codebases. You can learn more at: https://hubs.ly/Q01J_YR80

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7051978531295109120-bI6f/
###### <Card>

💡 GDB Another python integration tip: you can use python to write pretty-printers, extending the functionality of or replacing the in-built GDB pretty printer. Handy for formatting data structures or removing redundant information.

Learn more about this at: https://hubs.ly/Q01J_W2_0

👉 Want to save time debugging with GDB? I offer a 1 day on-site training course for teams of C++ engineers working on complex codebases. You can learn more at: https://hubs.ly/Q01K03f30

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7059920864573546496-EmKI/
###### <Card>

💡 GDB By default when a program forks, GDB will debug the parent; the child process will run unimpeded. If you use 𝚜𝚎𝚝 𝚏𝚘𝚕𝚕𝚘𝚠-𝚏𝚘𝚛𝚔-𝚖𝚘𝚍𝚎 𝚌𝚑𝚒𝚕𝚍 (rather than 𝚙𝚊𝚛𝚎𝚗𝚝, the default) then when the program forks you will be debugging the child process.

You can also use 𝚜𝚎𝚝 𝚍𝚎𝚝𝚊𝚌𝚑-𝚘𝚗-𝚏𝚘𝚛𝚔 𝚘𝚏𝚏 instead to create a new debugging instance that will run independently, allowing you to debug both processes at once if needed. You will now have two inferior programs, you can switch between them with 𝚒𝚗𝚏𝚎𝚛𝚒𝚘𝚛 𝟷 and 𝚒𝚗𝚏𝚎𝚛𝚒𝚘𝚛 𝟸.

👉 Want to upskill your whole team in just 1 day? Check out my training course at https://hubs.ly/Q01NF4MZ0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7062482766898057216-Yhfh/
###### <Card>

💡 GDB Run 𝚍𝚒𝚜𝚙𝚕𝚊𝚢 [𝚎𝚡𝚙𝚛𝚎𝚜𝚜𝚒𝚘𝚗] to evaluate a particular expression each time you return to the GDB prompt. This is handy for tracking a variable over time for example, without needing to re-issue a 𝚙𝚛𝚒𝚗𝚝 command each time.

Running the 𝚍𝚒𝚜𝚙𝚕𝚊𝚢 command adds the expression to a list shown each time, meaning you can have multiple at once. To remove an expression you can use the 𝚞𝚗𝚍𝚒𝚜𝚙𝚕𝚊𝚢 [𝚒𝚗𝚍𝚎𝚡] command.

👉 Want to master GDB in just 1 day and save time debugging? I run a bespoke on-site training course for teams of C++ engineers working on complex codebases. Get in touch at: https://hubs.ly/Q01NFgks0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7089213136162955264-lAjf/
###### <Card>

💡 GDB Sometimes an error only occurs at a certain point in the program, and so you want to stop on a breakpoint after it’s been hit a certain number of times. Using the 𝚒𝚐𝚗𝚘𝚛𝚎 command you can tell GDB to skip N breakpoint hits, allowing you to start debugging exactly when you want.

If your program is deterministic this can even give you a kind pauper's time travel debugging.

Using the command 𝚒𝚗𝚏𝚘 𝚋𝚛𝚎𝚊𝚔, you can see how many times a breakpoint has been hit before a certain point, useful for finding the number of breakpoints to skip.

The continue command takes 𝚒𝚐𝚗𝚘𝚛𝚎-𝚌𝚘𝚞𝚗𝚝 as an argument, allowing you to skip the breakpoint from which you are continuing a given number of times. For example, 𝚌 𝟸0 would skip the next 20 hits of breakpoint 2. (Note: only takes effect if continuing from a breakpoint.)

👉 More details at:
https://hubs.ly/Q01YBnrl0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7090030786879365120-rO1Q/
###### <Card>

💡 GDB If you want to examine the backtrace of multiple frames but you’re very deep in the stack (so 𝚋𝚝 𝚏𝚞𝚕𝚕 would show too much), you can use 𝚋𝚊𝚌𝚔𝚝𝚛𝚊𝚌𝚎 𝚗 to show the innermost n frames.

Similarly, you can use 𝚋𝚊𝚌𝚔𝚝𝚛𝚊𝚌𝚎 -𝚗 to show the n outermost frames.

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7092098043683983360-FAgT/
###### <Card>

💡 GDB You can use 𝚍𝚙𝚛𝚒𝚗𝚝𝚏 to place a dynamic print statement at a specific place in the source code as the program is executing, using 𝚍𝚙𝚛𝚒𝚗𝚝𝚏 𝚕𝚘𝚌𝚊𝚝𝚒𝚘𝚗,𝚝𝚎𝚖𝚙𝚕𝚊𝚝𝚎,𝚎𝚡𝚙𝚛𝚎𝚜𝚜𝚒𝚘𝚗𝟷,𝚎𝚡𝚙𝚛𝚎𝚜𝚜𝚒𝚘𝚗𝟸…, where template is a formatting string just like regular printf, and expression1… is a comma separated list of expressions.

Dynamic print statements can be useful as you won’t need to remember to remove them later, and you don’t need to recompile to get more info out. As the source code isn’t being modified, you won’t be introducing any new bugs either.

You can customise 𝚍𝚙𝚛𝚒𝚗𝚝𝚏 to call any function by using set 𝚜𝚎𝚝 𝚍𝚙𝚛𝚒𝚗𝚝𝚏-𝚜𝚝𝚢𝚕𝚎 𝚌𝚊𝚕𝚕 and 𝚜𝚎𝚝 𝚍𝚙𝚛𝚒𝚗𝚝𝚏-𝚏𝚞𝚗𝚌𝚝𝚒𝚘𝚗 [𝚏𝚞𝚗𝚌𝚝𝚒𝚘𝚗]. By default it just calls 𝚙𝚛𝚒𝚗𝚝𝚏. 𝚜𝚎𝚝 𝚍𝚙𝚛𝚒𝚗𝚝𝚏-𝚌𝚑𝚊𝚗𝚗𝚎𝚕 lets you print on other streams (default is stdout).

If remote debugging, and your gdbserver supports it, you can use set 𝚍𝚙𝚛𝚒𝚗𝚝𝚏-𝚜𝚝𝚢𝚕𝚎 𝚊𝚐𝚎𝚗𝚝 to have the dprintf happen on the target, which in some cases will go a lot faster.

👉 I also occasionally run on-site GDB training for teams of Linux C++ engineers at their companies: https://hubs.ly/Q01ZzFZc0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7108130871009800193-k97U/
###### <Card>

💡 GDB Did you know you can save breakpoints to a file with 𝚜𝚊𝚟𝚎 𝚋𝚛𝚎𝚊𝚔𝚙𝚘𝚒𝚗𝚝𝚜 [𝚏𝚒𝚕𝚎𝚗𝚊𝚖𝚎], allowing you to quickly load them all again in a future debugging session using 𝚜𝚘𝚞𝚛𝚌𝚎 [𝚏𝚒𝚕𝚎𝚗𝚊𝚖𝚎].

👉 I also occasionally run on-site GDB training for teams of Linux C++ engineers at their companies: https://hubs.ly/Q022hxxd0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7110312820725932032-Gp8V/
###### <Card>

💡 GDB If you have commands you run every time you debug, for example setting up aliases, or if you want to define a function to pretty print a specific data structure, you can put these definitions into a .𝚐𝚍𝚋𝚒𝚗𝚒𝚝 file in the current working directory or in your home directory. GDB will load this file and execute all the commands inside on startup, saving you from typing 𝚜𝚎𝚝 𝚕𝚘𝚐𝚐𝚒𝚗𝚐 𝚎𝚗𝚊𝚋𝚕𝚎𝚍 𝚘𝚗 etc. every time.

You may need to enable auto-loading for the directory by adding the line 𝚜𝚎𝚝 𝚊𝚞𝚝𝚘-𝚕𝚘𝚊𝚍-𝚜𝚊𝚏𝚎-𝚙𝚊𝚝𝚑 /𝚙𝚊𝚝𝚑/𝚝𝚘/𝚍𝚒𝚛 to your GDB config file in ~/.𝚌𝚘𝚗𝚏𝚒𝚐/𝚐𝚍𝚋/𝚐𝚍𝚋𝚒𝚗𝚒𝚝, or enable it for all directories with 𝚜𝚎𝚝 𝚊𝚞𝚝𝚘-𝚕𝚘𝚊𝚍 𝚜𝚊𝚏𝚎-𝚙𝚊𝚝𝚑 /

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7125504281033478144-9JlY/
###### <Card>

💡 GDB GDB: Display the memory contents at a given address using 𝚡 [𝚊𝚍𝚍𝚛𝚎𝚜𝚜]. (Short for ‘examine’.) You can customise the output with an optional format and length argument too, with x/[length][format] [address].

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7139967578285711360-VFDG/
###### <Card>

💡 GDB GDB has a few useful features for debugging multithreaded programs -- for example, it’ll inform you when new child threads are created. If you want more information about the threads that have spawned at any point, you can use 𝚒𝚗𝚏𝚘 𝚝𝚑𝚛𝚎𝚊𝚍𝚜, showing their ID, how the OS sees them, and the name the thread was given by the program.

The default behaviour for stepping through a thread releases all other threads, stopping them again when the step is completed - they aren’t in sync. This can be changed with 𝚜𝚎𝚝 𝚜𝚌𝚑𝚎𝚍𝚞𝚕𝚎𝚛-𝚕𝚘𝚌𝚔𝚒𝚗𝚐 𝚘𝚗, meaning only the current thread will run. Beware of deadlock though -- the thread you're running might block on a lock held by another (not running) thread.

A middle ground can be found with 𝚜𝚎𝚝 𝚜𝚌𝚑𝚎𝚍𝚞𝚕𝚎𝚛-𝚕𝚘𝚌𝚔𝚒𝚗𝚐 𝚜𝚝𝚎𝚙, which has scheduler-locking on when using 𝚜𝚝𝚎𝚙, but disables it when you use 𝚌𝚘𝚗𝚝𝚒𝚗𝚞𝚎, allowing you to travel between breakpoints without having to constantly switch between the threads.

👉 Watch my video tutorial to see this in action https://hubs.ly/Q02cDbWs0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7150516600138342402-HzSH/
###### <Card>

💡 GDB TUI mode top tip 👉 If you press 𝚌𝚝𝚛𝚕 + 𝚡, then 𝚜 in TUI mode (get there with 𝚝𝚞𝚒 𝚎𝚗𝚊𝚋𝚕𝚎), it enables “SingleKey” mode. In this mode you can use 𝚛 to 𝚛𝚞𝚗, 𝚌 to 𝚌𝚘𝚗𝚝𝚒𝚗𝚞𝚎, 𝚜 for 𝚜𝚝𝚎𝚙 (and 𝚚 to leave SingleKey mode), without pressing enter.

👉 Think your team could benefit from training on how to master GDB to save time on root cause analysis? Check out my 1 day training workshop at https://hubs.ly/Q02fQ4pC0

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7166457010429882368-qQ0a/
###### <Card>

💡 GDB Ever spent time figuring out how big a struct is and getting it wrong? Let GDB do it for you: 𝚙𝚝𝚢𝚙𝚎 /𝚘 will show you exactly what you need!

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7178419560507719680-BQSv/
###### <Card>

💡 GDB Did you know you can customise elements of TUI, such as changing the width of tab characters in the source and assembly windows with set 𝚜𝚎𝚝 𝚝𝚞𝚒 𝚝𝚊𝚋-𝚠𝚒𝚍𝚝𝚑 [𝚗] to make them n spaces wide, give line numbers more/less space with 𝚜𝚎𝚝 𝚝𝚞𝚒 𝚌𝚘𝚖𝚙𝚊𝚌𝚝-𝚜𝚘𝚞𝚛𝚌𝚎 [𝚘𝚗|𝚘𝚏𝚏], and changing the border with 𝚜𝚎𝚝 𝚝𝚞𝚒 𝚋𝚘𝚛𝚍𝚎𝚛-𝚖𝚘𝚍𝚎 [𝚖𝚘𝚍𝚎].

👉 Think your team could benefit from training on how to master GDB to save time on root cause analysis? Check out my 1 day training workshop at https://hubs.ly/Q02qM8T00

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7186394249641259008-NLkd/
###### <Card>

💡 GDB Historically GDB could be known for being slow to load big programs, but recent versions of GDB allow multithreaded debuginfo and symbol parsing. This can be controlled with 𝚖𝚊𝚒𝚗𝚝 𝚜𝚎𝚝 𝚠𝚘𝚛𝚔𝚎𝚛-𝚝𝚑𝚛𝚎𝚊𝚍𝚜 [𝚗], but by default is unlimited, allowing GDB to choose what it thinks is reasonable.

Note: I haven’t been able to find much about when it was introduced. Some say version 9, some say 10, and nothing about when unlimited became the default. I’ll have another look later.

##### https://www.linkedin.com/posts/gregthelaw_debugging-gdb-cplusplus-activity-7201987177096916994-8-Px/
###### <Card>

💡 GDB Valgrind is a debugging tool that can automatically detect some common memory errors in programs, and even help trace the source. In this example, it sees the heap block overrun, due to me not freeing a variable, and tells me what line it appears too. To look for memory errors and leaks, Valgrind is used with 𝚟𝚊𝚕𝚐𝚛𝚒𝚗𝚍 --𝚕𝚎𝚊𝚔-𝚌𝚑𝚎𝚌𝚔=𝚢𝚎𝚜 ./𝚖𝚢𝚙𝚛𝚘𝚐

By the way, you can get your free Valgrind cheat sheet from https://hubs.ly/Q02y--6D0

##### https://www.linkedin.com/posts/gregthelaw_debugging-cplusplus-cpp-activity-7219763617485762561-woit/
###### <Card>

💡 GDB Helgrind is a tool inside Valgrind for automatically catching common multithreading issues, like deadlocks and data races. Like Valgrind, it gives detail about what the error is and where it happened too - use it with 𝚟𝚊𝚕𝚐𝚛𝚒𝚗𝚍 --𝚝𝚘𝚘𝚕=𝚑𝚎𝚕𝚐𝚛𝚒𝚗𝚍 ./𝚖𝚢𝚙𝚛𝚘𝚐

🆓 Make sure to grab your free Valgrind/Helgrind cheat sheet from the Undo website :) https://hubs.ly/Q02H7FMv0

##### https://www.linkedin.com/posts/gregthelaw_gdb-cpp-cplusplus-activity-7227007942191919107-ekdA/
###### <Card>

💡 GDB If you don’t want to step into certain functions, use the skip command. e.g.
(𝚐𝚍𝚋) 𝚜𝚔𝚒𝚙 -𝚏𝚞𝚗𝚌𝚝𝚒𝚘𝚗 𝚙𝚛𝚒𝚗𝚝𝚏
𝙵𝚞𝚗𝚌𝚝𝚒𝚘𝚗 𝚙𝚛𝚒𝚗𝚝𝚏 𝚠𝚒𝚕𝚕 𝚋𝚎 𝚜𝚔𝚒𝚙𝚙𝚎𝚍 𝚠𝚑𝚎𝚗 𝚜𝚝𝚎𝚙𝚙𝚒𝚗𝚐.
(𝚐𝚍𝚋)

Or just use the command skip to skip the current function, e.g.
(𝚐𝚍𝚋) 𝚜𝚝𝚎𝚙
#0 𝚙𝚛𝚒𝚗𝚝𝚏 (__𝚏𝚖𝚝=0𝚡𝟻𝟻𝟻𝟻𝟻𝟻𝟻𝟻𝟼0𝟷0 "𝚑𝚎𝚕𝚕𝚘 𝚠𝚘𝚛𝚕𝚍 %𝚕𝚍 %𝚕𝚍\𝚗") 𝚊𝚝 /𝚞𝚜𝚛/𝚒𝚗𝚌𝚕𝚞𝚍𝚎/𝚡𝟾𝟼_𝟼𝟺-𝚕𝚒𝚗𝚞𝚡-𝚐𝚗𝚞/𝚋𝚒𝚝𝚜/𝚜𝚝𝚍𝚒𝚘𝟸.𝚑:𝟷𝟷𝟸
𝟷𝟷𝟸 𝚛𝚎𝚝𝚞𝚛𝚗 __𝚙𝚛𝚒𝚗𝚝𝚏_𝚌𝚑𝚔 (__𝚄𝚂𝙴_𝙵𝙾𝚁𝚃𝙸𝙵𝚈_𝙻𝙴𝚅𝙴𝙻 - 𝟷, __𝚏𝚖𝚝, __𝚟𝚊_𝚊𝚛𝚐_𝚙𝚊𝚌𝚔 ());
(𝚐𝚍𝚋) 𝚜𝚔𝚒𝚙
𝙵𝚞𝚗𝚌𝚝𝚒𝚘𝚗 𝚙𝚛𝚒𝚗𝚝𝚏 𝚠𝚒𝚕𝚕 𝚋𝚎 𝚜𝚔𝚒𝚙𝚙𝚎𝚍 𝚠𝚑𝚎𝚗 𝚜𝚝𝚎𝚙𝚙𝚒𝚗𝚐.
(𝚐𝚍𝚋) 𝚗𝚎𝚡𝚝
𝚑𝚎𝚕𝚕𝚘 𝚠𝚘𝚛𝚕𝚍 0 𝟷
𝚖𝚊𝚒𝚗 () 𝚊𝚝 𝚙𝚛𝚒𝚗𝚝𝚏.𝚌:𝟻𝟾
𝟻𝟾 𝚏𝚘𝚛 (𝚗 = 0; 𝚗 < (𝚗𝙼𝚒𝚕 * 𝙻𝟹_𝙼𝙸𝙻𝙻𝙸𝙾𝙽); 𝚗++) {
(𝚐𝚍𝚋)

Use skip -file to skip everything in a given file, or skip -gfile to use a glob. e.g.
(𝚐𝚍𝚋) 𝚜𝚔𝚒𝚙 -𝚐𝚏𝚒𝚕𝚎 /𝚞𝚜𝚛/𝚒𝚗𝚌𝚕𝚞𝚍𝚎*
𝙵𝚒𝚕𝚎(𝚜) /𝚞𝚜𝚛/𝚒𝚗𝚌𝚕𝚞𝚍𝚎* 𝚠𝚒𝚕𝚕 𝚋𝚎 𝚜𝚔𝚒𝚙𝚙𝚎𝚍 𝚠𝚑𝚎𝚗 𝚜𝚝𝚎𝚙𝚙𝚒𝚗𝚐.
(𝚐𝚍𝚋)

Disable or delete all previously enabled skips with 𝚜𝚔𝚒𝚙 𝚍𝚒𝚜𝚊𝚋𝚕𝚎 or 𝚜𝚔𝚒𝚙 𝚍𝚎𝚕𝚎𝚝𝚎. (Re-enable with 𝚜𝚔𝚒𝚙 𝚍𝚒𝚜𝚊𝚋𝚕𝚎.)

##### https://www.linkedin.com/posts/gregthelaw_cpp-cplusplus-debugging-activity-7254108721235079168-z5Dj/
###### <Card>

💡 GDB Finding unexpected values in your variables? 

With Undo the 𝚕𝚊𝚜𝚝 command allows you to rewind directly back to the last time that value was changed, and find out exactly where that bad value came from. Particularly useful for memory corruption errors, where the crash can happen minutes after the bad line was executed. 

👉 Check how this works in practice: https://hubs.ly/Q02V4bvP0

##### https://www.linkedin.com/posts/gregthelaw_cpp-cplusplus-debugging-activity-7272680105255096320-lDm7/
###### <Card>

💡 GDB Want to step over function calls?

When you’re stopped at a breakpoint, while you can step to the next line of your code with the 𝚗𝚎𝚡𝚝 command, each line can have several assembly instructions within. To move through the program at an even finer level, use the 𝚗𝚎𝚡𝚝𝚒 command - you can see the instructions you’re moving through using layout split, showing the source code and assembly side-by-side. It will step over any function calls.

👉 Want more GDB tips? I share a ton of free C++ debugging tutorials at https://hubs.ly/Q02_jd-q0

##### https://www.linkedin.com/posts/gregthelaw_cpp-cplusplus-debugging-activity-7292897501756485632-5ObF/
###### <Card>

💡 GDB Don't forget, you have OTHER open source debugging tools beyond GDB at your disposal

AddressSanitizer is a memory error detector, similar to Valgrind. However it’s used by compiling your program with the -𝚏𝚜𝚊𝚗𝚒𝚝𝚒𝚣𝚎=𝚊𝚍𝚍𝚛𝚎𝚜𝚜 flag instead of at runtime. When you run the program, it will give you a colourful report of any memory errors it finds!

👉 Want more C/C++ debugging tips? I share a ton of free C++ debugging tutorials at https://hubs.ly/Q035nbqv0

##### https://www.linkedin.com/posts/gregthelaw_cpp-cplusplus-debugging-activity-7295508599445807105-GWpF/
###### <Card>

💡 GDB Did you know you can debug with GDB using AddressSanitizer! 

If you run your ASan-compiled program with GDB, you can put a breakpoint on the __𝚊𝚜𝚊𝚗::𝚁𝚎𝚙𝚘𝚛𝚝𝙶𝚎𝚗𝚎𝚛𝚒𝚌𝙴𝚛𝚛𝚘𝚛 function to stop just before ASan reports an error! You can look at the stack and see where you are when the error happens in more detail.

👉 Want more C/C++ debugging tips? I share a ton of free C++ debugging tutorials at https://hubs.ly/Q036rYg40

---
# Subject
#### Topic Level (surface, depth, origin)

#### <Topic>
###### <Card>
