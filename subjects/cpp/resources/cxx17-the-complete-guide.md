# C++17: The Complete Guide
<img src="../../../covers/9783967300178.jpg" width="200"/>

## Chapter 1/29 <sup>(writing)</sup>

<details>
<summary>Use structured binding to initialize multiple entities?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <map>
>
> int main()
> {
>     std::map<int, char const*> letters;
>     letters.insert({0, "first"});
>     letters.insert({1, "second"});
>     letters.insert({2, "third"});
>
>     for (const auto& [index, letter]: letters)
>         std::cout << index << ": " << letter << "\n";
> }
> ``````

> **Resources**
> - C++17: The Complete Guide - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/structured_binding "cpp/language/structured_binding"
---
</details>

<details>
<summary>Use const and reference qualifiers with structured binding?</summary>

> **Description**
>
> ```cpp
> struct some_data
> {
>     int age;
>     char const* name;
> };
>
> int main()
> {
>     some_data personal_data{27, "Brian"};
>
>     auto const& [a1, n1] = personal_data; // const reference
>     auto const [a2, n2] = personal_data; // const
>     auto& [a3, n3] = personal_data; // non-const reference
>     auto [a4, n4] = personal_data; // copy
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use move semantics with structured bindings?</summary>

> ```cpp
> #include <string>
>
> struct some_data
> {
>     std::string text;
> };
>
> int main()
> {
>     some_data data{"long text"};
>
>     // entity is rvalue reference to data.text
>     auto&& [rv_text] = std::move(data);
>
>     // new entity stole the membership of value from data.text
>     std::string text = std::move(rv_text);
>
>     // rv_text and data.text no longer hold values
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use class and structures in structured bindings?</summary>

> * All non-static data members must be members of the same class definition.
>
> ```cpp
> struct A
> {
>     int a = 1;
>     int b = 2;
> };
>
> struct B : A
> {
> };
>
> struct C : A
> {
>     int c = 3;
> };
>
> int main()
> {
>     auto [x, y] = B{};
>     auto [i, j, k] = C{}; // ERROR
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use raw arrays in structured binding?</summary>

> * For an array passed as argument, this is not possible because it decays to the corresponding pointer type.
>
> ```cpp
> int main()
> {
>     int array[] = {1,2,3};
>     auto [i, j, k] = array;
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use `std::pair`, `std::tuple`, and `std::array` in structured binding?</summary>

> ```cpp
> #include <utility>
> #include <string>
> #include <tuple>
> #include <array>
>
> int main()
> {
>     std::array<int, 3> coordinates{1,0,1};
>     auto [x, y, z] = coordinates;
>
>     std::pair<int, std::string> letter{1, "some text"};
>     auto& [index, text] = letter;
>
>     std::tuple<long, std::string> book{9783967300178, "C++17: The Complete Guide"};
>     auto const& [isbn, title] = book;
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Make a custom type compatible with tuple interface to be used in structured binding?</summary>

> ```cpp
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

## Chapter 2/29
## Chapter 3/29
## Chapter 4/29
## Chapter 5/29
## Chapter 6/29
## Chapter 7/29
## Chapter 8/29
## Chapter 9/29
## Chapter 10/29 <sup>(writing)</sup>

<details>
<summary>Write a C++ function to decide at compile time wether it should return a passed string, call <code>std::to_string()</code> for a passed integral or floating-point value, or try to convert the passed argument to std::string.</summary>

> ```cpp
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 10
> ---
> **References**
> ---
</details>

## Chapter 11/29
## Chapter 12/29
## Chapter 13/29
## Chapter 14/29
## Chapter 15/29 <sup>(writing)</sup>

<details>
<summary>What object can be used in C++ STL to have a value with certain type or not have any value at all?</summary>

> `std::optional<>` model a nullable instance of an arbitrary type.
>
> ```cpp
> #include <optional>
>
> std::optional<int> oi{42};
> int i{*oi}; // 42
> ``````
>
> ---
> **Resources**
> - C++17 The Complete Guide - Chapter 15

> **References**
> ---
</details>

<details>
<summary>How can <code>std::optional<></code> be used as return values?</summary>

> **Description**
>
> ```cpp
> #include <optional>
> #include <string_view>
>
> std::optional<int> asInt(const std::string_view s)
> {
>     try
>     {
>         return std::stoi(s);
>     }
>     catch (...)
>     {
>         return std::nullopt;
>     }
> }
>
> asInt("42");           // std::optional<int>(42)
> asInt("077");          // std::optional<int>(42)
> asInt("forty two");    // std::nullopt
> asInt("0x33");         // std::optional<int>(42)
> ``````
>
> ---
> **Resources**
> - C++17 The Complete Guide - Chapter 15
> ---
> **References**
> ---
</details>

## Chapter 16/29
## Chapter 17/29
## Chapter 18/29
## Chapter 19/29
## Chapter 20/29 <sup>(published)</sup>

### Path Terminalogy

<details>
<summary>What are the constituents of a path?</summary>

> It consists of an optional *root name*, an optional *root directory*, and a
> sequence of filenames separated by *directory separators*.
>
> ```
> [root name] [root directory] [filenames]
> /home/brian/
> C:\Windows\Users\Brian\Desktop
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>What path formats are available?</summary>

> The path can be **relative**, so that the file location depends on the current directory, or **absolute**.
>
> Two formats are possible for path objects:
>
> - A generic format, which is portable.
> - A native format, which is specific to the underlying file system.
>
> On POSIX compliant operating systems there is not difference between the
> generic and the native format. On Windows the generic format `/tmp/note.txt`
> is a valid native format besides `\tmp\note.txt` which is also supported are
> two native versions of the same path.
>
> The generic path format is as follows:
>
> `[root name] [root directory] [relative path]`
>
> - The optional root name is implementation specific (e.g. `//host` on POSIX systems, `C:` on WIndows systems)
> - The optional root root directory is a directory separator
> - The relative path is a sequence of file names separated by directory separators
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>What are the properties of a normalized path?</summary>

> In a normalized path:
>
> - Filenames are separated only by a single preferred directory separator.
> - The filename `.` is not used unless the whole path is nothing but `.`.
> - The filename does not contain `..` filenames unless they are at the
>   beginning of a relative path.
> - The path only ends with a directory separator if the trailing filename is a
>   directory with a name other than `.` or `..`.
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>What are the differences of member and free-standing functions of path?</summary>

> The filesystem library provides several functions, which can be both member
> and free-standing functions. **Member** functions are cheap because they are
> pure lexical operations that do not take the actual filesystem into account,
> so that no operating system calls are necessary, e.g. `mypath.is_absolute()`.
> **Free-standing** functions on the other hand are expensive, because they
> usually take the actual filesystem into account, e.g. `equivalent(path1,
> path2)`. Sometimes, the filesystem library provides the same functionality
> operating both lexically and by the actual filesystem into account, e.g.
> `path1.lexically_relative(path2)`.
>
> Because of **Argument Dependent Lookup (ADL)** usually we don't have to
> specify the full namespace `std::filesystem` when calling free-standing
> filesystem functions.
>
> ```cpp
> create_directory(std::filesystem::path{"/tmp/notes"}); // OK
> remove(std::filesystem::path{"/tmp/note.txt"}); // OK
>
> std::filesystem::create_directory("/tmp/note.txt"); // OK
> std::filesystem::remove("/tmp/note.txt"); // OK
>
> create_directory("/tmp/notes"); // ERROR
> remove("/tmp/note.txt"); // OOPS: calls C function remove()
> ``````

> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>How many error handling approaches are available on filesystem library?</summary>

> **Description**
>
> Because dealing with exception is not always appropriate, the filesystem
> library uses a mixed approach when dealing with the filesystem.
>
> Filesystem operations usually have two overloads for each operation.
>
> - By default, the operations throw `std::filesystem_error` exceptions on errors.
> - By passing an additional out parameter, an error code can be used instead.
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Filesystem Error Handling

<details>
<summary>Handle a filesystem operation error with exceptions?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     try
>     {
>         std::filesystem::create_directory("/tmp/");
>     }
>     catch (std::filesystem::filesystem_error const& exp)
>     {
>         std::cerr << exp.path1() << ": " << exp.what() << std::endl;
>     }
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Handle a filesystem operation error with error code?</summary>

> ```cpp
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     std::error_code ec;
>     std::filesystem::create_directory("/tmp/", ec);
>     if (ec)
>     {
>         std::cerr << ec.message() << std::endl;
>     }
>
>     if (ec == std::errc::read_only_file_system)
>     {
>         std::cerr << "directory is read only\n";
>     }
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### File Types

<details>
<summary>What are the supporting different file types?</summary>

> The standard filesystem library defines an enumeration type `file_type`,
> which is standardized to have the following values:
>
> ```cpp
> namespace std::filesystem
> {
>     enum class file_type
>     {
>         regular, directory, symlink,
>         block, character, fifo, socket,
>         ...
>         none, not_found, unknown
>     };
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

### Path Construction

<details>
<summary>Create a path with different string types?</summary>

> ```cpp
> #include <string>
> #include <filesystem>
>
> using namespace std::string_literals;
>
> std::filesystem::path{"/dev/null"s};    // std::string
> std::filesystem::path{L"/dev/null"s};   // std::wstring
> std::filesystem::u8path{u8"/dev/null"s};  // std::u8string
> std::filesystem::u16path{u16"/dev/null"s}; // std::u16string
> std::filesystem::u32path{u32"/dev/null"s}; // std::u32string
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Create a path with a range?</summary>

> ```cpp
> #include <string>
> #include <filesystem>
>
> std::string filename{"/dev/random"};
> std::filesystem::path{filename.begin(), filename.end()};
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Get current path of the executing process?</summary>

> Note that `current_path()` is an expensive operation because it is based on
> operating system calls.
>
> ```cpp
> #include <filesystem>
>
> auto working_directory{std::filesystem::current_path()};
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Get the path of temporary directory?</summary>

> **Description**
>
> ```cpp
> #include <filesystem>
>
> auto temp{std::filesystem::temp_directory_path()};
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Path Inspection

<details>
<summary>Yield whether a path is empty?</summary>

> ```cpp
> std::filesystem::path p;
> p.empty(); // true
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Yield whether a path is absolute or relative?</summary>

> **Description**
>
> ```cpp
> std::filesystem::path p{"assets/image.png"};
> p.is_absolute(); // false
> p.is_relative(); // true
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield all the constituents of a path?</summary>

> ```cpp
> std::filesystem::path p{"/usr/src/linux/version"};
>
> p.has_filename(); // true
> p.filename(); // version
>
> p.has_stem(); // false
> p.stem(); // (none)
>
> p.has_extension(); // false
> p.extension(); // (none)
>
> p.has_root_name(); // false
> p.root_name(); // (none)
>
> p.has_root_directory(); // true
> p.root_directory(); // /
>
> p.has_root_path(); // true
> p.root_path(); // /
>
> p.has_parent_path(); // true
> p.parent_path(); // /usr/src/linux
>
> p.has_relative_path(); // false
> p.relative_path(); // (none)
>
> p.begin();
> p.end();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield if a path is normalized?</summary>

> ```cpp
> std::filesystem::path p{"/etc/resolv.conf"};
>
> p.lexically_normal();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Path Conversion

<details>
<summary>Yield a path as string objects of any byte size?</summary>

> **Description**
>
> ```cpp
> std::filesystem::path p{"/etc/os-release"};
>
> p.string();
> p.wstring();
> p.u8string();
> p.u16string();
> p.u32string();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Path Relativity

<details>
<summary>Yield a relative path from two paths?</summary>

> Lexically relative path can be used in symbolic link creation.
>
> Lexical relative path yields the empty path if there is no relative path from p1 to p2.
>
> ```cpp
> std::filesystem::path{"a/b/c"}.lexically_relative("/a/d"); // ../b/c
> std::filesystem::path{"a/d"}.lexically_relative("/a/b/c"); // ../../d
> ``````
>
> Lexical proximate path yields p1 if there is no relative path from p1 to p2.
>
> ```cpp
> std::filesystem::path{"a/b"}.lexically_relative("c/d"}; // ""
> std::filesystem::path{"a/b"}.lexically_proximate("c/d"}; // "a/b"
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Generic Paths

<details>
<summary>Yield a path as a generic string?</summary>

> ```cpp
> std::filesystem::path p{"/dir\\subdir/subsubdir\\/./\\"};
>
> p.generic_string(); // all the same: /dir/subdir/subsubdir//.//
> p.generic_wstring();
> p.generic_u8string();
> p.generic_u16string();
> p.generic_u32string();
> ``````
>
> `native()` yields the path converted to the native string encoding, which is
> defined by the type `std::filesystem::path::string_type`. Under Windows this
> type is `std::wstring`, so that you have to use `std::wcout`.
>
> `c_str()` does the same but yields the result as a null terminated character
> sequence. Note that using this function is also not portable.
>
> `make_preferred()` replaces any directory separator except for the root name
> by the native directory separator.
>
> ```cpp
> p.native(); // /dir\subdir/subsubdir\/./\
> p.c_str(); // same
> p.preferred(); // \\dir\\subdir\\subsubdir\\\\.\\\\
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Path Expansion

<details>
<summary>Concatenate a string to a path?</summary>

> `+` , `+=` and `concat()` just append new characters to a path.
>
> ```cpp
> std::filesystem::path p{"project"};
>
> auto p2 = p + ".git"; // project.git
>
> p += ".git"; // project.git
> p2.concat(".git"); // project.git
>
> std::filesystem::path p3{".git"};
> p.concat(p3.begin(), p3.end()); // project.git
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Append a subpath to a path?</summary>

> `/` , `/=` and `append()` add a subpath separated with the current directory
> separator.
>
> ```cpp
> std::filesystem::path p{"project"};
>
> auto p2 = p / ".git"; // project.git
>
> p.append(".git"); // project.git
> p /= ".git"; // project.git
>
> std::filesystem::path p3{".git"};
> p.append(p3.begin(), p3.end());
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Add extension to a file path that does not already have an extension?</summary>

> ```cpp
> std::filesystem::path p{"/src/project/main"};
> p.replace_extension(".cpp"); // /src/project/main.cpp
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Path Modification

<details>
<summary>Assign a string to a path as a new path?</summary>

> ```cpp
> std::filesystem::path p;
>
> std::string s{"/src/projects/linux"};
> p.assign(s);
>
> std::string_view sv{"/src/projects/linux-stable"};
> p.assign(sv);
>
> std::filesystem::path p2{"/src/projects/linux-hardened"};
> p.assign(p2.begin(), p2.end());
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Swap two path objects?</summary>

> ```cpp
> std::filesystem::path p1;
> std::filesystem::path p2;
>
> p1.swap(p2);
> std::swap(p1, p2);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Replace filename in a path?</summary>

> **Description**
>
> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.replace_filename("window.cpp"); // /src/project/window.cpp
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Replace extension in a path?</summary>

> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.replace_extension("hpp"); // /src/project/main.hpp
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Convert directory separators inside a path to the native format?</summary>

> **Description**
>
> ```cpp
> std::filesystem::path p;
> p.make_preferred();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Path Reduction

<details>
<summary>Remove filename from a path?</summary>

> **Description**
>
> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.remove_filename(); // /src/project/
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Remove extension from a path?</summary>

> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.replace_extension(); // /src/project/main
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Path Comparison

<details>
<summary>What comparison operators are supported by path objects?</summary>

> `==` , `!=` , `<` , `>` , `<=` , `>=` , `compare(p2)` , `compare(sv)` and `equivalent(p1, p2)` are available.
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Compare two paths <code>tmp/f</code> and <code>tmp/./f</code>?</summary>

> Using `==` , `!=` and `compare()` the following paths are all different:
>
> ```
> tmp/f
> ./tmp/f
> tmp/./f
> tmp/subtmp/../f
> tmp//f
> /tmp\f
> tmp/\/f
> ``````
>
> Only if you call `lexically_normal()` for each path, all of the paths above are equal.
>
> ```cpp
> std::filesystem::path p1{"tmp/f"};
> std::filesystem::path p2{"tmp/./f"};
>
> p1 == p2; // false
> p1.compare(p2); // not 0
> p1.lexically_normal() == p2.lexically_normal(); // true
> p1.lexically_normal().compare(p2.lexically_normal()); // 0
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Compare two paths holding symbolic links?</summary>

> To take the filesystem into account so that symbolic links are correctly
> handled, use `equivalent()`. Note that this function requires that both paths
> represent existing files.
>
> ```cpp
> std::filesystem::path p1{"/tmp/sym1"};
> std::filesystem::path p2{"/tmp/sym2"};
>
> std::filesystem::exists(p1); // true
> std::filesystem::exists(p2); // true
> std::filesystem::equivalent(p1, p2);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### File Existence Checking

<details>
<summary>Check for existance of a file?</summary>

> **Description**
>
> ```cpp
> std::filesystem::exists(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### File Type Checking

<details>
<summary>Check if a file is a regular file or a directory or a symbolic link?</summary>

> Note that these functions follow symbolic links.
> So for a symbolic link to a directory both `is_symlink()` and `is_directory()` yield true.
>
> ```cpp
> std::filesystem::is_symlink(p);
> std::filesystem::is_regular_file(p);
> std::filesystem::is_directory(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Check if a file is neither a regular nor a directory nor a symbolic link?</summary>

> ```cpp
> std::filesystem::is_other(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Check if a file is a special block, character, a fifo or a socket file?</summary>

> ```cpp
> std::filesystem::is_block_file(p);
> std::filesystem::is_character_file(p);
> std::filesystem::is_fifo(p);
> std::filesystem::is_socket(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Filesystem Attributes Querying

<details>
<summary>Check if a file is empty?</summary>

> **Description**
>
> ```cpp
> std::filesytem::is_empty(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Get the size of a file in bytes?</summary>

> This free-standing function returns the size of file p in bytes if it exists
> as regular file. For all other files the result is implementation-defined and
> not portable.
>
> ```cpp
> auto bytes = std::filesystem::file_size(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Get the number of hard links to a file?</summary>

> ```cpp
> std::filesystem::hard_link_count(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Get the last time a file was written into?</summary>

> Returns the timepoint of the last modification or write access of the file. The return type is a special `std::chrono::time_point` type.
>
> ```cpp
> namespace std::filesystem {
>     using file_time_type = chrono::time_point<trivialClock>;
> }
> ``````
>
> The clock type is an implementation specific clock type that reflects the resolution and range of file time values.
>
> ```cpp
> auto last_write = last_write_time(p);
> auto diff = std::filesystem::file_time_type::clock::now() - last_write;
> auto last_write_seconds = std::chrono::duration_cast<std::chrono::seconds>(diff).count();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Yield information about the disk space available at a given path?</summary>

> **Description**
>
> ```cpp
> std::filesystem::space_info = std::filesystem::space(p);
> ``````
>
> The return value of `space()` is the following signature:
>
> ```cpp
> namespace std::filesystem {
>     struct space_info {
>         uintmax_t capacity;
>         uintmax_t free;
>         uintmax_t available;
>     };
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Filesystem Attributes Modification

<details>
<summary>Rename a file?</summary>

> `rename()` can deal with any type of file including directories and symbolic
> links.
>
> Renaming symbolic links will rename the link, not where it refers to.
>
> ```cpp
> std::filesystem::rename(old, new);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Change the timepoint of the last write access of a file?</summary>

> ```cpp
> std::filesystem::last_write_time(p, newtime);
> std::filesystem::last_write_time(p, std::filesystem::file_time_type::clock::now());
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Replace the permissions of a file?</summary>

> ```cpp
> std::filesystem::permissions(p, perms);
> std::filesystem::permissions(p, perms, mode);
> ``````
>
> The optional `mode` is of the bitmask enumeration type `perm_options`,
> defined in namespace `std::filesystem`. It allows on one hand to choose
> between `replace`, `add`, and `remove` and on the other hand with `nofollow`
> to modify permissions of the symbolic links instead of the files they refer
> to.
>
> ```cpp
> // remove write access for group and any access for others
> std::filesystem::permissions(p, std::filesystem::perms::owner_write | std::filesystem::perms::others_all, std::filesystem::perm_options::remove);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Resize a regular file?</summary>

> **Description**
>
> ```cpp
> std::filesystem::resize_file(p, newSize);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Change the current directory of the process?</summary>

> ```cpp
> std::filesystem::current_path(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

### Filesystem Existence Checking

<details>
<summary>Check if a file exists?</summary>

> `exists()` follows symbolic links. So, it yields `false` if there is a
> symbolic link to a non-existing file. To avoid following symbolic links, use
> `symlink_status()` and then call `exists()` using the returned `file_status`
> object.
>
> ```cpp
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     std::filesystem::path existing_file{"/dev/random"};
>     std::filesystem::path non_existing_file{"/dev/none"};
>     std::filesystem::path existing_symlink{"/lib"};
>
>     std::filesystem::exists(existing_file);
>     std::filesystem::exists(non_existing_file);
>     std::filesystem::exists(symlink_status(existing_symlink));
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### File Status

<details>
<summary>Use filesystem operations without following symbolic links?</summary>

> Use `symlink_status()` function to return a `file_status` object and call
> these functions with it.
>
> ```cpp
> // check if p doesn't exist yet (as symbolic link)
> if (!exists(symlink_status(p)))
>     ...
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the status of a file following any symbolic links?</summary>

> ```cpp
> std::filesystem::status(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the status of a file without following symbolic links?</summary>

> ```cp
> std::filesystem::symlink_status(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Improve performance of file operation calls using file status?</summary>

> ```cpp
> std::filesystem::path p{};
> std::filesystem::file_status fs = std::filesystem::status(p);
>
> std::filesystem::is_regular_file(fs);
> std::filesystem::is_directory(fs);
> std::filesystem::is_symlink(fs);
> std::filesystem::is_other(fs);
>
> std::filesystem::is_character_file(fs);
> std::filesystem::is_block_file(fs);
> std::filesystem::is_fifo(fs);
> std::filesystem::is_socket(fs);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the type of a file using file status?</summary>

> **Description**
>
> ```cpp
> std::filesystem::path p{};
> std::filesystem::file_status fs = std::filesystem::status(p);
> std::filesystem::file_type ft = fs.type();
>
> switch (fs.type())
> {
>     using std::filesystem::file_type;
>     case (file_type::regular):      std::cout << "regular"; break;
>     case (file_type::directory):    std::cout << "directory"; break;
>     case (file_type::block):        std::cout << "block"; break;
>     case (file_type::character):    std::cout << "char"; break;
>     case (file_type::symlink):      std::cout << "symlink"; break;
>     case (file_type::socket):       std::cout << "socket"; break;
>     case (file_type::fifo):         std::cout << "fifo"; break;
>     case (file_type::not_found):    std::cout << "not found"; break;
>     case (file_type::unknown):      std::cout << "unknown"; break;
>     case (file_type::none):         std::cout << "none"; break;
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the permissions of a file using its file status?</summary>

> ```cpp
> std::filesystem::path p{};
> std::filesysetm::file_status fs = std::filesystem::status(p);
> std::filesystem::perms file_permissions = fs.permissions();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the type of a file?</summary>

> ```cpp
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     std::filesystem::path file{"/etc/passwd"};
>     std::filesystem::file_status status{std::filesystem::status(file)};
>     std::cout << "file type: ";
>     std::cout << "\n";
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### File Permissions

<details>
<summary>Yield which permissions does a file have?</summary>

> |Enum|Octal|POSIX|
> |---|---|---|
> |`none`|0||
> |`owner_read`|0400|`S_IRUSR`|
> |`owner_write`|0200|`S_IWUSR`|
> |`owner_exec`|0100|`S_IXUSR`|
> |`owner_all`|0700|`S_IRWXU`|
> |`group_read`|040|`S_IRGRP`|
> |`group_write`|020|`S_IWGRP`|
> |`group_exec`|010|`S_IXGRP`|
> |`group_all`|070|`S_IRWXG`|
> |`others_read`|04|`S_IROTH`|
> |`others_write`|02|`S_IWOTH`|
> |`others_exec`|01|`S_IXOTH`|
> |`others_all`|07|`S_IRWXO`|
> |`all`|0777||
> |`set_suid`|04000|`S_ISUID`|
> |`set_guid`|02000|`S_ISGID`|
> |`sticky_bit`|01000|`S_ISVTX`|
> |`mask`|07777||
> |`unknown`|0xFFFF||
>
> ```cpp
> std::filesystem::path p{};
> std::filesystem::file_status fs = std::filesystem::symlink_status(fs);
> std::filesystem::perms perms = fs.permissions();
> std::filesystem::perms write_free = std::filesystem::perms::owner_write | std::filesystem::perms::group_write | std::filesystem::perms::others_write;
>
> if ((perms & write_free) != std::filesystem::perms::none)
> {
> }
> ``````
>
> A shorter way to initialize a bitmask is:
>
> ```cpp
> if ((perms & std::filesystem::perms{0222}) != std::filesystem::perms::none)
> {
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

### File Creation

<details>
<summary>Create a regular file?</summary>

> ```cpp
> #include <fstream>
>
> std::fstream file{"/tmp/non-existing-file"};
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

### Directory Creation

<details>
<summary>Create a directory inside an existing directory?</summary>

> ```cpp
> std::filesystem::create_directory(p);
> std::filesystem::create_directory(p, attributes);
> ``````
>
> The functions to create one or more directories return whether a new
> directory was created. Thus, finding a directory that is already there is not
> an error. However, finding a file there that is not a directory is also not
> an error.
>
> ```cpp
> if (!create_directory(p) && !is_directory(p))
> {
>     std::cerr << p << " already exists as a non-directory\n";
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Create a tree of nested directories?</summary>

> **Description**
>
> ```cpp
> std::filesystem::create_directories(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

### Symbolic Link Creation

<details>
<summary>Create a symbolic link to a regular file?</summary>

> **Description**
>
> If path already exists as a symbolic link to a non-existing file, it will try
> to create the symbolic link at the location where already the symbolic link
> exists and raise a corresponding exception.
>
> ```cpp
> std::filesystem::create_symlink(to, new);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Create a symbolic link to a directory?</summary>

> ```cpp
> std::filesystem::create_directory_symlink(to, new);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

### Hard Link Creation

<details>
<summary>Create a hard link from a file?</summary>

> ```cpp
> std::filesystem::create_hard_link(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

### File Copy

<details>
<summary>Copy from a file of any type?</summary>

> ```cpp
> std::filesystem::copy(from, to);
> std::filesystem::copy(from, to, options);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Copy from a regular file?</summary>

> ```cpp
> std::filesystem::copy_file(from, to);
> std::filesystem::copy_file(from, to, options);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Why there is copy options?</summary>

> Copy functions:
>
> - Don't work with special file types.
> - Report an error if existing files are overwritten.
> - Don't operate recursively.
> - Follow symbolic links.
>
> ```cpp
> enum class std::filesystem::copy_options {
>     none,
>     skip_existing,      // skip overwriting existing files
>     overwrite_existing, // overwrite existing files
>     update_existing,    // overwrite existing files if the new files are newer
>     recursive,          // recursively copy sub-directories and their contents
>     copy_symlinks,      // copy symbolic links as symbolic links
>     skip_symlinks,      // ignore symbolic links
>     directories_only,   // copy directories only
>     create_hard_links,  // create additional hard links instead of copies of files
>     create_symlinks     // create symbolic links instead of copies of files
>     // for latter option the source path must be absolute path unless
>     // the destination path is in the current directory
> };
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Copy a symbolic link?</summary>

> Both symlinks would refer to the same file.
>
> ```cpp
> std::filesystem::copy_symlink(from, to);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### File Removal

<details>
<summary>Remove a file?</summary>

> **Description**
>
> ```cpp
> std::filesystem::remove(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Recursively remove a directory and all of its contents?</summary>

> **Description**
>
> Removes a file or recursively a directory. It returns as `uintmax_t` value
> how many files were removed. It returns 0 if there was no file and
> `uintmax_t(-1)` if an error occured and no exception is thrown.
>
> ```cpp
> std::filesystem::remove_all(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Filesystem Path Conversion

<details>
<summary>Yield the file an existing symbolic link refers to?</summary>

> **Description**
>
> The symbolic link and the file it refers to must already exist.
>
> ```cpp
> std::filesystem::read_symlink(symlink);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the absolute path of an existing path?</summary>

> `absolute()` function does not follow symbolic links.
>
> ```cpp
> std::filesystem::absolute(p);
> ``````
>
> `canonical()` function follows symbolic links.
> The file must already exist for this function to work.
>
> ```cpp
> std::filesystem::canonical(p);
> std::filesystem::weakly_canonical(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the relative path from current directory to a path?</summary>

> **Description**
>
> ```cpp
> std::filesystem::relative(p);
> std::filesystem::proximate(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the relative path from a base path to another path?</summary>

> ```cpp
> std::filesystem::relative(p, base);
> std::filesystem::proximate(p, base);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

### Directory Iteration

<details>
<summary>Iterate over the entries of a directory?</summary>

> The most convenient way to do is to use a range-based for loop.
>
> ```cpp
> for (auto const& entry: std::filesystem::directory_iterator(dir))
> {
>     std::cout << entry.lexically_normal().string() << '\n';
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Recursively iterate over directories with following symbolic links?</summary>

> ```cpp
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are the directory iterator options?</summary>

> When iterating over directories you can pass values of type
> `directory_options`. The type is a bitmask scoped enumeration type, defined
> in namespace `std::filesystem` as follows:
>
> ```cpp
> namespace std::filesystem {
>     enum class directory_options {
>         none,
>         follow_directory_symlink,
>         skip_permission_denied
>     };
> }
> ``````
>
> The default is not to follow symbolic links and to skip directories you are
> not allowed to iterate over. With `skip_permission_denied` iterating over a
> denied directory, results in an exception.
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

### Directory Entries

<details>
<summary>What operations are supported by directory entries?</summary>

> The elements directory iterators iterate over are of type
> `std::filesystem::directory_entry`. These iterators are input iterators. The
> reason is that iterating over a directory might result into different results
> as at any time directory entries might change. This has to be taken into
> account when using directory iterators in parallel.
>
> ```cpp
> e.path();
> e.exists()
> e.is_regular_file()
> e.is_directory()
> e.is_symlink()
> e.is_other()
> e.is_block_file()
> e.is_character_file()
> e.is_fifo()
> e.is_socket()
> e.file_size()
> e.hard_link_count()
> e.last_write_time()
> e.status()
> e.symlink_status()
> e1 == e2
> e1 != e2
> e1 < e2
> e1 <= e2
> e1 > e2
> e1 >= e2
> e.assign(p)
> e.replace_filename(p)
> e.refresh()
> ``````
>
> `assign()` and `replace_filename()` call the corresponding modifying path
> operations but do not modify the files in the underlying filesystem.
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Chapter 21/29
## Chapter 22/29
## Chapter 23/29
## Chapter 24/29
## Chapter 25/29
## Chapter 26/29
## Chapter 27/29
## Chapter 28/29
## Chapter 29/29
