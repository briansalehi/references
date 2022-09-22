# [C++20: The Complete Guide](#)
<img alt="" src="covers/.jpg" width="200"/>

> This book is one of the five (so far) essential books by Josuttis.

## Chapter 1/19

<details>
<summary>Define a user-defined type and overload all of comparison operators for it.</summary>

* All comparisons are based on either operator == or operator <
* Operators should be declared with `noexcept` if they cannot throw
* Operators should be declared with `constexpr` if they can be used at compile time
* Operators should be declared hidden friends if the constructors are not `explicit`
* Operators should be declared with `[[nodiscard]]` to warn if the return value is not used

```cpp
class basic_value
{
public:
    constexpr basic_value(long const init) noexcept : id{init} {}

    [[nodiscard]] friend constexpr
    bool operator ==(basic_value const& lhs, basic_value const& rhs) noexcept
    { return lhs.number == rhs.number; }


private:
    long number;
};
```
</details>


## Chapter 2/19
## Chapter 3/19
## Chapter 4/19
## Chapter 5/19
## Chapter 6/19
## Chapter 7/19
## Chapter 8/19
## Chapter 9/19
## Chapter 10/19
## Chapter 11/19
## Chapter 12/19
## Chapter 13/19
## Chapter 14/19
## Chapter 15/19
## Chapter 16/19
## Chapter 17/19
## Chapter 18/19
## Chapter 19/19
