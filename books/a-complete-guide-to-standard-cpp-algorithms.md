# [A Complete Guide to Standard C++ Algorithms]()
<img alt="A Complete Guide to Standard C++ Algorithms" src="../covers/a-complete-guide-to-standard-cpp-algorithms.png" width="200"/>

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

> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
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

> Origin: 2.1

> References:
---
</details>

<details>
<summary>How to use parallel executaion on <code>std::for_each</code> to invoke an expensive operation for each element of a container?</summary>

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

> Origin: 2.1

> References:
---
</details>

<details>
<summary>Use range based <code>std::for_each</code> utilizing a projection to invoke external methods?</summary>

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

> Origin: 2.1.1

> References:
---
</details>

<details>
<summary>Iterate over a limited number of a container using <code>std::for_each_n</code>?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++17 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> While `std::for_each` operates on the entire range, the interval $[begin, end)$, `std::for_each_n` operates on the range $[first, first + n)$.
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

> Origin: 2.1

> References:
---
</details>

<details>
<summary>How to swap two values?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> Correctly calling swap requires pulling the default std::swap version to the local scope.
>
> ```cpp
> #include <algorithm>
> 
> namespace library
> {
>     struct container { long value; };
> }
> 
> int main()
> {
>     library::container a{3}, b{4};
>     std::ranges::swap(a, b); // first calls library::swap
>                              // then it calls the default move-swap
> }
> ``````

> Origin: 2.2.1

> References:
---
</details>

<details>
<summary>Swap values of a range using <code>std::iter_swap</code>?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::iter_swap` is an indirect swap, swapping values behind two forward iterators.
>
> ```cpp
> #include <algorithm>
> #include <memory>
> 
> int main()
> {
>     auto p1 = std::make_unique<int>(1);
>     auto p2 = std::make_unique<int>(2);
> 
>     int *p1_pre = p1.get();
>     int *p2_pre = p2.get();
> 
>     std::ranges::swap(p1, p2);
>     // p1.get() == p1_pre, *p1 == 2
>     // p2.get() == p2_pre, *p2 == 1
> }
> ``````

> Origin: 2.2.2

> References:
---
</details>

<details>
<summary>How to exchange elements between two non-overlapping ranges using <code>std::swap_ranges</code>?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5,6};
>     std::swap_ranges(numbers.begin(), numbers.begin()+2, numbers.rbegin());
>     // numbers: {6,5,3,4,2,1}
> }
> ``````

> Origin: 2.2.3

> References:
---
</details>

<details>
<summary>What is the minimum requirement for a type to be comparable with <code>strict_weak_ordering</code>?</summary>

> Implementing a `strict_weak_ordering` for a custom type, at minimum requires providing an overload of `operator<`.
>
> A good default for a `strict_weak_ordering` implementation is *lexicographical ordering*.
>
> Since C++20 introduced the spaceship operator, user-defined types can easily access the default version of *lexicographical ordering*.
>
> ```cpp
> struct Point {
>     int x;
>     int y;
> 
>     // pre-C++20 lexicographical less-than
>     friend bool operator<(const Point& left, const Point& right)
>     {
>         if (left.x != right.x)
>             return left.x < right.x;
>         return left.y < right.y;
>     }
> 
>     // default C++20 spaceship version of lexicographical comparison
>     friend auto operator<=>(const Point&, const Point&) = default;
> 
>     // manual version of lexicographical comparison using operator <=>
>     friend auto operator<=>(const Point& left, const Point& right)
>     {
>         if (left.x != right.x)
>             return left.x <=> right.x;
>         return left.y <=> right.y;
>     }
> };
> ``````
>
> The type returned for the spaceship operator is the common comparison category type for the bases and members, one of:
>
> * `std::strong_ordering`
> * `std::weak_ordering`
> * `std::partial_ordering`

> Origin: 2.3

> References:
---
</details>

<details>
<summary>Compare if one range is lexicographically less than another using <code>std::lexicographical_compare</code> and <code>std::ranges::lexicographical_compare</code>?</summary>

> Lexicographical `strict_weak_ordering` for ranges is exposed through the `std::lexicographical_compare` algorithm.
>
> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> range1{1, 2, 3};
>     std::vector<long> range2{1, 3};
>     std::vector<long> range3{1, 3, 1};
> 
>     bool cmp1 = std::lexicographical_compare(range1.cbegin(), range1.cend(), range2.cbegin(), range2.cend());
>     // same as
>     bool cmp2 = range1 < range2;
>     // cmp1 = cmp2 = true
> 
>     bool cmp3 = std::lexicographical_compare(range2.cbegin(), range2.cend(), range3.cbegin(), range3.cend());
>     // same as
>     bool cmp4 = range2 < range3;
>     // cmp3 = cmp4 = true
> }
> ``````
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> #include <string>
> 
> int main()
> {
>     std::vector<std::string> range1{"Zoe", "Alice"};
>     std::vector<std::string> range2{"Adam", "Maria"};
>     auto compare_length = [](auto const& l, auto const& r) { return l.length() < r.length(); };
> 
>     bool cmp1 = std::ranges::lexicographical_compare(range1, range2, compare_length);
>     // different than
>     bool cmp2 = range1 < range2;
>     // cmp1 = true, cmp2 = false
> }
> ``````

> Origin: 2.3.1

> References:
---
</details>

<details>
<summary>Compare if one range is lexicographically less than another using spaceship operator equivalent of <code>std::lexicographical_compare</code>?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++20 |
> | constexpr | C++20 |
> | paralllel | N/A |
> | rangified | N/A |
>
> The `std::lexicographical_compare_three_way` is the spaceship operator equivalent to `std::lexicographical_compare`.
> It returns one of:
>
> * `std::strong_ordering`
> * `std::weak_ordering`
> * `std::partial_ordering`
>
> The type depends on the type returned by the elements’ spaceship operator.
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <string>
> 
> int main()
> {
>     std::vector<long> numbers1{1, 1, 1};
>     std::vector<long> numbers2{1, 2, 3};
> 
>     auto cmp1 = std::lexicographical_compare_three_way(numbers1.cbegin(), numbers1.cend(), numbers2.cbegin(), numbers2.cend());
>     // cmp1 = std::strong_ordering::less
> 
>     std::vector<std::string> strings1{"Zoe", "Alice"};
>     std::vector<std::string> strings2{"Adam", "Maria"};
> 
>     auto cmp2 = std::lexicographical_compare_three_way(strings1.cbegin(), strings1.cend(), strings2.cbegin(), strings2.cend());
>     // cmp2 = std::strong_ordering::greater
> }
> ``````

> Origin: 2.3.2

> References:
---
</details>

<details>
<summary>What is the minimum requirement to sort a range?</summary>

> The `std::sort` algorithm is the canonical `O(N log N)` sort (typically implemented as *intro-sort*).
>
> Due to the `O(n log n)` complexity guarantee, `std::sort` only operates on `random_access` ranges.
> Notably, `std::list` offers a method with an approximate `O(N log N)` complexity.

> Origin: 2.3.3

> References:
---
</details>

<details>
<summary>Sort a range using <code>std::sort</code>?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> #include <list>
> 
> struct Account
> {
>     long value() { return value_; }
>     long value_;
> };
> 
> int main()
> {
>     std::vector<long> series1{6,2,4,1,5,3};
>     std::sort(series1.begin(), series1.end());
> 
>     std::list<long> series2{6,2,4,1,5,3};
>     //std::sort(series2.begin(), series2.end()); // won't compile
>     series2.sort();
> 
>     // With C++20, we can take advantage of projections to sort by a method or member
>     std::vector<Account> accounts{{6},{2},{4},{1},{5},{3}};
>     std::ranges::sort(accounts, std::greater<>{}, &Account::value);
> }
> ``````

> Origin: 2.3.3

> References:
---
</details>

<details>
<summary>Sort a range of paired values providing an additional guarantee of preserving the relative order of equal elements?</summary>

> The `std::sort` is free to re-arrange equivalent elements, which can be undesirable when re-sorting an already sorted range.
> The `std::stable_sort` provides the additional guarantee of preserving the relative order of equal elements.
>
> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | N/A |
> | rangified | C++20 |
>
> If additional memory is available, `stable_sort` remains `O(n log n)`.
> However, if it fails to allocate, it will degrade to an `O(n log n log n)` algorithm.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> #include <string>
> 
> struct Record
> {
>     std::string label;
>     short rank;
> };
> 
> int main()
> {
>     std::vector<Record> records{{"b", 2}, {"e", 1}, {"c", 2}, {"a", 1}, {"d", 3}};
> 
>     std::ranges::stable_sort(records, {}, &Record::label);
>     // guaranteed order: a-1, b-2, c-2, d-3, e-1
> 
>     std::ranges::stable_sort(records, {}, &Record::rank);
>     // guaranteed order: a-1, e-1, b-2, c-2, d-3
> }
> ``````

> Origin: 2.3.4

> References:
---
</details>

<details>
<summary>Check if a range is already sorted in descending order?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <ranges>
> 
> int main()
> {
>     std::vector<int> data1 = {1, 2, 3, 4, 5};
>     bool test1 = std::is_sorted(data1.begin(), data1.end());
>     // test1 == true
>
>     std::vector<int> data2 = {5, 4, 3, 2, 1};
>     bool test2 = std::ranges::is_sorted(data2);
>     // test2 == false
>
>     bool test3 = std::ranges::is_sorted(data2, std::greater<>{});
>     // test3 == true
> }
> ``````

> Origin: 2.3.5

> References:
---
</details>

<details>
<summary>Check if a range is partially sorted?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> numbers{1,2,3,6,5,4};
>     auto iter = std::ranges::is_sorted_until(numbers);
>     // *iter = 6
> }
> ``````

> Origin: 2.3.6

> References:
---
</details>

<details>
<summary>Partially sort a range within a given sub-range?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::partial_sort` algorithm reorders the range’s elements such that the leading sub-range is in the same order it would when fully sorted.
> However, the algorithm leaves the rest of the range in an unspecified order.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<int> data{9, 8, 7, 6, 5, 4, 3, 2, 1};
> 
>     std::partial_sort(data.begin(), data.begin()+3, data.end());
>     // data == {1, 2, 3, -unspecified order-}
> 
>     std::ranges::partial_sort(data, data.begin()+3, std::greater<>());
>     // data == {9, 8, 7, -unspecified order-}
> }
> ``````
>
> The benefit of using a partial sort is faster runtime — approximately `O(N log K)`, where `K` is the number of elements sorted.

> Origin:  2.3.7

> References:
---
</details>

<details>
<summary>Partially sort a range within a given sub-range and write results to another range?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::partial_sort_copy` algorithm has the same behaviour as `std::partial_sort`; however, it does not operate inline.
> Instead, the algorithm writes the results to a second range.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<int> top(3);

>     // input == "0 1 2 3 4 5 6 7 8 9"
>     auto input = std::istream_iterator<int>(std::cin);
>     auto cnt = std::counted_iterator(input, 10);

>     std::ranges::partial_sort_copy(cnt, std::default_sentinel, top.begin(), top.end(), std::greater<>{});
>     // top == { 9, 8, 7 }
> }
> ``````

> Origin: 2.3.8

> References:
---
</details>

