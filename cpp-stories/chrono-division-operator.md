# Use operator/ to create chrono dates?

The `operator/()` in chrono types is overloaded and can take integers as the right-hand side parameter to creates combinational chrono types.

```cpp
std::chrono::year_month_day oct_31st_1996 = std::chrono::year{1996} / 10 / 31;
```

The date must be in the yyyy/mm/dd order, otherwise it's invalid:

```cpp
auto invalid_date = std::chrono::year{1996} / 31 / 10;
```

```cpp
std::chrono::month_weekday nov_3rd_monday = 11 / std::chrono::Monday[3];
```
