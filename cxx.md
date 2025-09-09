# C++
#### surface
#### Building Executable

###### Compile an optimized release configuration of a source that includes a header from the source directory and a header from the system and linked to a library?

```hpp
#pragma once

class example
{
public:
    example();
};
```

```cpp
#include <example.hpp>

example::example() { }
```

```cpp
#include <example.hpp>
#include <boost/system.hpp>

int main()
{
    example object{};
}
```

```sh
gcc -O3 -Wall -Wextra -Werror -pedantic -I. main.cpp example.cpp -o program -l boost_system
```
