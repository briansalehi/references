# C++ Programming

## Ranges

## Sentinels

<details>
<summary>What is a sentinel in ranges library?</summary>

> A *range* is denoted by a pair of *iterators*, or more generally, since C++20, an *iterator* and a *sentinel*.
>
> To reference the entire content of a data structure, we can use the `begin()` and `end()` methods that return an iterator to the first element and an iterator one past the last element, respectively.
> Hence, the range [begin, end) contains all data structure elements.
>
> ```cpp
> #include <algorithm>
> #include <iostream>
> #include <vector>
>
> int main()
> {
>     std::vector<int> numbers{1,2,3,4,5};
>     std::for_each(std::begin(numbers), std::end(numbers), [](auto e) { std::cout << e << " "; });
> }
> ``````
>
> *Sentinels* follow the same idea. However, they do not need to be of an *iterator* type.
> Instead, they only need to be comparable to an *iterator*.
> The exclusive end of the range is then the first iterator that compares equal to the sentinel.
>
> ```cpp
> #include <iostream>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> template <typename T>
> struct sentinel
> {
>     using iter_t = typename std::vector<T>::iterator;
>     iter_t begin;
>     std::iter_difference_t<iter_t> count;
>     bool operator==(iter_t const& other) const { return std::distance(begin, other) >= count; }
> };
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5};
>     std::vector<long>::iterator iter = numbers.begin();
>     std::ranges::for_each(iter, sentinel<long>{iter, 3}, [](auto e) { std::cout << e << " "; });
> }
> ``````

> Origin: A Complete Guide to Standard C++ Algorithms - Section 1.2

> References:
---
</details>

## Iterators

<details>
<summary>How to move iterators back and forth regardless of their bidirectional support?</summary>

> ```cpp
> #include <algorithm>
> #include <vector>
> #include <list>
>
> int main()
> {
>     std::vector<long> random_access{1,2,3,4,5};
>     std::list<long> bidirectional{1,2,3,4,5};
>
>     auto random_access_iterator = random_access.begin();
>     random_access_iterator += 3; // OK
>     random_access_iterator++; // OK
>     ssize_t random_difference = random_access_iterator - random_access.begin(); // OK: 4
>
>     auto bidirectional_iterator = bidirectional.begin();
>     //bidirectional_iterator += 5; // ERROR
>     std::advance(bidirectional_iterator, 3); // OK
>     bidirectional_iterator++; // OK, all iterators provide advance operation
>     //ssize_t bidirectional_difference = bidirectional_iterator - bidirectional.begin(); // ERROR
>     ssize_t bidirectional_difference = std::distance(bidirectional.begin(), bidirectional_iterator); // OK: 4
> }
> ``````

> Origin: A Complete Guide to Standard C++ Algorithms - Section 1.3

> References:
---
</details>

## Algorithms

### 1. Iteration

<details>
<summary>Using the standard algorithms, sum the values of a container?</summary>

> | `std::for_each` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The C++11 standard introduced the range-based for loop, which mostly replaced the uses of `std::for_each`.
>
> ```cp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> template <typename T>
> struct sum_predicate
> {
>     T sum;
>     void operator()(T const& e) { sum += e; }
> };
>
> int main()
> {
>     std::vector<long> numbers{1, 2, 3, 4, 5};
>     long sum{};
>
>     sum = std::for_each(numbers.begin(), numbers.end(), sum_predicate<long>{});
>     // sum == 15, using a unary predicate
>
>     std::for_each(numbers.begin(), numbers.end(), [&sum](auto e){ sum += e; });
>     // sum == 30, using a lambda
>
>     std::ranges::for_each(numbers, [&sum](auto e){ count++; sum += e; });
>     // sum == 45, using ranges
>
>     for (auto e: numbers) { sum += e; }
>     // sum == 60, using range-based for
> }
> ``````

> Origin: A Complete Guide to Standard C++ Algorithms - Section 1.1

> References:
---
</details>

<details>
<summary>Iterate over a range with <i>unsequenced parallel execution</i> model?</summary>

> As long as the operations are independent, there is no need for synchronization primitives.
>
> ```cpp
> #include <algorithm>
> #include <execution>
> #include <ranges>
> #include <vector>
>
> struct work
> {
>     void expensive_operation() { /* ... */ }
> };
>
> int main()
> {
>     std::vector<work> work_pool{work{}, work{}, work{}};
>     std::for_each(std::execution::par_unseq, work_pool.begin(), work_pool.end(), [](work& w) { w.expensive_operation(); });
> }
> ``````
>
> When synchronization is required, operations need to be atmoic.
>
> ```cpp
> #include <algorithm>
> #include <execution>
> #include <atomic>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5};
>     std::atomic<size_t> sum{};
>     std::for_each(std::execution::par_unseq, numbers.begin(), numbers.end(), [&sum](auto& e) { sum += e; });
> }
> ``````
>
> Note: parallel execution requires *libtbb* library to be linked.

> Origin: A Complete Guide to Standard C++ Algorithms - Section 1.1

> References:
---
</details>

<details>
<summary>Invoke an external method utilizing a projection over the entire elements of a range?</summary>

> ```cp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> struct work_unit
> {
>     size_t value;
>     work_unit(size_t initial): value{std::move(initial)} {}
>     size_t current() const { return value; }
> };
>
> int main()
> {
>     size_t sum{};
>     std::vector<work_unit> tasks{1,2,3};
>     std::ranges::for_each(tasks, [&sum](auto const& e) { sum += e; }, &work_unit::current);
>     // sum: 6
> }
> ``````

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.1.1

> References:
---
</details>

<details>
<summary>Iterate over a limited number of elements within a range?</summary>

> | `std::for_each_n` | standard |
> | --- | --- |
> | introduced | C++17 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> While `std::for_each` operates on the entire range, the interval $[begin, end)$, while the `std::for_each_n` operates on the range $[first, first + n)$.
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5,6};
>     std::size_t sum{};
>     std::for_each_n(numbers.begin(), 3, [&sum](auto const& e) { sum += e; });
>     // sum = 6
> }
> ``````
>
> Importantly, because the algorithm does not have access to the end iterator of the source range, it does no out-of-bounds checking, and it is the responsibility of the caller to ensure that the range $[first, first + n)$ is valid.

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.1

> References:
---
</details>

### 2. Sorting

<details>
<summary>Find the maximal sorted sub-range within a range using standard algorithms?</summary>

> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5};
>
>     auto last_sorted = std::is_sorted_until(numbers.begin(), numbers.end());
>
>     for (auto iter = numbers.begin(); iter != last_sorted; ++iter)
>         continue;
>
>     for (auto v: std::ranges::subrange(numbers.begin(), last_sorted))
>         continue;
> }
> ``````

> Origin: A Complete Guide to Standard C++ Algorithms - Section 1.4

> References:
---
</details>
