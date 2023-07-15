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

