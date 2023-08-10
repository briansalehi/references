# A Complete Guide to Standard C++ Algorithms
<img alt="A Complete Guide to Standard C++ Algorithms" src="../covers/a-complete-guide-to-standard-cpp-algorithms.png" width="200"/>

## Introduction <sup>(completed => edited => published)</sup>

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

## Swaps <sup>(completed => edited => published)</sup>

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

## Sorting <sup>(published)</sup>

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
<summary>What iterator type does the sort function operates on?</summary>

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
<summary>Check if a range is already sorted in ascending order?</summary>

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
<summary>Find the end iterator of the maximal sorted sub-range within a range using standard algorithms?</summary>

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

## Partitioning <sup>(published)</sup>

<details>
<summary>Reorder a vector of objects partitioned in two sections?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::partition` algorithm provides the basic partitioning functionality, reordering elements based on a unary predicate.
> The algorithm returns the partition point, an iterator to the first element for which the predicate returned `false`.
>
> ```cpp
> #include <algorithm>
> #include <iostream>
> #include <iterator>
> #include <ranges>
> #include <vector>
> #include <string>
>
> struct ExamResult
> {
>     std::string student_name;
>     int score;
> };
>
> int main()
> {
>     std::vector<ExamResult> results{{"Jane Doe", 84}, {"John Doe", 78}, {"Liz Clarkson", 68}, {"David Teneth", 92}};
>
>     auto partition_point = std::partition(results.begin(), results.end(), [threshold = 80](auto const& e) { return e.score >= threshold; });
>
>     std::for_each(results.begin(), partition_point, [](auto const& e) { std::cout << "[PASSED] " << e.student_name << "\n"; });
>     std::for_each(partition_point, results.end(), [](auto const& e) { std::cout << "[FAILED] " << e.student_name << "\n"; });
> }
> ``````

> Origin: 2.4.1

> References:
---
</details>

<details>
<summary>Guarantee the ordering of equal elements in partitioning a range?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | N/A |
> | rangified | C++20 |
>
> The `std::partition` algorithm is permitted to rearrange the elements with the only guarantee that elements for which the predicate evaluated to true will precede elements for which the predicate evaluated to false.
> This behaviour can be undesirable, for example, for UI elements.
>
> The `std::stable_partition` algorithm adds the guarantee of preserving the relative order of elements in both partitions.
>
> ```cpp
> auto& widget = get_widget();
> std::ranges::stable_partition(widget.items, &Item::is_selected);
> ``````

> Origin: 2.4.2

> References:
---
</details>

<details>
<summary>Check if a range is partitioned?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <cassert>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> series{2, 4, 6, 7, 9, 11};
>     auto is_even = [](auto v) { return v % 2 == 0; };
>     bool test = std::ranges::is_partitioned(series, is_even);
>     assert(test); // test = true
> }
> ``````

> Origin: 2.4.3

> References:
---
</details>

<details>
<summary>Copy the reordering results of partitioning a vector?</summary>

>
> | feature | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::partition_copy` is a variant of `std::partition` that, instead of reordering elements, will output the partitioned elements to the two output ranges denoted by two iterators.
>
> ```cpp
> #include <algorithm>
> #include <cassert>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> series{2, 4, 6, 7, 9, 11};
>     auto is_even = [](auto v) { return v % 2 == 0; };
>
>     std::vector<long> evens, odds;
>     std::ranges::partition_copy(series, std::back_inserter(evens), std::back_inserter(odds), is_even);
>
>     assert(evens.size() == 3);
>     assert(odds.size() == 3);
> }
> ``````

> Origin: 2.4.4

> References:
---
</details>

<details>
<summary>Find the nth element within a range?</summary>

> | feature | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::nth_element` algorithm is a partitioning algorithm that ensures that the element in the nth position is the element that would be in this position if the range was sorted.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> series1{6, 3, 5, 1, 2, 4};
>     std::vector<long> series2{series1};
>
>     std::nth_element(series1.begin(), std::next(series1.begin(), 2), series1.end());
>     // 1 2 3 5 6 4
>
>     std::nth_element(series2.begin(), std::next(series2.begin(), 2), series2.end(), std::greater<long>{});
>     // 5 6 4 3 2 1
> }
> ``````
>
> Because of its selection/partitioning nature, `std::nth_element` offers a better theoretical complexity than `std::partial_sort` - `O(n)` vs `O(n ∗ logk)`.
> However, note that the standard only mandates average `O(n)` complexity, and `std::nth_element` implementations can have high overhead, so always test to determine which provides better performance for your use case.

> Origin: 2.4.5

> References:
---
</details>

## Divide and Conquer <sup>(published)</sup>

<details>
<summary>Find the lower and upper bounds of a value within a sorted range?</summary>

> | `std::lower_bound` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> | `std::upper_bound` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The two algorithms differ in which bound they return:
>
> * The `std::lower_bound` returns the first element for which `element < value` returns `false`.
> * The `std::upper_bound` returns the first element for which `value < element`.
> * If no such element exists, both algorithms return the end iterator.
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <string>
>
> struct ExamResult
> {
>     std::string student_name;
>     int score;
> };
>
> int main()
> {
>     std::vector<ExamResult> results{{"Jane", 65}, {"Maria", 80}, {"Liz", 70}, {"David", 90}, {"Paula", 70}};
>     std::ranges::sort(results, std::less<int>{}, &ExamResult::score);
>
>     auto lower = std::ranges::lower_bound(results, 70, {}, &ExamResult::score);
>     // lower.score == 70
>     auto upper = std::ranges::upper_bound(results, 70, {}, &ExamResult::score);
>     // upper.score == 80
> }
> ``````
>
> While both algorithms will operate on any `forward_range`, the logarithmic divide and conquer behavior is only available for `random_access_range`.
>
> Data structures like `std::set`, `std::multiset`, `std::map`, `std::multimap` offer their `O(log N)` implementations of lower and upper bound as methods.
>
> ```sh
> #include <algorithm>
> #include <set>
>
> int main()
> {
>     std::multiset<int> data{1,2,3,4,5,6,6,6,7,8,9};
>
>     auto lower = data.lower_bound(6);
>     // std::distance(data.begin(), lower) == 5
>
>     auto upper = data.upper_bound(6);
>     // std::distance(data.begin(), upper) == 8
> }
> ``````

> Origin: 2.5.1

> References:
---
</details>

<details>
<summary>Return both lower and upper bounds of a value within a range?</summary>

> | `std::equal_range` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> data{1,2,3,4,5,6,6,6,7,8,9};
>
>     auto [lower, upper] = std::equal_range(data.begin(), data.end(), 6);
>     // std::distance(data.begin(), lower) == 5
>     // std::distance(data.begin(), upper) == 8
> }
> ``````

> Origin: 2.5.2

> References:
---
</details>

<details>
<summary>Return the upper bound of a value within a range using a predicate?</summary>

> | `std::partition_point` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> Despite the naming, `std::partition_point` works very similaryly to `std::upper_bound`, however instead of searching for a particular value, it searches using a predicate.
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> data{1,2,3,4,5,6,6,6,7,8,9};
>     auto point = std::partition_point(data.begin(), data.end(), [](long v) { return v < 6; });
>     // std::distance(data.begin(), point) = 5
> }
> ``````

> Origin: 2.5.3

> References:
---
</details>

<details>
<summary>Check the presence of a value within a range?</summary>

> | `std::binary_search` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> This function checks whether the requested value is present in the sorted range or not.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> data{1,2,3,4,5,6};
>     std::binary_search(data.begin(), data.end(), 4);
>     // true
>     std::ranges::binary_search(data, 4);
>     // true
> }
> ``````
>
> `std::binary_search` is equivalent to calling `std::equal_range` and checking whether the returned is non-empty; however, `std::binary_search` offers a single lookup performance, where `std::equal_range` does two lookups to determine the lower and upper bounds.

> Origin: 2.5.4

> References:
---
</details>

## Linear Operations on Sorted Ranges <sup>(published)</sup>

<details>
<summary>Determine whether one range is contained within another range?</summary>

> | `std::includes` | standard |
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
>
> int main()
> {
>     std::ranges::includes({1,2,3,4,5}, {3,4});
>     // true
> }
> ``````

> Origin: 2.6.1

> References:
---
</details>

<details>
<summary>Merge two sorted ranges into one?</summary>

> | `std::merge` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <execution>
> #include <iostream>
> #include <iterator>
> #include <ranges>
> #include <vector>
> #include <string>
> #include <map>
>
> int main()
> {
>     std::map<long, std::string> data1{{1, "first"}, {2, "first"}, {3, "first"}};
>     std::map<long, std::string> data2{{0, "second"}, {2, "second"}, {4, "second"}};
>     std::vector<std::pair<long, std::string>> result1, result2;
>     auto compare = [](auto const& left, auto const& right) { return left.first < right.first; };
>
>     std::ranges::merge(data1, data2, std::back_inserter(result1), compare);
>     std::ranges::for_each(result1, [](auto const& p) { std::cout << "{" << p.first << ", " << p.second << "} "; });
>     std::cout << "\n";
>
>     std::merge(std::execution::par_unseq, data1.begin(), data1.end(), data2.begin(), data2.end(), std::back_inserter(result2), compare);
>     std::ranges::for_each(result2, [](auto const& p) { std::cout << "{" << p.first << ", " << p.second << "} "; });
>     std::cout << "\n";
> }
> ``````

> Origin: 2.6.2

> References:
---
</details>

<details>
<summary>Merge two consecutive sub-ranges within a range?</summary>

> | `std::inplace_merge` | standard |
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
>     std::vector<long> range{1,3,5,2,4,6};
>     std::inplace_merge(range.begin(), range.begin()+3, range.end());
>     // range == {1,2,3,4,5,6}
> }
> ``````

> Origin: 2.6.3

> References:
---
</details>

<details>
<summary>Remove consecutive duplicate values within a sorted range?</summary>

> | `std::unique` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> | `std::unique_copy` | standard |
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
>
> int main()
> {
>     std::vector<long> range1{1,2,2,3,3,3,4,4,4,4,5,5,5,5,5};
>     std::vector<long> range2{range1};
>
>     auto last = std::unique(range1.begin(), range1.end());
>     range1.resize(std::distance(range1.begin(), last));
>     // range1 == {1,2,3,4,5};
>
>     std::vector<long> result;
>     std::ranges::unique_copy(range2, std::back_inserter(result));
>     // range2 is untouched
>     // result == {1,2,3,4,5};
> }
> ``````

> Origin: 2.6.4

> References:
---
</details>

## Set Operations <sup>(published)</sup>

<details>
<summary>Produce a range containing elements present in the first range but not in the second range?</summary>

> | `std::set_difference` | standard |
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
>     std::vector<long> data1{1,3,5,7,9};
>     std::vector<long> data2{3,4,5,6,7};
>     std::vector<long> difference;
>     std::ranges::set_difference(data1, data2, std::back_inserter(difference));
>     // difference == {1,9};
> }
> ``````

> Origin: 2.7.1

> References:
---
</details>

<details>
<summary>Produce a range containing elements present only in one of two ranges, but not both?</summary>

> | `std::set_symmetric_difference` | standard |
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
>     std::vector<long> data1{1,3,5,7,9};
>     std::vector<long> data2{3,4,5,6,7};
>     std::vector<long> symmetric_difference;
>     std::ranges::set_symmetric_difference(data1, data2, std::back_inserter(symmetric_difference));
>     // symmetric_difference == {1,4,6,9};
> }
> ``````

> Origin: 2.7.2

> References:
---
</details>

<details>
<summary>Produce a range containing elements present in either of the ranges?</summary>

> | `std::set_union` | standard |
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
>     std::vector<long> data1{1,3,5,7,9};
>     std::vector<long> data2{3,4,5,6,7};
>     std::vector<long> union;
>     std::ranges::set_union(data1, data2, std::back_inserter(union));
>     // union == {1,3,4,5,6,7,9}
> }
> ``````

> Origin: 2.7.3

> References:
---
</details>

<details>
<summary>Produce a range containing elements present in both of the ranges?</summary>

> | `std::set_intersection` | standard |
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
>     std::vector<long> data1{1,3,5,7,9};
>     std::vector<long> data2{3,4,5,6,7};
>     std::vector<long> intersection;
>     std::ranges::set_intersection(data1, data2, std::back_inserter(intersection));
>     // intersection == {3,5,7}
> }
> ``````

> Origin: 2.7.4

> References:
---
</details>

## Transformation Algorithms <sup>(published)</sup>

<details>
<summary>Apply a transformation function to each element within a range?</summary>

> | `std::transform` | standard |
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
>     std::vector<long> range{1,1,1,1,1};
>
>     // unary version
>     std::transform(range.begin(), range.end(), range.begin(), [](long e) { return e + 1; });
>     // {2,2,2,2,2}
>     std::transform(range.begin(), range.end(), range.begin(), range.begin(), [](long left, long right) { return left + right; });
>     // {4,4,4,4,4}
>
>     // binary version
>     std::ranges::transform(range, range.begin(), [](long e) { return e / e; });
>     // {1,1,1,1,1}
>     std::ranges::transform(range, range, range.begin(), [](long left, long right) { return left + right; });
>     // {2,2,2,2,2}
> }
> ``````

> Origin: 2.8.1

> References:
---
</details>

<details>
<summary>Remove elements that match the given value within a range?</summary>

> | `std::remove` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     auto last = std::remove(range.begin(), range.end(), 3);
>     range.erase(last, range.end());
> }
> ``````

> Origin: 2.8.2

> References:
---
</details>

<details>
<summary>Remove elements for which the given predicate evaluates true within a range?</summary>

> | `std::remove_if` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     auto last = std::remove_if(range.begin(), range.end(), [limit=4](long v) { return v > limit; });
>     range.erase(last, range.end());
> }
> ``````

> Origin: 2.8.2

> References:
---
</details>

<details>
<summary>Replace elements that match the given value within a range?</summary>

> | `std::replace` | standard |
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
>     std::vector<long> range{1,2,1,2,1};
>     std::ranges::replace(range, 2, 0);
>     // {1,0,1,0,1}
> }
> ``````

> Origin: 2.8.3

> References:
---
</details>

<details>
<summary>Replace elements for which the given predicate evaluates to true within a range?</summary>

> | `std::replace_if` | standard |
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
>     std::vector<long> range{1,2,1,2,1};
>     std::ranges::replace_if(range, [](long v) { return v > 1; }, 0);
>     // {1,0,1,0,1}
> }
> ``````

> Origin: 2.8.3

> References:
---
</details>

<details>
<summary>Reverse the order of elements in a range?</summary>

> | `std::reverse` | standard |
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
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::reverse(range);
>     // {5,4,3,2,1}
> }
> ``````

> Origin: 2.8.4

> References:
---
</details>

<details>
<summary>Rearrange elements in the range from <code>[first, middle), [middle, last)</code> to <code>[middle, last), [first, middle)</code>?</summary>

> | `std::rotate` | standard |
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
>     std::vector<long> range{1,2,3,4,5};
>
>     std::rotate(range.begin(), std::next(range.begin(), 3), range.end());
>     // {4,5,1,2,3}
>
>     std::ranges::rotate(range, std::next(range.begin(), 2));
>     // {1,2,3,4,5}
> }
> ``````

> Origin: 2.8.5

> References:
---
</details>

<details>
<summary>Move elements in the provided range by the specified amount of positions into left or right?</summary>

> | `std::shift_left` | standard |
> | --- | --- |
> | introduced | C++20 |
> | paralllel | C++20 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> | `std::shift_right` | standard |
> | --- | --- |
> | introduced | C++20 |
> | paralllel | C++20 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>
>     std::shift_left(range.begin(), range.end(), 3);
>     // {4,5,N,N,N}
>
>     std::shift_right(range.begin(), range.end(), 3);
>     // {N,N,N,4,5}
> }
> ``````

> Origin: 2.8.6

> References:
---
</details>

<details>
<summary>Rearrange elements in the given array in a randomly order?</summary>

> | `std::shuffle` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | N/A |
> | constexpr | N/A |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <ranges>
> #include <random>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::random_device rd{};
>     std::mt19937 generator{rd()};
>     std::ranges::shuffle(range, generator);
> }
> ``````

> Origin: 2.8.7

> References:
---
</details>

<details>
<summary>Rearrange elements of given array so that they are in their next or previous permutation?</summary>

> | `std::next_permutation` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
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
>     std::vector<long> range{1,2,3};
>     // range == {1,2,3};
>     std::next_permutation(range.begin(), range.end());
>     // range == {1,3,2};
>     std::prev_permutation(range.begin(), range.end());
>     // range == {1,2,3};
> }
> ``````

> Origin: 2.8.8

> References:
---
</details>

<details>
<summary>Check whether two ranges have the same content but not necessarily the same order of elements?</summary>

> | `std::is_permutation` | standard |
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
>     std::vector<long> range1{1,2,3}, range2{1,3,2};
>     std::ranges::is_permutation(range1, range2);
>     // true
> }
> ``````

> Origin: 2.8.9

> References:
---
</details>

## Left folds <sup>(completed)</sup>

<details>
<summary>Accumulate the elements of a range?</summary>

> | `std::accumulate` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | N/A |
>
> ```cpp
> #include <numeric>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3};
>
>     auto sum = std::accumulate(range.begin(), range.end(), 0);
>     // sum == 6
>
>     auto product = std::accumulate(range.begin(), range.end(), 1, std::multiplies<long>{});
>     // product == 6
> }
> ``````

> Origin: 2.9.1

> References:
---
</details>

<details>
<summary>Accumulate pairs of elements over two ranges into a single value?</summary>

> | `std::inner_product` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | N/A |
>
> ```cpp
> #include <algorithm>
> #include <numeric>
> #include <vector>
>
> int main()
> {
>     std::vector<long> widths{1,1,1,1,1};
>     std::vector<long> heights{2,2,2,2,2};
>
>     auto sum_area = std::inner_product(widths.begin(), widths.end(), heights.begin(), 0);
>     // sum_area == 10
>
>     std::vector<long> range{6,4,3,7,2,1};
>     auto sum_diffs = std::inner_product(range.begin(), range.end(), std::next(range.begin()), 0, std::plus<long>{}, [](long l, long r) { return std::abs(l-r); });
>     // sum_diffs == 14
> }
> ``````

> Origin: 2.9.2

> References:
---
</details>

<details>
<summary>Accumulate pairs of elements over two ranges and copy into the output range?</summary>

> | `std::partial_sum` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | N/A |
>
> ```cpp
> #include <algorithm>
> #include <numeric>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range(5,1);
>     std::partial_sum(range.begin(), range.end(), range.begin());
>     // range == {1,2,3,4,5}
>
>     std::vector<long> output;
>     std::partial_sum(range.begin(), range.end(), std::back_inserter(output), std::multiplies<long>{});
>     // output == {1,2,6,24,,120}
> }
> ``````

> Origin: 2.9.3

> References:
---
</details>

<details>
<summary>Calculate the difference of adjacent elements within a raneg?</summary>

> | `std::adjacent_difference` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | N/A |
>
> ```cpp
> #include <algorithm>
> #include <execution>
> #include <numeric>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::adjacent_difference(range.begin(), range.end(), range.begin());
>     // range == {1,1,1,1,1}
>
>     std::adjacent_difference(std::execution::par_unseq, range.begin(), range.end(), range.begin());
>     // range == {1,1,1,1,1}
>
>     std::vector<long> fibonacci(10,1);
>     std::adjacent_difference(fibonacci.begin(), std::prev(fibonacci.end()), std::next(fibonacci.begin()), std::plus<long>());
>     // fibonacci == {1,1,2,3,5,8,13,21,34,55}
> }
> ``````

> Origin: 2.9.4

> References:
---
</details>

## General Reductions <sup>(completed)</sup>

<details>
<summary>Reduce a range?</summary>

> | `std::reduce` | standard |
> | --- | --- |
> | introduced | C++17 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | N/A |
>
> ```cpp
> #include <algorithm>
> #include <numeric>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     long sum = std::reduce(range.begin(), range.end(), 0);
>     // sum == 15
>
>     long multiplies = std::reduce(range.begin(), range.end(), 1, std::multiplies<long>{});
>     // sum == 120
> }
> ``````

> Origin: 2.10.1

> References:
---
</details>

<details>
<summary>Calculate a sum of all elements?</summary>

> | `std::transform_reduce` | standard |
> | --- | --- |
> | introduced | C++17 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | N/A |
>
> ```cpp
> #include <algorithm>
> #include <numeric>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     long sum = std::transform_reduce(range.begin(), range.end(), 0, std::plus<long>{}, [](long e) { return e * 2; });
>     // sum == 30
> }
> ``````

> Origin: 2.10.2

> References:
---
</details>

<details>
<summary>Accumulate the values of a range by summing each value with its previous elements?</summary>

> | `std::inclusive_scan` | standard |
> | --- | --- |
> | introduced | C++17 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | N/A |
>
> | `std::exclusive_scan` | standard |
> | --- | --- |
> | introduced | C++17 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | N/A |
>
> ```cpp
> #include <algorithm>
> #include <numeric>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::vector<long> inclusive;
>     std::inclusive_scan(range.begin(), range.end(), std::back_inserter(inclusive));
>     // range == {1 3 6 10 15}
>
>     std::vector<long> exclusive;
>     std::exclusive_scan(range.begin(), range.end(), std::back_inserter(exclusive), 0);
>     // range == {0 1 3 6 10}
> }
> ``````

> Origin: 2.10.3

> References:
---
</details>

<details>
<summary>Accumulate the values of a range by summing each value with its previous elements by applying a custom predicate?</summary>

> | `std::transform_inclusive_scan` | standard |
> | --- | --- |
> | introduced | C++17 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | N/A |
>
> | `std::transform_exclusive_scan` | standard |
> | --- | --- |
> | introduced | C++17 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | N/A |
>
> ```cpp
> #include <algorithm>
> #include <numeric>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::vector<long> inclusive;
>     std::transform_inclusive_scan(range.begin(), range.end(), std::back_inserter(inclusive), std::plus<>{});
>     std::transform_inclusive_scan(range.begin(), range.end(), std::back_inserter(inclusive), std::plus<>{}, [](long v) { return std::abs(v); });
>
>     std::vector<long> exclusive;
>     std::transform_exclusive_scan(range.begin(), range.end(), std::back_inserter(exclusive), 0);
>     std::transform_exclusive_scan(range.begin(), range.end(), std::back_inserter(exclusive), 0, std::plus<>{}, [](long v) { return std::abs(v); });
> }
> ``````

> Origin: 2.10.4

> References:
---
</details>

## Boolean Reductions <sup>(published)</sup>

<details>
<summary>Indicate if all of the elements within a range evaluate to true for a predicate?</summary>

> | `std::all_of` | standard |
> | --- | --- |
> | introduced | C++11 |
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
>     std::vector<long> range{1,2,3};
>
>     std::ranges::all_of(range, [](long e) { return e > 0; });
>     // all numbers are possitive: true
> }
> ``````

> Origin: 2.11.1

> References:
---
</details>

<details>
<summary>Indicate if at least one element within a range evaluates to true for a predicate?</summary>

> | `std::all_of` | standard |
> | --- | --- |
> | introduced | C++11 |
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
>     std::vector<long> range{1,2,3};
>
>     std::ranges::any_of(range, [](long e) { return e % 2 == 0; });
>     // at least an even number exists: true
> }
> ``````

> Origin: 2.11.1

> References:
---
</details>

<details>
<summary>Indicate if no elements within a range evaluates to true for a predicate?</summary>

> | `std::all_of` | standard |
> | --- | --- |
> | introduced | C++11 |
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
>     std::vector<long> range{1,2,3};
>
>     std::ranges::none_of(range, [](long e) { return e < 0; });
>     // not any number is negative: true
> }
> ``````

> Origin: 2.11.1

> References:
---
</details>

## Generators <sup>(completed)</sup>

<details>
<summary>Fill a range by consecutively assigning the given value to each element?</summary>

> | `std::fill` | standard |
> | --- | --- |
> | introduced | C++98 |
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
>     std::vector<long> range(5,0);
>     std::ranges::fill(range, 1);
>     // range == {1,1,1,1,1}
> }
> ``````

> Origin: 2.12.1

> References:
---
</details>

<details>
<summary>Fill a range by consecutively assigning the given value to a limited number of elements?</summary>

> | `std::fill_n` | standard |
> | --- | --- |
> | introduced | C++98 |
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
>     std::vector<long> range(5,0);
>     std::ranges::fill_n(range, 3, 1);
>     // range == {1,1,1,0,0}
> }
> ``````

> Origin: 2.12.2

> References:
---
</details>

<details>
<summary>Fill a range by consecutively assigning the result of the provided generator?</summary>

> | `std::generate` | standard |
> | --- | --- |
> | introduced | C++98 |
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
>     std::vector<long> range(5,0);
>     std::ranges::generate(range, []() { return 1; });
>     // range == {1,1,1,1,1}
> }
> ``````

> Origin: 2.12.1

> References:
---
</details>

<details>
<summary>Fill the specified number of elements within a range by consecutively assigning the result of the provided generator?</summary>

> | `std::generate_n` | standard |
> | --- | --- |
> | introduced | C++98 |
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
>     std::vector<long> range(5,0);
>     std::ranges::generate_n(range, 3, []() { return 1; });
>     // range == {1,1,1,0,0}
> }
> ``````

> Origin: 2.12.2

> References:
---
</details>

<details>
<summary>Generate elements by consecutively assigning the result of applying the prefix <code>operator++</code>, starting with the initial value?</summary>

> | `std::iota` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++23 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <ranges>
>
> int main()
> {
>     std::vector<long> range(5,0);
>     std::ranges::iota(range, 1);
>     std::ranges::copy(range, std::ostream_iterator<long>(std::cout, " "));
> }
> ``````

> Origin: 2.12.3

> References:
---
</details>

## Copy and Move <sup>(completed)</sup>

<details>
<summary>Copy a non-overlapping and overlapping ranges?</summary>

> | `std::copy` | standard |
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
> #include <string>
>
> int main()
> {
>     std::vector<std::string> range{"a", "b", "c", "d", "e"};
>     std::ranges::copy(range.begin(), std::next(range.begin(), 3), std::next(range.begin(), 3));
>     // a b c a b c
>     std::ranges::copy(std::next(range.begin()), std::end(range), std::begin(range));
>     // b c a b c c
> }
> ``````

> Origin: 2.13.1

> References:
---
</details>

<details>
<summary>Move a non-overlapping and overlapping ranges?</summary>

> | `std::move` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> Significantly, whether `std::move` will move depends on the underlying element type.
> If the underlying type is copy-only, `std::move` will behave identically to `std::copy`.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> #include <string>
>
> int main()
> {
>     std::vector<std::string> range{"a", "b", "c", "d", "e"};
>     std::ranges::move(range.begin(), std::next(range.begin(), 3), std::next(range.begin(), 3));
>     // ? ? ? a b c
> }
> ``````

> Origin: 2.13.1

> References:
---
</details>

<details>
<summary>Copy and move a non-overlapping and overlapping ranges in the opposite direction?</summary>

> | `std::copy_backward` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> | `std::move_backward` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> #include <string>
>
> int main()
> {
>     std::vector<std::string> range{"a", "b", "c", "d", "e"};
>     std::vector<std::string> output(9, "");
>     std::ranges::copy_backward(std::begin(range), std::end(range), std::begin(output));
>     // output = {? ? ? ? a b c a b c}
>     std::ranges::copy_backward(std::begin(range), std::prev(std::end(range)), std::end(range));
>     // range = {a a b c d e}
> }
> ``````

> Origin: 2.13.2

> References:
---
</details>

<details>
<summary>Copy only a limited elements of a non-overlapping and overlapping ranges?</summary>

> | `std::copy_n` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The algorithm cannot check whether the requested count is valid and does not go out of bounds, so this burden is on the caller.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> #include <string>
>
> int main()
> {
>     std::vector<std::string> range{"a", "b", "c", "d", "e"};
>     std::vector<std::string> output;
>     std::ranges::copy_n(std::begin(range), 3, std::back_inserter(output));
>     // output == {a b c}
> }
> ``````

> Origin: 2.13.3

> References:
---
</details>

<details>
<summary>Selectively copy elements for which the predicate returns true?</summary>

> | `std::copy_if` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <iostream>
> #include <algorithm>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> range{1,2,3,4,5,6};
>     auto is_even = [](long e) { return e % 2 == 0; };
>     std::ranges::copy_if(range, std::ostream_iterator<long>(std::cout, " "), is_even); std::cout << "\n";
>     // 2 4 6
> }
> ``````

> Origin: 2.13.4

> References:
---
</details>

<details>
<summary>Selectively copy elements for which the predicate returns false?</summary>

> | `std::remove_copy_if` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <iostream>
> #include <algorithm>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> range{1,2,3,4,5,6};
>     auto is_even = [](long e) { return e % 2 == 0; };
>     std::ranges::remove_copy_if(range, std::ostream_iterator<long>(std::cout, " "), is_even); std::cout << "\n";
>     // 1 3 5
> }
> ``````

> Origin: 2.13.4

> References:
---
</details>

<details>
<summary>Selectively copy elements that do not match the provided value?</summary>

> | `std::remove_copy` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <iostream>
> #include <algorithm>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> range{1,2,3,4,5,6};
>     auto is_even = [](long e) { return e % 2 == 0; };
>     std::ranges::remove_copy(range, std::ostream_iterator<long>(std::cout, " "), 5); std::cout << "\n";
>     // 1 2 3 4 6
> }
> ``````

> Origin: 2.13.4

> References:
---
</details>

<details>
<summary>Copy a random selection N elements from the source range to the destination range utilising the provided random number generator?</summary>

> | `std::sample` | standard |
> | --- | --- |
> | introduced | C++17 |
> | paralllel | N/A |
> | constexpr | N/A |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <iostream>
> #include <ranges>
> #include <random>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> range(10,0);
>     std::iota(range.begin(), range.end(), 1);
>     std::random_device rd{};
>     std::mt19937 random_generator(rd());
>     std::ranges::sample(range, std::ostream_iterator<long>(std::cout, " "), 5, random_generator);
>     // R R R R R
> }
> ``````

> Origin: 2.13.5

> References:
---
</details>

<details>
<summary>Replace elements in a range matching a value?</summary>

> | `std::replace_copy` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <iostream>
> #include <iterator>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::replace_copy(range, std::ostream_iterator<long>(std::cout, " "), 5, 0); std::cout << "\n";
>     // 1 2 3 4 0
> }
> ``````

> Origin: 2.13.6

> References:
---
</details>

<details>
<summary>Replace elements in a range for which the predicate evaluates to true?</summary>

> | `std::replace_copy_if` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <iostream>
> #include <iterator>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::replace_copy_if(range, std::ostream_iterator<long>(std::cout, " "), [](long e) { return e % 2 == 0; }, 0); std::cout << "\n";
>     // 1 0 3 0 5
> }
> ``````

> Origin: 2.13.6

> References:
---
</details>

<details>
<summary>Copy elements of a range into another in reverse order?</summary>

> | `std::reverse_copy` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <iostream>
> #include <iterator>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::reverse_copy(range, std::ostream_iterator<long>(std::cout, " "));
>     // 5 4 3 2 1
> }
> ``````

> Origin: 2.13.7

> References:
---
</details>

<details>
<summary>Copy elements <code>[middle, last)</code>, followed by <code>[first, middle)</code> from a range into another?</summary>

> | `std::rotate_copy` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> Mirrors the behavior of the `std::rotate` algorithm.
>
> ```cpp
> #include <algorithm>
> #include <iostream>
> #include <iterator>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::rotate_copy(range, std::next(std::begin(range), 2), std::ostream_iterator<long>(std::cout, " "));
>     // 3 4 5 1 2
> }
> ``````

> Origin: 2.13.8

> References:
---
</details>

## Uninitialized Memory Algorithms

<details>
<summary>Construct and destroy a single element at a given address?</summary>

> | `std::construct_at` | standard |
> | --- | --- |
> | introduced | C++20 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> | `std::destroy_at` | standard |
> | --- | --- |
> | introduced | C++17 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <string>
> 
> int main()
> {
>     alignas(alignof(std::string)) char mem[sizeof(std::string)];
>     auto *ptr = reinterpret_cast<std::string*>(mem);
>     std::construct_at(ptr, 8, 'X');
>     // *ptr == "XXXXXXXX", ptr->length() == 8
>     std::destroy_at(ptr);
> }
> ``````

> Origin: 2.14.1

> References:
---
</details>

## Heap Data Structure <sup>(completed)</sup>

<details>
<summary>Reorder elements in the given range such that the elements maintain the max-heap property?</summary>

> | `std::make_heap` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The element at index $`i`$ compares greater or equal to the elements at indexes $`2i+1`$ and $`2i+2`$.
>
> ```cpp
> #include <algorithm>
> #include <iostream>
> #include <iterator>
> #include <ranges>
> #include <vector>
> 
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::make_heap(range);
>     // 5 4 3 1 2
>     std::ranges::make_heap(range, std::greater<long>{});
>     // 1 2 3 4 5
> }
> ``````

> Origin: 2.15.1

> References:
---
</details>

<details>
<summary>Push and pop values to heap?</summary>

> | `std::push_heap` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> | `std::pop_heap` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
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
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::make_heap(range);
>     // 5 4 3 1 2
> 
>     range.push_back(7);
>     std::ranges::push_heap(range);
>     // 7 4 5 1 2 3
> 
>     range.push_back(6);
>     std::ranges::push_heap(range);
>     // 7 4 6 1 2 3 5
> 
>     std::ranges::pop_heap(range);
>     // 6 4 5 1 2 3 7
> 
>     std::ranges::pop_heap(range.begin(), std::prev(range.end()));
>     // 5 4 3 1 2 6 7
> }
> ``````

> Origin: 2.15.1

> References:
---
</details>

<details>
<summary>Sort the elements in a heap?</summary>

> | `std::sort_heap` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
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
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::make_heap(range);
>     // 5 4 3 1 2
>     std::ranges::sort_heap(range);
>     // 1 2 3 4 5
> }
> ``````

> Origin: 2.15.2

> References:
---
</details>

<details>
<summary>Check if a range is a heap?</summary>

> | `std::is_heap` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | N/A |
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
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::make_heap(range);
>     std::ranges::is_heap(range);
>     // true
> }
> ``````

> Origin: 2.15.3

> References:
---
</details>

<details>
<summary>Check how further a range is a heap?</summary>

> | `std::is_heap_until` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | N/A |
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
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::make_heap(range);
>     auto it = std::ranges::is_heap_until(range);
>     // it == range.end()
> }
> ``````

> Origin: 2.15.3

> References:
---
</details>

## Search and Compare Algorithms

<details>
<summary>Find the first element matching the given value within a range?</summary>

> | `std::find` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <iostream>
> #include <iterator>
> #include <ranges>
> #include <vector>
> #include <string>
> 
> int main()
> {
>     std::string data{"first;second;third;"};
>     std::vector<std::string> out;
>     auto it = data.begin();
>     auto token = data.begin();
> 
>     while ((token = std::ranges::find(it, data.end(), ';')) != data.end())
>     {
>         out.push_back("");
>         std::copy(it, token, std::back_inserter(out.back()));
>         it = std::next(token);
>     }
>     std::ranges::copy(out, std::ostream_iterator<std::string>(std::cout, " "));
> }
> ``````

> Origin: 2.16.1

> References:
---
</details>

<details>
<summary>Find the first element for which the predicate evaluates to true?</summary>

> | `std::find_if` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> ``````

> Origin: 2.16.1

> References:
---
</details>

<details>
<summary>Find the first element for which the predicate evaluates to false?</summary>

> | `std::find_if_not` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> ``````

> Origin: 2.16.1

> References:
---
</details>

## Min-Max Algorithms

## Ranges

## Views <sup>(published)</sup>

<details>
<summary>Produce the view of the first elements and a range of second elements from a range of paired elements using views?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <string>
> #include <vector>
> #include <map>
>
> int main()
> {
>     std::map<long, std::string> map{ {0, "first"}, {1, "second"}, {2, "third"} };
>
>     std::ranges::copy(std::views::keys(map), std::ostream_iterator<long>(std::cout, " "));
>     // 0 1 2
>
>     std::ranges::copy(std::views::values(map), std::ostream_iterator<long>(std::cout, " "));
>     // first second third
> }
> ``````

> Origin: 4.1

> References:
---
</details>

<details>
<summary>Produce the view of Nth elements from a range of tuple-like elements?</summary>

> ```cp
> #include <iostream>
> #include <iterator>p
> #include <algorithm>
> #include <ranges>
> #include <string>
> #include <vector>
> #include <tuple>
>
> int main()
> {
>     std::vector<std::tuple<long, std::string, long>> range{ {0, "John", 4}, {1, "Laura", 5}, {2, "Alice", 5} };
>
>     std::vector<std::string> names;
>     std::ranges::copy(range | std::views::elements<1>, std::ostream_iterator<long>(std::cout, " "));
>     // John Laura Alice
>
>     std::vector<std::size_t> name_length;
>     std::ranges::copy(range | std::views::elements<2>, std::ostream_iterator<long>(std::cout, " "));
>     // 4 5 5
> }
> ``````

> Origin: 4.2

> References:
---
</details>

<details>
<summary>Apply a transformation functor to every element of the view of a range?</summary>

> ```cp
> #include <iostream>
> #include <iterator>p
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>
>     std::ranges::copy(std::views::transform(range, [](long e) -> long { return e*e; }), std::ostream_iterator<long>(std::cout, " "));
>     // 1 4 9 16 25
>
>     std::ranges::copy(range | std::views::transform([](long e) -> long { return e*e; }), std::ostream_iterator<long>(std::cout, " "));
>     // 1 4 9 16 25
> }
> ``````

> Origin: 4.3

> References:
---
</details>

<details>
<summary>Take first N elements of the view of a range?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(range | std::views::take(3), std::ostream_iterator<long>(std::cout, " "));
>     // 1 2 3
> }
> ``````

> Origin: 4.4

> References:
---
</details>

<details>
<summary>Take the sequence of elements from the view of a range for which the predicate evaluates to true?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(range | std::views::take_while([](long e) { return e <= 3; }), std::ostream_iterator<long>(std::cout, " "));
>     // 1 2 3
> }
> ``````

> Origin: 4.4

> References:
---
</details>

<details>
<summary>Drop the first N elements of the view of a range?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(range | std::views::drop(3), std::ostream_iterator<long>(std::cout, " "));
>     // 4 5
> }
> ``````

> Origin: 4.5

> References:
---
</details>

<details>
<summary>Drop the sequence of elements from the view of a range for which the predicate evaluates to true?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(range | std::views::drop_while([](long e) { return e <= 3; }), std::ostream_iterator<long>(std::cout, " "));
>     // 4 5
> }
> ``````

> Origin: 4.5

> References:
---
</details>

<details>
<summary>Filter the view of a range to consist all elements that satisfy the provided predicate?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5,6};
>     std::ranges::copy(range | std::views::filter([](long e) { return e % 2 == 0; }), std::ostream_iterator<long>(std::cout, " "));
>     // 2 4 6
> }
> ``````

> Origin: 4.6

> References:
---
</details>

<details>
<summary>Reverse the view of a range for bidirectional ranges?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(range | std::views::reverse, std::ostream_iterator<long>(std::cout, " "));
>     // 5 4 3 2 1
> }
> ``````

> Origin: 4.7

> References:
---
</details>

<details>
<summary>Adapt an iterator and the number of elements following it into the view of a range?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(std::views::counted(std::next(range.begin()), 3), std::ostream_iterator<long>(std::cout, " "));
>     // 2 3 4
> }
> ``````

> Origin: 4.8

> References:
---
</details>

<details>
<summary>Adapt a view into a range with a begin and end iterator of matching types for non-range versions of algorithms?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     auto common = range | std::views::take(3) | std::views::common;
>     std::copy(common.begin(), common.end(), std::ostream_iterator<long>(std::cout, " "));
>     // 1 2 3
> }
> ``````

> Origin: 4.9

> References:
---
</details>

<details>
<summary>Represent the view of all the elements of a range?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(std::views::all(range), std::ostream_iterator<long>(std::cout, " "));
>     // 1 2 3 4 5
> }
> ``````

> Origin: 4.10

> References:
---
</details>

<details>
<summary>Split a single range into a view over sub-ranges? (incomplete)</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <string>
> #include <charconv>
>
> int main()
> {
>     std::string version{"6.4.2"};
>     std::ranges::copy(
>         version |
>         std::views::split('.') |
>         std::views::transform([](auto v) {
>             int token; 
>             std::from_chars(v.data(), v.data() + v.size(), token);
>             return token;
>         }),
>         std::ostream_iterator<int>(std::cout, " ")
>     );
>     // 6 4 2
> }
> ``````

> Origin: 4.11

> References:
---
</details>

<details>
<summary>Flatten a splited view of a range?</summary>

> incomplete

> Origin: 4.11

> References:
---
</details>

<details>
<summary>Represent an empty view?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
>
> int main()
> {
>     std::ranges::copy(std::views::empty<long>, std::ostream_iterator<long>(std::cout, " "));
> }
> ``````

> Origin: 4.12

> References:
---
</details>

<details>
<summary>Represent a single element view?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
>
> int main()
> {
>     std::ranges::copy(std::views::single(4), std::ostream_iterator<long>(std::cout, " "));
>     // 4
> }
> ``````

> Origin: 4.12

> References:
---
</details>

<details>
<summary>Represent a view of the generated sequence formed by repeatedly incrementing an initial value?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
>
> int main()
> {
>     std::ranges::copy(std::views::iota(2,5), std::ostream_iterator<long>(std::cout, " "));
>     // 2 3 4
>
>     std::ranges::copy(std::views::iota(4) | std::views::take(3), std::ostream_iterator<long>(std::cout, " "));
>     // 4 5 6
> }
> ``````

> Origin: 4.13

> References:
---
</details>

<details>
<summary>Represent a view obtained by successively applying the istream input iterator?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
>
> int main()
> {
>     std::ranges::copy(std::views::istream<long>(std::cin), std::ostream_iterator<long>(std::cout, " "));
>     // 1 2 3 4
> }
> ``````

> Origin: 4.14

> References:
---
</details>

## Argument Dependent Lookup
