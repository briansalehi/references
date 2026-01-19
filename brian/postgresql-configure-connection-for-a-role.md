# Configure PostgreSQL to give accesss to a database to a role?

Prepend the following lines in `pg_hba.conf`:

```sql
host <database> <role> 127.0.0.1/32 trust
host <database> <role> ::1/128 trust
```
