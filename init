#!/usr/bin/env bash

psql -U postgres -f init.sql
psql -U flashback -f flashback.sql
psql -U flashback -c "insert into studies (user_id, section_id) select 1, id from sections where id not in (select section_id from studies where user_id = 1);"
