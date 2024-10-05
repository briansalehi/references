#!/usr/bin/env bash

psql -U postgres -f init.sql
psql -U flashback -f flashback.sql
