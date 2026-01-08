# What arithmetic operations are supported by std::chrono::day?

Member functions:

```cpp
constexpr std::chrono::day& operator+=( std::chrono::days const& ) noexcept;
constexpr std::chrono::day& operator-=( std::chrono::days const& ) noexcept;
```

Free functions:

```cpp
constexpr std::chrono::day& operator+=( std::chrono::day const&, std::chrono::days const& ) noexcept;
constexpr std::chrono::day& operator+=( std::chrono::days const&, std::chrono::day const& ) noexcept;
constexpr std::chrono::day& operator-=( std::chrono::day const&, std::chrono::days const& ) noexcept;
constexpr std::chrono::days& operator-=( std::chrono::day const&, std::chrono::day const& ) noexcept;
```

When two `std::chrono::day` operators are subtracted, the result is a `std::chrono::days` duration type.

Operators `--` and `++` are also supported.

```cpp
#include <chrono>
#include <print>

int main()
{
    std::chrono::day today{8};
    std::chrono::day someday{30};

    today += std::chrono::days{20};
    std::println("{}", today);

    std::chrono::day never = someday + std::chrono::days{10};
    std::println("{}: {}", never, never.ok());

    std::chrono::days diff = today - someday;
    std::println("{}: {}", diff, diff.ok());
}
```
