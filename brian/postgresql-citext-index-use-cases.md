# What are the use cases of citext?

The `citext` extension in PostgreSQL provides case-insensitive character string type. It allows us to store `Apple`, `apple`, and `APPLE` as identical strings during comparisons and lookups without needing to manually use `lower()`.

The most common use cases are when storing usernames and emails addresses.
