# [A Complete Guide to Standard C++ Algorithms]()
<img alt="A Complete Guide to Standard C++ Algorithms" src="covers/a-complete-guide-to-standard-cpp-algorithms.jpg" width="200"/>

<details>
<summary>How to use <code>std::for_each</code> algorithm with a predicate to sum values of a container?</summary>

> ```cp
> #include <algorithm>
> #include <vector>
> 
> template <typename T, typename S = std::size_t>
> struct sum_predicate
> {
>     S count;
>     T sum;
>     void operator()(T const& e)
>     {
>         count++;
>         sum += e;
>     }
> };
> 
> int main()
> {
>     std::vector<long> numbers{1, 2, 3, 4, 5};
>     auto [count, sum] = std::for_each(numbers.begin(), numbers.end(), sum_predicate<long>{});
>     // count: 5, sum: 15
> }
> ``````

> Origin: 1.1

> References:
---
</details>

<details>
<summary>How to use <code>std::for_each</code> algorithm with a capturing lambda to sum values of a container?</summary>

> ```cpp
> #include <algorithm>
> #include <vector>
> 
> int main()
> {
>     std::size_t count{};
>     long sum{};
>     std::vector<long> numbers{1, 2, 3, 4, 5};
>     std::for_each(numbers.begin(), numbers.end(), [&](auto const& e){ count++; sum += e; });
>     // count: 5, sum: 15
> }
> ``````

> Origin: 1.1

> References:
---
</details>

<details>
<summary>How to use <code>std::for_each</code> algorithm with unsequenced parallel execution model to sum values of a container?</summary>

> Note that variables are now shared state and need to be `std::atomic<>` or protected by a `std::mutex<>`.
>
> ```cp
> #include <algorithm>
> #include <execution>
> #include <atomic>
> #include <vector>
> 
> int main()
> {
>     std::atomic<std::size_t> count{};
>     std::atomic<long> sum{};
>     std::vector<long> numbers{1, 2, 3, 4, 5};
>     std::for_each(std::execution::par_unseq, numbers.begin(), numbers.end(), [&](auto const& e){ count++; sum += e; });
>     // count: 5, sum: 15
> }
> ``````

> Origin: 1.1

> References:
---
</details>

<details>
<summary>How to use ranges algorithm <code>std::ranges::for_each</code> to sum values of a container?</summary>

> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::size_t count{};
>     long sum{};
>     std::vector<long> numbers{1, 2, 3, 4, 5};
>     std::ranges::for_each(numbers, [&](auto const& e){ count++; sum += e; });
>     // count: 5, sum: 15
> }
> ``````

> Origin: 1.1

> References:
---
</details>

<details>
<summary>What is a sentinel and how is it different compared to a range?</summary>

> A *range* is then denoted by a pair of *iterators*, or more generally, since C++20, an *iterator* and a *sentinel*.
>
> To reference the entire content of a data structure, we can use the `begin()` and `end()` methods that return an iterator to the first element and an iterator one past the last element, respectively.
> Hence, the range [begin, end) contains all data structure elements.
>
> ```cpp
> #include <iostream>
> #include <algorithm>
> #include <vector>
> 
> int main()
> {
>     std::vector<int> numbers{1,2,3,4,5};
> 
>     auto iter1 = numbers.begin();
>     auto iter2 = numbers.end();
> 
>     std::for_each(iter1, iter2, [](auto e) { std::cout << e << " "; });
> }
> ``````
>
> Sentinels follow the same idea. However, they do not need to be of an iterator type.
> Instead, they only need to be comparable to an iterator.
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

> Origin: 1.2

> References:
---
</details>

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

> Origin: 1.3

> References:
---
</details>

<details>
<summary>How to think of standard algorithms in terms of ranges instead of iterators?</summary>

> The benefit of thinking about the returned value as the end iterator of a range is that it removes the potential for corner cases.
>
> ```cp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> in{1,2,3,4,5,6,7,8,9,10};
>     std::vector<long> out(10, 0);
> 
>     std::copy(in.begin(), in.end(), out.begin());
>     // output range is implied as: std::next(out.begin(), std::distance(in.begin(), in.end()));
> }
> ``````

> Origin: 1.4

> References:
---
</details>

<details>
<summary>Find the end iterator of a maximal sorted sub-range using standard algorithms?</summary>

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
>
> What if the algorithm doesn’t find any element out of order as a corner case?
> The returned value will be the end iterator of the source range, meaning that the range returned is simply the entire source range.

> Origin: 1.4

> References:
---
</details>

<details>
<summary>Iterate over all the elements of a container using <code>std::for_each</code>?</summary>

> The C++11 standard introduced the range-based for loop, which mostly replaced the uses of `std::for_each`.
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5};
>     std::size_t sum{};
>     std::for_each(numbers.begin(), numbers.end(), [&sum](auto const e) { sum += e; });
>     for (auto e: numbers) { sum += e; }
> }
> ``````
>
> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |

> Origin: 2.1

> References:
---
</details>
