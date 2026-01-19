# Grant connection access on a database to a role?

First revoke all access to public schema:

```sql
revoke all on database <database> from public;
```

Then authorize role:

```sql
grant connection on database <database> to <role>;
```
