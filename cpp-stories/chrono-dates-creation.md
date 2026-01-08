# What are the limits to constructing chrono date types with integers?

Constructors of chrono date types taking an integral type are explicit, so that copy initialization with an integral type won't work:

```cpp
std::chrono::day d{7}; // okay
std::chrono::day d2 = 3; // error
std::chrono::month m{12}; // okay
std::chrno::month m2 = 12; error
```
