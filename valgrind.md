# Valgrind
# Valgrind Documentation
## website
## valgrind.org
### page
#### surface

#### Topic
##### Section
###### Card

The option --tool dictates which Valgrind tool to run

valgrind [valgrind-options] <program> [program-options]

valgrind --tool=memcheck ls -l

Memcheck is the default tool and can be omitted.

The program runs on a synthetic CPU provided by the Valgrind core. As new code is executed for the first time, the core hands the code to the selected tool. The tool adds its own instrumentation code to this and hands the result back to the core, which coordinates the continued execution of this instrumented code.

Valgrind allows you to selectively suppress errors, by recording them in a suppressions file which is read when Valgrind starts up. 

To make it easier to write suppressions, you can use the --gen-suppressions=yes option. This tells Valgrind to print out a suppression for each reported error, which you can then copy into a suppressions file.

Different error-checking tools report different kinds of errors. The suppression mechanism therefore allows you to say which tools each suppression applies to.

The option -fno-inline makes it easier to see the function-call chain, which can help reduce confusion when navigating around large C++ apps.

Chances are you're set up like this already, if you intended to debug your program with GNU GDB, or some other debugger.

Alternatively, the Valgrind option --read-inline-info=yes instructs Valgrind to read the debug information describing inlining information. With this, function call chain will be properly shown, even when your application is compiled with inlining.

you should compile your code with -Wall because it can identify some or all of the problems that Valgrind can miss at the higher optimisation levels.

Compiler optimisations have been observed to generate code which fools Memcheck into wrongly reporting uninitialised value errors, or missing uninitialised value errors. a reasonable compromise is to use -O.

The default: send it to a file descriptor, which is by default 2 (stderr). So, if you give the core no options, it will write commentary to the standard error stream. If you want to send it to some other file descriptor, for example number 9, you can specify --log-fd=9.

A less intrusive option is to write the commentary to a file, which you specify by --log-file=filename.

The least intrusive option is to send the commentary to a network socket. The socket is specified as an IP address and port number pair, like this: --log-socket=192.168.0.1:12345

You can also omit the port number: --log-socket=192.168.0.1, in which case a default port of 1500 is used.

Note, unfortunately, that you have to use an IP address here, rather than a hostname.

Writing to a network socket is pointless if you don't have something listening at the other end. We provide a simple listener program, valgrind-listener, which accepts connections on the specified port and copies whatever it is sent to stdout.

valgrind-listener accepts three command-line options:

-e --exit-at-zero

    When the number of connected processes falls back to zero, exit. Without this, it will run forever

--max-connect=INTEGER

    By default, the listener can connect to up to 50 processes

portnumber

    Changes the port it listens on from the default (1500). The specified port must be in the range 1024 to 65535. The same restriction applies to port numbers specified by a --log-socket to Valgrind itself.

If a Valgrinded process fails to connect to a listener, for whatever reason (the listener isn't running, invalid or unreachable host or port, etc), Valgrind switches back to writing the commentary to stderr. The same goes for any process which loses an established connection to a listener. In other words, killing the listener doesn't kill the processes sending data to it.

All lines in the commentary have following form:

==12345== some-message-from-Valgrind

 The commentary contains a mix of messages from the Valgrind core and the selected tool. If the tool reports errors, it will report them to the commentary. However, if the tool does profiling, the profile data will be written to a file of some kind, depending on the tool, and independent of what --log-* options are in force. The commentary is intended to be a low-bandwidth, human-readable channel. Profiling data, on the other hand, is usually voluminous and not meaningful without further processing,

When an error-checking tool detects something bad happening in the program, an error message is written to the commentary.

==25832== Invalid read of size 4
==25832==    at 0x8048724: BandMatrix::ReSize(int, int, int) (bogon.cpp:45)
==25832==    by 0x80487AF: main (bogon.cpp:66)
==25832==  Address 0xBFFFF74C is not stack'd, malloc'd or free'd

This message says that the program did an illegal 4-byte read of address 0xBFFFF74C, which, as far as Memcheck can tell, is not a valid stack address, nor corresponds to any current heap blocks or recently freed heap blocks. The read is happening at line 45 of bogon.cpp, called from line 66 of the same file, etc.

Valgrind remembers all error reports. When an error is detected, it is compared against old reports, to see if it is a duplicate. If so, the error is noted, but no further commentary is emitted.

If you want to know how many times each error occurred, run with the -v option. When execution finishes, all the reports are printed out, along with, and sorted by, their occurrence counts.

Errors are reported before the associated operation actually happens. For example, if a program attempts to read from address zero, Memcheck will emit a message to this effect, and the program will then likely die with a segmentation fault.

In general, you should try and fix errors in the order that they are reported. Not doing so can be confusing. For example, a program which copies uninitialised values to several memory locations, and later uses them, will generate several error messages, when run on Memcheck. The first such error message may well give the most direct clue to the root cause of the problem.

The process of detecting duplicate errors is quite an expensive one and can become a significant performance overhead if your program generates huge quantities of errors. To avoid serious problems, Valgrind will simply stop collecting errors after 1,000 different errors have been seen, or 10,000,000 errors in total have been seen.

 These limits are defined in m_errormgr.c and can be increased if necessary.

To avoid this cutoff you can use the --error-limit=no option. Then Valgrind will always show errors, regardless of how many there are. Use this option carefully, since it may have a bad effect on performance.

2.5. Suppressing errors

A default suppression file is created by the ./configure script when the system is built.

Multiple suppression files are allowed. This is useful if part of your project contains errors you can't or don't want to fix, yet you don't want to continuously be reminded of them.

the easiest way to add suppressions is to use the --gen-suppressions=yes option

 This generates suppressions automatically. For best results, though, you may want to edit the output of --gen-suppressions=yes by hand

Each error to be suppressed is described very specifically.

If you use the -v option, at the end of execution, Valgrind prints out one line for each used suppression, giving the number of times it got used, its name and the filename and line number where the suppression is defined.

Depending on the suppression kind, the filename and line number are optionally followed by additional information (such as the number of blocks and bytes suppressed by a Memcheck leak suppression).

--1610-- used_suppression:      2 dl-hack3-cond-1 /usr/lib/valgrind/default.supp:1234
--1610-- used_suppression:      2 glibc-2.5.x-on-SUSE-10.2-(PPC)-2a /usr/lib/valgrind/default.supp:1234

Valgrind loads suppression patterns from $PREFIX/lib/valgrind/default.supp unless --default-suppressions=no has been specified.

You can ask to add suppressions from additional files by specifying --suppressions=/path/to/file.supp one or more times.

Each suppression has the following components:

* First line: a handy name to the suppression
* Second line: name of the tool(s) that the suppression is for (if more than one, comma-separated), and the name of the suppression itself, separated by a colon

tool_name1,tool_name2:suppression_name

* a small number of suppression types have extra information after the second line (eg. the Param suppression for Memcheck)

* Remaining lines: This is the calling context for the error -- the chain of function calls that led to it. There can be up to 24 of these lines.

C++ function names must be mangled. If you are writing suppressions by hand, use the --demangle=no option to get the mangled names in your error messages. 

This is the form that the GNU C++ compiler uses internally, and the form that must be used in suppression files.

Locations may be names of either shared objects, functions, or source lines. They begin with obj:, fun:, or src:

A location line may also be simply "..." (three dots). This is a frame-level wildcard, which matches zero or more frames. Frame level wildcards are useful because they make it easy to ignore varying numbers of uninteresting frames in between frames of interest.

the entire suppression must be between curly braces. Each brace must be the first character on its own line.

{
  gconv_transform_ascii_internal/mbrtowc/mbtowc
  Memcheck:Value4
  fun:__gconv_transform_ascii_internal
  fun:__mbr*toc
  fun:mbtowc
}

for Memcheck only, suppress a use-of-uninitialised-value error, when the data size is 4, when it occurs in the function gconv_transform_ascii_internal, when that is called from any function of name matching mbr*toc, when that is called from mbtowc.

{
  libX11.so.6.2/libX11.so.6.2/libXaw.so.7.0
  Memcheck:Value4
  obj:/usr/X11R6/lib/libX11.so.6.2
  obj:/usr/X11R6/lib/libX11.so.6.2
  obj:/usr/X11R6/lib/libXaw.so.7.0

This suppresses any size 4 uninitialised-value error which occurs anywhere in libX11.so.6.2, when called from anywhere in the same library, when called from anywhere in libXaw.so.7.0

{
  libX11.so.6.2/libX11.so.6.2/libXaw.so.7.0
  Memcheck:Value4
  src:valid.c:321
}

This suppresses any size-4 uninitialised-value error which occurs at line 321 in valid.c.

you can freely mix obj:, fun:, and src: lines in a suppression.

here's an example using three frame-level wildcards:

{
   a-contrived-example
   Memcheck:Leak
   fun:malloc
   ...
   fun:ddd
   ...
   fun:ccc
   ...
   fun:main
}

---
# Valgrind
#### surface
#### Topic
###### Card

