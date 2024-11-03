-- resource_id: 36
create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'The definitions are tedious and they add a lot of visual clutter, specially that well defined types should use `noexcept`, `constexpr`, `friend`, `[[nodiscard]]` qualifiers.');
call add_block('code', 'cpp', '[[nodiscard]] friend constexpr bool operator== (const Value& lhs, const Value& rhs) noexcept;
[[nodiscard]] friend constexpr bool operator!= (const Value& lhs, const Value& rhs) noexcept;
[[nodiscard]] friend constexpr bool operator< (const Value& lhs, const Value& rhs) noexcept;
[[nodiscard]] friend constexpr bool operator<= (const Value& lhs, const Value& rhs) noexcept;
[[nodiscard]] friend constexpr bool operator> (const Value& lhs, const Value& rhs) noexcept;
[[nodiscard]] friend constexpr bool operator>= (const Value& lhs, const Value& rhs) noexcept;');
call create_note_with_name('C++20: The Complete Guide', 1, 'What is the downsides of declaring all comparison operators manually?');

call add_block('text', 'txt', 'Since C++20, when the compiler finds no matching declaration for an expression `a != b`, the compiler rewrites the expression and looks for `!(a == b)`. If that does not work, the compiler also tries to change the order of the operands, so it tries `!(b == a)`.');
call add_block('code', 'cpp', 'operator!=(TypeA, TypeB);');
call add_block('code', 'cpp', 'operator==(TypeA, TypeB);');
call add_block('code', 'cpp', 'operator==(TypeB, TypeA);');
call add_block('code', 'cpp', 'TypeA::operator!=(TypeB);');
call add_block('code', 'cpp', 'TypeA::operator==(TypeB);');
call add_block('code', 'cpp', 'TypeB::operator==(TypeA);');
call add_block('text', 'txt', 'So just implementing `operator==` is enough for the compiler to do inequality because the compiler will rewrite the expression `a != b` as `!(a == b)`.');
call add_block('text', 'txt', 'Highest priority is to find a directly calling `operator!=`, and the lowest priority is to change the order of operands.');
call add_block('text', 'txt', 'Having both a free-standing function and a member function is an ambiguity error.');
call create_note_with_name('C++20: The Complete Guide', 1, 'What is the behavior of compilers when they cannot find a matching inequality operator for two objects?');

call add_block('text', 'txt', 'There is no rule that for all relational operators it is enough to have `operator<` defined. Instead, we can define `operator<=>`.');
call add_block('code', 'cpp', 'auto operator<=>(const Type& rhs) const = default;');
call add_block('text', 'txt', 'This expands for all relational and equality operators.');
call create_note_with_name('C++20: The Complete Guide', 1, 'What is the behavior of compilers when they cannot find a matching relational operator for two objects?');

call add_block('text', 'txt', 'Defaulted `operator==` handles equality of objects by defining `operator==` and `operator!=`, while `operator<=>` only handles relational operators. But a defaulted member `operator<=>` implicitly generates a defaulted `operator==`, resulting the full support of all relational and equality operators.');
call add_block('code', 'cpp', 'auto operator<=>(const Type& rhs) const = default;');
call add_block('code', 'cpp', 'auto operator==(const Type& rhs) const = default; // implicitly defaulted');
call create_note_with_name('C++20: The Complete Guide', 1, 'How does a defaulted member <code>operator<=></code> expand?');

call add_block('code', 'cpp', '#include <compare>');
call create_note_with_name('C++20: The Complete Guide', 1, 'What header should be included when defaulting spaceship operator?');

call add_block('text', 'txt', 'When declaring the default member `operator<=>`, the following applies for the generated operators:');
call add_block('text', 'list', '- `noexcept`: if comparing the members never throws.
- `constexpr`: if comparing the members is possible at compile time.
- **rewriting**: implicit type conversions for the first operand is supported.
- `operator==`: defines equality support with `operator==` and `operator!=`.
- `operator<=>`: defines relational support with `<`, `<=`, `>`, `>=` operators.');
call add_block('code', 'cpp', 'auto operator<=>(T const& rhs) const = default;');
call add_block('text', 'txt', 'Generates:');
call add_block('code', 'cpp', 'constexpr auto operator<=>(T const& rhs) const noexcept;');
call add_block('code', 'cpp', 'constexpr auto operator==(T const& rhs) const noexcept;');
call create_note_with_name('C++20: The Complete Guide', 1, 'What qualifiers automatically apply to default generated operators?');

call add_block('text', 'txt', 'To have more control over the generated comparison operators, we can define `operator==` and `operator<=>` ourselves.');
call add_block('code', 'cpp', 'constexpr auto operator==(T const& rhs) const noexcept
{
    return value == rhs.value;
}

constexpr auto operator<=>(T const& rhs) const noexcept
{
    return value <=> rhs.value;
}');
call create_note_with_name('C++20: The Complete Guide', 1, 'When should we define equality and spaceship operators manually?');

call add_block('text', 'txt', 'Rewriting might change the order of relational operands, which might enable implicit type conversion for the first operand.');
call add_block('text', 'txt', 'When `x <= y` does not find a matching definition of `operator<=`, it might be rewritten as `(x <=> y) <= 0` or `0 <= (y <=> x)`.');
call add_block('text', 'txt', 'If `x <=> y` is equal to 0, `x` and `y` are equal or equivalent. If `x <=> y` is less than 0, `x` is less than `y`. If `x <=> y` is greater than 0, `x` is greater than `y`.');
call create_note_with_name('C++20: The Complete Guide', 1, 'What expression does a compiler use to rewrite a relational operator when a matching definition is not found?');

call add_block('text', 'txt', 'The return type is a type that signals the *comparison category*, which could be *strong ordering*, *weak ordering*, or *partial ordering*. These types support the comparison with 0 to deal with the result.');
call add_block('code', 'cpp', '(x <=> y) == 0; // equal or equivalent
(x <=> y) < 0; // x less than y
(x <=> y) > 0; // x greater than y');
call create_note_with_name('C++20: The Complete Guide', 1, 'What is the return type of spaceship operator?');

call add_block('text', 'txt', '`operator<=>` takes precedence over all other comparison operators.');
call create_note_with_name('C++20: The Complete Guide', 1, 'What is the precedence of spaceship operator compared to other comparison operators?');

call add_block('text', 'txt', 'Outside the implementation of an `operator<=>`, programmers should never invoke `<=>` directly. Although you can, you should never write `a <=> b < 0` instead of `a < b`.');
call add_block('code', 'cpp', 'constexpr auto operator<=>(T const& rhs) const noexcept
{
    return value <=> rhs.value;
}');
call create_note_with_name('C++20: The Complete Guide', 1, 'Where can we directly call for comparison of two types with spaceship operator?');

call add_block('text', 'txt', 'Examples of this category are integral values or common strings.');
call add_block('code', 'cpp', 'std::strong_ordering::less;
std::strong_ordering::equal;
std::strong_ordering::equivalent;
std::strong_ordering::greater;');
call add_block('text', 'txt', 'Examples of this category are case-insensitive strings. `"hello"` and `"HELLO"` are equiavlent but not equal.');
call add_block('code', 'cpp', 'std::weak_ordering::less;
std::weak_ordering::equivalent;
std::weak_ordering::greater;');
call add_block('text', 'txt', 'This category works similar with an exception that the two types might not be comparable at all, like `NaN`. Any comparison with `NaN` results to `unordered` which is equivalent to false.');
call add_block('code', 'cpp', 'std::partial_ordering::less;
std::partial_ordering::equivalent;
std::partial_ordering::greater;
std::partial_ordering::unordered;');
call create_note_with_name('C++20: The Complete Guide', 1, 'What are the comparison category types?');

call add_block('text', 'txt', 'Instead of returning one of the comparison categories:');
call add_block('code', 'cpp', 'std::strong_ordering operator<=>(T const& rhs) const noexcept
{
    if (value == rhs.value) return std::strong_ordering::equal;
    if (value < rhs.value) return std::strong_ordering::less;
    return std::strong_ordering::greater;
}');
call add_block('text', 'txt', 'We should return the result of comparison of the two underying types without specifying return type:');
call add_block('code', 'cpp', 'auto operator<=>(T const& rhs) const noexcept
{
    return value <=> rhs.value;
}');
call add_block('text', 'txt', 'This not only returns the right value; it also ensures that the return value has the right comparison category type depending on the type of the member value.');
call create_note_with_name('C++20: The Complete Guide', 1, 'What is the best practice for defining the return value of spaceship operator?');

call add_block('code', 'cpp', '&lvalue <=> nullptr;');
call create_note_with_name('C++20: The Complete Guide', 1, 'What type the spaceship operator does not support?');

call add_block('text', 'txt', '`operator<=>` is predefined for all fundamental types for which the relational operators are defined.');
call add_block('code', 'cpp', 'int x{17};
int y{42};

x <=> y; // std::strong_ordering::equal
x <=> 17.0; // std::partial_ordering::equivalent
&x <=> &y; // std::weak_ordering::equal
&x <=> nullptr; // error: not supported

std::string{"hi"} <=> "hi"; // std::strong_ordering::equal
std::pair{42, 0.0} <=> std::pair{42, 7.7}; // std::partial_ordering::less');
call create_note_with_name('C++20: The Complete Guide', 1, 'What types are supported by spaceship operator?');

call add_block('text', 'txt', 'Comparison between fundamental types or standard library types might return different comparison categories, depending on the supported types.');
call create_note_with_name('C++20: The Complete Guide', 1, 'What comparison category type does comparing supported types generate?');

call add_block('text', 'txt', 'Because the return type depends on the comparison category, you can check against a specific return value:');
call add_block('code', 'cpp', 'if (x <=> y == std::partial_ordering::equivalent) // always okay');
call add_block('text', 'txt', 'But implicit type conversions only work from stronger to weaker ordering types, not the other way around. Therefore, using `std::weak_ordering` category for comparing the result will compile even if `operator<=>` yields a `std::strong_ordering` or `std::weak_ordering` value.');
call add_block('text', 'txt', 'However, a comparison with 0 is always possible and usually easier:');
call add_block('code', 'cpp', 'if (x <=> y == 0) // always okay');
call create_note_with_name('C++20: The Complete Guide', 1, 'What comparison category type is safe to be used when comparing fundamental or standard library types?');

call add_block('text', 'txt', 'There are cases where comparison of a complex type might return different comparison category types:');
call add_block('code', 'cpp', 'class complex_type
{
private:
    std::string name;
    double amount;

public:
    std::strong_ordering operator<=>(complex_type const& rhs) const noexcept
    {
        std::strong_ordering name_result{name <=> rhs.name};
        if (name_result != std::strong_ordering::equal)
        {
            return name_result; // std::strong_ordering
        }
        else
        {
            return amount <=> rhs.amount; // std::partial_ordering
        }
    }
};');
call add_block('text', 'txt', 'We can either choose the weakest comparison category, or use `std::common_comparison_category<>`:');
call add_block('code', 'cpp', 'class complex_type
{
private:
    std::string name;
    double amount;

public:
    auto operator<=>(complex_type const& rhs) const noexcept
        -> std::common_comparison_category_t<decltype(name <=> rhs.name),
                                             decltype(amount <=> rhs.amount)>
    {
        auto name_result{name <=> rhs.name};
        if (name_result != 0)
        {
            return name_result; // std::partial_ordering
        }
        else
        {
            return amount <=> rhs.amount; // std::partial_ordering
        }
    }
};');
call create_note_with_name('C++20: The Complete Guide', 1, 'Which comparison category type should be used when returning a comparison result with multiple ordering criteria?');

call add_block('code', 'cpp', 'class complex_type
{
private:
    std::string name;
    double amount;

public:
    std::strong_ordering operator<=>(complex_type const& rhs) const noexcept
    {
        std::strong_ordering name_result{name <=> rhs.name};
        if (name_result != std::strong_ordering::equal)
        {
            return name_result; // std::strong_ordering
        }
        else
        {
            return std::compare_strong_order_fallback(amount <=> rhs.amount); // std::strong_ordering
        }
    }
};');
call create_note_with_name('C++20: The Complete Guide', 1, 'What is the best practice when partial or weak ordering must be mapped to strong ordering?');

call add_block('text', 'txt', 'The member functions have to take the second parameter as `const` lvalue reference. Friend functions might alternatively take both parameters by value.');
call add_block('text', 'txt', 'Defaulted `operator==` require the support of `operator==` in the members and base classes.');
call add_block('text', 'txt', 'Defaulted `operator<=>` require the support of `operator==` and either an implemented `operator<` or a defaulted `operator<=>` in the members and base classes.');
call add_block('code', 'cpp', 'auto operator<=>(auto const& rhs) const;
friend auto operator<=>(auto const& rhs, auto const& lhs) const;
friend auto operator<=>(auto rhs, auto lhs) const;');
call create_note_with_name('C++20: The Complete Guide', 1, 'What are the requirements of defaulting spaceship and equality operators?');

call add_block('text', 'txt', 'If and only if an `operator<=>` member is defined as defaulted, then by definition a corresponding `operator==` member is also defined if no defaulted `operator==` is provided.');
call add_block('code', 'cpp', '[[nodiscard]] friend constexpr auto operator<=>(auto const& rhs) const noexcept requires(!std::same_as<decltype(rhs), bool>) = default;');
call create_note_with_name('C++20: The Complete Guide', 1, 'When does the defaulted equality operator is automatically defined?');

call add_block('text', 'txt', 'It defines a total order for raw pointers (which is not the case for operators `<=>` or `<`). Therefore, you should use it when generic types are used that can be raw pointer types.');
call add_block('code', 'cpp', 'auto operator<=>(auto const& rhs) const noexcept(noexcept(value<=>value))
{
    return std::compare_three_way{}(value<=>rhs.value);
}');
call create_note_with_name('C++20: The Complete Guide', 1, 'What is the advantage of using <code>std::compare_three_way</code> function object?');

call add_block('code', 'cpp', 'std::compare_three_way_result_t<T,T> operator<=>(auto const& rhs) const noexcept(noexcept(value<=>value));');
call create_note_with_name('C++20: The Complete Guide', 1, 'What type trait can be used to forward declare spaceship operator?');

call add_block('code', 'cpp', 'std::vector v1{0, 8, 15, 47, 11};
std::vector v2{0, 15, 8};
auto r1 = std::lexicographical_compare(v1.begin(), v1.end(), v2.begin(), v2.end());
auto r2 = std::lexicographical_compare_three_way(v1.begin(), v1.end(), v2.begin(), v2.end());');
call create_note_with_name('C++20: The Complete Guide', 1, 'What type is used to compare two ranges?');

call add_block('text', 'txt', 'Note that there is no ranges support (yet) for `lexicographical_compare_three_way()`. You can neither pass a range as a single argument nor pass projection parameters:');
call add_block('code', 'cpp', 'auto r3 = std::ranges::lexicographical_compare(v1, v2); // OK
auto r4 = std::ranges::lexicographical_compare_three_way(v1, v2); // ERROR');
call create_note_with_name('C++20: The Complete Guide', 1, 'What are the limitations of using lexicographical compare three way functions?');

cass set_section_as_complete('C++20: The Complete Guide', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++20: The Complete Guide', 2, '');
--
--cass set_section_as_complete('C++20: The Complete Guide', 2);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++20: The Complete Guide', 3, '');
--
--cass set_section_as_complete('C++20: The Complete Guide', 3);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++20: The Complete Guide', 4, '');
--
--cass set_section_as_complete('C++20: The Complete Guide', 4);

drop procedure add_block;
drop table temp_blocks;
