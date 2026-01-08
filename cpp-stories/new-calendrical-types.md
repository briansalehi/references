# What are the calendrical types introduced in C++20?

- `std::chrono::last_(spec)`
- `std::chrono::day`
- `std::chrono::month`
- `std::chrono::year`
- `std::chrono::weekday`
- `std::chrono::weekday_indexed`
- `std::chrono::weekday_last`
- `std::chrono::month_day`
- `std::chrono::month_day_last`
- `std::chrono::month_weekday`
- `std::chrono::month_weekday_last`
- `std::chrono::year_month`
- `std::chrono::year_month_day`
- `std::chrono::year_month_day_last`
- `std::chrono::year_month_weekday`
- `std::chrono::year_month_weekday_last`

All calendrical types are trivially copyable and have implicit `constexpr` constructors.

Most of the types have `ok()` method that returns true if a given state is correct in terms of type and its subtypes.
