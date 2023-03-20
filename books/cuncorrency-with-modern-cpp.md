# [Concurrency with Modern C++](#)
<img alt="Concurrency with Modern C++20" src="../covers/concurrency-with-modern-cpp.jpg" width="200"/>

## Chapter 1/17

Nothing to import.

## Chapter 2/17

<details>
<summary>How to use `std::atomic_flag` to make spinlock mechanism?</summary>

>
> ``cpp
> #include <atomic>
> #include <thread>
> #include <chrono>
> 
> class task_unit
> {
> public:
>     void do_something()
>     {
>         lock();
>         std::this_thread::sleep_for(std::chrono::seconds{1});
>         unlock();
>     }
> 
> private:
>     void lock() { while (flag.test_and_set()); }
>     void unlock() { flag.clear(); }
> 
> private:
>     std::atomic_flag flag;
> };
> 
> int main()
> {
>     task_unit task;
> 
>     std::thread taskA{&task_unit::do_something, &task};
>     std::thread taskB{&task_unit::do_something, &task};
> 
>     taskA.join();
>     taskB.join();
> }
> ``

> Origin:
> - 2.3.2.1

> References:
> - [std::atomic\_flag](https://en.cppreference.com/w/cpp/atomic/atomic_flag)
---
</details>

## Chapter 3/17
## Chapter 4/17
## Chapter 5/17
## Chapter 6/17
## Chapter 7/17
## Chapter 8/17
## Chapter 9/17
## Chapter 10/17
## Chapter 11/17
## Chapter 12/17
## Chapter 13/17
## Chapter 14/17
## Chapter 15/17
## Chapter 16/17
## Chapter 17/17
