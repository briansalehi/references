# Why do chrono date types accept invalid input?

That makes them cheap and compile-time constructible types. But this means validations must be explicit:

```cpp
#include <chrono>
#include <print>

int main()
{
    using std::chrono::January;
    using std::chrono::February;
    using namespace std::chrono_literals;

    std::chrono::year_month_day valid = 2026y / January / 29;
    std::chrono::year_month_day invalid = 2026y / February / 29;

    std::println("{} {}", valid, valid.ok());
    std::println("{:%D} {}", valid, valid.ok());
    std::println("{:%D} {}", invalid, invalid.ok());
}
```

When an invalid date is printed with default formatter, there will be a warning appended to its output. This warning will not be printed when `%D` specifier is used.
