# Create a role?

```sql
create role if not exists <role> with login createdb superuser connection limit 1;
create role if not exists <role> with nologin nocreatedb nosuperuser connection limit 1;
```
