# [C++20: The Complete Guide](https://www.amazon.com/20-Complete-Guide-Nicolai-Josuttis/dp/3967309207)
<img alt="" src="covers/.jpg" width="200"/>


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

<details>
<summary>What object is used to represent the sequence of elements as a whole to be passed  to algorithms instead of <code>begin()</code> and <code>end()</code> functions?</summary>

> Ranges
</details>

<details>
<summary>What are the preconditions and requirements of <code>std::ranges::sort()</code> to accept a container?</summary>

* To have random access iterators, iterators that can be used to read, write, jump back and forth, and compute distance.
* To be sortable and support comparison operators.
</details>

<details>
<summary>How to use ranges to sort a container?</summary>

```cpp
#include <algorithm>
#include <vector>
#include <ranges>

int main()
{
    std::vector<int> numbers{3,5,1,2,4};
    std::ranges::sort(numbers);
}
```
</details>

<details>
<summary>What object can be used to iterate over the elements of a range by filtering out some elements or performing some transformaions of their values?</summary>

> Views
</details>

<details>
<summary>How to iterate over first 5 elements of a range using view adaptors?</summary>

```cpp
std::ranges::take(container, 5);
```
</details>


<details>
<summary>How to sort only the first 5 elements of a container using ranges</summary>

```cpp
#include <vector>
#include <ranges>

int main()
{
    std::vector<int> numbers{42,80,13,26,51,9,38};
    std::ranges::sort(std::views::take(numbers, 5));
}
```
</details>

<details>
<summary>How to generate a sequence of values using views?</summary>

```cpp
std::views::iota(1, 11); // [1,10]
```
</details>

<details>
<summary>How to use combination of ranges and views that don't generate values to make filtering blocks?</summary>

```cpp
// nested form
auto v = std::views::take(
            std::views::transform(
                std::views::filter(container, [](auto e) { return e % 3 == 0; }),
                [](auto e) { return e * e; }),
            3);

// piped form
auto v = container | std::views::filter([](auto e) { return e % 2 == 0; })
                   | std::views::transform([](auto e) { return e * e; })
                   | std::views::take(3);
```
</details>

<details>
<summary>How to use a sentinel as an end of a range in iterating over a container?</summary>

```cpp
```
</details>

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
