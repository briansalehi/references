# C++
# Asynchronous Programming with C++
## book
## Packt Publishing
### chapter
### Javier Reguera-Salgado

#### surface
#### Thread Construction

##### 3

###### Pass a value as parameter to a thread?

```cpp
#include <string>
#include <thread>

void take_value(std::string value)
{
}

int main()
{
    std::string message{"big object"};
    std::jthread worker{take_value, message};
}
```

###### Pass a reference as parameter to a thread?

```cpp
#include <string>
#include <thread>
#include <functional>

void take_ref(std::string &ref)
{
}

int main()
{
    std::string message{"big object"};
    std::jthread worker{take_ref, std::ref(message)};
}
```

###### Pass a constant reference as a parameter to a thread?

```cpp
#include <string>
#include <thread>
#include <function>

void take_cref(std::string const& cref)
{
}

int main()
{
    std::string message{"big object"};
    std::jthread worker{take_cref, std::cref(message)};
}
```

###### Pass an rvalue reference as a parameter to a thread?

```cpp
#include <string>
#include <thread>
#include <utility>

void take_rvalue(std::string&& rvalue)
{
}

int main()
{
    std::string message{"big object"};
    std::jthread worker{take_rvalue, std::move(message)};
}
```

#### Returning Value from Threads

##### 3

###### What are the considerations of returning a value from threads?

Threads cannot directly return values. Therefore, to take computed values from threads, we should pass an non-const lvalue as output parameter to the thread and expect a value after the thread has joined.

```cpp
#include <print>
#include <thread>
#include <functional>

template<typename T, typename R>
void sum(T const& lhs, T const& rhs, R& result)
{
    result = lhs + rhs;
}

int main()
{
    long percentage{};
    std::jthread worker{sum<long>, 42, 58, std::ref(percentage)};
    worker.join();
    std::println("%{}", percentage);
}
```

Future and promises are a more elegant way of returning values from threads.

#### Moving Threads

##### 3

###### Move the ownership of a thread to another thread object?

Threads can only be moved, but not copied.

```cpp
#include <thread>
#include <chrono>

void do_something()
{
    std::this_thread::sleep_for(std::chrono::seconds{3});
}

int main()
{
    std::jthread short_living{do_something};
    std::jthread long_living{std::move(short_living)};
}
```

#### 3

##### Joining Threads

###### Wait for a thread to complete execution?

Joining a thread blocks the current thread while waiting for the completion of the joining thread.

```cpp
#include <thread>

void do_something()
{
}

int main()
{
    std::thread worker{do_something);
    worker.join();
}
```

Because it is easy to forget joining a `std::thread`, we should instead use `std::jthread` that will automatically join when the execution reaches the end of scope.

###### Check if a thread has already joined?

```cpp
#include <thread>

void do_something()
{
}

int main()
{
    std::jthread worker{do_something};

    if (!worker.joinable())
    {
        worker.join();
    }
}
```

#### Detaching Threads

##### 3

###### Create a daemon thread?

A thread must join or detach before the main thread terminates, otherwise the program will abort its execution.

```cpp
#include <thread>

void do_something()
{
}

int main()
{
    std::jthread daemon{do_something};
    daemon.detach();
}
```