# C++17 STL Cookbook
<img src="../covers/9781787120495.jpg" width="200"/>

## Chapter 1/10
## Chapter 2/10
## Chapter 3/10
## Chapter 4/10
## Chapter 5/10
## Chapter 6/10
## Chapter 7/10
## Chapter 8/10
## Chapter 9/10
## Chapter 10/10 <sup>(writing)</sup>

<details>
<summary>Check if <code>/usr/src/linux/version</code> file exists?</summary>

> ```cpp
> #include <filesystem>
>
> int main()
> {
>     try
>     {
>         std::filesystem::path version_path{"/usr/src/linux/version"}; // throws std::bad_alloc
>
>         if (std::filesystem::exists(version_path)) // throws std::system_error
>         {
>             // ...
>         }
>     }
>     catch (std::system_error const& exp)
>     {
>         std::cerr << "file operation error: " << exp.what() << std::endl;
>     }
>     catch (std::bad_alloc const& exp)
>     {
>         std::cerr << "path could not be allocated: " << exp.what() << std::endl;
>     }
> }
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>Get the current path of executing program?</summary>

> ```cpp
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     try
>     {
>         std::filesystem::path working_directory{std::filesystem::current_path()};
>         std::cout << working_directory << std::endl;
>     }
>     catch (std::filesystem::filesystem_error const& exp)
>     {
>         std::cerr << exp.what() << std::endl;
>     }
> }
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Get the canonical form of a path?</summary>

> `std::filesystem::canonical()` throws a `std::filesystem_error` type
> exception if the path we want to canonicalize does not exist.
>
> ```cpp
> #include <iostream>
> #include <exception>
> #include <filesystem>
>
> int main()
> {
>     try
>     {
>         std::filesystem::path relative_path{"/usr/././lib/../include"};
>         std::filesystem::path canonical_path{std::filesystem::canonical(relative_path)};
>         std::cout << canonical_path << std::endl;
>     }
>     catch (std::filesystem::filesystem_error const& exp)
>     {
>         std::cerr << exp.what() << std::endl;
>     }
>     catch (std::bad_alloc const& exp)
>     {
>         std::cerr << exp.what() << std::endl;
>     }
> }
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>Get the canonical form of a path relative to another path?</summary>

> `std::filesystem::canonical()` accepts a path as an optional second argument.
>
> ```cpp
> path canonical(path const& p, path const& base = current_path());
> ``````
>
> The second path `base` is prepended to path `p` if `p` is a relative path.
>
> ```cpp
> #include <iostream>
> #include <exception>
> #include <filesystem>
>
> int main()
> {
>     try
>     {
>         std::filesystem::path relative_path{"./lib/../include"};
>         std::filesystem::path base_path{"/usr"};
>         std::filesystem::path canonical_path{std::filesystem::canonical(relative_path, base_path)};
>         std::cout << canonical_path << std::endl;
>     }
>     catch (std::filesystem::filesystem_error const& exp)
>     {
>         std::cerr << exp.what() << std::endl;
>     }
>     catch (std::bad_alloc const& exp)
>     {
>         std::cerr << exp.what() << std::endl;
>     }
> }
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Get the absolute path of <code>./.local/bin</code>?</summary>

> `std::filesystem::canonical()` does what `std::filesystem::absolute()` does,
> but canonical additionally removes any "." or ".." paths.
>
> `std::filesystem::absolute()` does not call system calls.
>
> ```cpp
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     try
>     {
>         std::filesystem::path relative_path{"./.local/bin"};
>         auto absolute_path{std::filesystem::absolute(relative_path)};
>
>         std::cout << absolute_path << std::endl;
>     }
>     catch (std::filesystem::filesystem_error const& exp)
>     {
>         std::cerr << exp.what() << std::endl;
>     }
>     catch (std::bad_alloc const& exp)
>     {
>         std::cerr << exp.what() << std::endl;
>     }
> }
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Concatenate two paths?</summary>

> `std::filesystem::path` overloads `operator/` and `operator+` for path
> concatenation, but `operator/` uses path separators between junctions and
> `operator+` only acts as string concatanation.
>
> ```cpp
> #include <filesystem>
>
> std::filesystem::path parent{"/usr/bin"};
> std::filesystem::path executable{"bash"};
> std::filesystem::path shell{parent + executable}; // /usr/binbash
> std::filesystem::path shell{parent / executable}; // /usr/bin/bash
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Check if two paths are addressing the same location?</summary>

> `std::filesystem::equivalent()` canonicalizes the paths, which it accepts as
> arguments and returns true if they describe the same path after all.
>
> Both operands need to exist before call to this free-standing function. It
> will throw `std::filesystem::system_error` otherwise.
>
> ```cpp
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     std::filesystem::path p1{"/lib/modules"};
>     std::filesystem::path p2{"/usr/lib/modules"};
>     std::cout << std::boolalpha << std::filesystem::equivalent(p1, p2) << std::endl;
>     // true
> }
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Get the type of a file from its path?</summary>

> ```cpp
> #include <filesystem>
>
> std::filesystem::is_directory("/usr/bin"); // true
> std::filesystem::is_regular_file("/usr/bin/bash"); // true
> std::filesystem::is_symlink("/lib"); // true
> std::filesystem::is_character_file("/dev/random"); // true
> std::filesystem::is_block_file("/dev/sda"); // true
> std::filesystem::is_fifo("/dev/null"); // false
> std::filesystem::is_socket("/dev/null"); // false
> std::filesystem::other("/dev/null"); // false
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Make the type checking of a file cheaper by not calling system calls?</summary>

> ```cpp
> #include <filesystem>
>
> std::filesystem::path executables_path{"/usr/local/bin"};
> std::filesystem::file_status executables_status{std::filesystem::file_status(executables_path)};
>
> std::filesystem::is_directory(executables_status);
> std::filesystem::is_regular_file(executables_status);
> std::filesystem::is_symlink(executables_status);
> std::filesystem::is_character_file(executables_status);
> std::filesystem::is_block_file(executables_status);
> std::filesystem::is_fifo(executables_status);
> std::filesystem::is_socket(executables_status);
> std::filesystem::other(executables_status);
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Check if the permission of a file includes user, group, and others access?</summary>

> ```cpp
> #include <fstream>
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     std::filesystem::perms perms = std::filesystem::status("/dev/null").permissions();
>
>     std::cout << ((perms & std::filesystem::perms::owner_read)   == std::filesystem::perms::none ? '-' : 'r');
>     std::cout << ((perms & std::filesystem::perms::owner_write)  == std::filesystem::perms::none ? '-' : 'w');
>     std::cout << ((perms & std::filesystem::perms::owner_exec)   == std::filesystem::perms::none ? '-' : 'x');
>     std::cout << ((perms & std::filesystem::perms::group_read)   == std::filesystem::perms::none ? '-' : 'r');
>     std::cout << ((perms & std::filesystem::perms::group_write)  == std::filesystem::perms::none ? '-' : 'w');
>     std::cout << ((perms & std::filesystem::perms::group_exec)   == std::filesystem::perms::none ? '-' : 'x');
>     std::cout << ((perms & std::filesystem::perms::others_read)  == std::filesystem::perms::none ? '-' : 'r');
>     std::cout << ((perms & std::filesystem::perms::others_write) == std::filesystem::perms::none ? '-' : 'w');
>     std::cout << ((perms & std::filesystem::perms::others_exec)  == std::filesystem::perms::none ? '-' : 'x');
> }
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Get the size of a regular file?</summary>

> ```cpp
> #include <filesystem>
>
> std::filesystem::path file_path{"/usr/bin/g++"};
> std::size_t size = std::filesystem::file_size(file_path);
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Iterate over the entries of a directory?</summary>

> ```cpp
> #include <filesystem>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> std::vector<std::filesystem::directory_entry> entries;
> std::filesystem::path directory_path{"/usr/bin"};
> std::filesystem::directory_iterator entry_iterator{std::filesystem::directory_iterator{directory_path}};
> std::copy(entry_iterator, std::back_inserter(entries));
> ``````
>
> ---
> **Resources**
> - C++17 STL Cookbook - Chapter 10
>
> ---
> **References**
> ---
</details>

