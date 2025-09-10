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

#### Variable Initialization

###### Define a function to evaluate multiplication of a double to a global constant number in compile time?

```cpp
constexpr double pi{3.1415};

double pi_times(double const value)
{
    return value * pi;
}
```

#### Smart Pointer

###### Share the instance of an object without losing ownership?

```cpp
#include <memory>

class Heavy { };

class Owner
{
private:
    std::shared_ptr<Heavy> heavy;
public:
    Owner(std::unique_ptr<Heavy> init): heavy{std::move(init)}
    {
    }
    
    std::weak_ptr<Heavy> getObject() const
    {
        return heavy;
    }
};

int main()
{
    std::unique_ptr<Heavy> heavy;
    Owner owner{std::move(heavy)};
    std::weak_ptr<Heavy> object{owner.getObject()};
    std::shared_ptr<Heavy> shared{object.lock()};
    // use shared
}
```
