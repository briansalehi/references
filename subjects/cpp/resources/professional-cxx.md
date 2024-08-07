# Professional C++
<img src="../../../covers/9781119695400.jpg" width="200"/>

## Chapter 1/34
## Chapter 2/34
## Chapter 3/34
## Chapter 4/34
## Chapter 5/34
## Chapter 6/34
## Chapter 7/34
## Chapter 8/34
## Chapter 9/34
## Chapter 10/34
## Chapter 11/34
## Chapter 12/34
## Chapter 13/34
## Chapter 14/34
## Chapter 15/34
## Chapter 16/34
## Chapter 17/34 <sup>(writing)</sup>

### Standard Iterators

<details>
<summary>What are the standard iterators?</summary>

> **Description**
>
> |Iterator Category|Operations Required|
> |---|---|
> |Input Iterator|Read-only access: `operator*` `operator->`<br>forward only: `operator++`<br>assignable: `operator=`<br>copyable<br>comparable for equality: `operator==` `operator!=`|
> |Output Iterator|Read-only access: `operator*` (no `operator->` access)<br>forward only: `operator++`<br>assignable: `operator=`<br>copyable<br>no comparability supported|
> |Forward Iterator|Input Iterator capability<br>default constructor|
> |Bidirectional Iterator|Forward Iterator capability<br>bidirectional `operator++` `operator--`|
> |Random Access Iterator|Bidirectional Iterator capability<br>assignable: `operator=` `operator+=` `operator-=`<br>arithmetic: `operator+` `operator-`<br>copyable<br>comparable `operator==` `operator!=` `operator>` `operator<` `operator<=` `operator>=`<br>element-wise access `operator[]`|
> |Contiguous Iterator|Random access capability<br>logically adjacent elements of the container must be physically adjacent in memory|
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
> ---
> **References**
> ---
</details>

<details>
<summary>What iterator types are publically provided by standard data structures?</summary>

> Every data structure of the Standard Library that supports iterators provides
> public type aliases for its iterator type, called `iterator` and
> `const_iterator`.
>
> Containers that allow iteration over their elements in reverse order also
> provide public type aliases called `reverse_iterator` and
> `const_reverse_iterator`.
>
> ```cpp
> std::vector<int>::const_reverse_iterator cr_iter;
> std::vector<std::string>::const_iterator c_iter;
> std::vector<double>::iterator iter;
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17

> **References**
> ---
</details>

<details>
<summary>What non-member functions are provided by standard to return supported iterators?</summary>

> **Description**
>
> `<iterator>` provides the following global nonmember functions to retrieve
> specific iterators for a container:
>
> - `std::begin()` and `std::end()`
> - `std::rbegin()` and `std::rend()`
> - `std::cbegin()` and `std::cend()`
> - `std::crbegin()` and `std::crend()`
>
> These functions are also supported by standard data structures.

> **Resources**
> - Professional C++ - Chapter 17

> **References**
> ---
</details>

### Argument Dependent Lookups (ADL)

<details>
<summary>What is the advantage of having argument dependent lookup supported?</summary>

> When a function is called without its namespace qualification like `std::` ,
> it is said that the so called *argument dependent lookups* (ADL) is supported
> for this function.
>
> ```cpp
> #include <iterator>
> #include <vector>
>
> std::vector<double> scalar{1,2,3,4};
> auto iter = begin(scalar);
> // compiler deduces std::vector<double>::iterator due argument type
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
> ---
> **References**
> ---
</details>

<details>
<summary>When does a function supports argument dependent lookup?</summary>

> When you specialize a nonmember function for your own type, you can either
> put those specializations in the `std` namespace or put them in the same
> namespace as the type for which you are specializing them. The latter is
> recommended as this enables ADL.
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17

> **References**
> ---
</details>

### Iterator Distances

<details>
<summary>Compute the distance between two iterators of a container?</summary>

> ```cpp
> #include <iterator>
>
> std::vector<double> v;
> auto element_count = std::distance(std::begin(v), std::end(v));
> ``````

> **Resources**
> - Professional C++ - Chapter 17
> ---
> **References**
> ---
</details>

### Iterator Traits

<details>
<summary>What iterator type traits are supported by the standard?</summary>

> Standard provides a class template called `iterator_traits`, defined in
> `<iterator>`, that allows you to find the type of the elements referred to by
> the iterator to store temporary values, or to figure out whether the iterator
> is bidirectional or random access.
>
> To access to this information, instantiate `iterator_traits` class template
> with the iterator type of interest, and access one of five type aliases:
>
> - `value_type`: The type of elements referred to
> - `difference_type`: A type capable of representing the distance
> - `iterator_category` (c++20): The type of iterator
>   + `input_iterator_tag`
>   + `output_iterator_tag`
>   + `forward_iterator_tag`
>   + `bidirectional_iterator_tag`
>   + `random_access_iterator_tag`
>   + `contiguous_iterator_tag`
> - `pointer`: The type of pointer to an element
> - `reference`: The type of reference to an element
>
> ```cpp
> template<typename IteratorType>
> void print_value(IteratorType it)
> {
>     typename iterator_traits<IteratorType>::value_type temp;
>     temp = *it;
>     std::cout << temp << std::endl;
> }
>
> std::vector<double> v{42};
> print_value(std::cbegin(v));
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
> ---
> **References**
> ---
</details>

### Stream Iterators

<details>
<summary>What stream iterators are provided by the standard?</summary>

> **Description**
>
> The standard library provides four stream iterators:
>
> - `std::istream_iterator`
> - `std::ostream_iterator`
> - `std::istreambuf_iterator`
> - `std::ostreambuf_iterator`
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
> ---
> **References**
> ---
</details>

### Output Stream Iterator

<details>
<summary>Use output stream iterator to write values to an output stream?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
>
> template<typename InputIterator, typename OutputIterator>
> void copy(InputIterator begin, InputIterator end, OutputIterator target)
> {
>     for (auto iter = begin; iter != end; ++iter, ++target)
>     {
>         *target = *iter;
>     }
> }
>
> std::vector<double> v{1,2,3,4};
> std::vector<double> copy(v.size());
> copy(std::begin(v), std::end(v), std::begin(copy));
> copy(std::begin(v), std::end(v), std::ostream_iterator<int>{std::cout, " "});
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
> ---
> **References**
> ---
</details>

### Input Stream Iterator

<details>
<summary>Use input stream iterator to read values from an input stream?</summary>

> ```cpp
> #include <iterator>
> #include <vector>
>
> template<typename InputIterator>
> auto get_input(InputIterator begin, InputIterator end)
> {
>     std::vector<namespace std::iterator_traits<InputIterator>::value_type> results;
>
>     for (auto iter = begin; iter != end; ++iter)
>     {
>         results.push_back(*iter);
>     }
>
>     return results;
> }
>
> std::vector<int> inputs = get_input(std::istream_iterator<int>{std::cin}, std::istream_iterator<int>{});
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
> ---
> **References**
> ---
</details>

### Iterator Adapters

<details>
<summary>What iterator adapters are supported by the standard?</summary>

> The standard library provides five iterator adapters.
>
> The first group of adapters are created from a container and are usually used
> as output iterators:
>
> - `std::back_insert_iterator`: Uses `push_back()` to insert elements into a
>   container
> - `std::front_insert_iterator`: Uses `push_front()` to insert elements into a
>   container
> - `std::insert_iterator`: Uses `insert()` to insert elements into a container
>
> The second group of adapters are created from another iterator, not a
> container, and are usually used as input iterators:
>
> - `reverse_iterator`: reverse the iteration order of another iterator
> - `move_iterator`: the dereferencing operator for a `move_iterator`
>   automatically converts the value to an rvalue reference, so it can be moved
>   to a new destination.
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
>
> ---
> **References**
> ---
</details>

### Insert Iterators

<details>
<summary>Use iterator adapters to populate containers only supporting <code>push_back()</code>?</summary>

> ```cpp
> #include <iterator>
> #include <algorithm>
> #include <vector>
>
> std::vector<double> v{1.1, 2.2, 3.3, 4.4, 5.5};
> std::vector<double> copy_v;
> std::back_insert_iterator<std::vector<double>> populate_v{copy_v};
> std::copy(std::begin(v), std::end(v), populate_v);
> ``````
>
> You can also use `std::back_inserter()` utility function to create a `std::back_insert_iterator`.
>
> ```cpp
> std::copy(std::begin(v), std::end(v), std::back_inserter(copy_v));
> ``````
>
> With class template argument deduction (CTAD), this can also be written as follows:
>
> ```cpp
> std::copy(std::begin(v), std::end(v), std::back_insert_iterator{copy_v});
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
>
> ---
> **References**
> ---
</details>

<details>
<summary>Use iterator adapters to populate containers only supporting <code>push_front()</code>?</summary>

> **Description**
>
> ```cpp
> #include <iterator>
> #include <algorithm>
> #include <queue>
>
> std::queue<double> q{1.1, 2.2, 3.3, 4.4, 5.5};
> std::queue<double> copy_q;
> std::front_insert_iterator<std::queue<double>> populate_q{copy_q};
> std::copy(std::begin(q), std::end(q), populate_q);
> ``````
>
> You can also use `std::front_inserter()` utility function to create a `std::front_insert_iterator`.
>
> ```cpp
> std::copy(std::begin(q), std::end(q), std::front_inserter(copy_q));
> ``````
>
> With class template argument deduction (CTAD), this can also be written as follows:
>
> ```cpp
> std::copy(std::begin(q), std::end(q), std::front_insert_iterator{copy_q});
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
>
> ---
> **References**
> ---
</details>

<details>
<summary>Use iterator adapters to populate containers only supporting <code>insert()</code>?</summary>

> `std::insert_iterator` works similarly, except that the it also takes an
> initial iterator position in its constructor, which it passes to the first
> call to `std::insert(position, element)`.
>
> ```cpp
> #include <iterator>
> #include <algorithm>
> #include <set>
>
> std::set<double> s{1.1, 2.2, 3.3, 4.4, 5.5};
> std::set<double> copy_s;
> std::insert_iterator<std::set<double>> populate_s{copy_s, std::begin(copy_s)};
> std::copy(std::begin(s), std::end(s), populate_s);
> ``````
>
> The `std::insert_iterator` modifies the iterator hint that it passes to
> `insert()` after each call to `insert()`, such that the position is one past
> the just inserted element.
>
> You can also use `std::inserter()` utility function to create a
> `std::insert_iterator`.
>
> ```cpp
> std::copy(std::begin(s), std::end(s), std::inserter(copy_s, std::begin(copy_s)));
> ``````
>
> With class template argument deduction (CTAD), this can also be written as
> follows:
>
> ```cpp
> std::copy(std::begin(s), std::end(s), std::insert_iterator{copy_s, std::begin(copy_s)});
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
> ---
> **References**
> ---
</details>

### Reverse Iterators

<details>
<summary>What are the use cases of reverse iterators?</summary>

> **Description**
>
> The standard library provides an `std::reverse_iterator` class template that
> iterates through bidirectional or random-access iterator in a reverse
> direction.
>
> An `std::reverse_iterator` is useful mostly with algorithms in the standard
> library or your own functions that have no equivalents that work in reverse
> order.
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
> ---
> **References**
> ---
</details>

<details>
<summary>Obtain the base iterator from a reverse iterator?</summary>

> You can always obtain the underlying `std::iterator` from a
> `std::reverse_iterator` by calling its `base()` method. However, because of
> how `std::reverse_iterator` is implemented, the `std::iterator` returned from
> `base()` always refers to one element past the element referred to by the
> `std::reverse_iterator` on which it's called. To get to the same element, you
> must subtract one.
>
> ```cpp
> #include <vector>
> #include <iterator>
> #include <algorithm>
>
> std::vector<int> v{11, 22, 33, 22, 11};
> std::vector<int>::iterator iter1{ std::find(std::begin(v), std::end(v), 22) };
> std::vector<int>::reverse_iterator iter2{ std::find(std::rbegin(v), std::rend(v), 22) };
>
> if (iter1 != std::end(v) && iter2 != std::rend(v))
> {
>     auto first{ std::distance(std::begin(v), iter1);
>     auto second{ std::distance(std::begin(v), --iter2.base());
> }
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
>
> ---
> **References**
> ---
</details>

### Move Iterators

<details>
<summary>What are the use cases of move iterators?</summary>

> The standard library provides an iterator adapter called
> `std::move_iterator`. The dereferencing operator of a `std::move_iterator`
> automatically converts the value to an rvalue reference, which means that the
> value can be moved to a new destination without the overhead of copying.
>
> ```cpp
> MovableType m;
>
> std::vector<MovableType> source;
> source.push_back(m);
> source.push_back(m);
>
> std::vector<MovableType> copies{std::begin(source), std::end(source)};
> ``````
>
> By using `std::make_move_iterator()` to create `std::move_iterator`, the move constructor of `MovableType` is called instead of the copy constructors:
>
> ```cpp
> std::vector<MovableType> steals{std::make_move_iterator(source), std::make_move_iterator(source)};
> ``````
>
> Class template argument deduction (CTAD) with `std::move_iterator` can also be used:
>
> ```cpp
> std::vector<MovableType> steals{std::move_iterator{std::begin(source)}, std::move_iterator{std::end(source)}};
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 17
> ---
> **References**
> ---
</details>

## Chapter 18/34 Standard Library Containers <sup>(writing)</sup>

### Containers

<details>
<summary>What semantics do standard containers use to take values?</summary>

> **Description**
>
> Standard Library containers use value semantics on elements. Thus, when you
> write classes that you intend to use with the Standard Library, you need to
> make sure they are copyable.
>
> If you prefer reference semantics, you can store pointers to elements instead
> of the elements themselves. To do so, store `std::reference_wrappers` in the
> container. A `std::reference_wrapper` basically exists to make references
> copyable and can be created using the std::ref() and cref() helper functions,
> all defined in `<functional>` header.
>
> ---
> **Resources**
> - Professional C++ - Chapter 18
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/container
> - [containers]
> ---
</details>

<details>
<summary>What are the default template parameters of standard containers?</summary>

> **Description**
>
> One of the template type parameters for Standard Library containers is an
> allocator. The container uses this allocator to allocate and deallocate
> memory for elements.
>
> ```cpp
> template<typename T, typename Allocator = std::allocator<T>> class vector;
> ``````
>
> Some containers, such as a map, additionally accept a comparator as one of
> the template type parameters. This comparator is used to order elements. This
> default is to compare elements using `operator<`.
>
> ```cpp
> template<typename Key, typename T, typename Compare = std::less<Key>,
>     typename Allocator = std::allocator<std::pair<const Key, T>>> class map;
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 18
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/container
> - [containers]
> ---
</details>

<details>
<summary>What are the requirements on elements in standard containers?</summary>

> **Description**
>
> - Default Constructor
> - Copy Constructor
> - Move Constructor
> - Copy Assignment Operator
> - Move Assignment Operator
> - Destructor
> - `operator==`
> - `operator<`
> - `operator>,<=,>=,!=`
>
> ---
> **Resources**
> - Professional C++ - Chapter 18
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/container
> - [containers]
> ---
</details>

### Sequential Containers

<details>
<summary>What are the sequential standard containers?</summary>

> **Description**
>
> Following containers are sequential containers because they store a sequence of elements:
>
> - `std::vector`
> - `std::deque`
> - `std::list`
> - `std::forward_list`
> - `std::array`
>
> ---
> **Resources**
> - Professional C++ - Chapter 18
> ---
> **References**
> ---
</details>

### Sequential Views

### Container Adapters

### Ordered Associative Containers

### Unordered Associative Containers

### Flat Associative Containers

### Vector

<details>
<summary>What is the memory layout of a vector?</summary>

> **Description**
>
> In a vector the elements are stored in contiguous memory. You can index into
> a vector, as well as add new elements to the back or insert them anywhere.
>
> Vector is a class template with two type parameters, the element type and an
> allocator type.
>
> ```cpp
> template <typename T, typename Allocator = allocator<T>> class vector;
> ``````
>
> ---
> **Resources**
> - Professional C++ - Chapter 18
> ---
> **References**
> ---
</details>

## Chapter 19/34
## Chapter 20/34
## Chapter 21/34
## Chapter 22/34
## Chapter 23/34
## Chapter 24/34
## Chapter 25/34
## Chapter 26/34
## Chapter 27/34
## Chapter 28/34
## Chapter 29/34
## Chapter 30/34
## Chapter 31/34
## Chapter 32/34
## Chapter 33/34
## Chapter 34/34
