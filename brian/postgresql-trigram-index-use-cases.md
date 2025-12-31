# What are the use cases of GIN index?

GIN (Generalized Inverted Index) in `pg_trgm` extension speeds up text searching that are too complex for standard B-tree indexes.

A standard index works like a dictionary, but a trigram index works by breaking words into 3-character chunks, allowing it to find matches anywhere in the string, even if there are typos. This index calculates **similarity** between the search term and the data based on how many 3-character chunks they share.

Similarity operator `%` can be used on a column where trigram index is applied:

```sql
select * from users where name % 'Jonathon';
```

This similarity searching will match `Jonathon` and `jonathan` despite being a typo because they share `jon`, `ona`, and `nat`.
