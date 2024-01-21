# Udemy: SQL and PostgreSQL - The Complete Developer's Guide

## Chapter 1/37 <sup>(complete)</sup>

<details>
<summary>What web service gives free access to a postgres client?</summary>

> https://pg-sql.com

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 1

> References:
---
</details>

## CRUD Operations

<details>
<summary>Create a table of cities holding name, country, population and area of each?</summary>

> ```sql
> create table cities (name varchar(50), country varchar(50), population int, area int);
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 1

> References:
---
</details>

<details>
<summary>Insert data into a table?</summary>

> ```sql
> insert into cities (name, country, population, area)
> values ('Tehran', 'Iran', 15000000, 40000),
>        ('Munich', 'Germany', 8000000, 20000);
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 1

> References:
---
</details>

<details>
<summary>Retrieve information from a table?</summary>

> ```sql
> select * from cities;
> select name, country from cities;
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 1

> References:
---
</details>

## Calculated Columns

<details>
<summary>Calculate the arithmetic operations of two columns from a table?</summary>

> There are eight main arithmetic operations available in SQL:
>
> 1. Addition `+`
> 2. Subtraction `-`
> 3. Multiplication `*`
> 4. Division `/`
> 5. Power `^`
> 6. Square Root `|/`
> 7. Absolute Value `@`
> 8. Remainder `%`
>
> ```sql
> select name, population / area from cities;
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 1

> References:
---
</details>

<details>
<summary>Name the operational generated column in a query?</summary>

> ```sql
> select name, population / area as density from cities;
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 1

> References:
---
</details>

## String Operations

<details>
<summary>What string operations are available in SQL?</summary>

> - Concatanation either by `||` operator or `concat()` function
> - Change case by `lower()` and `upper()`
> - Length of string with `length()`
>
> ```sql
> select firstname || ' ' || lastname as fullname from staff;
> select concat(firstname, ' ', lastname) as fullname from staff;
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 1

> References:
---
</details>

## Chapter 2/37 <sup>(complete)</sup>

## Filtering Query

<details>
<summary>Limit the results of a query?</summary>

> ```sql
> select name, area from cities where area > 40000;
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 2

> References:
---
</details>

<details>
<summary>What parts of a select query does the database read first?</summary>

> In a simple select query statement:
>
> ```sql
> select name, area from cities where area > 40000;
> ``````
>
> The source `from` would be read first. Then, the filtering `where` reduces
> the results. Finally, the columns would be selected.

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 2

> References:
---
</details>

<details>
<summary>Filter query result by checking the existance of a column in a set of values?</summary>

> ```sql
> select name, country from cities where country in ('USA', 'Germany', 'France');
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 2

> References:
---
</details>

<details>
<summary>Reverse the filtering of a query by checking the none-existance of a column in a set of values?</summary>

> ```sql
> select name, country from cities where country not in ('USA', 'Germany', 'France');
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 2

> References:
---
</details>

## Comparison Operators

<details>
<summary>What comparison operators are supported by SQL?</summary>

> - Equality `=`
> - Greater `>`
> - Less `<`
> - Greater or Equal `>=`
> - Less or Equal `<=`
> - Inequality `<>` or `!=`
> - between two `between`
> - exists in list `in`
> - not exists in list `not in`

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 2

> References:
---
</details>

## Compound Operators

<details>
<summary>What compound operators are supported by SQL?</summary>

> - `and`
> - `or`
>
> ```sql
> select device, manufacturer from devices where country in ('USA', 'China');
> select device, manufacturer from devices where country = 'USA' or country = 'China';
> select device, manufacturer from devices where country = 'USA' and manufacturer = 'ASUS';
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 2

> References:
---
</details>

## Calculated Conditions

<details>
<summary>Limit the results of a query by comparing the calculated values of two columns?</summary>

> ```sql
> select name, country, population / area as density from cities where population / area > 40000;
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 2

> References:
---
</details>

## Update Records

<details>
<summary>Update a cell within a very big table?</summary>

> ```sql
> update cities set population = 20000000 where name = 'Tehran';
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 2

> References:
---
</details>

## Delete Records

<details>
<summary>Delete a row from a table?</summary>

> ```sql
> delete from cities where name = 'Tehran';
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 2

> References:
---
</details>

<details>
<summary>Delete all rows of a table?</summary>

> ```sql
> delete from cities;
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 2

> References:
---
</details>

## Chapter 3/37 <sup>(complete)</sup>

## Relationships

<details>
<summary>How many relationships are possible between data?</summary>

> - one to one
> - one to many
> - many to one
> - many to many

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 3

> References:
---
</details>

## Primary Key

<details>
<summary>What are the characteristics of a primary key?</summary>

> - Each row in every table has one primary key (not empty)
> - No other row in the same table can have the same value (unique)
> - 99% of the time called id
> - Either an integer or a UUID
> - Will never change

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 3

> References:
---
</details>

<details>
<summary>What is the common way of making a primary key auto generate a unique id in postgres?</summary>

> Using `serial` in postgres, we will have a value typed as integral and auto
 generate unique IDs.
>
> ```sql
> create table users (
>     id serial primary key,
>     username varchar(50)
> )
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 3

> References:
---
</details>

## Foreign Key

<details>
<summary>What are the characteristics of a foreign key?</summary>

> - Rows only have this key if they have a cell that belongs to another record
> - Many rows in the same table can have the same foreign key
> - Name varies, usually called something like `xyz_id`
> - Exactly equal to the primary key of the referenced row
> - Will change if the relationship changes

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 3

> References:
---
</details>

<details>
<summary>What statement is used to create a foreign key?</summary>

> ```sql
> create table photos (
>     id serial primary key,
>     url varchar(1000),
>     user_id integer references users(id)
> )
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 3

> References:
---
</details>

## Foreign Key Insertion

<details>
<summary>What happens when record gets inserted without foreign key?</summary>

> A record having foreign key referencing to an existing record would be
> successful. But a record referencing to an invalid record will fail. Also,
> when inserting a record having foreign key set to `NULL` is also a successful
> insertion.
>
> ```sql
> insert into photos (url, user_id) values ('https://cdn1.example.com/image1.jpg', NULL);
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 3

> References:
---
</details>

## Constraints

<details>
<summary>What constraints are supported by SQL when referencing record of a foreign key is deleted?</summary>

> - `on delete restrict`: throw an error when deleting the record having foreign keys referenced to it
> - `on delete no action`: same as above
> - `on delete cascade`: delete the referencing record too
> - `on delete set null`: set the foreign key value to NULL
> - `on delete set default`: set the forign key value to a default value

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 3

> References:
---
</details>

<details>
<summary>What is the default behavior of postgres when deleting a record being referenced by foreign keys?</summary>

> When the action after deletion of referenced record is not specified for a
> foreign key, `on delete restrict` is the default.
>
> ```sql
> create table photos (
>     id serial primary key,
>     url varchar(1000),
>     user_id integer references on users(id) on delete restrict
> )
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 3

> References:
---
</details>

## Join Query

<details>
<summary>Query two tables by associating them on foreign keys?</summary>

> ```sql
> select url, username
> from users
> join photos on users.id = photos.user_id;
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 3

> References:
---
</details>

## Default Value

<details>
<summary>What statement can be used to set default value for a foreign key when referenced record is deleted?</summary>

> ```sql
> create table photos (
>     id serial primary key,
>     url varchar(50) not null,
>     user_id integer default 0 references on users(id) on delete set default
> )
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 3

> References:
---
</details>

## Chapter 4/37 <sup>(complete)</sup>

## Joins

<details>
<summary>How many joins are supported by SQL?</summary>

> - **join** or **inner join**
>
> ```sql
> select photo_id, user_id
> from users
> join photos on photos.user_id = users.id;
> ``````
>
> - **left outer join**
>
> ```sql
> select photo_id, user_id
> from users
> left join photos on photos.user_id = users.id;
> ``````
>
> - **right outer join**
>
> ```sql
> select photo_id, user_id
> from users
> right join photos on photos.user_id = users.id;
> ``````
>
> - **full join**
>
> ```sql
> select photo_id, user_id
> from users
> full join photos on photos.user_id = users.id;
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 4

> References:
---
</details>

<details>
<summary>Filter the records of a join query with a condition?</summary>

> ```sql
> select photo_id, user_id
> from users
> join photos on photos.user_id = users.id
> where photos.views > 2000;
> ``````

> Origins:
> - Udemy: SQL and PostgreSQL - The Complete Developer's Guide - Chapter 4

> References:
---
</details>

## Chapter 5/37 <sup>(writing)</sup>



## Chapter 6/37
## Chapter 7/37
## Chapter 8/37
## Chapter 9/37
## Chapter 10/37
## Chapter 11/37
## Chapter 12/37
## Chapter 13/37
## Chapter 14/37
## Chapter 15/37
## Chapter 16/37
## Chapter 17/37
## Chapter 18/37
## Chapter 19/37
## Chapter 20/37
## Chapter 21/37
## Chapter 22/37
## Chapter 23/37
## Chapter 24/37
## Chapter 25/37
## Chapter 26/37
## Chapter 27/37
## Chapter 28/37
## Chapter 29/37
## Chapter 30/37
## Chapter 31/37
## Chapter 32/37
## Chapter 33/37
## Chapter 34/37
## Chapter 35/37
## Chapter 36/37
## Chapter 37/37
