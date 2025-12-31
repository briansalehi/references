# Create a trigram index on a table?

We should enable the `pg_trgm` extension:

```sql
create extension if not exists pg_trgm with schema <schema>;
```

Then apply `gin` index on a column:

```sql
create index <index> on <table> using gin(<column> gin_trgm_ops);
```
