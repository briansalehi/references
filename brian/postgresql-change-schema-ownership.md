# Change ownership of a schema to a role?

```sql
alter schema public owner to <role>;
```

```sql
revoke all on schema public from public;
grant usage, create on schema public to <role>;
```
